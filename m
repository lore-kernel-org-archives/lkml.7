Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA143C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC4C520673
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:41:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MPF4eMLl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387791AbgAIQlN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 11:41:13 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36874 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1733306AbgAIQlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 11:41:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578588072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W8is7aJP7Jr94Kau6TBpmvxbpseySDfgA2zeSyOzsAQ=;
        b=MPF4eMLl3AxOTUHxEmJnBnPjXPwPqPlmzNhlE5toXMPU9In+AKdKTEqot4SH1NTDEmWpY8
        bUCZ3tk6usuHJA94fBP8vX0vnWmxeB0ZvwB2CR8OtjPyXcmRstMnvAglHlQxwtDAgzP+vt
        ru6JweDBGEFQdq5U0LjlXQsFTwqbuF8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-pskfBW-eOQCUDgzMqOWhPg-1; Thu, 09 Jan 2020 11:41:06 -0500
X-MC-Unique: pskfBW-eOQCUDgzMqOWhPg-1
Received: by mail-qv1-f69.google.com with SMTP id e10so4447045qvq.18
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 08:41:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=W8is7aJP7Jr94Kau6TBpmvxbpseySDfgA2zeSyOzsAQ=;
        b=bP5o6s++t05kzHNSYFsHYsh7CbAiOjlH3KbJFDikYJPvtjhIVtpkj/cBRVQaY07Py7
         quQLhOQcL9K1T5+l+2o6Zc93mVl6vhU5KO3aXd1hJhC4hRro8/8UYsyhIirMzp30rgSt
         ji+eMlgFx5V3MZHM2dhUQJmv8D9zqcu8N4gHY95X1Dh4CSK9Tr5J0nisE3Q3bUbdfGPA
         s0mLWnBGo1g5ZpEXDQC+iBPHhOTuHNmUusPd4/0HLk0B2satb4tepviToSj+Js5QDAwm
         n7c1xk73VPyVxcM/Ui0+vGMsIHx80TzH+h+1kPbB4ozUZTIXrAw1wZeNUSqFp4n03s5C
         sWqQ==
X-Gm-Message-State: APjAAAXeKbu4XgvEFF7hfcm//fQi1RXVpS1ap7g4qftZPGTGByLYh97r
        WovudtjbY/Yy9XXXToKXnMPZRu6zx8tg2jTthPxJ90SFZdFKc6toy2lgGZ9UDJh91LtFsAQjK4L
        sodSITz5V1B4TDtxMr5Xj7Ra7
X-Received: by 2002:a0c:d60e:: with SMTP id c14mr9518432qvj.76.1578588065793;
        Thu, 09 Jan 2020 08:41:05 -0800 (PST)
X-Google-Smtp-Source: APXvYqwFThgj+FPfsa8kRdSVmK/1QdWGxewVr4WL/ID/MZzW7mYehsO2/EBPyUx+T7omkvmVW3Z1Gg==
X-Received: by 2002:a0c:d60e:: with SMTP id c14mr9518407qvj.76.1578588065427;
        Thu, 09 Jan 2020 08:41:05 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id g16sm3237033qkk.61.2020.01.09.08.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 08:41:04 -0800 (PST)
Date:   Thu, 9 Jan 2020 11:41:02 -0500
From:   Peter Xu <peterx@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christophe de Dinechin <dinechin@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yan Zhao <yan.y.zhao@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Kevin Kevin <kevin.tian@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v3 14/21] KVM: Don't allocate dirty bitmap if dirty ring
 is enabled
Message-ID: <20200109164102.GA36997@xz-x1>
References: <20200109145729.32898-1-peterx@redhat.com>
 <20200109145729.32898-15-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200109145729.32898-15-peterx@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 09:57:22AM -0500, Peter Xu wrote:
> Because kvm dirty rings and kvm dirty log is used in an exclusive way,
> Let's avoid creating the dirty_bitmap when kvm dirty ring is enabled.
> At the meantime, since the dirty_bitmap will be conditionally created
> now, we can't use it as a sign of "whether this memory slot enabled
> dirty tracking".  Change users like that to check against the kvm
> memory slot flags.
> 
> Note that there still can be chances where the kvm memory slot got its
> dirty_bitmap allocated, _if_ the memory slots are created before
> enabling of the dirty rings and at the same time with the dirty
> tracking capability enabled, they'll still with the dirty_bitmap.
> However it should not hurt much (e.g., the bitmaps will always be
> freed if they are there), and the real users normally won't trigger
> this because dirty bit tracking flag should in most cases only be
> applied to kvm slots only before migration starts, that should be far
> latter than kvm initializes (VM starts).
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/linux/kvm_host.h | 5 +++++
>  virt/kvm/kvm_main.c      | 5 +++--
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index c96161c6a0c9..ab2a169b1264 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -353,6 +353,11 @@ struct kvm_memory_slot {
>  	u8 as_id;
>  };
>  
> +static inline bool kvm_slot_dirty_track_enabled(struct kvm_memory_slot *slot)
> +{
> +	return slot->flags & KVM_MEM_LOG_DIRTY_PAGES;
> +}
> +
>  static inline unsigned long kvm_dirty_bitmap_bytes(struct kvm_memory_slot *memslot)
>  {
>  	return ALIGN(memslot->npages, BITS_PER_LONG) / 8;
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index f0f766183cb2..46da3169944f 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -1120,7 +1120,8 @@ int __kvm_set_memory_region(struct kvm *kvm,
>  	}
>  
>  	/* Allocate page dirty bitmap if needed */
> -	if ((new.flags & KVM_MEM_LOG_DIRTY_PAGES) && !new.dirty_bitmap) {
> +	if ((new.flags & KVM_MEM_LOG_DIRTY_PAGES) && !new.dirty_bitmap &&
> +	    !kvm->dirty_ring_size) {
>  		if (kvm_create_dirty_bitmap(&new) < 0)
>  			goto out_free;
>  	}
> @@ -2309,7 +2310,7 @@ static void mark_page_dirty_in_slot(struct kvm *kvm,
>  				    struct kvm_memory_slot *memslot,
>  				    gfn_t gfn)
>  {
> -	if (memslot && memslot->dirty_bitmap) {
> +	if (memslot && kvm_slot_dirty_track_enabled(memslot)) {
>  		unsigned long rel_gfn = gfn - memslot->base_gfn;
>  		u32 slot = (memslot->as_id << 16) | memslot->id;
>  
> -- 
> 2.24.1
> 

I think below should be squashed as well into this patch:

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 621b842a9b7b..0806bd12d8ee 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -1308,7 +1308,7 @@ static inline bool memslot_valid_for_gpte(struct kvm_memory_slot *slot,
 {
        if (!slot || slot->flags & KVM_MEMSLOT_INVALID)
                return false;
-       if (no_dirty_log && slot->dirty_bitmap)
+       if (no_dirty_log && kvm_slot_dirty_track_enabled(slot))
                return false;
  
        return true;

Thanks,

-- 
Peter Xu

