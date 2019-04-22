Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB483C282E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 10:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD4562075A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 10:38:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UdrlvXS2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbfDVKiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 06:38:51 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42107 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbfDVKiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 06:38:50 -0400
Received: by mail-pf1-f196.google.com with SMTP id w25so5525301pfi.9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 03:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=8ShUaFNcZ5bsBda1zqagRP6x7qsp4WEK4DhvDe+5Rtw=;
        b=UdrlvXS2ETIdt395/IwHQdgQ08T0mVB8OOoD2yCuJxMEckn6sdSLY/ltf0KqsPn25L
         F0a1HS0moaN4aXGz8DNvP6RB2+obSdXzTo2nCwe2F40xHt85H6go2aArGQm50ujLWHfh
         lXU1/N/cfJulz4YNfOtASO10KSiJ338Gb400MNzpjb/F4v+JHzAxx3OUtcJLXUf4zaZI
         A/HMENe5eI/ldswg+q/rNZHWLhLApKUSX6CQ+IIX1Re0y/7VrjEIPU41cZC/Cfo4h89M
         xvprhbab/eYp0Zk7niNvbejVlXXt9A6Ize/RWzD9acRSmSw/sDSbJIGfrn0Kv3l67a/r
         UEDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8ShUaFNcZ5bsBda1zqagRP6x7qsp4WEK4DhvDe+5Rtw=;
        b=WXagcKBfTP08l93KgfEqenNCTB8Y8bVoWJ5UmtWsv8exh/G8O0Q5bA7Yhp7NOtq7EM
         BB8kY3YoQnXGvDOrahaSc+Qq6yM78M/1y1V43w6Vruk7ULQ1vHWmE33zIA/QKXMIfc/b
         cZlDqqtz4ZrlBIF7/pPYuAueGmH4McMAtuRa4j9ZpKsXfnU208r+Z3VwJ7ghq8sLJq1Q
         sKuGOfX143bbrFUaZNpWTQPVOFLbFSKvv6MGiyyS6M2XfRuR0CKAVE0qBMikGgmN59bz
         OEZLPbK16az2RRDu3ZFVOQfyS4T8g4/8nf1J1vaSN8Uc3nYXhd1ZaNQpcmzv0gUIVTfa
         q2Hw==
X-Gm-Message-State: APjAAAXcNtIgLXZKoTmNN8C+w8bNKaIG3cSsolI9tED/jrCC3ciur2fK
        tSatEjzCNyovqtBYydxwh7Gxv/86UrW/mQ==
X-Google-Smtp-Source: APXvYqzcbhJjU+E1kE/vP3nKLCghCNJ3GWcQJuOwOgpar8jx+J/5M8T8m51itSvisFIjAwWiXOIPBg==
X-Received: by 2002:a62:ac02:: with SMTP id v2mr1463566pfe.163.1555929529565;
        Mon, 22 Apr 2019 03:38:49 -0700 (PDT)
Received: from localhost.localdomain (ch.ptr162.ptrcloud.net. [153.122.97.60])
        by smtp.gmail.com with ESMTPSA id r87sm21596546pfa.71.2019.04.22.03.38.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2019 03:38:48 -0700 (PDT)
From:   Weikang shi <swkhack@gmail.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, swkhack <swkhack@gmail.com>
Subject: [PATCH] mm: Change count_mm_mlocked_page_nr return type
Date:   Mon, 22 Apr 2019 18:38:36 +0800
Message-Id: <20190422103836.48566-1-swkhack@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: swkhack <swkhack@gmail.com>

In 64-bit machine,the value of "vma->vm_end - vma->vm_start"
maybe negative in 32bit int and the "count >> PAGE_SHIFT"'s rusult
will be wrong.So change the local variable and return
value to unsigned long will fix the problem.

Signed-off-by: swkhack <swkhack@gmail.com>
---
 mm/mlock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/mlock.c b/mm/mlock.c
index 080f3b364..d614163f5 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -636,11 +636,11 @@ static int apply_vma_lock_flags(unsigned long start, size_t len,
  * is also counted.
  * Return value: previously mlocked page counts
  */
-static int count_mm_mlocked_page_nr(struct mm_struct *mm,
+static unsigned long count_mm_mlocked_page_nr(struct mm_struct *mm,
 		unsigned long start, size_t len)
 {
 	struct vm_area_struct *vma;
-	int count = 0;
+	unsigned long count = 0;
 
 	if (mm == NULL)
 		mm = current->mm;
-- 
2.17.1

