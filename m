Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD1DC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 00:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96FBA24672
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 00:33:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HTyZEvW9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbfLRAdF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 19:33:05 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:22868 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725975AbfLRAdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 19:33:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576629183;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MUqu+OLn2DzlXo+Ea5AeHEiHuVl3+cBg4SznB5lZzm0=;
        b=HTyZEvW9rF5U6eEBIB6IR7GUUAECV/wtv8m12/68XNCvjpqchEOwI8IXxPKw9nn9zVuFJM
        Nq5u/DOaQgWIhnpdd7gJh2//Ms+sGshrRF8LZH7vGW/616ycS+nAvnHHINSZHPqtzf9y3f
        LNNbWLDos0fTKrSAR5VsgScpmY7UziU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-wdfapklgOfaYvKaP_hRdoQ-1; Tue, 17 Dec 2019 19:33:02 -0500
X-MC-Unique: wdfapklgOfaYvKaP_hRdoQ-1
Received: by mail-wr1-f69.google.com with SMTP id u12so92998wrt.15
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 16:33:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MUqu+OLn2DzlXo+Ea5AeHEiHuVl3+cBg4SznB5lZzm0=;
        b=cmfjQi2A7gSevBHGfs9wp8M5qrxHPjWiD+mT2qOMgg+Sr+FYYYsKe9auVHRfOV96tD
         mrGtEl8epKgP7iTQ2O/jNGsZJriFP60a4cKgqFZ1fUZL9k5S1qq9l3jyoR5nfgpqT1ht
         BoWG7fwYOwluuGlktTQfhTXPME0ZgnNEbUm1QJpaz5q65dpMy7MHY4uFnmOVh8TT8Dep
         k52kRaOisoXdeR1g2PWo2xOdrW6z+FZR6DlpEFClp+6OKD62hrN9O0qqiHw+N4M1oK/L
         jbuYZmRCp/vaRg6vfUXOWhtaKTIN9QgabFoAYdFjhm+ZHNIg+gSlPYKQbLqzGuoPKgvv
         YTnQ==
X-Gm-Message-State: APjAAAXNm5Sbbsby+wk6Llq4k2eVwJOFzp7jVeOdzLazsVqeIjcdXjM4
        D3zz5dWHyduI3y+tHE67kG+NeTsJfmuUpnOdiHVy3uX/wkg87fmTU8w7sq/2Ap5s0YW6xhC/pey
        bhJ/SXB770XGmwfGtxOHLr43B
X-Received: by 2002:adf:fe07:: with SMTP id n7mr556716wrr.286.1576629181391;
        Tue, 17 Dec 2019 16:33:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqyOPwwYn1/kpxfXxxae5zrFUIrXtQjN+X+Arvd/trczko5NgR6MDwSv2h+RxstUNB/j43mNkA==
X-Received: by 2002:adf:fe07:: with SMTP id n7mr556679wrr.286.1576629181096;
        Tue, 17 Dec 2019 16:33:01 -0800 (PST)
Received: from [192.168.10.150] ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id d10sm516606wrw.64.2019.12.17.16.33.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 16:33:00 -0800 (PST)
Subject: Re: [PATCH RFC 04/15] KVM: Implement ring-based dirty memory tracking
To:     Peter Xu <peterx@redhat.com>
Cc:     Christophe de Dinechin <dinechin@redhat.com>,
        Christophe de Dinechin <christophe.de.dinechin@gmail.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>
References: <20191129213505.18472-5-peterx@redhat.com>
 <m1lfrihj2n.fsf@dinechin.org> <20191213202324.GI16429@xz-x1>
 <bc15650b-df59-f508-1090-21dafc6e8ad1@redhat.com>
 <E167A793-B42A-422D-8D46-B992CB6EBE69@redhat.com>
 <d59ac0eb-e65a-a46f-886e-6df80a2b142f@redhat.com>
 <20191217153837.GC7258@xz-x1>
 <ecb949d1-4539-305f-0a84-1704834e37ba@redhat.com>
 <20191217164244.GE7258@xz-x1>
 <c6d00ced-64ff-34af-99dd-abbcbac67836@redhat.com>
 <20191217194114.GG7258@xz-x1>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <838084bf-efd7-009c-62ce-f11493242867@redhat.com>
