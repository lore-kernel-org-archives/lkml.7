Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79062C10F12
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 01:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49EFC2084B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 01:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f0tErIzk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbfDPBUT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 21:20:19 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36807 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbfDPBUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 21:20:18 -0400
Received: by mail-pg1-f194.google.com with SMTP id 85so9463265pgc.3;
        Mon, 15 Apr 2019 18:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0BmGj+DXo97h0eyX21MxdzNP7h8++htrvxxJpmEZbP0=;
        b=f0tErIzkKReXXEJLaZy3/0udhGAQ/EhVtP2MoYp1IDReqT5qc5GUyToJJivRTlDA7E
         sEl+AkC2kksFl4HosSDmtfGagritnkZic1VxeoU3FjZbwV48b5MC1afX9Bjg7rbQkpPw
         MfwnOu0SeryYZGUM70u3u34zcgXq2mRqCbDlIv9iLnRUgeo6UUd5xTpvneW9pCOWeeEj
         xLWtVpSdOYYq95z0LwaHFvY2FZp6BYVBkG41H+ZjsJbrEyK0DTiX0RWHkB42Ke7dp6ea
         Mnnseabnk1+ldvyMvo7034ygJj/mQbNSUPIWJDOu3EA8A8YnjHaPlf7HY9rCK9v2YikD
         q1rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0BmGj+DXo97h0eyX21MxdzNP7h8++htrvxxJpmEZbP0=;
        b=RcVc3NFxDEDGRPCRABusbjVXBhEC5MTW+4AnA/uada2H72CNJ0OBd+a0v27fNUGLc4
         PombZWt/nqRGmZ4ptH/R/WuKsWslhueyLOjuc+3Encuw36RE4VKpHs6IPGxmQLw3E9P3
         Bdeo7WrawLs0pCubu+dUVKiI35Rw5Pbprm3eJvV4+iR5ZZStjI4OdKzQnwyCuqkWS3Qz
         HujOJwhMSrS1KsoLF+Nccg/EeYM/JotORayrEwd/lwN4Vcre9WKiitGRKom/bIrwY00v
         BBj7A3afU2EwwHpvEyqZpkeOMy7NBLYTEQIPZfcuXY/0AoFzDZT7sadSzWMDuEfRru+U
         Z7ug==
X-Gm-Message-State: APjAAAXdowSOr6+dJ0pIt/iUFfroZbd+jZLPncUoUZotdq2wpZAf9vw+
        kLZ2mJk19mZEeQy9U6yKUZxuTE+U
X-Google-Smtp-Source: APXvYqxq8A26GTvMtB660PXTApRNoeapQaDX/mY75cXrK7be8xNniM+zl0CfmMNfmNh2tWiJBBslmA==
X-Received: by 2002:a65:6108:: with SMTP id z8mr73547769pgu.106.1555377617811;
        Mon, 15 Apr 2019 18:20:17 -0700 (PDT)
Received: from tw-172-25-31-76.office.twttr.net ([8.25.197.24])
        by smtp.gmail.com with ESMTPSA id a85sm64206995pfa.166.2019.04.15.18.20.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 18:20:16 -0700 (PDT)
From:   Cong Wang <xiyou.wangcong@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-edac@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 1/2] ras: fix an off-by-one error in __find_elem()
Date:   Mon, 15 Apr 2019 18:20:00 -0700
Message-Id: <20190416012001.5338-1-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ce_arr.array[] is always within the range [0, ce_arr.n-1].
However, the binary search code in __find_elem() uses ce_arr.n
as the maximum index, which could lead to an off-by-one
out-of-bound access when the element after the last is exactly
the one just got deleted, that is, 'min' returned to caller as
'ce_arr.n'.

Fixes: 011d82611172 ("RAS: Add a Corrected Errors Collector")
Cc: Tony Luck <tony.luck@intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 drivers/ras/cec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
index 2d9ec378a8bc..61332c9aab5a 100644
--- a/drivers/ras/cec.c
+++ b/drivers/ras/cec.c
@@ -184,7 +184,7 @@ static void cec_timer_fn(struct timer_list *unused)
 static int __find_elem(struct ce_array *ca, u64 pfn, unsigned int *to)
 {
 	u64 this_pfn;
-	int min = 0, max = ca->n;
+	int min = 0, max = ca->n - 1;
 
 	while (min < max) {
 		int tmp = (max + min) >> 1;
-- 
2.20.1

