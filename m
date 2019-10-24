Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D32CA9EBC
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 15:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5837D20684
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 15:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409818AbfJXPyS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 11:54:18 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:42738 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2409778AbfJXPyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 11:54:16 -0400
Received: from mr1.cc.vt.edu (mail.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x9OFsFsi010033
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 11:54:15 -0400
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
        by mr1.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x9OFsAmA022914
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 11:54:15 -0400
Received: by mail-qt1-f199.google.com with SMTP id 44so18983930qtu.20
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 08:54:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=MUvS5PDnwB4+WdsZuJfNIUv2476cZnvleiETBi+G30w=;
        b=kn13Zwc5Iec3Lls+6zuMwqC3vHOzGe1xU3Vmd1zeoNVw5EVWKIb1WZPXREbjjDpg6x
         Zurk33pseR5xNJ2jbxCG1YmGQYl5HK9o6jR+wH3JFsTZpH8x9m+EgVCF248pl7BUlEGE
         NcgxvnaMkHrVm34tdBEp/CtOzjNY98+9fnXgSfzpAns1sZJEq0Rb/M0ADEn7j6Kiny7D
         IrgG9S1YJ6i70tSt7DA7NvIxg+XAPjJ84Q4nyDGUH2iq/Tz/rMdVUn36mdJncqszFJ0c
         Y7Izs3iSC62tnI6djXHm5K41n8F7HdRa2/MxqLfsA29hjDxli7ZMIzN/hhYwQVreFGIC
         ZkxQ==
X-Gm-Message-State: APjAAAUzQ8pbwyzztwVEHD5KVpf2FKSVZ/m/Ag+x0wS/8fdr3ue2cLs3
        N8qltL4pyatyCHe+eSEQPmP757NihcIw7wWkcnT3zPcAjM6tuwhpIqP0gUccck2Le6SenCQ5l/r
        SYl+M3gOMGNGgx2PKUYQiBjtwH0co+U/HONQ=
X-Received: by 2002:a37:2d45:: with SMTP id t66mr14453491qkh.259.1571932449983;
        Thu, 24 Oct 2019 08:54:09 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyv0THDRF5Q8L/pxFbc9GDAB6Ang93ytLfBAJhcM8jNwiofzVTAkF/B5LwGaOEgwq3ULpiVKA==
X-Received: by 2002:a37:2d45:: with SMTP id t66mr14453464qkh.259.1571932449713;
        Thu, 24 Oct 2019 08:54:09 -0700 (PDT)
Received: from turing-police.lan ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id x133sm12693274qka.44.2019.10.24.08.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 08:54:08 -0700 (PDT)
From:   Valdis Kletnieks <valdis.kletnieks@vt.edu>
X-Google-Original-From: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/15] staging: exfat: Clean up return codes - FFS_DIRBUSY
Date:   Thu, 24 Oct 2019 11:53:14 -0400
Message-Id: <20191024155327.1095907-4-Valdis.Kletnieks@vt.edu>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191024155327.1095907-1-Valdis.Kletnieks@vt.edu>
References: <20191024155327.1095907-1-Valdis.Kletnieks@vt.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert FFS_DIRBUSY to -EBUSY

Signed-off-by: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
---
 drivers/staging/exfat/exfat.h       | 1 -
 drivers/staging/exfat/exfat_super.c | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index 1d82de4e1a5c..ec52237b01cd 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -221,7 +221,6 @@ static inline u16 get_row_index(u16 i)
 #define FFS_NOTOPENED           12
 #define FFS_MAXOPENED           13
 #define FFS_EOF                 15
-#define FFS_DIRBUSY             16
 #define FFS_MEMORYERR           17
 #define FFS_NAMETOOLONG		18
 #define FFS_ERROR               19
diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index 50fc097ded69..566cfba0a522 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -2697,7 +2697,7 @@ static int exfat_rmdir(struct inode *dir, struct dentry *dentry)
 			err = -ENOTEMPTY;
 		else if (err == -ENOENT)
 			err = -ENOENT;
-		else if (err == FFS_DIRBUSY)
+		else if (err == -EBUSY)
 			err = -EBUSY;
 		else
 			err = -EIO;
-- 
2.23.0

