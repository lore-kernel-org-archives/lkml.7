Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D36AAC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 15:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99DD32053B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 15:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V9A8Is0U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbfLJPxE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 10:53:04 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59772 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727437AbfLJPxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 10:53:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575993182;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q7Wkuo5DOrROzVyUdQcO7Id9YJhb4KcA4EFLGC9qzM8=;
        b=V9A8Is0U3DRFP8i6swiFb+jykQmeWthfs8OmOuyqiR77nokwjNWU1tKxqyvdjQhb5Uqpqy
        6xATPgaIPdTKWTsKQY0FbKPVZHDox3mNB9DpA0HzfjgVtQoNURAlqnIJRetj1MBhbSHk9k
        N0pRG24GIRNKGudysFlmTQUu1FWXROA=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-oOBpzL8bNL21DXykE1emwA-1; Tue, 10 Dec 2019 10:53:01 -0500
Received: by mail-qk1-f198.google.com with SMTP id a6so12501697qkl.7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 07:53:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CTMg4TU0Xzm9Sp3cKGL3NKbE9vCAJaofWeL0HT4DNMU=;
        b=OQhdQ2SvxDFuAYvFvPu6njRSzIdjw8xOh5NWxOOMgtijiGGsE0uHkbdeg8ajR85PJb
         Ph4wnR8YApcSfpUmWcoaddbINDHMXSoSbxIWSYgc9DVjjg+k53zHMx1IyLicrjeEHAM7
         tHBpj1Xl3F0TlsVAQ99mDy0lN1oKbYSd+Kx+d3RXSv24m2fzxc92gA4nfB52QlJk3z/c
         Hn1sCGs+xo7pPdhBBgrqH979XcEcbVfiBDaiUrP5NWHDSbkk2CRhUkyVORpK6/y73yUh
         OWJtVYQWOzv+G5hhOq/AfFRnfwDwYHJ5vj3BobUljdZsOxMd+ulIkJP2VhZv4RuYJocb
         obIQ==
X-Gm-Message-State: APjAAAU561tDeRnaJqb2quHtIFy2o1LIBmphPxw22yqe52sT3f23/2Qr
        HXkt4OcLv2PNWH116KHVREJPLQz8q3vNnrugHiMP1InYJ3Tb8DjHPOOtGgBzhJUQd/pRIuYUSZp
        SFwdCHaWSfXZOXXVxgr0DCsnU
X-Received: by 2002:aed:2469:: with SMTP id s38mr4423842qtc.172.1575993181256;
        Tue, 10 Dec 2019 07:53:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqyQcTBiI7P3OeRYMxxzIss87EQVvdXW+O/wzbi1TnkUtQrmno9BbevPH1mBp0ZhCa/2sQMpbA==
X-Received: by 2002:aed:2469:: with SMTP id s38mr4423817qtc.172.1575993180966;
        Tue, 10 Dec 2019 07:53:00 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id 4sm1040383qki.51.2019.12.10.07.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 07:53:00 -0800 (PST)
Date:   Tue, 10 Dec 2019 10:52:59 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH RFC 04/15] KVM: Implement ring-based dirty memory tracking
Message-ID: <20191210155259.GD3352@xz-x1>
References: <20191129213505.18472-1-peterx@redhat.com>
 <20191129213505.18472-5-peterx@redhat.com>
 <20191202201036.GJ4063@linux.intel.com>
 <20191202211640.GF31681@xz-x1>
 <20191202215049.GB8120@linux.intel.com>
 <fd882b9f-e510-ff0d-db43-eced75427fc6@redhat.com>
 <20191203184600.GB19877@linux.intel.com>
 <374f18f1-0592-9b70-adbb-0a72cc77d426@redhat.com>
 <20191209215400.GA3352@xz-x1>
 <affd9d84-1b84-0c25-c431-a075c58c33dc@redhat.com>
MIME-Version: 1.0
In-Reply-To: <affd9d84-1b84-0c25-c431-a075c58c33dc@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-MC-Unique: oOBpzL8bNL21DXykE1emwA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 11:07:31AM +0100, Paolo Bonzini wrote:
> > I'm thinking whether I can start
> > to use this information in the next post on solving an issue I
> > encountered with the waitqueue.
> >=20
> > Current waitqueue is still problematic in that it could wait even with
> > the mmu lock held when with vcpu context.
>=20
> I think the idea of the soft limit is that the waiting just cannot
> happen.  That is, the number of dirtied pages _outside_ the guest (guest
> accesses are taken care of by PML, and are subtracted from the soft
> limit) cannot exceed hard_limit - (soft_limit + pml_size).

So the question go backs to, whether this is guaranteed somehow?  Or
do you prefer us to keep the warn_on_once until it triggers then we
can analyze (which I doubt..)?

One thing to mention is that for with-vcpu cases, we probably can even
stop KVM_RUN immediately as long as either the per-vm or per-vcpu ring
reaches the softlimit, then for vcpu case it should be easier to
guarantee that.  What I want to know is the rest of cases like ioctls
or even something not from the userspace (which I think I should read
more later..).

If the answer is yes, I'd be more than glad to drop the waitqueue.

>=20
> > The issue is KVM_RESET_DIRTY_RINGS needs the mmu lock to manipulate
> > the write bits, while it's the only interface to also wake up the
> > dirty ring sleepers.  They could dead lock like this:
> >=20
> >       main thread                            vcpu thread
> >       =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D                            =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >                                              kvm page fault
> >                                                mark_page_dirty_in_slot
> >                                                mmu lock taken
> >                                                mark dirty, ring full
> >                                                queue on waitqueue
> >                                                (with mmu lock)
> >       KVM_RESET_DIRTY_RINGS
> >         take mmu lock               <------------ deadlock here
> >         reset ring gfns
> >         wakeup dirty ring sleepers
> >=20
> > And if we see if the mark_page_dirty_in_slot() is not with a vcpu
> > context (e.g. kvm_mmu_page_fault) but with an ioctl context (those
> > cases we'll use per-vm dirty ring) then it's probably fine.
> >=20
> > My planned solution:
> >=20
> > - When kvm_get_running_vcpu() !=3D NULL, we postpone the waitqueue wait=
s
> >   until we finished handling this page fault, probably in somewhere
> >   around vcpu_enter_guest, so that we can do wait_event() after the
> >   mmu lock released
>=20
> I think this can cause a race:
>=20
> =09vCPU 1=09=09=09vCPU 2=09=09host
> =09---------------------------------------------------------------
> =09mark page dirty
> =09=09=09=09write to page
> =09=09=09=09=09=09treat page as not dirty
> =09add page to ring
>=20
> where vCPU 2 skips the clean-page slow path entirely.

If we're still with the rule in userspace that we first do RESET then
collect and send the pages (just like what we've discussed before),
then IMHO it's fine to have vcpu2 to skip the slow path?  Because
RESET happens at "treat page as not dirty", then if we are sure that
we only collect and send pages after that point, then the latest
"write to page" data from vcpu2 won't be lost even if vcpu2 is not
blocked by vcpu1's ring full?

Maybe we can also consider to let mark_page_dirty_in_slot() return a
value, then the upper layer could have a chance to skip the spte
update if mark_page_dirty_in_slot() fails to mark the dirty bit, so it
can return directly with RET_PF_RETRY.

Thanks,

--=20
Peter Xu

