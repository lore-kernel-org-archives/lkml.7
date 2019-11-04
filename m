Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78602CA9EBB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 01:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 580BD21D7C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 01:46:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729032AbfKDBqX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 20:46:23 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:39764 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728997AbfKDBqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 20:46:21 -0500
Received: from mr6.cc.vt.edu (mr6.cc.vt.edu [IPv6:2607:b400:92:8500:0:af:2d00:4488])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id xA41kLOT025828
        for <linux-kernel@vger.kernel.org>; Sun, 3 Nov 2019 20:46:21 -0500
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
        by mr6.cc.vt.edu (8.14.7/8.14.7) with ESMTP id xA41kFrq017758
        for <linux-kernel@vger.kernel.org>; Sun, 3 Nov 2019 20:46:21 -0500
Received: by mail-qt1-f199.google.com with SMTP id u26so17367305qtq.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2019 17:46:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=t2ehr98/+rTL7PfDpH8Ry/AJxdIjjPlUhdGTTfS2sb8=;
        b=XSN6K3a/mzq1d6ycLvj2j5eL4V2T6qJuLS8owolkAdF6G6kD5DfjENNxPiKaU6rv6d
         cufiPCQKFp+1u5Q9Nr2SUhuLonidFq102NGlrH808ktSd63ej0kfdkh8CqlhaarPZpv1
         +zDyQ+CuQNYfLgpr7J6GCyMuyrqJjwgrBJGvRYlK5LsADp/8jOv8Dl7aNQ8eQzIinDx3
         BmRJiDRwpj6sRvLb5JgfeaDjT35TBHrvUA4gxZon34eoDNC3M0xEG1TYSeiDp8l7plAz
         Gipd7iFI+pFhkKqVt12hiaVM817dK3EZUNFJyt3dZUU4lM8MXbwYl2zL2KPDjX/vJdow
         v3iQ==
X-Gm-Message-State: APjAAAVUJ3jxozdIkeTMAOa6HzcUmX4Eyi+mQ2fmkL2Jwb5SHfZWDNWA
        zVZaVExS14Ba56d0fXnJGhhQrdI1taGmBQ5lnVScWqiVfVqacRbDo5cidlLohES+ezuqEEA0Paa
        YQbvLm02ed3MrK7LoJXfSAoQFgGqyHodLo+4=
X-Received: by 2002:a05:620a:147c:: with SMTP id j28mr981930qkl.26.1572831975752;
        Sun, 03 Nov 2019 17:46:15 -0800 (PST)
X-Google-Smtp-Source: APXvYqwmwjNIr9K00FS6v/P5pCflkjocTlPkPXDpcvEsmRL8Nav7frFQIOeb/vbYK9VsqWlId1xUiA==
X-Received: by 2002:a05:620a:147c:: with SMTP id j28mr981912qkl.26.1572831975498;
        Sun, 03 Nov 2019 17:46:15 -0800 (PST)
Received: from turing-police.lan ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id d2sm8195354qkg.77.2019.11.03.17.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2019 17:46:14 -0800 (PST)
From:   Valdis Kletnieks <valdis.kletnieks@vt.edu>
X-Google-Original-From: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
To:     Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
Cc:     Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/10] staging: exfat: Clean up return codes - remove unused codes
Date:   Sun,  3 Nov 2019 20:45:02 -0500
Message-Id: <20191104014510.102356-7-Valdis.Kletnieks@vt.edu>
X-Mailer: git-send-email 2.24.0.rc1
In-Reply-To: <20191104014510.102356-1-Valdis.Kletnieks@vt.edu>
References: <20191104014510.102356-1-Valdis.Kletnieks@vt.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are 6 FFS_* error values not used at all. Remove them.

Signed-off-by: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
---
 drivers/staging/exfat/exfat.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index 443fafe1d89d..b3fc9bb06c24 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -210,12 +210,6 @@ static inline u16 get_row_index(u16 i)
 
 /* return values */
 #define FFS_SUCCESS             0
-#define FFS_MOUNTED             3
-#define FFS_NOTMOUNTED          4
-#define FFS_ALIGNMENTERR        5
-#define FFS_SEMAPHOREERR        6
-#define FFS_NOTOPENED           12
-#define FFS_MAXOPENED           13
 
 #define NUM_UPCASE              2918
 
-- 
2.24.0.rc1

