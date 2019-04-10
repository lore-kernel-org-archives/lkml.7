Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E84C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 20:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C59D21741
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 20:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554929137;
	bh=px7U9x0mLoBLBqMhq8XW+g+Q3qd7cPBMdlw/mG7xJKo=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=DVSG6FrGAXksFJv1gB5eE4z7aNf3fgWtwJAnABkpK2p5tfN9omeW9EEAK85jQzO2U
	 Vy+Rb65UvF6ko55ANdFUqKdvXNLYBpr4Vabm77bYc+HkEa6qa4NyHePPewrAg+5iA7
	 mDg2/8M4aiupwaGM2vnu3hKd/BWpV7ZkADRLEV3A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfDJUpf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 16:45:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:58694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725782AbfDJUpf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 16:45:35 -0400
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E88020830;
        Wed, 10 Apr 2019 20:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554929133;
        bh=px7U9x0mLoBLBqMhq8XW+g+Q3qd7cPBMdlw/mG7xJKo=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=AmQN83vmKb1z/AX2SC1Wfy8efQU+dEKiqszeBTCQhF/PTU+zM3JFdRt3kkL3I5jJv
         CPYuo/rIMKwWTI3rqqvem5uvqkDy4OEhqSFMD7l3zIer1UW74Xlbjsmg16bdq8Yfut
         DP5pAz/3mSCRsMvI4+gP/e0tBx14WYZ655lvWp2s=
Date:   Wed, 10 Apr 2019 13:45:29 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-X260
To:     Ankur Arora <ankur.a.arora@oracle.com>
cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Joao Martins <joao.m.martins@oracle.com>,
        Juergen Gross <jgross@suse.com>, Artem_Mygaiev@epam.com,
        xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
        =?UTF-8?Q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [Xen-devel] [PATCH RFC 00/39] x86/KVM: Xen HVM guest support
In-Reply-To: <8300d893-40a3-2b5b-e510-cd5955c72670@oracle.com>
Message-ID: <alpine.DEB.2.10.1904101345080.4155@sstabellini-ThinkPad-X260>
References: <20190220201609.28290-1-joao.m.martins@oracle.com> <35051310-c497-8ad5-4434-1b8426a317d2@redhat.com> <8b1f4912-4f92-69ae-ae01-d899d5640572@oracle.com> <3ee91f33-2973-c2db-386f-afbf138081b4@redhat.com> <59676804-786d-3df8-7752-8e45dec6d65b@oracle.com>
 <ac0fb2d0-59bf-1330-24ab-331c1a69b13f@suse.com> <94738323-ebdf-d58e-55b6-313e27c923b0@oracle.com> <585163c2-8dea-728d-7556-9cb3559f0eca@suse.com> <97808492-58ee-337f-c894-900b34b7b1a5@oracle.com> <alpine.DEB.2.10.1904081728120.4155@sstabellini-ThinkPad-X260>
 <8300d893-40a3-2b5b-e510-cd5955c72670@oracle.com>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Apr 2019, Ankur Arora wrote:
