Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA1CC282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCF8A2077B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:21:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B2c24VEr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729073AbgAGVVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:21:09 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:44736 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728267AbgAGVVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:21:05 -0500
Received: by mail-vs1-f65.google.com with SMTP id p6so464256vsj.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 13:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xSRU4qb0ZOTzAyNx1lTLU2yX2h3B/4YPYeMRUYoNUNw=;
        b=B2c24VErfFgKcj+Y8pK4fduvG+1fQI+hXYgNkXJGbBRFwaKnQ/dBzAG8TezMb3/Q9Q
         m6031Hs6rCtZUh7bmDnZFhiSnSqShiG0SN6iRp876eP4eOImfeY0uKJ9ZWeLETLyWqfs
         ZvEaJ5UebA6DyfgEHhVXrAEmr3UFLR1V8Z7y4lbVghEPUprT3u9Ns75q6VXY3IBNTYmA
         rzqG9reCI0/e6EHRkRd7LSyHIGjW03TyI6y8ltFpSP5HkFFf9fyin3FuJdsuef5nzQ4Q
         QIreO53IIKEtcmoXxH6F+iIuZEQXYkKGC4vyb6gpMMULXGdvg7fWB2J2Zgp84mdF7ZPM
         ofag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xSRU4qb0ZOTzAyNx1lTLU2yX2h3B/4YPYeMRUYoNUNw=;
        b=WDC9iGj7Kv3Wc54kVt2Akbn7aZ20yPuo1j7kbh85Tt8IR6UDbJpe6IcauU/ZgQE4KO
         manrzBLTigVqY11PUmEbFZVVgB4jJqmIa2ipIRa8CH8sIWFd/ta2ncGrYl4C7SAK6RYR
         xIvKGf4tZ22S0FI/yvUjzoaBp61jY7VPZkDpMbwUAMXsew9xity83qoIWldCt6eR1z/0
         hbj6ZtBNnQRuU+E02DG91py0Wlwy/DPmS8LjHIPRgk1IJtDDOt45a1tn/eLc6lvyxCyd
         M5JdxuFgh5d0wwGU8h16JosU+8KwKNVYnD4VYL6Z616CagbKyzk12tlpwVbdnP6QwshX
         +R2A==
X-Gm-Message-State: APjAAAXVHB1s5HhLr9q83U3VL0aR8rq4Y8MOPgdd64aAiuS3SIjMdvis
        Azh1hRg76pPahVufUKdBctEj40Vi7IDhVglE50ksjQ==
X-Google-Smtp-Source: APXvYqyENOKFRASsBlhAPSr8XO5DU0ppABR3JIJu+k4Fe6D6fkhlIMmdJuGT0juY1Iv+IXC4K3kUX9+MYDhqzMADc7Y=
X-Received: by 2002:a67:6f46:: with SMTP id k67mr906097vsc.2.1578432064703;
 Tue, 07 Jan 2020 13:21:04 -0800 (PST)
MIME-Version: 1.0
References: <20191216213901.106941-1-bgardon@google.com> <20191216213901.106941-9-bgardon@google.com>
 <20200107154227.tvex5natt7a64nzj@kamzik.brq.redhat.com>
In-Reply-To: <20200107154227.tvex5natt7a64nzj@kamzik.brq.redhat.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Tue, 7 Jan 2020 13:20:53 -0800
Message-ID: <CANgfPd9VxvJYAw_cqG9X2GUAkZ9vumF8mZ1+P==mJoZgShR_rg@mail.gmail.com>
Subject: Re: [PATCH v3 8/8] KVM: selftests: Move large memslots above KVM
 internal memslots in _vm_create
To:     Andrew Jones <drjones@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Would it be viable to allocate at 4G be default and then add another
interface for allocations at low memory addresses? For most tests, I
don't think there's any value to having the backing paddrs below 3G.

On Tue, Jan 7, 2020 at 7:42 AM Andrew Jones <drjones@redhat.com> wrote:
>
> On Mon, Dec 16, 2019 at 01:39:01PM -0800, Ben Gardon wrote:
> > KVM creates internal memslots between 3 and 4 GiB paddrs on the first
> > vCPU creation. If memslot 0 is large enough it collides with these
> > memslots an causes vCPU creation to fail. When requesting more than 3G,
> > start memslot 0 at 4G in _vm_create.
> >
> > Signed-off-by: Ben Gardon <bgardon@google.com>
> > ---
> >  tools/testing/selftests/kvm/lib/kvm_util.c | 15 +++++++++++----
> >  1 file changed, 11 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> > index 41cf45416060f..886d58e6cac39 100644
> > --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> > +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> > @@ -113,6 +113,8 @@ const char * const vm_guest_mode_string[] = {
> >  _Static_assert(sizeof(vm_guest_mode_string)/sizeof(char *) == NUM_VM_MODES,
> >              "Missing new mode strings?");
> >
> > +#define KVM_INTERNAL_MEMSLOTS_START_PADDR (3UL << 30)
> > +#define KVM_INTERNAL_MEMSLOTS_END_PADDR (4UL << 30)
> >  /*
> >   * VM Create
> >   *
> > @@ -128,13 +130,16 @@ _Static_assert(sizeof(vm_guest_mode_string)/sizeof(char *) == NUM_VM_MODES,
> >   *
> >   * Creates a VM with the mode specified by mode (e.g. VM_MODE_P52V48_4K).
> >   * When phy_pages is non-zero, a memory region of phy_pages physical pages
> > - * is created and mapped starting at guest physical address 0.  The file
> > - * descriptor to control the created VM is created with the permissions
> > - * given by perm (e.g. O_RDWR).
> > + * is created. If phy_pages is less that 3G, it is mapped starting at guest
> > + * physical address 0. If phy_pages is greater than 3G it is mapped starting
> > + * 4G into the guest physical address space to avoid KVM internal memslots
> > + * which map the region between 3G and 4G. The file descriptor to control the
> > + * created VM is created with the permissions given by perm (e.g. O_RDWR).
> >   */
> >  struct kvm_vm *_vm_create(enum vm_guest_mode mode, uint64_t phy_pages, int perm)
> >  {
> >       struct kvm_vm *vm;
> > +     uint64_t guest_paddr = 0;
> >
> >       DEBUG("Testing guest mode: %s\n", vm_guest_mode_string(mode));
> >
> > @@ -227,9 +232,11 @@ struct kvm_vm *_vm_create(enum vm_guest_mode mode, uint64_t phy_pages, int perm)
> >
> >       /* Allocate and setup memory for guest. */
> >       vm->vpages_mapped = sparsebit_alloc();
> > +     if (guest_paddr + phy_pages > KVM_INTERNAL_MEMSLOTS_START_PADDR)
> > +             guest_paddr = KVM_INTERNAL_MEMSLOTS_END_PADDR;
> >       if (phy_pages != 0)
> >               vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS,
> > -                                         0, 0, phy_pages, 0);
> > +                                         guest_paddr, 0, phy_pages, 0);
> >
> >       return vm;
> >  }
> > --
> > 2.24.1.735.g03f4e72817-goog
> >
>
> I feel like this function is becoming too magic and it'll be more
> complicated for tests that need to add additional memory regions
> to know what physical addresses are available. Maybe we should assert
> if we can't allocate more than 3G at offset zero and also provide
> another interface for allocating at an offset input by the user,
> as long as the offset is 4G or above (asserting when it isn't)?
>
> Thanks,
> drew
>
