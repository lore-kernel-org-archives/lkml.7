Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 496E9C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 16:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17FA4216F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 16:53:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jN1XFAMD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728776AbfEHQxc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 12:53:32 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35518 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728044AbfEHQxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 12:53:31 -0400
Received: by mail-pl1-f196.google.com with SMTP id w24so10213635plp.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 09:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=1VcQ/lfM08SXvOgnrylDwHXID+O2QS5SQTEiTY7pKR4=;
        b=jN1XFAMDjh462U6OA3bEn3+sOAOeu2mFwIEJudjbEPRy8O94uCF1olVHEjD2qH7zIX
         TTPJ1TZoT/s3boPM44QZ+tENF2k8vNVHzQ1lE1iTIuCdWyKtdwXQM8OYvqJc11Kp/56s
         KNaB4KfPG1zkYr8T2yV/Zmrb1T1j9wYdKbmRcKh8DIq53a6IiEUgJkuGwMpo/aB+25Lb
         A8uRkgjVxmypEqaeUtKKNknQIYHBICCRWbR0ccMpMvWp+eNFHw3oXLF2aA02UD91EzGH
         aKD8+5WPacr6QLCkOQNebiM1WIHTLMOaj4JzjoavAdZRHcXw5U+mWzBUMhr+1Cf+aWWq
         NRNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1VcQ/lfM08SXvOgnrylDwHXID+O2QS5SQTEiTY7pKR4=;
        b=MgKXbg7BZW2C5OgP/VrdArCGlhR52PNeRB7n7dzNs/u9fnIU0oPihMWouQAbFUHDRH
         i4wmYmhi1XUcabp6mOghJV2U98bMgrUrZviJ9u7iN8SywgqynqosXJ3iY9noLRhnV5EW
         gxJw4cA3hmmEI4OAPDPrV1M6DiVqOSpCbfVRYHFJCTUQzd3vxmtZ3Z1d1nQUManKr6Ne
         Y9aOthsRQf+KQM1svFuMqo86RgWw+AWeRIQorP8Z+fXsqcXYLm5FBKsWhqBUrUWtzWxO
         mrSGv8HsIHy85uzyhOxsjTmu7I7mBz+uvLVVst9UzJfdfZKAfPJV3OoTuLMNUxwoSozF
         cVVQ==
X-Gm-Message-State: APjAAAWDn4971rfyJjySWhLR2TYg5UdkIWRG7xGp7NS8wOBNivZr1TDq
        JGWrWSBebg2wfc4w1zurE5F62Ig7cg==
X-Google-Smtp-Source: APXvYqw5M4RV8ZNy/CF3V1SZqj526bLnkLBNlYsA5DALAlbnfTvqNGI5VFJpDWDlA4dyk1hBsISLsA==
X-Received: by 2002:a17:902:e407:: with SMTP id ci7mr48331151plb.219.1557334410313;
        Wed, 08 May 2019 09:53:30 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:6000:7ab1:cd79:1ccc:df38:79c0])
        by smtp.gmail.com with ESMTPSA id m2sm25180676pfi.24.2019.05.08.09.53.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 09:53:29 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     p.zabel@pengutronix.de, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 0/4] Add reset controller support for BM1880 SoC
Date:   Wed,  8 May 2019 22:23:15 +0530
Message-Id: <20190508165319.19822-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patchset adds reset controller support for Bitmain BM1880 SoC.
BM1880 SoC has two reset controllers each controlling reset lines of
different peripherals. And the reset-simple driver has been reused here.

This patchset has been tested on 96Boards Sophon Edge board.

Thanks,
Mani

Changes in v2:

As per review from Philipp:

* Reused reset_simple_active_low struct instead of a new one for bm1880
* Splitted the SPDX license change to a separate commit
* Added Reviewed-by tags from Rob and Philipp

Manivannan Sadhasivam (4):
  dt-bindings: reset: Add devicetree binding for BM1880 reset controller
  arm64: dts: bitmain: Add reset controller support for BM1880 SoC
  reset: Add reset controller support for BM1880 SoC
  reset: Switch to SPDX license identifier for reset-simple

 .../bindings/reset/bitmain,bm1880-reset.txt   |  18 +++
 arch/arm64/boot/dts/bitmain/bm1880.dtsi       |  17 +++
 drivers/reset/Kconfig                         |   3 +-
 drivers/reset/reset-simple.c                  |   8 +-
 .../dt-bindings/reset/bitmain,bm1880-reset.h  | 106 ++++++++++++++++++
 5 files changed, 146 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/reset/bitmain,bm1880-reset.txt
 create mode 100644 include/dt-bindings/reset/bitmain,bm1880-reset.h

-- 
2.17.1

