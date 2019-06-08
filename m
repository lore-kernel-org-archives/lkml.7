Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 804BAC468BD
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 19:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E7BC2166E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 19:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CcJVLs2B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbfFHTyi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 15:54:38 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33261 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727786AbfFHTyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 15:54:38 -0400
Received: by mail-pg1-f196.google.com with SMTP id k187so2411175pga.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jun 2019 12:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7z7G2uIs0k+svTX+jtZAzZRGJWQLvmM8i7xrZdjKEXo=;
        b=CcJVLs2BWQiGNei2MbtI6uiXWAb/JLA3+6p0R5uSVtGdgJCJSv6yBAMuVVe2LKu7DH
         l8XD5lo+nX6Zp9FSjvnoirPJj3PqQ/uQLGiLqOQDi+pkGFDKwHLf+gmhd/LdE0G3uhrZ
         wD7nPtsQWQn9SrOei/XUq/JRIZcZ9IQ9L7BVNycYvo5T1H4bWY/UCuF6GAqag1LkXIwA
         u7op+FLgpMulPzwHOKMdwW0xiGNuxLft8zAh4E235mgYFprMl4try5pTiEvU2XOMdT62
         XkvugA+tPg7D9SOJP8gqUJF+dr3kDnguAYW3MT2FNgYhzav+X/7lv4015xN+nLneo+4t
         LMZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7z7G2uIs0k+svTX+jtZAzZRGJWQLvmM8i7xrZdjKEXo=;
        b=LDOojtEAN0uoUvBGy8qOSlCvV5GaXHQ7/Fhr/OcfzYXpdujJsP7aqS+Rfe7Mq+irJ3
         CEbJVuP1QoS/IhRqqpryCy57Q3KVv2RZIF+nTAcD1KHGtnPdG1YAzdxMA6JkKNSxXDqm
         qk8Hzr9O+L2GlnN1lu4YM4vUsREdekYGILatqBWj1RCM0aCVbk9XxWd/309n5WAhcl5N
         AnOGT+gpS7rabyIGCKiiBbPsJCHeopuyJMHocCvvpJMFHv14W5BrQ7fhHgmP9VqAV5hz
         lO2UFRo4gK8BAn2U0DhOAUIfeHC0trAcVV+QbD6NSaNyXimSsHIsOO5gnvuDGZeBBNYY
         rp4w==
X-Gm-Message-State: APjAAAXVKHbeW3GJAg62ByHn2UVEfcrwIqlC9CH0NEVYJCObue4MqO5B
        4oaSPkon4fO+bGkW+hZacy49
X-Google-Smtp-Source: APXvYqzGq9Wlppe/fkGUI+bPzYy4jai5cTMOZ+AdImb8blZYRY64w3WjFSlIocF4HQh4o4FeAhE03Q==
X-Received: by 2002:a63:cc4e:: with SMTP id q14mr8601057pgi.84.1560023677661;
        Sat, 08 Jun 2019 12:54:37 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:7185:fba9:ec1e:ad07:23ac:d3ee])
        by smtp.gmail.com with ESMTPSA id b35sm6034377pjc.15.2019.06.08.12.54.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Jun 2019 12:54:37 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     ulf.hansson@linaro.org, afaerber@suse.de, robh+dt@kernel.org,
        sboyd@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        thomas.liau@actions-semi.com, linux-actions@lists.infradead.org,
        linus.walleij@linaro.org, linux-clk@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 7/7] arm64: configs: Enable Actions Semi platform in defconfig
Date:   Sun,  9 Jun 2019 01:23:17 +0530
Message-Id: <20190608195317.6336-8-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190608195317.6336-1-manivannan.sadhasivam@linaro.org>
References: <20190608195317.6336-1-manivannan.sadhasivam@linaro.org>
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
index 4d583514258c..e0b5f4f8c9ff 100644
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

