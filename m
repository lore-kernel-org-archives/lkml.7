Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37BA9C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10DC620644
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560443401;
	bh=lQkuSuLoO+Klp0cPventqHyggeqvBvY2y55UVlqmXWI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=km/jEau7vqKvmh2nTWQIX4sycVs1h42gd/0UrfwKg07yeNTJjzZq0ny/r8jiap3PC
	 mmt/PdVOTtfdZToCv1fdtW1jmek8UgH3DsgMO2dNaaIGNQTCCp6V/2CChjYoWtCKqA
	 8zKZazhrsI4NXrcIMddV+KZvk0IraQ03V8TSa33U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392438AbfFMQ37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:29:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:52940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730922AbfFMIfL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 04:35:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B27DE206E0;
        Thu, 13 Jun 2019 08:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560414911;
        bh=lQkuSuLoO+Klp0cPventqHyggeqvBvY2y55UVlqmXWI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O2yeUaJymRCns3fsdFcK+AWpyrsz60L88TRa1ov4+gg+C0ZzlHYPzgvBWkoo18ebt
         L9WrUieHbeAbgU/53lXp/PtPKEvax3ARgYBo9ErmGrAeiUEGrk/GFFaKohSfs6NJLp
         x5sNRv0VbXakqsxZrEJLvZDF8u+goRvJZXsPHatg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yue Hu <huyue2@yulong.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Laura Abbott <labbott@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 09/81] mm/cma.c: fix crash on CMA allocation if bitmap allocation fails
Date:   Thu, 13 Jun 2019 10:32:52 +0200
Message-Id: <20190613075649.745754240@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190613075649.074682929@linuxfoundation.org>
References: <20190613075649.074682929@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 1df3a339074e31db95c4790ea9236874b13ccd87 ]

f022d8cb7ec7 ("mm: cma: Don't crash on allocation if CMA area can't be
activated") fixes the crash issue when activation fails via setting
cma->count as 0, same logic exists if bitmap allocation fails.

Link: http://lkml.kernel.org/r/20190325081309.6004-1-zbestahu@gmail.com
Signed-off-by: Yue Hu <huyue2@yulong.com>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Laura Abbott <labbott@redhat.com>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/cma.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/cma.c b/mm/cma.c
index 5749c9b3b5d0..cba4fe1b284c 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -105,8 +105,10 @@ static int __init cma_activate_area(struct cma *cma)
 
 	cma->bitmap = kzalloc(bitmap_size, GFP_KERNEL);
 
-	if (!cma->bitmap)
+	if (!cma->bitmap) {
+		cma->count = 0;
 		return -ENOMEM;
+	}
 
 	WARN_ON_ONCE(!pfn_valid(pfn));
 	zone = page_zone(pfn_to_page(pfn));
-- 
2.20.1



