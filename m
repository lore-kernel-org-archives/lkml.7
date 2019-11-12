Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4491C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 02:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2B86206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 02:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbfKLCKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 21:10:51 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:48024 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727093AbfKLCKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 21:10:47 -0500
Received: from mr5.cc.vt.edu (mr5.cc.vt.edu [IPv6:2607:b400:92:8400:0:72:232:758b])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id xAC2Ak78011525
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 21:10:46 -0500
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
        by mr5.cc.vt.edu (8.14.7/8.14.7) with ESMTP id xAC2Afoc001555
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 21:10:46 -0500
Received: by mail-qv1-f70.google.com with SMTP id i11so7550427qvh.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 18:10:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=uphTJK2IDaoRqiwK0hx3G7xcHeFWsEZMUn5zNKoPI0w=;
        b=PaHOrosy+5KKTNh6ZAg1l86mGOmw8yoDQoAvxeRUVsKgzRM29tAZ5ogbn92TQYJxsi
         9pmz3o18PvHSjxGTl+peoZXhH+OnXIkAsA7cnx8StTFQua1hNxHt0CgphGXggPDEK2lo
         060mSjAEXF9EYLDWfvqWFQccKenns0aHcPfZ2V5/4OfsfEFVRUZFZL+c51rqofOUBtjB
         abqmDfjIp+dTjbLX4N51lTDlwVpMvbrEGycp3X+/8rW1nc1cuY5y6gjeH/ANhnxFqOjS
         CsQ0s+xth1+P6dcex0swdjJ/OGQIT+rbE5ye/ALXX3A/98wweNFKxe/PRNtEZEwbPjCJ
         NIOw==
X-Gm-Message-State: APjAAAXRPnS/BfjZe33CZkdYErdW4SuN6Ep9VSjd69iGCrC//ASW03AN
        xTxQk0uHeICtMUwc225zQIZsW4VS8TFoLsEarwH/KFq18seE9bt2ahoJqgFRUwzgGieiVLS8aKr
        Y3sB1kiQyykXRthIBENz08oYLHqhTgEyX9Ak=
X-Received: by 2002:a0c:a998:: with SMTP id a24mr25872138qvb.117.1573524641378;
        Mon, 11 Nov 2019 18:10:41 -0800 (PST)
X-Google-Smtp-Source: APXvYqyP9wpj6EloB26bcXsuYqLDNDs33pV7zPD64rSvVFKAnI1TcwuvnpFunMC2Bkhe+5aVicw5Fw==
X-Received: by 2002:a0c:a998:: with SMTP id a24mr25872127qvb.117.1573524641133;
        Mon, 11 Nov 2019 18:10:41 -0800 (PST)
Received: from turing-police.lan ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id o195sm8004767qke.35.2019.11.11.18.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 18:10:40 -0800 (PST)
From:   Valdis Kletnieks <valdis.kletnieks@vt.edu>
X-Google-Original-From: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
To:     gregkh@linuxfoundation.org
Cc:     Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/9] staging: exfat: Clean up return codes - remove unused codes
Date:   Mon, 11 Nov 2019 21:09:54 -0500
Message-Id: <20191112021000.42091-7-Valdis.Kletnieks@vt.edu>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191112021000.42091-1-Valdis.Kletnieks@vt.edu>
References: <20191112021000.42091-1-Valdis.Kletnieks@vt.edu>
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
2.24.0

