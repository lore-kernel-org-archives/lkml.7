Return-Path: <SRS0=w4Fx=WO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 002A9C3A589
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 19:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA2CA218A4
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 19:39:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GOpi23ZW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbfHRTjc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 15:39:32 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45795 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfHRTjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 15:39:32 -0400
Received: by mail-pf1-f193.google.com with SMTP id w26so5820820pfq.12;
        Sun, 18 Aug 2019 12:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a8+L6poDC20GcQQ9CfyPX7El391DODwhknO5Uu2z/P8=;
        b=GOpi23ZWVr64SH0Vu9SJdU+hs6VoZUy5QE9KBREpVVzD4b07FglIvvvaPDBy5dC7J/
         nKMMCD6/copl5kczMBMnNguX0lSHQi9eiRApNpD2wGvk6JmFxUmDf9Q90Di8NIo2D2Gh
         CyTQttAEKWbh9IGkWTLdqLZeCmLoYDB2cUJIzJ93dXeEUuRDkcLR/GkedO8UfVSVQjRQ
         nCmHe17Xiu+VdGtHoOAI+Vt57aooSYAYtU4XpLEaXH22qig6FZP9soYjcT6OvVEtfe8Z
         hmrGZ+T4qwyuwhsAqcmH4C7xXSYyYZiuJIVnBXUSlfPQ0CtTBYLKSzlXVQmmj22EQfwK
         sx9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a8+L6poDC20GcQQ9CfyPX7El391DODwhknO5Uu2z/P8=;
        b=Qo4RqZDJbYMR6AJ7BxqedHls6jHEs2P1LTCQDP339TCiIfcFzVqUCU52Bs7w/GTgO9
         jtsVrksQ1EFlQgO4jYnD4uvIjOHbIhu0OfP9hMCeEk9EBeZuJatvKH4/s9Z7LzsVUZ5m
         Is/iQXaPtmAOTlWe/30sC+gy2mX3roy0NQ3m77auqccaVu9KqKah7RgLY+uVSS8Zyk0r
         TiA3qH1ETA5N00YkStvj/rinWyT4cYwDS7/xE0Uusv7vBez0Q+18WROLSG6tFL5h1Jew
         zc09P/vYgfecANMNkBhrSMhbQj0HbbR1h2Yai3jpI6l4OObmUKefcURUoilNmL/cAHnQ
         0Nvg==
X-Gm-Message-State: APjAAAVrZ3hSFFAkz4LmuZSjdon/3GGr1XfywLlztp6RX9dNrxfwJ2MV
        SlvnkjP3hUtguNDDfOYjmLLg1Ta1
X-Google-Smtp-Source: APXvYqxYIXFqhwAQK3mpk0fNnX3nZwkcmz/afOcd6XTFDlWHsIBUqj1+EURmOIXoL7iiX1TsTdbPFA==
X-Received: by 2002:aa7:9a12:: with SMTP id w18mr21671346pfj.110.1566157171532;
        Sun, 18 Aug 2019 12:39:31 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([103.110.42.34])
        by smtp.gmail.com with ESMTPSA id m9sm24492787pgr.24.2019.08.18.12.39.30
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 18 Aug 2019 12:39:31 -0700 (PDT)
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     sivanich@sgi.com, jhubbard@nvidia.com
Cc:     jglisse@redhat.com, ira.weiny@intel.com,
        gregkh@linuxfoundation.org, arnd@arndb.de,
        william.kucharski@oracle.com, hch@lst.de,
        inux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Bharath Vedartham <linux.bhar@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [Linux-kernel-mentees][PATCH 2/2] sgi-gru: Remove uneccessary ifdef for CONFIG_HUGETLB_PAGE
Date:   Mon, 19 Aug 2019 01:08:55 +0530
Message-Id: <1566157135-9423-3-git-send-email-linux.bhar@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1566157135-9423-1-git-send-email-linux.bhar@gmail.com>
References: <1566157135-9423-1-git-send-email-linux.bhar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

is_vm_hugetlb_page will always return false if CONFIG_HUGETLB_PAGE is
not set.

Cc: Ira Weiny <ira.weiny@intel.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Jérôme Glisse <jglisse@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Dimitri Sivanich <sivanich@sgi.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: William Kucharski <william.kucharski@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
---
 drivers/misc/sgi-gru/grufault.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/misc/sgi-gru/grufault.c b/drivers/misc/sgi-gru/grufault.c
index 61b3447..bce47af 100644
--- a/drivers/misc/sgi-gru/grufault.c
+++ b/drivers/misc/sgi-gru/grufault.c
@@ -180,11 +180,11 @@ static int non_atomic_pte_lookup(struct vm_area_struct *vma,
 {
 	struct page *page;
 
-#ifdef CONFIG_HUGETLB_PAGE
-	*pageshift = is_vm_hugetlb_page(vma) ? HPAGE_SHIFT : PAGE_SHIFT;
-#else
-	*pageshift = PAGE_SHIFT;
-#endif
+	if (unlikely(is_vm_hugetlb_page(vma)))
+		*pageshift = HPAGE_SHIFT;
+	else
+		*pageshift = PAGE_SHIFT;
+
 	if (get_user_pages(vaddr, 1, write ? FOLL_WRITE : 0, &page, NULL) <= 0)
 		return -EFAULT;
 	*paddr = page_to_phys(page);
@@ -238,11 +238,12 @@ static int atomic_pte_lookup(struct vm_area_struct *vma, unsigned long vaddr,
 		return 1;
 
 	*paddr = pte_pfn(pte) << PAGE_SHIFT;
-#ifdef CONFIG_HUGETLB_PAGE
-	*pageshift = is_vm_hugetlb_page(vma) ? HPAGE_SHIFT : PAGE_SHIFT;
-#else
-	*pageshift = PAGE_SHIFT;
-#endif
+
+	if (unlikely(is_vm_hugetlb_page(vma)))
+		*pageshift = HPAGE_SHIFT;
+	else
+		*pageshift = PAGE_SHIFT;
+
 	return 0;
 
 err:
-- 
2.7.4