Date:   Wed, 18 Dec 2019 01:33:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191217194114.GG7258@xz-x1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/12/19 20:41, Peter Xu wrote:
> On Tue, Dec 17, 2019 at 05:48:58PM +0100, Paolo Bonzini wrote:
>> On 17/12/19 17:42, Peter Xu wrote:
>>>
>>> However I just noticed something... Note that we still didn't read
>>> into non-x86 archs, I think it's the same question as when I asked
>>> whether we can unify the kvm[_vcpu]_write() interfaces and you'd like
>>> me to read the non-x86 archs - I think it's time I read them, because
>>> it's still possible that non-x86 archs will still need the per-vm
>>> ring... then that could be another problem if we want to at last
>>> spread the dirty ring idea outside of x86.
>>
>> We can take a look, but I think based on x86 experience it's okay if we
>> restrict dirty ring to arches that do no VM-wide accesses.
> 
> Here it is - a quick update on callers of mark_page_dirty_in_slot().
> The same reverse trace, but ignoring all common and x86 code path
> (which I covered in the other thread):
> 
> ==================================
> 
>    mark_page_dirty_in_slot (non-x86)
>         mark_page_dirty
>             kvm_write_guest_page
>                 kvm_write_guest
>                     kvm_write_guest_lock
>                         vgic_its_save_ite [?]
>                         vgic_its_save_dte [?]
>                         vgic_its_save_cte [?]
>                         vgic_its_save_collection_table [?]
>                         vgic_v3_lpi_sync_pending_status [?]
>                         vgic_v3_save_pending_tables [?]
>                     kvmppc_rtas_hcall [&]
>                     kvmppc_st [&]
>                     access_guest [&]
>                     put_guest_lc [&]
>                     write_guest_lc [&]
>                     write_guest_abs [&]
>             mark_page_dirty
>                 _kvm_mips_map_page_fast [&]
>                 kvm_mips_map_page [&]
>                 kvmppc_mmu_map_page [&]
>                 kvmppc_copy_guest
>                     kvmppc_h_page_init [&]
>                 kvmppc_xive_native_vcpu_eq_sync [&]
>                 adapter_indicators_set [?] (from kvm_set_irq)
>                 kvm_s390_sync_dirty_log [?]
>                 unpin_guest_page
>                     unpin_blocks [&]
>                     unpin_scb [&]
> 
> Cases with [*]: should not matter much
>            [&]: should be able to change to per-vcpu context
>            [?]: uncertain...
> 
> ==================================
> 
> This time we've got 8 leaves with "[?]".
> 
> I'm starting with these:
> 
>         vgic_its_save_ite [?]
>         vgic_its_save_dte [?]
>         vgic_its_save_cte [?]
>         vgic_its_save_collection_table [?]
>         vgic_v3_lpi_sync_pending_status [?]
>         vgic_v3_save_pending_tables [?]
> 
> These come from ARM specific ioctls like KVM_DEV_ARM_ITS_SAVE_TABLES,
> KVM_DEV_ARM_ITS_RESTORE_TABLES, KVM_DEV_ARM_VGIC_SAVE_PENDING_TABLES.
> IIUC ARM needed these to allow proper migration which indeed does not
> have a vcpu context.
> 
> (Though I'm a bit curious why ARM didn't simply migrate these
>  information explicitly from userspace, instead it seems to me that
>  ARM guests will dump something into guest ram and then tries to
>  recover from that which seems to be a bit weird)
>  
> Then it's this:
> 
>         adapter_indicators_set [?]
> 
> This is s390 specific, which should come from kvm_set_irq.  I'm not
> sure whether we can remove the mark_page_dirty() call of this, if it's
> applied from another kernel structure (which should be migrated
> properly IIUC).  But I might be completely wrong.
> 
>         kvm_s390_sync_dirty_log [?]
>         
> This is also s390 specific, should be collecting from the hardware
> PGSTE_UC_BIT bit.  No vcpu context for sure.
> 
> (I'd be glad too if anyone could hint me why x86 cannot use page table
>  dirty bits for dirty tracking, if there's short answer...)

With PML it is.  Without PML, however, it would be much slower to
synchronize the dirty bitmap from KVM to userspace (one atomic operation
per page instead of one per 64 pages) and even impossible to have the
dirty ring.

> I think my conclusion so far...
> 
>   - for s390 I don't think we even need this dirty ring buffer thing,
>     because I think hardware trackings should be more efficient, then
>     we don't need to care much on that either from design-wise of
>     dirty ring,

I would be surprised if it's more efficient without something like PML,
but anyway the gist is correct---without write protection-based dirty
page logging, s390 cannot use the dirty page ring buffer.

>   - for ARM, those no-vcpu-context dirty tracking probably needs to be
>     considered, but hopefully that's a very special path so it rarely
>     happen.  The bad thing is I didn't dig how many pages will be
>     dirtied when ARM guest starts to dump all these things so it could
>     be a burst...  If it is, then there's risk to trigger the ring
>     full condition (which we wanted to avoid..)

It says all vCPU locks must be held, so it could just use any vCPU.  I
am not sure what's the upper limit on the number of entries, or even
whether userspace could just dirty those pages itself, or perhaps
whether there could be a different ioctl that gets the pages into
userspace memory (and then if needed userspace can copy them into guest
memory, I don't know why it is designed like that).

Paolo

