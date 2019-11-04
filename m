Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E09DCA9EBB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 01:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B94B20848
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 01:46:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729083AbfKDBqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 20:46:45 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:35646 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728847AbfKDBqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 20:46:44 -0500
Received: from mr5.cc.vt.edu (junk.cc.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id xA41kiG4010049
        for <linux-kernel@vger.kernel.org>; Sun, 3 Nov 2019 20:46:44 -0500
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        by mr5.cc.vt.edu (8.14.7/8.14.7) with ESMTP id xA41kc6T020021
        for <linux-kernel@vger.kernel.org>; Sun, 3 Nov 2019 20:46:43 -0500
Received: by mail-qt1-f197.google.com with SMTP id b26so13716981qtr.23
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2019 17:46:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=qTxGEwNV+Sk0SeHWmPXlOLn4RKQVFhpEvTO0Y4n51KM=;
        b=E3F7d2Qv/GlQ73JHKhIaaKiQg/HVxvZmjlnFL7L6tGUPFDR9SHVZehRUu/MRzjwYK7
         MYo6LMt3FZBYNrZXSw9grGoJU3QcGWmuWBDS/raXDnRmLgLpmRwn0bRz5R1VIDlsJqHT
         dyTlpfgdYFCxAosFmBGdgRytiOVskLimRmIavuJdyw4U554/O3miGNbCQ+3Gn+vgl+zY
         cgX2nx9j+fV2Fb0qyvNbvxz8yiUdG/hk7tVXbkjdlpcOjwkW8+HJVFi3AcKbcS/Nl91L
         X0/d93xcFQ4Q9RhataiJTvsbTsr92o8qer225LQuqYQLHwhEJbLpxFeL6mkuuHkzrfVC
         P5Tg==
X-Gm-Message-State: APjAAAX37VlyvNDACKheMZw/1KIFKzfh+o92Uk4nE5krRQpGeE7bUUOG
        uvvxRTrTJc7/S9cm9vlrFwKBxlvmd4rK5+NiqEluaxOKG4ccZHm/CdPNAOL6oqI7gUxKN8fOVfU
        1IqbPctobpeje8fxfQIi/1n4h7rprpxbnMXw=
X-Received: by 2002:a37:94e:: with SMTP id 75mr11659249qkj.49.1572831998704;
        Sun, 03 Nov 2019 17:46:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqyNOdjoS+XWcHbmgBG9GQ0EzR72CJJzmH1aqr3uutJM0tM9TeQrkLe8PfSFtpgshzvA329kuQ==
X-Received: by 2002:a37:94e:: with SMTP id 75mr11659237qkj.49.1572831998459;
        Sun, 03 Nov 2019 17:46:38 -0800 (PST)
Received: from turing-police.lan ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id d2sm8195354qkg.77.2019.11.03.17.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2019 17:46:37 -0800 (PST)
From:   Valdis Kletnieks <valdis.kletnieks@vt.edu>
X-Google-Original-From: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
To:     Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
Cc:     Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/10] staging: exfat: Correct return code
Date:   Sun,  3 Nov 2019 20:45:05 -0500
Message-Id: <20191104014510.102356-10-Valdis.Kletnieks@vt.edu>
X-Mailer: git-send-email 2.24.0.rc1
In-Reply-To: <20191104014510.102356-1-Valdis.Kletnieks@vt.edu>
References: <20191104014510.102356-1-Valdis.Kletnieks@vt.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use -ENOTEMPTY rather than -EEXIST for attempting to remove
a directory that still has files in it.

Signed-off-by: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
---
 drivers/staging/exfat/exfat_super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index a97a61a60517..e2254d45ef6e 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -2167,7 +2167,7 @@ static int ffsRemoveDir(struct inode *inode, struct file_id_t *fid)
 	clu_to_free.flags = fid->flags;
 
 	if (!is_dir_empty(sb, &clu_to_free)) {
-		ret = -EEXIST;
+		ret = -ENOTEMPTY;
 		goto out;
 	}
 
-- 
2.24.0.rc1

