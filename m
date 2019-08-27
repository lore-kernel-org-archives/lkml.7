Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABFD2C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 788B4206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566893235;
	bh=tua5d1hXf1BvgQx1c7amcpAtm6+0tqhdrE6Ve8PXZv0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NpEfFamxnjj8Q8PymlHcus1xJhgkFNgUL7bCdss2b6j/wecWFAmLAlWxLLq4R5qqH
	 qNi2Lgm292NwQAwdCFtY13IpoAsSysBHQItKMTebzOEo+t6gjNOFl2HXgJY4Fr0jXi
	 BqwsBZxxuRh5mhO7mweOyC0Nr3NALkUP+Qam7W54=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729557AbfH0IHN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 04:07:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:37212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733133AbfH0IHK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 04:07:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8EA8206BA;
        Tue, 27 Aug 2019 08:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566893229;
        bh=tua5d1hXf1BvgQx1c7amcpAtm6+0tqhdrE6Ve8PXZv0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oIY5c2MG+YoBRBhWYQn4fdiavIYSOOZ1qmMBUGkSr1B5yYHP7wJDYvUI7E8u+T3NE
         WrPutC3UBfT7z2ryISDp+yweLgCvAlM6TdNqM7paM3JokFUljsdXpRnw8DGeFXqNsL
         kbDbhqmMUiG4dYrQHhN1XfkpYRXsozPOhxalL+yY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Walter Wu <walter-zh.wu@mediatek.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 5.2 153/162] mm/kasan: fix false positive invalid-free reports with CONFIG_KASAN_SW_TAGS=y
Date:   Tue, 27 Aug 2019 09:51:21 +0200
Message-Id: <20190827072744.111451053@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190827072738.093683223@linuxfoundation.org>
References: <20190827072738.093683223@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Ryabinin <aryabinin@virtuozzo.com>

commit 00fb24a42a68b1ee0f6495993fe1be7124433dfb upstream.

The code like this:

	ptr = kmalloc(size, GFP_KERNEL);
	page = virt_to_page(ptr);
	offset = offset_in_page(ptr);
	kfree(page_address(page) + offset);

may produce false-positive invalid-free reports on the kernel with
CONFIG_KASAN_SW_TAGS=y.

In the example above we lose the original tag assigned to 'ptr', so
kfree() gets the pointer with 0xFF tag.  In kfree() we check that 0xFF
tag is different from the tag in shadow hence print false report.

Instead of just comparing tags, do the following:

1) Check that shadow doesn't contain KASAN_TAG_INVALID.  Otherwise it's
   double-free and it doesn't matter what tag the pointer have.

2) If pointer tag is different from 0xFF, make sure that tag in the
   shadow is the same as in the pointer.

Link: http://lkml.kernel.org/r/20190819172540.19581-1-aryabinin@virtuozzo.com
Fixes: 7f94ffbc4c6a ("kasan: add hooks implementation for tag-based mode")
Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Reported-by: Walter Wu <walter-zh.wu@mediatek.com>
Reported-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Andrey Konovalov <andreyknvl@google.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/kasan/common.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -409,8 +409,14 @@ static inline bool shadow_invalid(u8 tag
 	if (IS_ENABLED(CONFIG_KASAN_GENERIC))
 		return shadow_byte < 0 ||
 			shadow_byte >= KASAN_SHADOW_SCALE_SIZE;
-	else
-		return tag != (u8)shadow_byte;
+
+	/* else CONFIG_KASAN_SW_TAGS: */
+	if ((u8)shadow_byte == KASAN_TAG_INVALID)
+		return true;
+	if ((tag != KASAN_TAG_KERNEL) && (tag != (u8)shadow_byte))
+		return true;
+
+	return false;
 }
 
 static bool __kasan_slab_free(struct kmem_cache *cache, void *object,


