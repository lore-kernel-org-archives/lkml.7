Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37230CA9EBB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 01:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 073A121D7C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 01:46:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728922AbfKDBqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 20:46:07 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:35566 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728877AbfKDBqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 20:46:06 -0500
Received: from mr4.cc.vt.edu (mr4.cc.ipv6.vt.edu [IPv6:2607:b400:92:8300:0:7b:e2b1:6a29])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id xA41k5Hr009911
        for <linux-kernel@vger.kernel.org>; Sun, 3 Nov 2019 20:46:05 -0500
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
        by mr4.cc.vt.edu (8.14.7/8.14.7) with ESMTP id xA41k0Xt026062
        for <linux-kernel@vger.kernel.org>; Sun, 3 Nov 2019 20:46:05 -0500
Received: by mail-qt1-f199.google.com with SMTP id k9so17423721qtg.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2019 17:46:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=v4VlzHRnLSC3b1EjzBkiWjmC1bP42YDPnuAdgZvBprM=;
        b=LJasfQ/ElOwriHLsNArRUeyBXiBPCymiR9qkzi9sc5LVTu+vB2x4go8xzV2P3Xda/7
         2X+atW8dWfwN+QkgKG9PTtTaFBkvRr9ukMJx+TgutYHjDYpkF7O74Gk7piGAVO3Fr/hD
         TBmdcrVaWzCnevI3nT1uxwzAC+PiKayWjogFjolUjCjvvdtnpz+WFvumtjSTCu2bFg2O
         bvf/6xmeRyE1ZQpI3l56an0KImAdQLONxJZGf39rLC7JzuDMFI1mObzF3ACOv3Mo9i7B
         IggARBq9eOy7FUpN6UeEdTDpHy6bM+E+zr7mBk1fE2Kp+KEN7PJnaXfADzn/1TdXH7n9
         ACMA==
X-Gm-Message-State: APjAAAWd76WvuVlNFwKe9LtsQJa4nJYgx6TodJsn0Vi0gROMxLvI6Usf
        vJ0exxARZuDocyupnEp3Uj7Pjjb0YKh+1WZz7aUfNXraf/rijkfQPvoaThhpgA2bkIXo8qXnkVC
        bsceRSoXfmHw0OBvfU3qVxFG/QuVFSRaCZNY=
X-Received: by 2002:ad4:5429:: with SMTP id g9mr20440308qvt.27.1572831959968;
        Sun, 03 Nov 2019 17:45:59 -0800 (PST)
X-Google-Smtp-Source: APXvYqwXoWMfSxtMRA4ckuqq21dK8J+BAjDxrP0r0w/l8V1aRV7ziX/XVpeMeGToZS1TbuMSc3RYUg==
X-Received: by 2002:ad4:5429:: with SMTP id g9mr20440300qvt.27.1572831959712;
        Sun, 03 Nov 2019 17:45:59 -0800 (PST)
Received: from turing-police.lan ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id d2sm8195354qkg.77.2019.11.03.17.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2019 17:45:58 -0800 (PST)
From:   Valdis Kletnieks <valdis.kletnieks@vt.edu>
X-Google-Original-From: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
To:     Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
Cc:     Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/10] staging: exfat: Clean up return codes - FFS_EOF
Date:   Sun,  3 Nov 2019 20:44:59 -0500
Message-Id: <20191104014510.102356-4-Valdis.Kletnieks@vt.edu>
X-Mailer: git-send-email 2.24.0.rc1
In-Reply-To: <20191104014510.102356-1-Valdis.Kletnieks@vt.edu>
References: <20191104014510.102356-1-Valdis.Kletnieks@vt.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert FFS_EOF to return 0 for a zero-length read() as per 'man 2 read'.

Signed-off-by: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
---
 drivers/staging/exfat/exfat.h       | 1 -
 drivers/staging/exfat/exfat_super.c | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index 286605262345..292af85e3cd2 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -217,7 +217,6 @@ static inline u16 get_row_index(u16 i)
 #define FFS_INVALIDFID          8
 #define FFS_NOTOPENED           12
 #define FFS_MAXOPENED           13
-#define FFS_EOF                 15
 #define FFS_ERROR               19
 
 #define NUM_UPCASE              2918
diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index d6d5f0fd47fd..7c99d1f8cba8 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -723,7 +723,7 @@ static int ffsReadFile(struct inode *inode, struct file_id_t *fid, void *buffer,
 	if (count == 0) {
 		if (rcount)
 			*rcount = 0;
-		ret = FFS_EOF;
+		ret = 0;
 		goto out;
 	}
 
-- 
2.24.0.rc1

