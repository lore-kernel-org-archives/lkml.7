Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54963C76191
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 15:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 299812083B
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 15:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c6dwQn1n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfGUP6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 11:58:23 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39253 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfGUP6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 11:58:22 -0400
Received: by mail-pl1-f196.google.com with SMTP id b7so17974895pls.6
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2019 08:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JyrOjFUx/MRse3HXWL5eBpv0RUzUDf7uqwjLdruvk74=;
        b=c6dwQn1npVP477E/wwUDfZXXs4PH5AGJyZ36YnFhXxt+3hwOGrOvuiiR8gK3sEpjtB
         WiGZWjZ1UNMC1L6Ox3RYGz8Fvu1wKUbJ+JqYncKoWoQaF9hBM5wTRVX9r3WB7z1Q49K0
         4+aNg+MobiwUdEY6WrtZd0FnQQ0o2qXB8gQwFVuCmGe2Jkprim3Je0/L+cu8T9j4wiIh
         myl5IHrGskpz8sAyzbxCnd1e7LSgGIBiCjBwimvtgCUE/LrEor8wEPwb1cnMqV65eiRU
         30xl0000zcHhG3vQsfQtucLqNTeri/MnBwMpv5W5n1g2eLWighpH/DTX8+8d1y6t+S9I
         Kpqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JyrOjFUx/MRse3HXWL5eBpv0RUzUDf7uqwjLdruvk74=;
        b=Xx2t94dmnoYe+kHDV82ioKnpyLBb6GjpLhQlvXIGeF/24etiygBpZEog2n7hPXd0nc
         bWxW+dWd2v0f2QgbV3uy2171eHAXuWVxgkJFEAeIM2i4LVCU4wZa9LtwHjhb18QMive5
         lOhiI6enXIv/3nroIj4Er5FASZxRXfeuKAnZi9YP8Akj6iWmj3EYs2Q6E3TDUN8w8qbF
         3+ZPNIOLp/npqRjoAJcuZkcTcjTP2L/khu3dvvv2nC6vV4yACRgLO8pGLmZgbl3i9xwF
         0ZVikq+ebdtZhTX703VlsGKgvhhvey5f9xHtEktSZsQer90+rGLW4XzUK2sJNDLOXc5Y
         gWqA==
X-Gm-Message-State: APjAAAWYZpgKRX4Cs2kt8VtyoUK60El2WTuO4fcNSZgO4y2Q3MEq6hci
        O59nf1l/UQSsd8nmukLt3/4=
X-Google-Smtp-Source: APXvYqxcll7G/MTDDThq2L/Ziyu763qr+TVJaFz6DGgGZzAfccbiPOPYj/IdvSBgFi/gtmy5opFZBA==
X-Received: by 2002:a17:902:a606:: with SMTP id u6mr65491139plq.275.1563724702028;
        Sun, 21 Jul 2019 08:58:22 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([103.110.42.34])
        by smtp.gmail.com with ESMTPSA id o14sm74720111pfh.153.2019.07.21.08.58.20
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 21 Jul 2019 08:58:21 -0700 (PDT)
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     arnd@arndb.de, sivanich@sgi.com, gregkh@linuxfoundation.org
Cc:     ira.weiny@intel.com, jhubbard@nvidia.com, jglisse@redhat.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Bharath Vedartham <linux.bhar@gmail.com>
Subject: [PATCH 1/3] sgi-gru: Convert put_page() to get_user_page*()
Date:   Sun, 21 Jul 2019 21:28:03 +0530
Message-Id: <1563724685-6540-2-git-send-email-linux.bhar@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1563724685-6540-1-git-send-email-linux.bhar@gmail.com>
References: <1563724685-6540-1-git-send-email-linux.bhar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For pages that were retained via get_user_pages*(), release those pages
via the new put_user_page*() routines, instead of via put_page().

This is part a tree-wide conversion, as described in commit fc1d8e7cca2d
("mm: introduce put_user_page*(), placeholder versions").

Cc: Ira Weiny <ira.weiny@intel.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Jérôme Glisse <jglisse@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Dimitri Sivanich <sivanich@sgi.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
---
 drivers/misc/sgi-gru/grufault.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/sgi-gru/grufault.c b/drivers/misc/sgi-gru/grufault.c
index 4b713a8..61b3447 100644
--- a/drivers/misc/sgi-gru/grufault.c
+++ b/drivers/misc/sgi-gru/grufault.c
@@ -188,7 +188,7 @@ static int non_atomic_pte_lookup(struct vm_area_struct *vma,
 	if (get_user_pages(vaddr, 1, write ? FOLL_WRITE : 0, &page, NULL) <= 0)
 		return -EFAULT;
 	*paddr = page_to_phys(page);
-	put_page(page);
+	put_user_page(page);
 	return 0;
 }
 
-- 
2.7.4

