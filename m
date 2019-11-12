Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B70C17441
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 02:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D27E720818
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 02:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbfKLCKh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 21:10:37 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:47982 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727004AbfKLCKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 21:10:36 -0500
Received: from mr3.cc.vt.edu (mr3.cc.ipv6.vt.edu [IPv6:2607:b400:92:8500:0:7f:b804:6b0a])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id xAC2AZPr011467
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 21:10:35 -0500
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
        by mr3.cc.vt.edu (8.14.7/8.14.7) with ESMTP id xAC2AUbM005474
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 21:10:35 -0500
Received: by mail-qk1-f198.google.com with SMTP id m189so9188863qkc.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 18:10:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=DPYClz7LCDj0+BjYYDN7UOMear3Iae3kG0hEuBak2P8=;
        b=uZ+55OiRmMrDmAesv5L42vFs8N1gkBJa57Kghz0MjzVLmiTmLVTvkGPrJs9SJ2gYn6
         w1cCA5q26JzVXT+XJFp6nswQOddNTD1+eGplu3aRsbH5eyQiKU7QLJQhNUGGSS0+s64e
         4T987VPIX5yHJCG0xozzQibBdMQ1xAty/jYFdQVWsFkmoTWO+HU8gb1u5pzrKSUwQRL7
         eZ0KnG2M6vC/uYQPXWKXwg9ocwAs6XiVaIMSNwP/lnzbjnY+xrnr1yWcMzox+CcCZ3rq
         lZLuc+GSI4P4tFHmZ8Q8VsbPEsPBmV0WkeiNy9j5E5wiYCQVIb7eQyRMhW7Qeuttd+ey
         3mDg==
X-Gm-Message-State: APjAAAXOwq/poNhd/LjKfqx5mkrRhtl9oA65SwooW8/JI80xLPRTPlCN
        EMz80HawkGjUKvNljJPupcrkDKq1xvGOzqu4ZmXrriN1MW1TvnWLIKqvymtDDXY+E1Mac5th9cK
        86ht1zSWQGq314WCFHDedGLRryMU4hxYzy40=
X-Received: by 2002:a37:30b:: with SMTP id 11mr3819793qkd.254.1573524629779;
        Mon, 11 Nov 2019 18:10:29 -0800 (PST)
X-Google-Smtp-Source: APXvYqw2dur+yakoYVVJvPAEPbS3GqD5CoXaqf6BC9T/Frq5jGpMp/n1Sbs+SyzKW5RMGN/bLLZ0cQ==
X-Received: by 2002:a37:30b:: with SMTP id 11mr3819776qkd.254.1573524629505;
        Mon, 11 Nov 2019 18:10:29 -0800 (PST)
Received: from turing-police.lan ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id o195sm8004767qke.35.2019.11.11.18.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 18:10:28 -0800 (PST)
From:   Valdis Kletnieks <valdis.kletnieks@vt.edu>
X-Google-Original-From: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
To:     gregkh@linuxfoundation.org
Cc:     Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/9] staging: exfat: Clean up return codes - FFS_EOF
Date:   Mon, 11 Nov 2019 21:09:51 -0500
Message-Id: <20191112021000.42091-4-Valdis.Kletnieks@vt.edu>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191112021000.42091-1-Valdis.Kletnieks@vt.edu>
References: <20191112021000.42091-1-Valdis.Kletnieks@vt.edu>
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
2.24.0

