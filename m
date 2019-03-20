Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7439AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FED3218A2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XPx/ICyS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfCTUZq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 16:25:46 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44247 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbfCTUZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 16:25:46 -0400
Received: by mail-pg1-f195.google.com with SMTP id i2so2588288pgj.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 13:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=HiftAZ1wMxpcuv9eoeBNDyTOl/+5hkrxRMwR+7h1t0U=;
        b=XPx/ICyS5hw93ueeuCoRBA6RUAhzQKIDoihdw9SCsLC3O92PgIjCT+z9HQglDF0Sal
         FA/YUMoTcG1OW4KSFOxRRHO+gnfgwR0mZHw0QAbi4zGjrwOze/wZDXjx57PuLX5f8Oov
         B5PJ3xC9ods1SvFY4+UwFOrDFrWVyk0GEUkumL1yv3qf0pSdVPD6URQBMcwm7tyT14ih
         RqqYZNIZXHQcDmgqwOML6Rr0cVLcvJLBQyIE1FaTwIdcU041TkC2zU2IzybtORxPQxXI
         3EoQKy5jgAeDWqoWJwUc65F6SbeF5juNmIhPUrGfT9UQpBgm+2L3HrkYwSozF8sQXUd5
         phSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HiftAZ1wMxpcuv9eoeBNDyTOl/+5hkrxRMwR+7h1t0U=;
        b=GqaR3fd360kAd6NMN8R4vBVSPrltwDiYnQA4tf9R3WgkjzoRbO5OTcRPbUJ6A90a85
         r7DZB/j3n21wgZe9dVK2KOQbQ73GpdOzBgC5MqK/Q5uYXnVr3uBR6okMdpukejHSeIkU
         o85UQAjypAoVlZaNTgvdXVtjSGzzKMMFYaJ7waUtC/xIkK0s/3z/0bby9Iozo6ws3v87
         YlHtrK80VO9s7mFrE46E1e7t7L3fgzftEvdkTar1quy+CTq7zh/a7jgaYaEzPje2KA5G
         +NIhgcdh+Zl8ibJEJZUhT7OlI7SVuifdakUndI9vdJju9G+++09tmiya0d/Xo0irk04r
         x3gQ==
X-Gm-Message-State: APjAAAVNOeLGO4bVWFBIp8JsxlmaFVNSFMuDboxoX9pnWA8nXV4TKFdO
        REjG7nC9gEtNAUacCYakUuFevo5bFhE=
X-Google-Smtp-Source: APXvYqz4wss951sLWPtwYy7F5lLxRDhDMeDxdaHp9hkQU9aPaxGy0gJrJwOaRydFr2jJrNCngpFSRw==
X-Received: by 2002:a63:535c:: with SMTP id t28mr30564380pgl.128.1553113544855;
        Wed, 20 Mar 2019 13:25:44 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id u187sm866338pfu.113.2019.03.20.13.25.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Mar 2019 13:25:43 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Tanglei Han <hantanglei@huawei.com>,
        Zhuangluan Su <suzhuangluan@hisilicon.com>,
        Ryan Grachek <ryan@edited.us>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH 0/3] DMA dts changes for hi3660
Date:   Wed, 20 Mar 2019 13:25:37 -0700
Message-Id: <1553113540-28726-1-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here are a few dts changes which didn't get picked up
for the last merge window to enable support for code
changes that did land in v5.1.

Let me know if you have any objecitons or feedback!

thanks
-john

Cc: Tanglei Han <hantanglei@huawei.com>
Cc: Zhuangluan Su <suzhuangluan@hisilicon.com>
Cc: Ryan Grachek <ryan@edited.us>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Wei Xu <xuwei5@hisilicon.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org

John Stultz (2):
  arm64: dts: hi3660: Add dma to uart nodes
  arm64: dts: hi3660: Fixup unofficial dma-min-chan to dma-channel-mask

Youlin Wang (1):
  arm64: dts: hi3660: Add hisi asp dma device

 arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

-- 
2.7.4

