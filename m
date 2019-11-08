Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD426FC6195
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 14:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75F8E222CE
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 14:00:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="en6LYhoc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbfKHOAC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 09:00:02 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37864 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726462AbfKHOAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 09:00:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573221600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/N/8UXn3e2Lp0vVWR2vN44bd4vuoU28wTMfbGBL3ybA=;
        b=en6LYhoceXoY7g5qW5r53wiGsHKQVH9d/TpjCpalUXvCsC8gD/hpOnZlfmCHCpZb4/yJOr
        6ISdEdTyWmizWNwVhInZ+jMb//6Q19TVleTiI/ZhbBwoFikJ1ctVF1U2BSt/+vv5boEeJG
        ocUwM/GK1msTMLyYTxVpHIlpWG5o4dM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-B3whmig_P56tqrYYPQWXZQ-1; Fri, 08 Nov 2019 08:59:56 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 401B7107ACC4;
        Fri,  8 Nov 2019 13:59:54 +0000 (UTC)
Received: from redhat.com (ovpn-123-175.rdu2.redhat.com [10.10.123.175])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AA80160856;
        Fri,  8 Nov 2019 13:59:52 +0000 (UTC)
Date:   Fri, 8 Nov 2019 08:59:50 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     John Hubbard <jhubbard@nvidia.com>, linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [RFC] mm: gup: add helper page_try_gup_pin(page)
Message-ID: <20191108135950.GB4456@redhat.com>
References: <20191103112113.8256-1-hdanton@sina.com>
 <20191104043420.15648-1-hdanton@sina.com>
 <20191104102050.15988-1-hdanton@sina.com>
 <20191105042755.7292-1-hdanton@sina.com>
 <20191106092240.1712-1-hdanton@sina.com>
 <20191107095017.17544-1-hdanton@sina.com>
 <20191108093837.1696-1-hdanton@sina.com>
MIME-Version: 1.0
In-Reply-To: <20191108093837.1696-1-hdanton@sina.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: B3whmig_P56tqrYYPQWXZQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 08, 2019 at 05:38:37PM +0800, Hillf Danton wrote:
>=20
> On Thu, 7 Nov 2019 09:57:48 -0500 Jerome Glisse wrote:
> >=20
> > I am not sure i follow ? Today we can not differentiate between GUP
> > and regular get_page(), if you use some combination of specific fs
> > and hardware you might get some BUG_ON() throws at you depending on
> > how lucky/unlucky you are. We can not solve this without being able
> > to differentiate between GUP and regular get_page(). Hence why John's
> > patchset is the first step in the right direction.
> >=20
> What is the second one? And when? By who?

Fix current BUG_ON() by not releasing buffer after write-back. Decide what
to do for write back and then a page is pin. It will happens once we are
done with pin changes and the infrastructure is in place. It will be done
by John or others.


> > If there is no GUP on a page then regular writeback happens as it has
> > for years now so in absence of GUP i do not see any issue.
> >=20
> >=20
> > > > still something where there is no agreement as far as i remember th=
e
> > > > outcome of the last discussion we had. I expect this will a topic
> > > > at next LSF/MM or maybe something we can flush out before.
> > >
> > > These are the restraints we know
> > >
> > > A, multiple gup pins
> > > B, mutual data corruptions
> > > C, no break of existing use cases
> > > D, zero copy
> >=20
> > ? What you mean by zero copy ?
> >=20
> Snippet that can be found at https://lwn.net/Articles/784574/
>=20
> "get_user_pages() is a way to map user-space memory into the kernel's
> address space; it will ensure that all of the requested pages have
> been faulted into RAM (and locked there) and provide a kernel mapping
> that, in turn, can be used for direct access by the kernel or (more
> often) to set up zero-copy I/O operations.
>=20
> > > E, feel free to add
> > >
> > > then what is preventing an agreement like bounce page?
> >=20
> > There is 2 sides (AFAIR):
> >     - do not write back GUPed page and wait until GUP goes away to
> >       write them. But GUP can last as long as the uptime and we can
> >       loose data on power failure.
> >     - use a bounce page so that there is a chance we have some data
> >       on power failure
> >=20
> > >
> > > Because page migrate and reclaim have been working for a while with
> > > gup pin taken into account, detecting it has no priority in any form
> > > over the agreement on how to make a witeback page stable.
> >=20
> > migrate just ignore GUPed page and thus there is no issue with migrate.
> > writeback is a special case here because some filesystem need a stable
> > page content and also we need to inhibit some fs specific things that
> > trigger BUG_ON() in set_page_dirty*()
> >=20
> Which drivers so far have been snared by the BUG_ON()? Is there any
> chance to fix them one after another? Otherwise what is making them
> special (long-lived pin)?

It is a race thing so it does not necesarily happens, the longer the pin
the higher risk. It can only happens with some fs (i forgot which ones but
you can go read the previous threads). It is easy to fix all we need to
do is not release some fs structure of pinned pages after write-back.


> After setting page dirty, is there any pending DMA transfer to the
> dirty page? If yes, what is the point to do writeback for corrupted
> data? If no, what is preventing the gup pin from being released?

When user of GUP calls set_page_dirty() they _must_ be done with using the
page and it is the case today AFAICT, so no pending DMA. The GUP pin is
release after set_page_dirty() by all current users.

Note that current users all do that once they are done and they can hold
the pages for an _indifinite_ amount of time ie forever. They do dirty
pages in their teardown code path.

Hence the question that we need ti answer is what to do for dirty pages
while they are GUPed. Note that a page can be set dirty while GUPed
because CPU access can still happens and thus the regular dirtyness
tracking mechanism do operate on such page.

So page can go through:
    - GUPed by someone
    - write by CPU, mark as dirty
    - regular write-back kicks in
    - page is mark clean and fs might release data structure

    ... any amount of time ... what to do here if more CPU writes ?

    - GUPed user done and put_page but before call set_page_dirty()
      this might BUG_ON() inside fs code for some fs if the page was
      left clean on the CPU since last writeback

I would strongly advise to read previous thread this was discussed at
length.

Cheers,
J=E9r=F4me