> On 2019-04-08 5:35 p.m., Stefano Stabellini wrote:
> > On Mon, 8 Apr 2019, Joao Martins wrote:
> > > On 4/8/19 11:42 AM, Juergen Gross wrote:
> > > > On 08/04/2019 12:36, Joao Martins wrote:
> > > > > On 4/8/19 7:44 AM, Juergen Gross wrote:
> > > > > > On 12/03/2019 18:14, Joao Martins wrote:
> > > > > > > On 2/22/19 4:59 PM, Paolo Bonzini wrote:
> > > > > > > > On 21/02/19 12:45, Joao Martins wrote:
> > > > > > > > > On 2/20/19 9:09 PM, Paolo Bonzini wrote:
> > > > > > > > > > On 20/02/19 21:15, Joao Martins wrote:
> > > > > > > > > > >   2. PV Driver support (patches 17 - 39)
> > > > > > > > > > > 
> > > > > > > > > > >   We start by redirecting hypercalls from the backend to
> > > > > > > > > > > routines
> > > > > > > > > > >   which emulate the behaviour that PV backends expect i.e.
> > > > > > > > > > > grant
> > > > > > > > > > >   table and interdomain events. Next, we add support for
> > > > > > > > > > > late
> > > > > > > > > > >   initialization of xenbus, followed by implementing
> > > > > > > > > > >   frontend/backend communication mechanisms (i.e. grant
> > > > > > > > > > > tables and
> > > > > > > > > > >   interdomain event channels). Finally, introduce
> > > > > > > > > > > xen-shim.ko,
> > > > > > > > > > >   which will setup a limited Xen environment. This uses
> > > > > > > > > > > the added
> > > > > > > > > > >   functionality of Xen specific shared memory (grant
> > > > > > > > > > > tables) and
> > > > > > > > > > >   notifications (event channels).
> > > > > > > > > > 
> > > > > > > > > > I am a bit worried by the last patches, they seem really
> > > > > > > > > > brittle and
> > > > > > > > > > prone to breakage.  I don't know Xen well enough to
> > > > > > > > > > understand if the
> > > > > > > > > > lack of support for GNTMAP_host_map is fixable, but if not,
> > > > > > > > > > you have to
> > > > > > > > > > define a completely different hypercall.
> > > > > > > > > > 
> > > > > > > > > I guess Ankur already answered this; so just to stack this on
> > > > > > > > > top of his comment.
> > > > > > > > > 
> > > > > > > > > The xen_shim_domain() is only meant to handle the case where
> > > > > > > > > the backend
> > > > > > > > > has/can-have full access to guest memory [i.e. netback and
> > > > > > > > > blkback would work
> > > > > > > > > with similar assumptions as vhost?]. For the normal case,
> > > > > > > > > where a backend *in a
> > > > > > > > > guest* maps and unmaps other guest memory, this is not
> > > > > > > > > applicable and these
> > > > > > > > > changes don't affect that case.
> > > > > > > > > 
> > > > > > > > > IOW, the PV backend here sits on the hypervisor, and the
> > > > > > > > > hypercalls aren't
> > > > > > > > > actual hypercalls but rather invoking shim_hypercall(). The
> > > > > > > > > call chain would go
> > > > > > > > > more or less like:
> > > > > > > > > 
> > > > > > > > > <netback|blkback|scsiback>
> > > > > > > > >   gnttab_map_refs(map_ops, pages)
> > > > > > > > >     HYPERVISOR_grant_table_op(GNTTABOP_map_grant_ref,...)
> > > > > > > > >       shim_hypercall()
> > > > > > > > >         shim_hcall_gntmap()
> > > > > > > > > 
> > > > > > > > > Our reasoning was that given we are already in KVM, why
> > > > > > > > > mapping a page if the
> > > > > > > > > user (i.e. the kernel PV backend) is himself? The lack of
> > > > > > > > > GNTMAP_host_map is how
> > > > > > > > > the shim determines its user doesn't want to map the page.
> > > > > > > > > Also, there's another
> > > > > > > > > issue where PV backends always need a struct page to reference
> > > > > > > > > the device
> > > > > > > > > inflight data as Ankur pointed out.
> > > > > > > > 
> > > > > > > > Ultimately it's up to the Xen people.  It does make their API
> > > > > > > > uglier,
> > > > > > > > especially the in/out change for the parameter.  If you can at
> > > > > > > > least
> > > > > > > > avoid that, it would alleviate my concerns quite a bit.
> > > > > > > 
> > > > > > > In my view, we have two options overall:
> > > > > > > 
> > > > > > > 1) Make it explicit, the changes the PV drivers we have to make in
> > > > > > > order to support xen_shim_domain(). This could mean e.g. a) add a
> > > > > > > callback
> > > > > > > argument to gnttab_map_refs() that is invoked for every page that
> > > > > > > gets looked up
> > > > > > > successfully, and inside this callback the PV driver may update
> > > > > > > it's tracking
> > > > > > > page. Here we no longer have this in/out parameter in
> > > > > > > gnttab_map_refs, and all
> > > > > > > shim_domain specific bits would be a little more abstracted from
> > > > > > > Xen PV
> > > > > > > backends. See netback example below the scissors mark. Or b) have
> > > > > > > sort of a
> > > > > > > translate_gref() and put_gref() API that Xen PV drivers use which
> > > > > > > make it even
> > > > > > > more explicit that there's no grant ops involved. The latter is
> > > > > > > more invasive.
> > > > > > > 
> > > > > > > 2) The second option is to support guest grant mapping/unmapping
> > > > > > > [*] to allow
> > > > > > > hosting PV backends inside the guest. This would remove the Xen
> > > > > > > changes in this
> > > > > > > series completely. But it would require another guest being used
> > > > > > > as netback/blkback/xenstored, and less performance than 1)
> > > > > > > (though, in theory,
> > > > > > > it would be equivalent to what does Xen with grants/events). The
> > > > > > > only changes in
> > > > > > > Linux Xen code is adding xenstored domain support, but that is
> > > > > > > useful on its own
> > > > > > > outside the scope of this work.
> > > > > > > 
> > > > > > > I think there's value on both; 1) is probably more familiar for
> > > > > > > KVM users
> > > > > > > perhaps (as it is similar to what vhost does?) while  2) equates
> > > > > > > to implementing
> > > > > > > Xen disagregation capabilities in KVM.
> > > > > > > 
> > > > > > > Thoughts? Xen maintainers what's your take on this?
> > > > > > 
> > > > > > What I'd like best would be a new handle (e.g. xenhost_t *) used as
> > > > > > an
> > > > > > abstraction layer for this kind of stuff. It should be passed to the
> > > > > > backends and those would pass it on to low-level Xen drivers
> > > > > > (xenbus,
> > > > > > event channels, grant table, ...).
> > > > > > 
> > > > > So if IIRC backends would use the xenhost layer to access grants or
> > > > > frames
> > > > > referenced by grants, and that would grok into some of this. IOW, you
> > > > > would have
> > > > > two implementors of xenhost: one for nested remote/local events+grants
> > > > > and
> > > > > another for this "shim domain" ?
> > > > 
> > > > As I'd need that for nested Xen I guess that would make it 3 variants.
> > > > Probably the xen-shim variant would need more hooks, but that should be
> > > > no problem.
> > > > 
> > > I probably messed up in the short description but "nested remote/local
> > > events+grants" was referring to nested Xen (FWIW remote meant L0 and local
> > > L1).
> > > So maybe only 2 variants are needed?
> > > 
> > > > > > I was planning to do that (the xenhost_t * stuff) soon in order to
> > > > > > add
> > > > > > support for nested Xen using PV devices (you need two Xenstores for
> > > > > > that
> > > > > > as the nested dom0 is acting as Xen backend server, while using PV
> > > > > > frontends for accessing the "real" world outside).
> > > > > > 
> > > > > > The xenhost_t should be used for:
> > > > > > 
> > > > > > - accessing Xenstore
> > > > > > - issuing and receiving events
> > > > > > - doing hypercalls
> > > > > > - grant table operations
> > > > > > 
> > > > > 
> > > > > In the text above, I sort of suggested a slice of this on 1.b) with a
> > > > > translate_gref() and put_gref() API -- to get the page from a gref.
> > > > > This was
> > > > > because of the flags|host_addr hurdle we depicted above wrt to using
> > > > > using grant
> > > > > maps/unmaps. You think some of the xenhost layer would be ammenable to
> > > > > support
> > > > > this case?
> > > > 
> > > > I think so, yes.
> > > > 
> > > > > 
> > > > > > So exactly the kind of stuff you want to do, too.
> > > > > > 
> > > > > Cool idea!
> > > > 
> > > > In the end you might make my life easier for nested Xen. :-)
> > > > 
> > > Hehe :)
> > > 
> > > > Do you want to have a try with that idea or should I do that? I might be
> > > > able to start working on that in about a month.
> > > > 
> > > Ankur (CC'ed) will give a shot at it, and should start a new thread on
> > > this
> > > xenhost abstraction layer.
> > 
> > If you are up for it, it would be great to write some documentation too.
> > We are starting to have decent docs for some PV protocols, describing a
> > specific PV interface, but we are lacking docs about the basic building
> > blocks to bring up PV drivers in general. They would be extremely
> Agreed. These would be useful.
> 
> > useful. Given that you have just done the work, you are in a great
> > position to write those docs. Even bad English would be fine, I am sure
> > somebody else could volunteer to clean-up the language. Anything would
> > help :-)
> Can't make any promises on this yet but I will see if I can convert
> notes I made into something useful for the community.

Thank you!
