Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96647C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 02:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66DC422DD6
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 02:41:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rLyhcFrh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbfHUClW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 22:41:22 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36224 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbfHUClW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 22:41:22 -0400
Received: by mail-pf1-f195.google.com with SMTP id w2so394775pfi.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 19:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0YPh4ZPworY3ZEjE24wMYeyXg9KZRbq3tqWyWWQ8XlQ=;
        b=rLyhcFrheG3o5Qx36QQ7u9F9uz6BwEvvGRbEFwHczuyYBmBtSTcgoqnF/CpXUVKaUF
         oFPWCqQ4uFTZ86OpbY1QLizgo72Qacqp4vAUUu7JOSh9ify6x0ZJRRcGFapCIP/AO0AY
         Vsihv62MIoIyy5uSqLpZHyHqaFFEda8zb2G3FIV2Xw2fzJVGD4eHfhtIzlc8H5QFlt3Z
         yJPO05K75raZr5sErAAPhuaYP0ioHGau7+VtaimX4l5tiBEnWy+Csd8f3CTSrP4/MhkT
         idghhLoGl7DRYN6wJeVfO/IDfPyE5E0FeAGuQWaQCvsY75FGgAwSsXCcq3xbt5ivgjXM
         B4bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0YPh4ZPworY3ZEjE24wMYeyXg9KZRbq3tqWyWWQ8XlQ=;
        b=LqIzEvX/i2zYhELR17hJ4YARJCjNyummQO9BF1vWda/DcOLn+zg+NIIcZTkxc6pRvO
         8hDdz2EY+7Ez/BSj9Qw8rt54oNXZG5h2gNcd6ngVEZsqu0z1Qm0WgLXydCmXfZoiqVhi
         kujasI97DambVX4bK2+qkpvEL37B3NX8CKiLqZY1bD5S4KVnmq3CdTPnrdNO/pnPcGjy
         Ya1aGE58y/olr2C8FkpiJjD1fLiRS6lWV3WFvaH7oD9oYwu2pcmxrIkAsJoVJIN4Gb/V
         YiVLtTSYSHT/fQxgKFqMtrYDu+vcusDfSRNtVxVkNuGgTlbK5dMLqBY3GHp4yLn6KFcD
         U8mw==
X-Gm-Message-State: APjAAAVYs2ELl8ElGApJsBON2JjosauIrzpgCw2v3F3INaoHFwkaOiYk
        x37iASwrx0hrp/MRV26SBLkf
X-Google-Smtp-Source: APXvYqwmigcKaPRf+OIOd50oOxOjUzfx0doqmb3OFqSsh3CLhHvbUYDNLJUbQly1qsFB7EvMt3oOsw==
X-Received: by 2002:a63:1f1f:: with SMTP id f31mr26894682pgf.353.1566355281516;
        Tue, 20 Aug 2019 19:41:21 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:7101:175:ddd7:6c31:ebc7:37e8])
        by smtp.gmail.com with ESMTPSA id b126sm26091608pfa.177.2019.08.20.19.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 19:41:21 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     ulf.hansson@linaro.org, afaerber@suse.de, robh+dt@kernel.org,
        sboyd@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        thomas.liau@actions-semi.com, linux-actions@lists.infradead.org,
        linus.walleij@linaro.org, linux-clk@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 7/7] arm64: configs: Enable Actions Semi platform in defconfig
Date:   Wed, 21 Aug 2019 08:10:14 +0530
Message-Id: <20190821024014.14070-8-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190821024014.14070-1-manivannan.sadhasivam@linaro.org>
References: <20190821024014.14070-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the Actions Semi platform can now boot a distro, enable it in
ARM64 defconfig.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 0e58ef02880c..8e27777d6687 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -29,6 +29,7 @@ CONFIG_BLK_DEV_INITRD=y
 CONFIG_KALLSYMS_ALL=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_PROFILING=y
+CONFIG_ARCH_ACTIONS=y
 CONFIG_ARCH_AGILEX=y
 CONFIG_ARCH_SUNXI=y
 CONFIG_ARCH_ALPINE=y
-- 
2.17.1

