Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF50C5DF64
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 15:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDAD3217F5
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 15:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jN7GMg/x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731652AbfKFPqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 10:46:39 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52214 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727028AbfKFPqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 10:46:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573055198;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I513jpBvCXeiyw/OWi6grP+ZDrJYUiN54Oer6ld6BmU=;
        b=jN7GMg/x9Y2f/+TyzycVU8/MzeTbjfnVPGYFoemsYYEIkLBkCb4lVPgjB88iGpgVL3D656
        QrsaWIaWiWRgrIcnRBy2Flh9AkkmYUplqcLpMLAp9IsxW4wD2IeeBJgT07f4KIMwMPsTJW
        Ml8ARk6cdWmCZdkI/3vhpiiCQ2JQZHQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-fwIHBv6vMJS67yhI-7qIqA-1; Wed, 06 Nov 2019 10:46:35 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C586800EBA;
        Wed,  6 Nov 2019 15:46:33 +0000 (UTC)
Received: from redhat.com (ovpn-125-216.rdu2.redhat.com [10.10.125.216])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E155E5D9E1;
        Wed,  6 Nov 2019 15:46:31 +0000 (UTC)
Date:   Wed, 6 Nov 2019 10:46:29 -0500
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
Message-ID: <20191106154629.GA3889@redhat.com>
References: <20191103112113.8256-1-hdanton@sina.com>
 <20191104043420.15648-1-hdanton@sina.com>
 <20191104102050.15988-1-hdanton@sina.com>
 <20191105042755.7292-1-hdanton@sina.com>
 <20191106092240.1712-1-hdanton@sina.com>
MIME-Version: 1.0
In-Reply-To: <20191106092240.1712-1-hdanton@sina.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: fwIHBv6vMJS67yhI-7qIqA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2019 at 05:22:40PM +0800, Hillf Danton wrote:
>=20
> On Tue, 5 Nov 2019 10:54:15 -0500 Jerome Glisse wrote:
> >=20
> > On Tue, Nov 05, 2019 at 12:27:55PM +0800, Hillf Danton wrote:
> > >
> > > On Mon, 4 Nov 2019 14:03:55 -0500 Jerome Glisse wrote:
> > > >
> > > > On Mon, Nov 04, 2019 at 06:20:50PM +0800, Hillf Danton wrote:
> > > > >
> > > > > On Sun, 3 Nov 2019 22:09:03 -0800 John Hubbard wrote:
> > > > > > On 11/3/19 8:34 PM, Hillf Danton wrote:
> > > > > > ...
> > > > > > >>
> > > > > > >> Well, as long as we're counting bits, I've taken 21 bits (!)=
 to track
> > > > > > >> "gupers". :)  More accurately, I'm sharing 31 bits with get_=
page()...please
> > > > > > >
> > > > > > > Would you please specify the reasoning of tracking multiple g=
upers
> > > > > > > for a dirty page? Do you mean that it is all fine for guper-A=
 to add
> > > > > > > changes to guper-B's data without warning and vice versa?
> > > > > >
> > > > > > It's generally OK to call get_user_pages() on a page more than =
once.
> > > > >
> > > > > Does this explain that it's generally OK to gup pin a page under
> > > > > writeback and then start DMA to it behind the flusher's back with=
out
> > > > > warning?
> > > >
> > > > It can happens today, is it ok ... well no but we live in an imperf=
ect
> > > > world. GUP have been abuse by few device driver over the years and =
those
> > > > never checked what it meant to use it so now we are left with exist=
ing
> > > > device driver that we can not break that do wrong thing.
> > >
> > > See your point :)
> > >
> > > > I personaly think that we should use bounce page for writeback so t=
hat
> > > > writeback can still happens if a page is GUPed.
> > >
> > > Gup can be prevented from falling foul of writeback IMHO if the page
> > > under writeback, gup pinned or not, remains stable until it is no
> > > longer dirty.
> > >
> > > For that stability, either we can check PageWriteback on gup pinning
> > > for instance as the RFC does or drivers can set a gup-pinned page
> > > dirty only after DMA and start no more DMA until it is clean again.
> > >
> > > As long as that stability is ensured writeback will no longer need to
> > > take care of gup pin, long-lived or transient.
> > >
> > > It seems unlike a request too strict to meet in practice wrt data
> > > corruption, and bounce page for writeback sounds promising. Does it
> > > need to do a memory copy?
> >=20
> > Once driver has GUP it does not check and re-check the struct page
> > so there is no synchronization whatsoever after GUP happened. In
> > fact for some driver you can not synchronize anything once the device
> > has been program. Many devices are not just simple DMA engine you
> > can start and stop at will (network, GPUs, ...).
>=20
> Because "there is no synchronization whatsoever after GUP happened,"
> we need to take another close look at the reasoning for tracking
> multiple gupers if the chance of their mutual data corruptions exists
> in the wild. (If any sync mechanism sits between them to avoid data
> corruption, then it seems single pin is enough.)

It does exist in the wild but the userspace application would be either
doing something stupid or something terribly clever. For instance you
can have 2 network interface writing to the same GUPed page but that is
because the application made the same request over two NICs and both
endup writting the samething.

You can also have 2 GUPer each writting to different part of the page
and never stepping on each others.

The point really is that from kernel point of view there is just no
way to know if the application is doing something wrong or if it just
perfectly fine. This is exactly the same thing as CPU threads, you do
not ask the kernel to ascertain wether what application threads are
doing is wrong or right.

So we have to live with the fact that we can have multiple GUPers and
that it is not our problems if that happens and we can do nothing
about it.

Note that we are removing GUP from some of those driver, ones where
the device can abide to mmu notifier. But that is just something
orthogonal to all this.


> > So once a page is GUP there is just noway to garanty its stability
> > hence the best thing we can do is snapshot it to a bounce page.
>=20
> It becomes clearer OTOH that we are more likely than not moving in
> the incorrect direction, in cases like how to detect gupers and what
> to do for writeback if page is gup pinned, without a clear picture
> of the bounce page in the first place. Any plan to post a patch just
> for idea show?

The agreement so far is that we need to be able to identify GUPed
pages and this is what John's patchset does. Once we have that piece
than we can discuss what to do in respect of write-back. Which is
still something where there is no agreement as far as i remember the
outcome of the last discussion we had. I expect this will a topic
at next LSF/MM or maybe something we can flush out before.

In any case my opinion is bounce page is the best thing we can do,
from application and FS point of view it mimics the characteristics
of regular write-back just as if the write protection window of the
write-backed page was infinitly short.

Cheers,
J=E9r=F4me

