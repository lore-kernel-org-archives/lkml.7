Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD3AC76188
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 10:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 032AD2085A
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 10:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hLJyV9Dj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbfGUKtY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 06:49:24 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42579 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbfGUKtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 06:49:24 -0400
Received: by mail-pf1-f193.google.com with SMTP id q10so16006444pff.9
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2019 03:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=eKFZ+EJBtskl1K3Uj/6mEks//mPAAbWUtGxEDCSbwhI=;
        b=hLJyV9DjZPboQ7KXy5p51iwcZvwuln7M6OXpjcGUp3WjsgHpwSD39IogMlGKXrsdcY
         S+M1yzJ7XZUR6LSSuqOxYvWjKNsrHyy0cQjnjwNDUIjoI+WgIkhtwb2Hx3xzoQPmUrWf
         rjO+HfphX62VK4lSatvndtye0xK5Fpp9OjqSmVObNLtOv8b3YahgNMlSDBjQbsuWXXFk
         +y7cSY4D96Lw3Af6Fr/o0QibV5aU4DYg2h9upvET5wFE+MYaTLDMM40rNSDirEoXM7Mp
         V0mvN5e3DOQha2i1J48HaJPCCuli4fieJDhh/ppyJ1/AqZ4efWxSg6EK68bYFgYexio3
         Rzdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=eKFZ+EJBtskl1K3Uj/6mEks//mPAAbWUtGxEDCSbwhI=;
        b=qospySIAGB10hzNbM8JgASca13LbokCRsc0y/ogZoTQoklTBQq8wfpecgoVl12t2+m
         7AgZtVb8FZ27G39WNOxv7bcJFgCX2JYfEZJqjq7NNo0NJX5ClYzZNz/TQCzDlE1tVrN7
         ATMSQEqMaWqsnLx0HddmVRish/j0bMkS1u50dnIk+pkYdlmHXKdWaNWprj51SYiJ5RD1
         440LrsayOnpYRd4cuBjM0xrpIo4Dosncf/nzYT+j4tNzLH4IN0onfj1s2E3c5aG7jpDx
         e9NqNcSFtU7Z+qC3zW62N8VAXeafQQb34UJPbwQOD9Iuq0QGbHAwLCxeJOocrA8CjLjk
         /Nrw==
X-Gm-Message-State: APjAAAVqtlRCdZixxzMGCWlixH6ifbxOxntBmYCI9PIVupnlxbEqsgNB
        4O753+lsFbHDFnmnlnA0ooE=
X-Google-Smtp-Source: APXvYqyPW325GP+WXejUuGAHO4b7Sgym3wb9RCTAINF/vHd801OWKwoP7wpSCgDF/91Tcu0ehPezAQ==
X-Received: by 2002:a63:d04e:: with SMTP id s14mr62897813pgi.189.1563706163666;
        Sun, 21 Jul 2019 03:49:23 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.86.126])
        by smtp.gmail.com with ESMTPSA id l4sm36276472pff.50.2019.07.21.03.49.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Jul 2019 03:49:22 -0700 (PDT)
Date:   Sun, 21 Jul 2019 16:19:17 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Dave Kleikamp <shaggy@kernel.org>,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] jfs: Change return type of txLog
Message-ID: <20190721104917.GA4627@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As txLog always returns 0 change return type from int to void.

fix below issue reported by coccicheck 
/fs/jfs/jfs_txnmgr.c:1370:5-7: Unneeded variable: "rc". Return "0" on
line 1417


Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 fs/jfs/jfs_txnmgr.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/fs/jfs/jfs_txnmgr.c b/fs/jfs/jfs_txnmgr.c
index c8ce7f1..645cd0a2 100644
--- a/fs/jfs/jfs_txnmgr.c
+++ b/fs/jfs/jfs_txnmgr.c
@@ -159,8 +159,8 @@ static void mapLog(struct jfs_log * log, struct tblock * tblk, struct lrd * lrd,
 static void txAllocPMap(struct inode *ip, struct maplock * maplock,
 		struct tblock * tblk);
 static void txForce(struct tblock * tblk);
-static int txLog(struct jfs_log * log, struct tblock * tblk,
-		struct commit * cd);
+static void txLog(struct jfs_log *log, struct tblock *tblk,
+		struct commit *cd);
 static void txUpdateMap(struct tblock * tblk);
 static void txRelease(struct tblock * tblk);
 static void xtLog(struct jfs_log * log, struct tblock * tblk, struct lrd * lrd,
@@ -1256,8 +1256,7 @@ int txCommit(tid_t tid,		/* transaction identifier */
 	 *
 	 * txUpdateMap() resets XAD_NEW in XAD.
 	 */
-	if ((rc = txLog(log, tblk, &cd)))
-		goto TheEnd;
+	 txLog(log, tblk, &cd);
 
 	/*
 	 * Ensure that inode isn't reused before
@@ -1365,9 +1364,8 @@ int txCommit(tid_t tid,		/* transaction identifier */
  *
  * RETURN :
  */
-static int txLog(struct jfs_log * log, struct tblock * tblk, struct commit * cd)
+static void txLog(struct jfs_log *log, struct tblock *tblk, struct commit *cd)
 {
-	int rc = 0;
 	struct inode *ip;
 	lid_t lid;
 	struct tlock *tlck;
@@ -1413,8 +1411,6 @@ static int txLog(struct jfs_log * log, struct tblock * tblk, struct commit * cd)
 			jfs_err("UFO tlock:0x%p", tlck);
 		}
 	}
-
-	return rc;
 }
 
 /*
-- 
2.7.4

