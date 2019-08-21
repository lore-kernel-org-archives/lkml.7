Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E40A7C3A589
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 02:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA48B22DA7
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 02:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uK44JlaR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbfHUC5h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 22:57:37 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46619 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbfHUC5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 22:57:36 -0400
Received: by mail-pl1-f196.google.com with SMTP id c2so479195plz.13
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 19:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0YPh4ZPworY3ZEjE24wMYeyXg9KZRbq3tqWyWWQ8XlQ=;
        b=uK44JlaR1k3uAS4AX3pTDEr/vTzJzlJG3h0cfLeudtdjt2eTHBjAcnUQl+nX8E2LhN
         qCLGyyMqNg23YESt9V6DoY3pHFBGGmRlYuDnqyYX+iShevZAV/Dn4G6IDT9lBXJAHj3m
         9nBp91YmOaxbaS1aW6IK2JuDZchAGjlCHl478vqdoYAm9UMDunVKLDVy/V3v899zP9Qi
         pvMu4EarvlbOHOzVJgP1hSfPL7LSJGBbhSmY1nMwmX9s3cTwlV+fc+8tAmc+OP4bZ1lz
         lyQ0oP9/J9EAAVm8Ir1EoxS8w8tmPI2dkAjFZC8t9BGt/ILxUKrdiBnGWy4sib1utZNq
         BqrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0YPh4ZPworY3ZEjE24wMYeyXg9KZRbq3tqWyWWQ8XlQ=;
        b=nBwnXN1SbuXIyBAYj36DSOeeZ20CbxHNaYPoJk0ASvrS+m9vPFHUSYX0cgVcWrV4q1
         RnSus2KFQEkN4fd8ec0Lq2atCEK3U/OUmUx3/QgotDPruSEruWW6FTFzrIIbNnPST/+N
         lpWkaPssFJDQNrtWiZYFONHNbzj6H/VTYThWd+sJ/n+f/CtPusgK+cY00uUNW1RfgoXQ
         LDfpAoEmV3rYHdsbuw/EjYLSN/cd8D6XvJ8F0eJbLY8TXNYGyhSoqrpf6DhldNfdQszZ
         LQ/yBjaHWrDo05YT1UuoMkqtWGbs8bZAVhtX77JHDsqIJxjFueLuw3PTsNVdhF7u5cm/
         /W2w==
X-Gm-Message-State: APjAAAUnortVESfGaE8S1HMKj9qTvMY0zyZMhasrBQK2UqXx2QeQBlqf
        vZ+oo4N2EK6MV9qAmirN/P/d
X-Google-Smtp-Source: APXvYqxWX41fVvpAy5mDzcBY4knA0x++pNqIAFAUMif6+qT59dLNFyls0cGJowbkdKkvLw/bLqAyCw==
X-Received: by 2002:a17:902:b710:: with SMTP id d16mr25772303pls.165.1566356255979;
        Tue, 20 Aug 2019 19:57:35 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:7101:175:ddd7:6c31:ebc7:37e8])
        by smtp.gmail.com with ESMTPSA id d16sm13251682pfd.81.2019.08.20.19.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 19:57:35 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     ulf.hansson@linaro.org, afaerber@suse.de, robh+dt@kernel.org,
        sboyd@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        thomas.liau@actions-semi.com, linux-actions@lists.infradead.org,
        linus.walleij@linaro.org, linux-clk@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 7/7] arm64: configs: Enable Actions Semi platform in defconfig
Date:   Wed, 21 Aug 2019 08:26:29 +0530
Message-Id: <20190821025629.15470-8-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190821025629.15470-1-manivannan.sadhasivam@linaro.org>
References: <20190821025629.15470-1-manivannan.sadhasivam@linaro.org>
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

