Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F269C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 03:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D30320854
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 03:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="I4tWEvZI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbfCSDU0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 23:20:26 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48436 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbfCSDUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 23:20:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8cOcRzjIwTqLzjM51anaSwI2gAP+jsx+4ZN5gqnYUgE=; b=I4tWEvZIfSkzZB9k50MhjOS+p
        OupUFBYVK9RTV1208k82etZeYqgiZABof5TObr7F4uODnqxm1rp+Epk+pBDi21EJHjcjrqHh84bU9
        3uuM5SbyIAl6k64S4xjNsY74mYgVvfXZ4g7J2Paiw+pMd931xxFT7/AQoJCpwgkDY69mu5YFoxQi2
        +00fZoYebqxvS4s3iC7fMjUMNSBtu5/GcO2Vt2iVRPMjt9gbkj3DKtDKkTUaq4Nf9/obdcEv7TTB6
        ++iBelLhkwhg/WgFK+PyjNzNaewYeJbuKnJxNzhZt0QT8jHNfKYl65tw8QHvSxnfkuCzKqvfm1csK
        WH9aQnbsA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h65Ic-00074L-LW; Tue, 19 Mar 2019 03:20:22 +0000
Date:   Mon, 18 Mar 2019 20:20:22 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     akpm@linux-foundation.org, mike.kravetz@oracle.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-sparse@vger.kernel.org
Subject: Re: [PATCH] include/linux/hugetlb.h: Convert to use vm_fault_t
Message-ID: <20190319032022.GR19508@bombadil.infradead.org>
References: <20190318162604.GA31553@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190318162604.GA31553@jordon-HP-15-Notebook-PC>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 09:56:05PM +0530, Souptick Joarder wrote:
> >> mm/memory.c:3968:21: sparse: incorrect type in assignment (different
> >> base types) @@    expected restricted vm_fault_t [usertype] ret @@
> >> got e] ret @@
>    mm/memory.c:3968:21:    expected restricted vm_fault_t [usertype] ret
>    mm/memory.c:3968:21:    got int

I think this may be a sparse bug.

Compare:

+++ b/mm/memory.c
@@ -3964,6 +3964,9 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
        if (flags & FAULT_FLAG_USER)
                mem_cgroup_enter_user_fault();
 
+       ret = 0;
+       ret = ({ BUG(); 0; });
+       ret = 1;
        if (unlikely(is_vm_hugetlb_page(vma)))
                ret = hugetlb_fault(vma->vm_mm, vma, address, flags);
        else

../mm/memory.c:3968:13: sparse: warning: incorrect type in assignment (different base types)
../mm/memory.c:3968:13: sparse:    expected restricted vm_fault_t [assigned] [usertype] ret
../mm/memory.c:3968:13: sparse:    got int
../mm/memory.c:3969:13: sparse: warning: incorrect type in assignment (different base types)
../mm/memory.c:3969:13: sparse:    expected restricted vm_fault_t [assigned] [usertype] ret
../mm/memory.c:3969:13: sparse:    got int

vm_fault_t is __bitwise:

include/linux/mm_types.h:typedef __bitwise unsigned int vm_fault_t;

so simply assigning 0 to ret should work (and does on line 3967), but
sparse doesn't seem to like it as part of a ({ .. }) expression.

