Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C324C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 16:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2865A2087F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 16:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbfH3Qmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 12:42:49 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:45086 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728246AbfH3Qms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 12:42:48 -0400
Received: from mr4.cc.vt.edu (mail.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x7UGglAQ012145
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 12:42:47 -0400
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
        by mr4.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x7UGggVe004889
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 12:42:47 -0400
Received: by mail-qk1-f198.google.com with SMTP id o4so7932580qkg.11
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 09:42:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version:date
         :message-id;
        bh=AMywH1n1mw6t5p5hLpZTz0Q6W8htDSaR2tsRwWJpbB4=;
        b=PSM0hXySuyUo6FKNwnQhhJFozdU56VrY6V6ER239OAV7JMKT1OdM1MCwcI+loqEOp8
         qJs4u/Mt7Tn7rxya7cFPwwcIdsiDLEEfPp3bx0cglCAOdHHroNImF72JVdlBP6iv91uZ
         UmphT6fOkg+WyFuEOtCftm59BGtK1B5/LYNuIpiYmZritVbM/cLIBitRkQaGNP+aJS01
         FY/lLLsUMUC4xum2pxwnnBm7PJUh3Ck0PYs8yc6JCZKDSI/qamnS7og1gUafdwQHX7LU
         9EYocYUZTEB1NtLisrDNFisv43BU+pawdfqan2jd6he2QjI2b4iVtTOja/CrrYG71Ztt
         OInQ==
X-Gm-Message-State: APjAAAWXxYDwc2O/UGhPmmJp7qzSm54HgTxjtLajvfmtSGZ+gkO4/g3+
        5/PATHZgLRXimSQKwZzUStlkPtPc1MXAV7bzcP1rMFtwLjhNGZoL2gfVXpOfcb6iRa7g84VSicT
        9TezUP36NeYY2oSKRte/55IcQ0ZJVY32usPw=
X-Received: by 2002:ac8:120c:: with SMTP id x12mr8899872qti.315.1567183361985;
        Fri, 30 Aug 2019 09:42:41 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwaY2l4b6tk1M6trceqg9AZjRhcMlNGwJvpCK2NExWnBnD86JM81kuWaQfA7O5TUsj17REnaA==
X-Received: by 2002:ac8:120c:: with SMTP id x12mr8899847qti.315.1567183361693;
        Fri, 30 Aug 2019 09:42:41 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4340::ba0])
        by smtp.gmail.com with ESMTPSA id f27sm2703076qkl.25.2019.08.30.09.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 09:42:40 -0700 (PDT)
From:   "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>,
        Christoph Hellwig <hch@infradead.org>
cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/staging/exfat - by default, prohibit mount of fat/vfat
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Fri, 30 Aug 2019 12:42:39 -0400
Message-ID: <245727.1567183359@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Concerns have been raised about the exfat driver accidentally mounting
fat/vfat file systems.  Add an extra configure option to help prevent that.

Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

diff --git a/drivers/staging/exfat/Kconfig b/drivers/staging/exfat/Kconfig
index 78b32aa2ca19..1df177b1dc72 100644
--- a/drivers/staging/exfat/Kconfig
+++ b/drivers/staging/exfat/Kconfig
@@ -4,6 +4,14 @@ config EXFAT_FS
 	help
 	  This adds support for the exFAT file system.
 
+config EXFAT_DONT_MOUNT_VFAT
+	bool "Prohibit mounting of fat/vfat filesysems by exFAT"
+	default y
+	help
+	  By default, the exFAT driver will only mount exFAT filesystems, and refuse
+	  to mount fat/vfat filesystems.  Set this to 'n' to allow the exFAT driver
+	  to mount these filesystems.
+
 config EXFAT_DISCARD
 	bool "enable discard support"
 	depends on EXFAT_FS
diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index 5b5c2ca8c9aa..7fdb5b8bc928 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -486,10 +486,16 @@ static int ffsMountVol(struct super_block *sb)
 			break;
 
 	if (i < 53) {
+#ifdef CONFIG_EXFAT_DONT_MOUNT_VFAT
+		ret = -EINVAL;
+		printk(KERN_INFO "EXFAT: Attempted to mount VFAT filesystem\n");
+		goto out;
+#else
 		if (GET16(p_pbr->bpb + 11)) /* num_fat_sectors */
 			ret = fat16_mount(sb, p_pbr);
 		else
 			ret = fat32_mount(sb, p_pbr);
+#endif
 	} else {
 		ret = exfat_mount(sb, p_pbr);
 	}

