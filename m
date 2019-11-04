Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B105CA9EBB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 01:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C45221D7C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 01:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728995AbfKDBqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 20:46:15 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:39748 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728957AbfKDBqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 20:46:12 -0500
Received: from mr2.cc.vt.edu (mr2.cc.vt.edu [IPv6:2607:b400:92:8400:0:90:e077:bf22])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id xA41kAcB025792
        for <linux-kernel@vger.kernel.org>; Sun, 3 Nov 2019 20:46:10 -0500
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
        by mr2.cc.vt.edu (8.14.7/8.14.7) with ESMTP id xA41k5Ds008067
        for <linux-kernel@vger.kernel.org>; Sun, 3 Nov 2019 20:46:10 -0500
Received: by mail-qk1-f197.google.com with SMTP id o184so16281439qke.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2019 17:46:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=nCdjs/guPQ346vNtYDwvfg9pb4hZkLVUac954rX/dpk=;
        b=YJfuykRo+0PrvoeQejsI92HmSMqWZpzzjZ7bNw4+w62z9UzEs3+QRK/E58GO6y8nC9
         frLuGehFPxCo46VWEki9LNKxhIm01iZG0XQOuCq5KyDzOezaBfxwUqYyKdZSFZVWK+f9
         rE2GR+XHXpfOd822D/4eCUIk7Lp33GfjCtP/HBdm7XjjXw9ooDexPLuioPn+hXWSMAK/
         N+LyEkQSe59+8YBUdgYsWAhJVcfRxqBVfCyibyabyiZG3l2MXcWxOaztiZZyWhjzhXtc
         otijGi1umPfjjf0khO38RfJDx5SJzm/kBxROvCmVUU68Zzy7Ekz7w/Gl4/+v8mC1vkak
         A1tQ==
X-Gm-Message-State: APjAAAV6W01vk9BpMPL2dZi+9W7PYVTekFExRzaRz7eW87TPfLPClHZF
        SXRac8pW4OQufV7tOvIDRC5FgJ3pV6h6sxDuTdjKIR5hdtNsJJquIq9cB4ScFi3Qn0nXGCcnJT3
        Y9DornTcdCAs+EKsDu4vP8+0w/vk8WjPuc9o=
X-Received: by 2002:a05:620a:120e:: with SMTP id u14mr7746815qkj.325.1572831965531;
        Sun, 03 Nov 2019 17:46:05 -0800 (PST)
X-Google-Smtp-Source: APXvYqz2m7WN/D3Ffc/jabz7utsgrdaTFRm3V+LReg6jgNuifx+Z/76kOMw/7712smDxSyi/e4NGnQ==
X-Received: by 2002:a05:620a:120e:: with SMTP id u14mr7746805qkj.325.1572831965261;
        Sun, 03 Nov 2019 17:46:05 -0800 (PST)
Received: from turing-police.lan ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id d2sm8195354qkg.77.2019.11.03.17.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2019 17:46:04 -0800 (PST)
From:   Valdis Kletnieks <valdis.kletnieks@vt.edu>
X-Google-Original-From: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
To:     Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
Cc:     Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/10] staging: exfat: Clean up return codes - FFS_INVALIDFID
Date:   Sun,  3 Nov 2019 20:45:00 -0500
Message-Id: <20191104014510.102356-5-Valdis.Kletnieks@vt.edu>
X-Mailer: git-send-email 2.24.0.rc1
In-Reply-To: <20191104014510.102356-1-Valdis.Kletnieks@vt.edu>
References: <20191104014510.102356-1-Valdis.Kletnieks@vt.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Covert FFS_INVALIDFID to -EINVAL

Signed-off-by: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
---
 drivers/staging/exfat/exfat.h       |  1 -
 drivers/staging/exfat/exfat_super.c | 10 +++++-----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index 292af85e3cd2..7a817405c624 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -214,7 +214,6 @@ static inline u16 get_row_index(u16 i)
 #define FFS_NOTMOUNTED          4
 #define FFS_ALIGNMENTERR        5
 #define FFS_SEMAPHOREERR        6
-#define FFS_INVALIDFID          8
 #define FFS_NOTOPENED           12
 #define FFS_MAXOPENED           13
 #define FFS_ERROR               19
diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index 7c99d1f8cba8..dd6530aef63a 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -699,7 +699,7 @@ static int ffsReadFile(struct inode *inode, struct file_id_t *fid, void *buffer,
 
 	/* check the validity of the given file id */
 	if (!fid)
-		return FFS_INVALIDFID;
+		return -EINVAL;
 
 	/* check the validity of pointer parameters */
 	if (!buffer)
@@ -831,7 +831,7 @@ static int ffsWriteFile(struct inode *inode, struct file_id_t *fid,
 
 	/* check the validity of the given file id */
 	if (!fid)
-		return FFS_INVALIDFID;
+		return -EINVAL;
 
 	/* check the validity of pointer parameters */
 	if (!buffer)
@@ -1237,7 +1237,7 @@ static int ffsMoveFile(struct inode *old_parent_inode, struct file_id_t *fid,
 
 	/* check the validity of the given file id */
 	if (!fid)
-		return FFS_INVALIDFID;
+		return -EINVAL;
 
 	/* check the validity of pointer parameters */
 	if (!new_path || (*new_path == '\0'))
@@ -1358,7 +1358,7 @@ static int ffsRemoveFile(struct inode *inode, struct file_id_t *fid)
 
 	/* check the validity of the given file id */
 	if (!fid)
-		return FFS_INVALIDFID;
+		return -EINVAL;
 
 	/* acquire the lock for file system critical section */
 	mutex_lock(&p_fs->v_mutex);
@@ -2145,7 +2145,7 @@ static int ffsRemoveDir(struct inode *inode, struct file_id_t *fid)
 
 	/* check the validity of the given file id */
 	if (!fid)
-		return FFS_INVALIDFID;
+		return -EINVAL;
 
 	dir.dir = fid->dir.dir;
 	dir.size = fid->dir.size;
-- 
2.24.0.rc1

