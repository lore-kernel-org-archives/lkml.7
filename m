Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C25EAC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 17:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AB982073D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 17:15:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eqNlHohu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730788AbfLKRP4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 12:15:56 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:57309 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726313AbfLKRP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 12:15:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576084554;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9ndFu0fDV4m1MlK8dA5FS6+r6ltpLnY4rIv/v9BIC+A=;
        b=eqNlHohu1mQRKpWH/IhAxbp2R471fHBmOEDQlpXg79Z1s2P5ozxeQsJzQY6u6f98mmRppO
        Cv/uRHOg02lj3aY73NBUmPpiEYafFaC/h+Qh7ssSyKNch3akG1gYFpQLM4MhiptIK4SR4V
        jgtHAjtPfWekHT7I2RUde89J0W2jOz8=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-1IdyiS-VNRSTXfGGKuPawQ-1; Wed, 11 Dec 2019 12:15:53 -0500
X-MC-Unique: 1IdyiS-VNRSTXfGGKuPawQ-1
Received: by mail-qt1-f197.google.com with SMTP id e37so4829592qtk.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 09:15:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9ndFu0fDV4m1MlK8dA5FS6+r6ltpLnY4rIv/v9BIC+A=;
        b=eK6MVozrAHE9vHkBSyOUj2pO88RSAx+7U2/1kfEVMBF18FYocTdS601dy3PfcDzTwc
         i4/ANeKb2hvCZQoravAmvv8wlRFppMAQ9wWW7wDljoyjiigvkDoFSF+f3QXXjvvzVFoJ
         T/fBZ8ejrh2/4Mxc4XHymLgo5h4Vlp3PiR0GLdbqjXEbcMQiu28k8TX/EbcC5JgsoOy6
         Ir6qmPpIqnuEpaiXpCHP4YyzwND6i23W3J41XYnw+DpmakFMFwcRuITBHDsywLh5WqsM
         ifnjO0+s/lX16utlidhyTDmYqP31mPIiosDZO5JU8MlDwmISm+TC4zsYQxpHA7/vqs53
         tR6g==
X-Gm-Message-State: APjAAAW2dqCnmHFX2Zdoj7dX5OjCcLoK0qcbMJCzbr0p2bHe57ZXM2BZ
        byPzYDqnl6kpoYPKNGRGpjjQywIEZ7r75+jRukQSv1/OUt6rkadC+wjQXMCANgd6btbNKKnjjz7
        aCeLTMplNzBiax9dz5ikc6pqn
X-Received: by 2002:ac8:6f09:: with SMTP id g9mr3721835qtv.275.1576084552261;
        Wed, 11 Dec 2019 09:15:52 -0800 (PST)
X-Google-Smtp-Source: APXvYqwiq9r2oGewGA5FIlvEHuucrbQ6MdIeAu5/Id1pWn+VePtoHJU/Ypu20w7YGiHikexilyMs+g==
X-Received: by 2002:ac8:6f09:: with SMTP id g9mr3721800qtv.275.1576084551910;
        Wed, 11 Dec 2019 09:15:51 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id f13sm1069432qtj.14.2019.12.11.09.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 09:15:51 -0800 (PST)
Date:   Wed, 11 Dec 2019 12:15:49 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Christophe de Dinechin <dinechin@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH RFC 00/15] KVM: Dirty ring interface
Message-ID: <20191211171549.GF48697@xz-x1>
References: <20191129213505.18472-1-peterx@redhat.com>
 <m1r21bgest.fsf@redhat.com>
 <f386bca9-b967-2e76-c580-465463843aa4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f386bca9-b967-2e76-c580-465463843aa4@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 03:16:30PM +0100, Paolo Bonzini wrote:
