Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09BBFC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEE2921904
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:02:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FCJq6arG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbfDXMCi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 08:02:38 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41876 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbfDXMCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 08:02:38 -0400
Received: by mail-pg1-f195.google.com with SMTP id f6so9273521pgs.8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 05:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=MQpbaIZ4jJPf5F2sHt9NkO9ybLST1usylGMUyiBWYMQ=;
        b=FCJq6arGgHlm4eQU5CtWGScB9D/pUJtD9rufZPQ3Kx3DbOGVDr4xriOJNThRYTgjJL
         YbG8JbwuBd9YopOOUWgIyK0nEZOuP4S+GlXtvlFM7iDddJCRd2iAtJOi1y9lj5fc7ZEZ
         N11jMGOS8/oiHPA/plHbBBNC6+ODcvm1HRdPbvOFCweUbj9307U/SkzIi2BEExsFpyGU
         nLCXbyk7uW+Gb69Am84HyiQ50OvqtEbCcjFUuAyH4Ontgq7alkREEVWtbcTXHorW7Gt+
         B2VSRcobqUekjorG8UmEtBOQy2Yb++gnbeyOHd6rRZ5i8GraVm962Az2Bcc3Wp9UKu9i
         rgSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MQpbaIZ4jJPf5F2sHt9NkO9ybLST1usylGMUyiBWYMQ=;
        b=OT61EjRx0GWlyT4ZNLh1O2aCZzfNqfW45ZcyIkPQHpQqq3HfuV1uumzneFoNPuz5NQ
         gbAIfUSzAP2kMlLikIdoqNf3/Wl3jCpk1YD4G8ClKa4H0o8ScQYQi1wGNYnLLnwTMz8u
         dUsz/kBd6+/o351FDalIuk9CbwnnesoHhHt3eoq6nCKWJanoleGpImzKFcqszhKc70uo
         OTh7zagjDTHuNIuI3sYIQyJRe9oZadeYCoyWdRt1lKhVpvorH9ABUcJDBA6WeBIKJss/
         JzWFqzScQqz5ldVrokPZFYJX2UhPdIQNuzrfIW3nZfhTZd2ZUIqycSB6AY63/eP/UgGm
         5JjA==
X-Gm-Message-State: APjAAAXfI2+lr02BvbKfY4TyG1I8h3GhqrPgFewC0klCCfMbTkEMuXpO
        PlBBBXCgCVNg4mKRKglryYlS
X-Google-Smtp-Source: APXvYqxyiH1ZQebrAOODmiIRy8zCRQUeEk1Wl3+YAhYZwNub5s36bayGcVwZCjedEtfXon68Ctypvg==
X-Received: by 2002:a65:50c2:: with SMTP id s2mr30624466pgp.112.1556107357474;
        Wed, 24 Apr 2019 05:02:37 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:711:bac8:7d48:1fca:4d86:743])
        by smtp.gmail.com with ESMTPSA id j22sm25870840pfn.129.2019.04.24.05.02.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 05:02:36 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     linus.walleij@linaro.org, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        linux-gpio@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 0/5] Add pinctrl support for BM1880 SoC
Date:   Wed, 24 Apr 2019 17:32:19 +0530
Message-Id: <20190424120224.22660-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patchset adds pinctrl support for Bitmain BM1880 SoC and
Sophon Edge board. BM1880 SoC can only handle pinmux functionality,
hence the driver has no pinconf support.

This patchset has been tested on 96Boards Sophon Edge board.

Thanks,
Mani

Manivannan Sadhasivam (5):
  dt-bindings: pinctrl: Add BM1880 pinctrl binding
  arm64: dts: bitmain: Add pinctrl support for BM1880 SoC
  arm64: dts: bitmain: Add UART pinctrl support for Sophon Edge
  pinctrl: Add pinctrl support for BM1880 SoC
  MAINTAINERS: Add entry for BM1880 pinctrl

 .../pinctrl/bitmain,bm1880-pinctrl.txt        |  98 ++
 MAINTAINERS                                   |   2 +
 .../boot/dts/bitmain/bm1880-sophon-edge.dts   |  29 +
 arch/arm64/boot/dts/bitmain/bm1880.dtsi       |  14 +
 drivers/pinctrl/Kconfig                       |   7 +
 drivers/pinctrl/Makefile                      |   1 +
 drivers/pinctrl/pinctrl-bm1880.c              | 965 ++++++++++++++++++
 7 files changed, 1116 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/bitmain,bm1880-pinctrl.txt
 create mode 100644 drivers/pinctrl/pinctrl-bm1880.c

-- 
2.17.1

