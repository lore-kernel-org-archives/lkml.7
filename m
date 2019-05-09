Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31243C04AB2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CD0A2177E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:09:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Ty+mA9f2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbfEISJy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 14:09:54 -0400
Received: from mail.skyhub.de ([5.9.137.197]:36996 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726686AbfEISJm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 14:09:42 -0400
Received: from zn.tnic (p200300EC2F0F5F0071783F241746291C.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:5f00:7178:3f24:1746:291c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C5E8A1EC0AB1;
        Thu,  9 May 2019 20:09:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1557425381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yT6UDLNwTwdWvAssPx4cqJ9QuilTsvk/SQF0VjYpQSc=;
        b=Ty+mA9f2PNbXmL3/gFdWmxaKFTKd1wUCwoYxq9dV6Hl54wMWvjQYiN0E/A/n4cdeDvaE3+
        HBGISidm5nMUT0STP2lq83k1IeEliHlNBjAZ6dlToGtt1KOXUFLCy4boki88iOHcgQr3/P
        aYx025XzQHbSQV5w6YfdjFBZch6rhXg=
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     linux-edac <linux-edac@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 10/11] RAS/CEC: Add CONFIG_RAS_CEC_DEBUG and move CEC debug features there
Date:   Thu,  9 May 2019 20:09:25 +0200
Message-Id: <20190509180926.31932-11-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190509180926.31932-1-bp@alien8.de>
References: <20190509180926.31932-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Luck <tony.luck@intel.com>

The pfn and array files in (debugfs)/ras/cec are intended for debugging
the CEC code itself. They are not needed on production systems, so the
default setting for this CONFIG option is "n".

 [ bp: Have it with less ifdeffery by using IS_ENABLED(). ]

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/ras/Kconfig | 10 ++++++++++
 drivers/ras/cec.c    | 26 ++++++++++++++------------
 2 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/arch/x86/ras/Kconfig b/arch/x86/ras/Kconfig
index a9c3db125222..9ad6842de4b4 100644
--- a/arch/x86/ras/Kconfig
+++ b/arch/x86/ras/Kconfig
@@ -11,3 +11,13 @@ config RAS_CEC
 
 	  Bear in mind that this is absolutely useless if your platform doesn't
 	  have ECC DIMMs and doesn't have DRAM ECC checking enabled in the BIOS.
+
+config RAS_CEC_DEBUG
+	bool "CEC debugging machinery"
+	default n
+	depends on RAS_CEC
+	help
+	  Add extra files to (debugfs)/ras/cec to test the correctable error
+	  collector feature. "pfn" is a writable file that allows user to
+	  simulate an error in a particular page frame. "array" is a read-only
+	  file that dumps out the current state of all pages logged so far.
diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
index 71f3e14c35d8..c4505c0893a7 100644
--- a/drivers/ras/cec.c
+++ b/drivers/ras/cec.c
@@ -486,18 +486,6 @@ static int __init create_debugfs_nodes(void)
 		return -1;
 	}
 
-	pfn = debugfs_create_file("pfn", S_IRUSR | S_IWUSR, d, &dfs_pfn, &pfn_ops);
-	if (!pfn) {
-		pr_warn("Error creating pfn debugfs node!\n");
-		goto err;
-	}
-
-	array = debugfs_create_file("array", S_IRUSR, d, NULL, &array_ops);
-	if (!array) {
-		pr_warn("Error creating array debugfs node!\n");
-		goto err;
-	}
-
 	decay = debugfs_create_file("decay_interval", S_IRUSR | S_IWUSR, d,
 				    &decay_interval, &decay_interval_ops);
 	if (!decay) {
@@ -512,6 +500,20 @@ static int __init create_debugfs_nodes(void)
 		goto err;
 	}
 
+	if (!IS_ENABLED(CONFIG_RAS_CEC_DEBUG))
+		return 0;
+
+	pfn = debugfs_create_file("pfn", S_IRUSR | S_IWUSR, d, &dfs_pfn, &pfn_ops);
+	if (!pfn) {
+		pr_warn("Error creating pfn debugfs node!\n");
+		goto err;
+	}
+
+	array = debugfs_create_file("array", S_IRUSR, d, NULL, &array_ops);
+	if (!array) {
+		pr_warn("Error creating array debugfs node!\n");
+		goto err;
+	}
 
 	return 0;
 
-- 
2.21.0