> On 11/12/19 14:41, Christophe de Dinechin wrote:
> > 
> > Peter Xu writes:
> > 
> >> Branch is here: https://github.com/xzpeter/linux/tree/kvm-dirty-ring
> >>
> >> Overview
> >> ============
> >>
> >> This is a continued work from Lei Cao <lei.cao@stratus.com> and Paolo
> >> on the KVM dirty ring interface.  To make it simple, I'll still start
> >> with version 1 as RFC.
> >>
> >> The new dirty ring interface is another way to collect dirty pages for
> >> the virtual machine, but it is different from the existing dirty
> >> logging interface in a few ways, majorly:
> >>
> >>   - Data format: The dirty data was in a ring format rather than a
> >>     bitmap format, so the size of data to sync for dirty logging does
> >>     not depend on the size of guest memory any more, but speed of
> >>     dirtying.  Also, the dirty ring is per-vcpu (currently plus
> >>     another per-vm ring, so total ring number is N+1), while the dirty
> >>     bitmap is per-vm.
> > 
> > I like Sean's suggestion to fetch rings when dirtying. That could reduce
> > the number of dirty rings to examine.
> 
> What do you mean by "fetch rings"?

I'd wildly guess Christophe means something like we create a ring pool
and we try to find a ring to push the dirty gfn when it comes.

OK, should I count it as another vote to Sean's? :)

I agree, but imho larger number of rings won't really be a problem as
long as it's still per-vcpu (after all we have a vcpu number
limitation which is harder to break...).  To me what Sean's suggestion
attracted me most is that the interface is cleaner, that we don't need
to expose the ring in two places any more.  At the meantime, I won't
care too much on perf issue here because after all it's dirty logging.
If perf is critial, then I think I'll certainly choose per-vcpu ring
without doubt even if it complicates the interface because it'll
certainly help on some conditional lockless.

> 
> > Also, as is, this means that the same gfn may be present in multiple
> > rings, right?
> 
> I think the actual marking of a page as dirty is protected by a spinlock
> but I will defer to Peter on this.

In most cases imho we should be with the mmu lock iiuc because the
general mmu page fault will take it.  However I think there're special
cases:

  - when the spte was popped already and just write protected, then
    it's very possible we can go via the quick page fault path
    (fast_page_fault()).  That is lockless (no mmu lock taken).

  - when there's no vcpu context, we'll use the per-vm ring.  Though
    per-vm ring is locked (per-vcpu ring is not!), I don't see how it
    would protect two callers to insert two identical gfns
    sequentially.. Also it can happen between per-vm and per-vcpu ring
    as well.

So I think gfn duplication could happen, but it should be rare.  Even
if it happens, it won't hurt much because the 2nd/3rd/... dirty bit of
the same gfn will simply be skipped by userspace when harvesting.

> 
> Paolo
> 
> >>
> >>   - Data copy: The sync of dirty pages does not need data copy any more,
> >>     but instead the ring is shared between the userspace and kernel by
> >>     page sharings (mmap() on either the vm fd or vcpu fd)
> >>
> >>   - Interface: Instead of using the old KVM_GET_DIRTY_LOG,
> >>     KVM_CLEAR_DIRTY_LOG interfaces, the new ring uses a new interface
> >>     called KVM_RESET_DIRTY_RINGS when we want to reset the collected
> >>     dirty pages to protected mode again (works like
> >>     KVM_CLEAR_DIRTY_LOG, but ring based)
> >>
> >> And more.
> >>
> >> I would appreciate if the reviewers can start with patch "KVM:
> >> Implement ring-based dirty memory tracking", especially the document
> >> update part for the big picture.  Then I'll avoid copying into most of
> >> them into cover letter again.
> >>
> >> I marked this series as RFC because I'm at least uncertain on this
> >> change of vcpu_enter_guest():
> >>
> >>         if (kvm_check_request(KVM_REQ_DIRTY_RING_FULL, vcpu)) {
> >>                 vcpu->run->exit_reason = KVM_EXIT_DIRTY_RING_FULL;
> >>                 /*
> >>                         * If this is requested, it means that we've
> >>                         * marked the dirty bit in the dirty ring BUT
> >>                         * we've not written the date.  Do it now.
> > 
> > not written the "data" ?

Yep, though I'll drop these lines altogether so we'll be fine.. :)

Thanks,

-- 
Peter Xu

