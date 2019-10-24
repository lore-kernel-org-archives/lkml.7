Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 032C2CA9EBB
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 15:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D843221872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 15:54:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503389AbfJXPyx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 11:54:53 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:54640 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2503368AbfJXPyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 11:54:52 -0400
Received: from mr4.cc.vt.edu (mr4.cc.ipv6.vt.edu [IPv6:2607:b400:92:8300:0:7b:e2b1:6a29])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x9OFsoa5027154
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 11:54:50 -0400
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
        by mr4.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x9OFsjIC015897
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 11:54:50 -0400
Received: by mail-qt1-f200.google.com with SMTP id 44so18985848qtu.20
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 08:54:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=w9B0/WniKt/epgo+p5dMZKrzDCoq6S2v82rQ+FNBDqI=;
        b=E/mxD21N4GJYJtaXwrPY+bg3e9xJzHnRHuopLEqT2c4A+tRhpFp5QMy2R3dNGhKvj0
         RlQoOEkMQYjL82Ufuz+7cbEyS0hI97MpVTVxrt4eKfWmY3GR3aJ/sgpucV8uZ5At2V6e
         lyqMJNIZpZraa2VQ4le5o4QFFsH+yqAqHj0weuvWrAPgejbaDaBfj6F9/g09uxPN2SuF
         wtzlFMh7ceQ0ENlm4mHoVmxw5el3I8hAy1uUfUUlICVuzj08mXMJM1JV2rCLlAMJobTd
         M3nLuXmNHvh3KdCrFtT1+aZBzFibkzU6u4X0p8gr/fvTNPtUxgOZuKl+O7fi1QOsR6xF
         E95w==
X-Gm-Message-State: APjAAAX9UO2Y/eF7WV0OSu+kG19mxTm+FUfe0c3kzPQz9i/nhww82dfh
        8xn1tRG7UaLU7gOKYoa1O2eJp5iacogGWehF2BC1X5ethFrAzHqMtd8xlvhyvsQstQt5Fp0Muqv
        O8iJrYlaV6bjeKQ4+sMzl95H3x75sYXAQ3EY=
X-Received: by 2002:a37:8b44:: with SMTP id n65mr11178799qkd.312.1571932485435;
        Thu, 24 Oct 2019 08:54:45 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxUaqQXOGe/pBFaYVlG1qusbGV1mxhM6T0ltC9sZRdfer7+GV4J8xUWUbutmzgjsBo7GZUudA==
X-Received: by 2002:a37:8b44:: with SMTP id n65mr11178775qkd.312.1571932485163;
        Thu, 24 Oct 2019 08:54:45 -0700 (PDT)
Received: from turing-police.lan ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id x133sm12693274qka.44.2019.10.24.08.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 08:54:44 -0700 (PDT)
From:   Valdis Kletnieks <valdis.kletnieks@vt.edu>
X-Google-Original-From: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 11/15] staging: exfat: Clean up return codes - FFS_EOF
Date:   Thu, 24 Oct 2019 11:53:22 -0400
Message-Id: <20191024155327.1095907-12-Valdis.Kletnieks@vt.edu>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191024155327.1095907-1-Valdis.Kletnieks@vt.edu>
References: <20191024155327.1095907-1-Valdis.Kletnieks@vt.edu>
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
index df7b99707aed..3ff7293fedd2 100644
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
index a5c85dafefb4..a0c28fd8824b 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -717,7 +717,7 @@ static int ffsReadFile(struct inode *inode, struct file_id_t *fid, void *buffer,
 	if (count == 0) {
 		if (rcount)
 			*rcount = 0;
-		ret = FFS_EOF;
+		ret = 0;
 		goto out;
 	}
 
-- 
2.23.0

