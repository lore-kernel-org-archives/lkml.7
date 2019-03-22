Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82474C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FFFB21929
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553258424;
	bh=6KfBVJ3m5R21fDxFjxoQkNsL8x1SKclXLwAXu2VGBG4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yQxWtD0zr8e+wslWnvcdn3/Jla/V5kRFV0QsqwEgRT4X1QLsiBSjt7r6TDnhHAOUg
	 r3bVkCqnKvyC08VdvsPzNdN5mZYHkmEY28XzvLg4v4Ie1awogNq5+ZkDyq44J7b/SJ
	 tGU6DdhfGShpxiVljHJ3Mh3lXBtVAYuJPP19OnhI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389150AbfCVMkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:40:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:45204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388228AbfCVMGp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:06:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D997206C0;
        Fri, 22 Mar 2019 12:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256405;
        bh=6KfBVJ3m5R21fDxFjxoQkNsL8x1SKclXLwAXu2VGBG4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IACnXoVll7qIwbf348E691pmZGuFHNfZolL4HMwR/amnsr+j+qQ9Tn5IBmyVTRrBA
         vQ30cN+ZIED8ulOdqvUjV9zhOKq2T8MYV3bt+7rg/TKK1vZMrCda+buv0Y+ILewwvK
         n4/Vh0WFSMHRhDkc1DCiLiVWjmvBpYeUAegx9QDY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Roman Penyaev <rpenyaev@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Joe Perches <joe@perches.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.19 201/280] mm/vmalloc: fix size check for remap_vmalloc_range_partial()
Date:   Fri, 22 Mar 2019 12:15:54 +0100
Message-Id: <20190322111330.764404978@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Roman Penyaev <rpenyaev@suse.de>

commit 401592d2e095947344e10ec0623adbcd58934dd4 upstream.

When VM_NO_GUARD is not set area->size includes adjacent guard page,
thus for correct size checking get_vm_area_size() should be used, but
not area->size.

This fixes possible kernel oops when userspace tries to mmap an area on
1 page bigger than was allocated by vmalloc_user() call: the size check
inside remap_vmalloc_range_partial() accounts non-existing guard page
also, so check successfully passes but vmalloc_to_page() returns NULL
(guard page does not physically exist).

The following code pattern example should trigger an oops:

  static int oops_mmap(struct file *file, struct vm_area_struct *vma)
  {
        void *mem;

        mem = vmalloc_user(4096);
        BUG_ON(!mem);
        /* Do not care about mem leak */

        return remap_vmalloc_range(vma, mem, 0);
  }

And userspace simply mmaps size + PAGE_SIZE:

  mmap(NULL, 8192, PROT_WRITE|PROT_READ, MAP_PRIVATE, fd, 0);

Possible candidates for oops which do not have any explicit size
checks:

   *** drivers/media/usb/stkwebcam/stk-webcam.c:
   v4l_stk_mmap[789]   ret = remap_vmalloc_range(vma, sbuf->buffer, 0);

Or the following one:

   *** drivers/video/fbdev/core/fbmem.c
   static int
   fb_mmap(struct file *file, struct vm_area_struct * vma)
        ...
        res = fb->fb_mmap(info, vma);

Where fb_mmap callback calls remap_vmalloc_range() directly without any
explicit checks:

   *** drivers/video/fbdev/vfb.c
   static int vfb_mmap(struct fb_info *info,
             struct vm_area_struct *vma)
   {
       return remap_vmalloc_range(vma, (void *)info->fix.smem_start, vma->vm_pgoff);
   }

Link: http://lkml.kernel.org/r/20190103145954.16942-2-rpenyaev@suse.de
Signed-off-by: Roman Penyaev <rpenyaev@suse.de>
Acked-by: Michal Hocko <mhocko@suse.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Joe Perches <joe@perches.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/vmalloc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2244,7 +2244,7 @@ int remap_vmalloc_range_partial(struct v
 	if (!(area->flags & VM_USERMAP))
 		return -EINVAL;
 
-	if (kaddr + size > area->addr + area->size)
+	if (kaddr + size > area->addr + get_vm_area_size(area))
 		return -EINVAL;
 
 	do {


