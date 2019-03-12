Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58626C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 13:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1525A206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 13:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="GxwhhnRw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbfCLN3L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 09:29:11 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44657 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbfCLN3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 09:29:11 -0400
Received: by mail-wr1-f66.google.com with SMTP id w2so2682452wrt.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 06:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sXUXVXlvAdVAFUbmGrPp3Y++cwC7YAn6ufejqo4y85E=;
        b=GxwhhnRwAI0mQHn3+AajPHEAD5qHfVqJPCTFDxTXDwSUADjGv7hxGYdhiKXd2O8MO0
         TRdtTKDgC6x3/Z7AgmZZ854ynfWnJ+6gsJ+3qJmsmWRsf/GJugTYGWiw3RjAil6zBpSz
         bZpwn2umdbdREZOzE0WZsYyh/4TPyBPdk4kDzGFOpUWQ761lw2uDkl1iPuCOed6c4fhj
         xRdMVASza2YeZE07e76lkq+ogwY7yQteiyuIco6P1GFnkMX5yfOFy/P5xnxFpYB2qbrc
         2ftNr64IrwKUk33E9RD9x7cVG+Npzw1AhW1DoUzQJIXXiRWIkc3up6Ze6dU0UCC7C6ch
         lcCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sXUXVXlvAdVAFUbmGrPp3Y++cwC7YAn6ufejqo4y85E=;
        b=t56xdhXAJAeprhiZ0jJEdYLba1EAsLX+V85s7jDB2md0yQ2eYM7Swijrd7R7gKpsWa
         Li+RGgiXmG/ZOwn2whlNuK+0HIKI5G1gmdL6PiwNYHwtb47xUFXiaj0vtgPA+sqTlKFk
         HDBmHKutzgqBKQlD9H3WdtEJwk9nUZAS0DlFT95pdkmdkZQ5CYT3KCIL+bisLFGpAWmO
         i0mTPM9/vgMhhJ3Z1oHKj81dhq3QY7p20pScoEG355r/kis7r19Ptfz0d+VsKWNtGyz+
         kv+SjJN/lQlkoLH4W3DNTnZqGlmOSNsL7AcZb3JkcBg7xcf5D7EsRi+WavrtEBhlyL9j
         IpGw==
X-Gm-Message-State: APjAAAU9EWQ4OIfVS6nIu5CxtvsPq3aajyjRQPgfc3HkpSzPQlg2a5QX
        8bGKhyFRCnIjM1QfJ2A8JF1LLg==
X-Google-Smtp-Source: APXvYqyDMMU4JGKeldvw1hUSjmGm8MTelCfenfBNg9tvci4kOGrW1HU8vJ+50w18UmQ6InjasI0jxg==
X-Received: by 2002:a5d:5386:: with SMTP id d6mr22774771wrv.104.1552397349635;
        Tue, 12 Mar 2019 06:29:09 -0700 (PDT)
Received: from localhost.localdomain (aputeaux-684-1-27-140.w90-86.abo.wanadoo.fr. [90.86.252.140])
        by smtp.gmail.com with ESMTPSA id d9sm19953173wrn.72.2019.03.12.06.29.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 06:29:08 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH] mm: remove unused variable
Date:   Tue, 12 Mar 2019 14:28:52 +0100
Message-Id: <20190312132852.20115-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The mm variable is set but unused. Remove it.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 mm/mprotect.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index 028c724dcb1a..130dac3ad04f 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -39,7 +39,6 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 		unsigned long addr, unsigned long end, pgprot_t newprot,
 		int dirty_accountable, int prot_numa)
 {
-	struct mm_struct *mm = vma->vm_mm;
 	pte_t *pte, oldpte;
 	spinlock_t *ptl;
 	unsigned long pages = 0;
-- 
2.20.1

