Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A705CA9ECF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 19:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B9C620869
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 19:04:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JxEoCPU5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729418AbfKDTEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 14:04:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24707 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728321AbfKDTEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 14:04:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572894246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o+b8NjPRUKQ+2J5og0i8ZiirbNKP/A0yVqr+r6mXyYc=;
        b=JxEoCPU5hOv6oRv7X1TyoQ9jAvc2X27Ytm1jXk5ZoX6uWESYgv4VyKMTwv7q+dS0XPY1z0
        hsobXPVZXpuJkymhOetaCTg7iNbQnZXewXJb+IyMsqRYrcrFB9PqND35lOoOFnV99GLkcM
        klObKsHHAAitRgIvvLJ3ih1DX1nmx5w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-VlZXnWgFNza582B-zOtudA-1; Mon, 04 Nov 2019 14:04:03 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D20041005500;
        Mon,  4 Nov 2019 19:03:58 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.178])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8A0925D6D0;
        Mon,  4 Nov 2019 19:03:57 +0000 (UTC)
Date:   Mon, 4 Nov 2019 14:03:55 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     John Hubbard <jhubbard@nvidia.com>, linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jan Kara <jack@suse.cz>,
        Mel Gorman <mgorman@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [RFC] mm: gup: add helper page_try_gup_pin(page)
Message-ID: <20191104190355.GH5134@redhat.com>
References: <20191103112113.8256-1-hdanton@sina.com>
 <20191104043420.15648-1-hdanton@sina.com>
 <20191104102050.15988-1-hdanton@sina.com>
MIME-Version: 1.0
In-Reply-To: <20191104102050.15988-1-hdanton@sina.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: VlZXnWgFNza582B-zOtudA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2019 at 06:20:50PM +0800, Hillf Danton wrote:
>=20
> On Sun, 3 Nov 2019 22:09:03 -0800 John Hubbard wrote:
> > On 11/3/19 8:34 PM, Hillf Danton wrote:
> > ...
> > >>
> > >> Well, as long as we're counting bits, I've taken 21 bits (!) to trac=
k
> > >> "gupers". :)  More accurately, I'm sharing 31 bits with get_page()..=
.please
> > >=20
> > > Would you please specify the reasoning of tracking multiple gupers
> > > for a dirty page? Do you mean that it is all fine for guper-A to add
> > > changes to guper-B's data without warning and vice versa?
> >=20
> > It's generally OK to call get_user_pages() on a page more than once.
>=20
> Does this explain that it's generally OK to gup pin a page under
> writeback and then start DMA to it behind the flusher's back without
> warning?=20

It can happens today, is it ok ... well no but we live in an imperfect
world. GUP have been abuse by few device driver over the years and those
never checked what it meant to use it so now we are left with existing
device driver that we can not break that do wrong thing.

I personaly think that we should use bounce page for writeback so that
writeback can still happens if a page is GUPed. John's patchset is the
first step to be able to identify GUPed page and maybe special case them.

>=20
> > And even though we are seeing some work to reduce the number of places
> > in the kernel that call get_user_pages(), there are still lots of call =
sites.
> > That means lots of combinations and situations that could result in mor=
e
> > than one gup call per page.
> >=20
> > Furthermore, there is no mechanism, convention, documentation, nor anyt=
hing
> > at all that attempts to enforce "for each page, get_user_pages() may on=
ly
> > be called once."
>=20
> What sense is this making wrt the data corruption resulting specifically
> from multiple gup references?

Multiple GUP references do not imply corruption. Only one or more devices
writing to the page while writeback is happening is a cause of corruption.
Multiple device writting in the same page concurrently is like multiple
CPU thread doing the same. Either the application/device drivers are doing
this rightfully on purpose or the application has a bug. Either way it is
not our problem (note here i am talking about userspace portion of the
device driver).


> > >> I think you must have missed the many contentious debates about the
> > >> tension between gup-pinned pages, and writeback. File systems can't
> > >> just ignore writeback in all cases. This patch leads to either
> > >> system hangs or filesystem corruption, in the presence of long-lasti=
ng
> > >> gup pins.
> > >=20
> > > The current risk of data corruption due to writeback with long-lived
> > > gup references all ignored is zeroed out by detecting gup-pinned dirt=
y
> > > pages and skipping them; that may lead to problems you mention above.
> > >=20
> >=20
> > Here, I believe you're pointing out that the current situation in the
> > kernel is already broken, with respect to fs interactions (especially
> > writeback) with gup. Yes, you are correct, there is a problem.
> >=20
> > > Though I doubt anything helpful about it can be expected from fs in n=
ear
> >=20
> > Actually, fs and mm folks are working together to solve this.
> >=20
> > > future, we have options for instance that gupers periodically release
> > > their references and re-pin pages after data sync the same way as the
> > > current flusher does.
> > >=20
> >=20
> > That's one idea. I don't see it as viable, given the behavior of, say,
> > a compute process running OpenCL jobs on a GPU that is connected via
> > a network or Infiniband card--the idea of "pause" really looks more lik=
e
> > "tear down the complicated multi-driver connection, writeback, then set=
 it
> > all up again", I suspect. (And if we could easily interrupt the job, we=
'd
> > probably really be running with a page-fault-capable GPU plus and IB ca=
rd
> > that does ODP, plus HMM, and we wouldn't need to gup-pin anyway...)
>=20
> Well is it OK to shorten the behavior above to "data corruption in
> writeback is tolerable in practice because of the expensive cost of
> data sync"?
>=20
> What is the point of writeback? Why can the writeback of long-lived
> gup-pinned pages not be skipped while data sync can be entirely
> ignored?

I do not think we want that (skip writeback on GUPed page). I think what
we should do is use a bounce page ie take a snapshot of the page and
starts writeback with the snapshot. We need a snapshot because fs code
expect stable page content for things like encryption or hashing or other
crazy fs features :)

Cheers,
J=E9r=F4me

