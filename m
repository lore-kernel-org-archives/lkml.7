Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF9CC04AA9
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 13:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3799421707
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 13:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G3VBJNj1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728726AbfD3N0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 09:26:06 -0400
Received: from mail-oi1-f201.google.com ([209.85.167.201]:43480 "EHLO
        mail-oi1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728649AbfD3N0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 09:26:01 -0400
Received: by mail-oi1-f201.google.com with SMTP id w16so5434787oic.10
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 06:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xNbRPHb0QaxGlTA7s33PjaJCVzzZC2iohEMIfDhjOnw=;
        b=G3VBJNj1Efd82TURXBcG2ETfYyZa4nNQbw5XcSPgrFNgGTDcrjKi2K3Iqxh9GCJaVT
         q4ybexiR1zpb+d5J4+ktYX//GzTjjx7hvSHawuAMH2628bR7wRgw71HvGhNfTflHW/zs
         Atp0zpFkZrhjqB1YK2fIhTRq2d162F4gSLgDXmj1SWW0QKaRzutUGTNf9j2DzCy8DQXs
         6qis1IjWlpcydKHrLlqfebzxPQ65WrUm0DNZpeC309u8+WueXbRuj/bbSEKVwswOSRBh
         9Q1k1UxCvXqArWAzlxVP1yBw+FzmFzBJan3FvrRViSuycjCJ8f4ZVoJHTVS0bktu9b7r
         znhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xNbRPHb0QaxGlTA7s33PjaJCVzzZC2iohEMIfDhjOnw=;
        b=nS8mQqFxajvNBnHbz+d8cfADH679ORYaxykqeIxOTzxcOwUY0wkaDY2nC2t1SB9qo9
         RuU9ofN08xPHIpiXXB1VNZf8V5dJXDNmDuZrwLVUNBT/9OYG0UQtOUHFy1CGE/hO5AoC
         FLQ12jk4oUId3pk3iH4Tz2xpXjHyHZCVeAkc1RYjDScN+1z5jZB/uQu2wCdBYS/SICyd
         v16n9R5AFiRg5ij1+6Q9L11GLfi797JK0KzB1yhmX6soWU2QL9FSv3JCcnn75VHPCJV3
         BVub9KzfSyTxnnQW6c0r8G24OXN3pPv6Eo5EQAZSo41qpFqAoWO9t1QCMcvOTsd5RNzg
         nF6g==
X-Gm-Message-State: APjAAAW+PpIg5w8xMDV2l/iIKn5SY7pQCbhL8FVIRm721l00fuPDCUHP
        wpOUobxql4gngbPg+Im2ooVW0N11KH4KLnmI
X-Google-Smtp-Source: APXvYqzqz0hM8566mMMykEcEDE15qguKaKv3Gnp85A2T0WJw46tHTZ3v4v+uUTcgMqiUvlhCC6+9Qaw/183DYgvX
X-Received: by 2002:a05:6808:4ca:: with SMTP id a10mr3005375oie.35.1556630760913;
 Tue, 30 Apr 2019 06:26:00 -0700 (PDT)
Date:   Tue, 30 Apr 2019 15:25:10 +0200
In-Reply-To: <cover.1556630205.git.andreyknvl@google.com>
Message-Id: <66262e91c1768bf61e78456608a8a5190ea4e1d8.1556630205.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1556630205.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
Subject: [PATCH v14 14/17] media/v4l2-core, arm64: untag user pointers in videobuf_dma_contig_user_get
From:   Andrey Konovalov <andreyknvl@google.com>
To:     linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        linux-media@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Yishai Hadas <yishaih@mellanox.com>, Kuehling@google.com,
        Felix <Felix.Kuehling@amd.com>, Deucher@google.com,
        Alexander <Alexander.Deucher@amd.com>, Koenig@google.com,
        Christian <Christian.Koenig@amd.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is a part of a series that extends arm64 kernel ABI to allow to
pass tagged user pointers (with the top byte set to something else other
than 0x00) as syscall arguments.

videobuf_dma_contig_user_get() uses provided user pointers for vma
lookups, which can only by done with untagged pointers.

Untag the pointers in this function.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 drivers/media/v4l2-core/videobuf-dma-contig.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/media/v4l2-core/videobuf-dma-contig.c b/drivers/media/v4l2-core/videobuf-dma-contig.c
index e1bf50df4c70..8a1ddd146b17 100644
--- a/drivers/media/v4l2-core/videobuf-dma-contig.c
+++ b/drivers/media/v4l2-core/videobuf-dma-contig.c
@@ -160,6 +160,7 @@ static void videobuf_dma_contig_user_put(struct videobuf_dma_contig_memory *mem)
 static int videobuf_dma_contig_user_get(struct videobuf_dma_contig_memory *mem,
 					struct videobuf_buffer *vb)
 {
+	unsigned long untagged_baddr = untagged_addr(vb->baddr);
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
 	unsigned long prev_pfn, this_pfn;
@@ -167,22 +168,22 @@ static int videobuf_dma_contig_user_get(struct videobuf_dma_contig_memory *mem,
 	unsigned int offset;
 	int ret;
 
-	offset = vb->baddr & ~PAGE_MASK;
+	offset = untagged_baddr & ~PAGE_MASK;
 	mem->size = PAGE_ALIGN(vb->size + offset);
 	ret = -EINVAL;
 
 	down_read(&mm->mmap_sem);
 
-	vma = find_vma(mm, vb->baddr);
+	vma = find_vma(mm, untagged_baddr);
 	if (!vma)
 		goto out_up;
 
-	if ((vb->baddr + mem->size) > vma->vm_end)
+	if ((untagged_baddr + mem->size) > vma->vm_end)
 		goto out_up;
 
 	pages_done = 0;
 	prev_pfn = 0; /* kill warning */
-	user_address = vb->baddr;
+	user_address = untagged_baddr;
 
 	while (pages_done < (mem->size >> PAGE_SHIFT)) {
 		ret = follow_pfn(vma, user_address, &this_pfn);
-- 
2.21.0.593.g511ec345e18-goog

