Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C85C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 17:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56E472190A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 17:03:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h2HLm9tt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbfCURDp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 13:03:45 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:50525 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728013AbfCURDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 13:03:43 -0400
Received: by mail-it1-f195.google.com with SMTP id m137so5435652ita.0;
        Thu, 21 Mar 2019 10:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9bmNiIiYSXpSlnRBJipd8bRpL/IMsEPjbQrVWRlU9SA=;
        b=h2HLm9ttoJzyWmFCPllwKVOFnmaKmLYsADm7Re/c7mDSJX6cJAkYIq8Brpxp8lzOVJ
         ueSygsrYrHr6bLG66E+RCS+W55QVpSc+Nqxg/Ts8e1iGuXCTtrw+jT9I6IBHofwYWtbR
         vZozciCYArpSZt+nXmVzKnXHPEDacJd0djR7rMD9eCoJGgh0323QFkjwDRcvFRaJFdkd
         SfvbL8c4g41REHm02adqPWfvcOHa7nCr038UhslI/G8h39UGDvx5m3A9jNf6eby5wrza
         DiXIPE/j3N1jS5EeabiIwRdca5ObRMJnQBl8g3EPGIjILpAi6IrMF4cbumLQdiFFCNG/
         2Znw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9bmNiIiYSXpSlnRBJipd8bRpL/IMsEPjbQrVWRlU9SA=;
        b=c4EXRtdv58oc7qjbkX1/+t9eu5q1fDuCLk9GnR3TSn+BVpLdSkuJ6wQm1bamT+fuJI
         c5CXQjPkmhJyQNkPbic0AWfoItdJD3d3FU3B/E7LI5Lu0hvAeTPLJ2mKumjm00X8LyXn
         qrH0ezMoFYsE3mj8tgTqRWhqh9ByIMbkzWLFBHkeO0hgYSL9R/fK1NWZfYXt4vlrZtoG
         cWA436uYkaHfvImFnYtSIpnTz8VbVQySoPlcr0oGy9OkmRK1qJFX1sgyTRTjVQCabTMQ
         althpBKLCDV9Ydcaiu4MWYPxrRpjrDcZJYThJRgucFtuoNq1SlhRzYJK8aoftqyypINa
         WH4Q==
X-Gm-Message-State: APjAAAW/kF5rWL8ze6nrNiZ9OeGZGtyocKO6xA/2SPFnaHR7FTiyyFpy
        SddlSOngU0GeFhtGtT849SM=
X-Google-Smtp-Source: APXvYqwC0i60GO2oaG0501xzeRAEuJFw0K1CqY9l1jq8o4oEypffAnsOoqHfkqiu1tU9DU/PpF4q0w==
X-Received: by 2002:a24:6948:: with SMTP id e69mr411341itc.140.1553187822124;
        Thu, 21 Mar 2019 10:03:42 -0700 (PDT)
Received: from localhost.localdomain (c-73-242-244-99.hsd1.nm.comcast.net. [73.242.244.99])
        by smtp.gmail.com with ESMTPSA id t23sm2577951ioj.19.2019.03.21.10.03.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 10:03:41 -0700 (PDT)
From:   George Hilliard <thirtythreeforty@gmail.com>
To:     Paul Burton <paul.burton@mips.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        George Hilliard <thirtythreeforty@gmail.com>
Subject: [RESEND PATCH] mips: ralink: allow zboot
Date:   Thu, 21 Mar 2019 11:03:34 -0600
Message-Id: <20190321170334.15122-2-thirtythreeforty@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190321170334.15122-1-thirtythreeforty@gmail.com>
References: <20190321170334.15122-1-thirtythreeforty@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Architecturally, there's nothing preventing compressed images from
working.  Bootloaders built with support for the various compression
methods can decompress and run the kernel.  In practice, many
bootloaders do not support compressed images, but kernels for those
boards should just not be compressed.

Tested on an MT7688 with U-Boot doing LZMA decompression of uImage.

Signed-off-by: George Hilliard <thirtythreeforty@gmail.com>
---
 arch/mips/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 4a5f5b0ee9a9..b286fbbd9699 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -619,6 +619,7 @@ config RALINK
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 	select SYS_SUPPORTS_MIPS16
+	select SYS_SUPPORTS_ZBOOT
 	select SYS_HAS_EARLY_PRINTK
 	select CLKDEV_LOOKUP
 	select ARCH_HAS_RESET_CONTROLLER
-- 
2.21.0

