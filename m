Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E157C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 02:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3320420879
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 02:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gzy2uqxx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbfEMChO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 22:37:14 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38060 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727148AbfEMChO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 22:37:14 -0400
Received: by mail-pg1-f195.google.com with SMTP id j26so5952403pgl.5
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2019 19:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=VU3aFBFKq8lpBvO42+887yBZzGyg8zhfJfkDGxXu1Ng=;
        b=Gzy2uqxxKJL0QrBwHfIoV5pxtyqY4VmkeOTa+76twY0ZJ8upgNTDskZo9rx4cP27qp
         9hUy8Nkp73tyKHT/QWmRpZHemAUb0bcFXYh7TLUVKXQvaH/GFgeReSOI9AmA+RPbZZPx
         oWYlpo8XJA7ayia7IY6bMzWr0ZqAtLcfsKN9V6vSSeLo8mIqTTVRRg3pm8O9TRiP7jI7
         kwjcgFTFNc+aIjSqwEfeOUoD/R69+R2k1opHKZ54e4YesggcyOAO4uxkujJeUsgnRS30
         dQnI+fd4JCeda83rvmZcNtWu+uKuU8u5VQn9Oo18OQeZx6PKuLJXRNcLVK48REhOxJQ+
         Nf3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VU3aFBFKq8lpBvO42+887yBZzGyg8zhfJfkDGxXu1Ng=;
        b=WaWNBa4Pe5NZi1/gdNMZsf942t660GMlNInfg2cxPLSxChNJ9jJK+JcuZU72QkbGRZ
         QVMckhJicUrRyipwn2oYWELOtwuES7YrOFUVIKQft9AeJ5kCEXEnxtd2Nfo2+qKDVe3C
         e3Lq5rp3jPxoX0bcjieRkMyONiKSivd3egJzzoWPxgGDjvNUkAwRS2RyfS2sqPXyZWXm
         ujc4EflFBJS2wusXOsB50fUnnWfpIIW35jS5iEkaXv4HWnxQGyjsktTRcT4J44HO12Jn
         ThAIJDvBn79zk+beFJJBaHqpoVEfuX2GOiv4eNQFi9tZfZyVj7up5Eo+jVb7quW6KbCz
         8Jgg==
X-Gm-Message-State: APjAAAV5c4vLYoNldkivcp8hlE65Ee9yCyE8E0w5ygzQjLCSVR6E1fkP
        CwFerprn+jQJWOIKLpSgbwQ=
X-Google-Smtp-Source: APXvYqxhWOdP+Qg7MYa7LiwMgL/NiBSA0QM3Qjo0JeTAZOTI6qeHYKqjn2tCm4dcvaMlaBODAARnRQ==
X-Received: by 2002:a63:c50c:: with SMTP id f12mr28107838pgd.71.1557715033479;
        Sun, 12 May 2019 19:37:13 -0700 (PDT)
Received: from localhost.localdomain ([185.241.43.160])
        by smtp.gmail.com with ESMTPSA id d186sm11070342pfd.183.2019.05.12.19.37.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 May 2019 19:37:12 -0700 (PDT)
From:   Weikang shi <swkhack@gmail.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, swkhack <swkhack@gmail.com>
Subject: [PATCH] mm: Change count_mm_mlocked_page_nr return type
Date:   Mon, 13 May 2019 10:37:01 +0800
Message-Id: <20190513023701.83056-1-swkhack@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: swkhack <swkhack@gmail.com>

In 64-bit machine,the value of "vma->vm_end - vma->vm_start"
maybe negative in 32bit int and the "count >> PAGE_SHIFT"'s result
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

