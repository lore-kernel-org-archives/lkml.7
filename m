Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32AADC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 03:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05E85206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 03:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730144AbfDWDsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 23:48:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42986 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726260AbfDWDsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 23:48:06 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6AD753091761;
        Tue, 23 Apr 2019 03:48:06 +0000 (UTC)
Received: from xz-x1 (ovpn-12-175.pek2.redhat.com [10.72.12.175])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8F5EF19C78;
        Tue, 23 Apr 2019 03:48:04 +0000 (UTC)
Date:   Tue, 23 Apr 2019 11:48:02 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH] KVM: fix KVM_CLEAR_DIRTY_LOG for memory slots of
 unaligned size
Message-ID: <20190423034802.GC21301@xz-x1>
References: <1555508561-19864-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1555508561-19864-1-git-send-email-pbonzini@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Tue, 23 Apr 2019 03:48:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 03:42:41PM +0200, Paolo Bonzini wrote:
> If a memory slot's size is not a multiple of 64 pages (256K), then
> the KVM_CLEAR_DIRTY_LOG API is unusable: clearing the final 64 pages
> either requires the requested page range to go beyond memslot->npages,
> or requires log->num_pages to be unaligned, and kvm_clear_dirty_log_protect
> requires log->num_pages to be both in range and aligned.
> 
> To allow this case, allow log->num_pages not to be a multiple of 64 if
> it ends exactly on the last page of the slot.
> 
> Reported-by: Peter Xu <peterx@redhat.com>
> Fixes: 98938aa8edd6 ("KVM: validate userspace input in kvm_clear_dirty_log_protect()", 2019-01-02)
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  Documentation/virtual/kvm/api.txt            | 5 +++--
>  tools/testing/selftests/kvm/dirty_log_test.c | 4 ++--
>  virt/kvm/kvm_main.c                          | 7 ++++---
>  3 files changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
> index b62ad0d94234..de97369ad30d 100644
> --- a/Documentation/virtual/kvm/api.txt
> +++ b/Documentation/virtual/kvm/api.txt
> @@ -3829,8 +3829,9 @@ The ioctl clears the dirty status of pages in a memory slot, according to
>  the bitmap that is passed in struct kvm_clear_dirty_log's dirty_bitmap
>  field.  Bit 0 of the bitmap corresponds to page "first_page" in the
>  memory slot, and num_pages is the size in bits of the input bitmap.
> -Both first_page and num_pages must be a multiple of 64.  For each bit
> -that is set in the input bitmap, the corresponding page is marked "clean"
> +first_page must be a multiple of 64; num_pages must also be a multiple of
> +64 unless first_page + num_pages is the size of the memory slot.  For each
> +bit that is set in the input bitmap, the corresponding page is marked "clean"
>  in KVM's dirty bitmap, and dirty tracking is re-enabled for that page
>  (for example via write-protection, or by clearing the dirty bit in
>  a page table entry).
> diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
> index 4715cfba20dc..052fb5856df4 100644
> --- a/tools/testing/selftests/kvm/dirty_log_test.c
> +++ b/tools/testing/selftests/kvm/dirty_log_test.c
> @@ -289,7 +289,7 @@ static void run_test(enum vm_guest_mode mode, unsigned long iterations,
>  	max_gfn = (1ul << (guest_pa_bits - guest_page_shift)) - 1;
>  	guest_page_size = (1ul << guest_page_shift);
>  	/* 1G of guest page sized pages */
> -	guest_num_pages = (1ul << (30 - guest_page_shift));
> +	guest_num_pages = (1ul << (30 - guest_page_shift)) + 3;

Some comment mentioning the reason to shift a random number?

>  	host_page_size = getpagesize();
>  	host_num_pages = (guest_num_pages * guest_page_size) / host_page_size +
>  			 !!((guest_num_pages * guest_page_size) % host_page_size);
> @@ -359,7 +359,7 @@ static void run_test(enum vm_guest_mode mode, unsigned long iterations,
>  		kvm_vm_get_dirty_log(vm, TEST_MEM_SLOT_INDEX, bmap);
>  #ifdef USE_CLEAR_DIRTY_LOG
>  		kvm_vm_clear_dirty_log(vm, TEST_MEM_SLOT_INDEX, bmap, 0,
> -				       DIV_ROUND_UP(host_num_pages, 64) * 64);
> +				       host_num_pages);
>  #endif
>  		vm_dirty_log_verify(bmap);
>  		iteration++;
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index f4da53321161..ace23d8a309f 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -1269,7 +1269,7 @@ int kvm_clear_dirty_log_protect(struct kvm *kvm,
>  	if (as_id >= KVM_ADDRESS_SPACE_NUM || id >= KVM_USER_MEM_SLOTS)
>  		return -EINVAL;
>  
> -	if ((log->first_page & 63) || (log->num_pages & 63))
> +	if (log->first_page & 63)
>  		return -EINVAL;
>  
>  	slots = __kvm_memslots(kvm, as_id);
> @@ -1282,8 +1282,9 @@ int kvm_clear_dirty_log_protect(struct kvm *kvm,
>  	n = kvm_dirty_bitmap_bytes(memslot);
>  
>  	if (log->first_page > memslot->npages ||
> -	    log->num_pages > memslot->npages - log->first_page)
> -			return -EINVAL;
> +	    log->num_pages > memslot->npages - log->first_page ||
> +	    (log->num_pages < memslot->npages - log->first_page && (log->num_pages & 63)))
> +	    return -EINVAL;

There seems to be some indentation issue and overlong line, besides
that the patch content looks good to me.

Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks,

-- 
Peter Xu
