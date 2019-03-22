Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D77B2C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A62212183E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553260599;
	bh=HAyCZq/oIuQ67uR5cIbDu8hncq4VM9MZDnW9YQMf6gQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n0H3mZz4TeXNNxE8pzl8ftvw9LW4DHwdvA59ViFL9rBDPeEReWWwvS9BJBnIlZ/Ar
	 TRDj1r8zyzUWB62VatfphP3+ZTW3TuPbXxHcyCL3hNjrUXM1LBXp24nbp9sADVdS1Y
	 tLWxAQxlO9P+COWRSx6rKuObgtr9PX+zdReQ6lZE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729670AbfCVNQh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 09:16:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:54350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728510AbfCVL0i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:26:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3A2D218A2;
        Fri, 22 Mar 2019 11:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553253997;
        bh=HAyCZq/oIuQ67uR5cIbDu8hncq4VM9MZDnW9YQMf6gQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iVHP/1ewIPc+xlLTR1tBLPJBXc7dNDha8kXyU3rAtu7WS+oGIzooInHBU4eZOanGf
         89h9cPH/YOrM0n6eUePCzdmCGka27aZ0ytZRRIgcRIfrooohySzWM8VQM2lj9chWr3
         pKip61teDOHo68TecqWrhy/sv7Yr45DNUQqhk8aM=
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
Subject: [PATCH 3.18 120/134] mm/vmalloc: fix size check for remap_vmalloc_range_partial()
Date:   Fri, 22 Mar 2019 12:15:33 +0100
Message-Id: <20190322111219.063712948@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111210.465931067@linuxfoundation.org>
References: <20190322111210.465931067@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2140,7 +2140,7 @@ int remap_vmalloc_range_partial(struct v
 	if (!(area->flags & VM_USERMAP))
 		return -EINVAL;
 
-	if (kaddr + size > area->addr + area->size)
+	if (kaddr + size > area->addr + get_vm_area_size(area))
 		return -EINVAL;
 
 	do {


