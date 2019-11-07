Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2595CC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 14:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7AF62178F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 14:58:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IVKPQ78/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388319AbfKGO57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 09:57:59 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:41344 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726231AbfKGO57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 09:57:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573138678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7l5amhkGDagbeQhTlwEEOaNEQkt+wAGLwWigXrmUAmw=;
        b=IVKPQ78/XoqqIng4wUjWrZRNkPfsilkyDTJ33vGZrbmLwd1eMNuRXmj85/bYjbKQpccysI
        bQlWo2jrWcEN7TZgdLQEAI5U5KZtjkI0x/N7e+DDMfHpPt2cCSyKBmo0z/ndFci4d/+B4J
        8iekZZbBnGLc4vMezQu4SsFli3brqlg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-65cA_gI2MYaGIewHrH_2qQ-1; Thu, 07 Nov 2019 09:57:53 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A93081800D6B;
        Thu,  7 Nov 2019 14:57:51 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.178])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8211D600F4;
        Thu,  7 Nov 2019 14:57:50 +0000 (UTC)
Date:   Thu, 7 Nov 2019 09:57:48 -0500
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
Message-ID: <20191107145748.GA3666@redhat.com>
References: <20191103112113.8256-1-hdanton@sina.com>
 <20191104043420.15648-1-hdanton@sina.com>
 <20191104102050.15988-1-hdanton@sina.com>
 <20191105042755.7292-1-hdanton@sina.com>
 <20191106092240.1712-1-hdanton@sina.com>
 <20191107095017.17544-1-hdanton@sina.com>
MIME-Version: 1.0
In-Reply-To: <20191107095017.17544-1-hdanton@sina.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 65cA_gI2MYaGIewHrH_2qQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2019 at 05:50:17PM +0800, Hillf Danton wrote:
>=20
> On Wed, 6 Nov 2019 10:46:29 -0500 Jerome Glisse wrote:
> >=20
> > On Wed, Nov 06, 2019 at 05:22:40PM +0800, Hillf Danton wrote:
> [...]
> > > >
> > > > Once driver has GUP it does not check and re-check the struct page
> > > > so there is no synchronization whatsoever after GUP happened. In
> > > > fact for some driver you can not synchronize anything once the devi=
ce
> > > > has been program. Many devices are not just simple DMA engine you
> > > > can start and stop at will (network, GPUs, ...).
> > >
> > > Because "there is no synchronization whatsoever after GUP happened,"
> > > we need to take another close look at the reasoning for tracking
> > > multiple gupers if the chance of their mutual data corruptions exists
> > > in the wild. (If any sync mechanism sits between them to avoid data
> > > corruption, then it seems single pin is enough.)
> >=20
> > It does exist in the wild but the userspace application would be either
> > doing something stupid or something terribly clever. For instance you
> > can have 2 network interface writing to the same GUPed page but that is
> > because the application made the same request over two NICs and both
> > endup writting the samething.
> >=20
> > You can also have 2 GUPer each writting to different part of the page
> > and never stepping on each others.
> >=20
> > The point really is that from kernel point of view there is just no
> > way to know if the application is doing something wrong or if it just
> > perfectly fine. This is exactly the same thing as CPU threads, you do
> > not ask the kernel to ascertain wether what application threads are
> > doing is wrong or right.
> >=20
> > So we have to live with the fact that we can have multiple GUPers and
> > that it is not our problems if that happens and we can do nothing
> > about it.
>=20
> Ok. Multiple gupers are a must-have, and perhaps their mutal data
> corruptions as well.
>=20
> > Note that we are removing GUP from some of those driver, ones where
> > the device can abide to mmu notifier. But that is just something
> > orthogonal to all this.
> >=20
> >=20
> > > > So once a page is GUP there is just noway to garanty its stability
> > > > hence the best thing we can do is snapshot it to a bounce page.
> > >
> > > It becomes clearer OTOH that we are more likely than not moving in
> > > the incorrect direction, in cases like how to detect gupers and what
> > > to do for writeback if page is gup pinned, without a clear picture
> > > of the bounce page in the first place. Any plan to post a patch just
> > > for idea show?
> >=20
> > The agreement so far is that we need to be able to identify GUPed
> > pages and this is what John's patchset does. Once we have that piece
>=20
> Oh they are there, and barely trot away in case of long-lived pin.
>=20
> > than we can discuss what to do in respect of write-back. Which is
>=20
> Nobody seems to care what to do in the absence of gup pin.

I am not sure i follow ? Today we can not differentiate between GUP
and regular get_page(), if you use some combination of specific fs
and hardware you might get some BUG_ON() throws at you depending on
how lucky/unlucky you are. We can not solve this without being able
to differentiate between GUP and regular get_page(). Hence why John's
patchset is the first step in the right direction.

If there is no GUP on a page then regular writeback happens as it has
for years now so in absence of GUP i do not see any issue.


> > still something where there is no agreement as far as i remember the
> > outcome of the last discussion we had. I expect this will a topic
> > at next LSF/MM or maybe something we can flush out before.
>=20
> These are the restraints we know
>=20
> A, multiple gup pins
> B, mutual data corruptions
> C, no break of existing use cases
> D, zero copy

? What you mean by zero copy ?

> E, feel free to add
>=20
> then what is preventing an agreement like bounce page?

There is 2 sides (AFAIR):
    - do not write back GUPed page and wait until GUP goes away to
      write them. But GUP can last as long as the uptime and we can
      loose data on power failure.
    - use a bounce page so that there is a chance we have some data
      on power failure

>=20
> Because page migrate and reclaim have been working for a while with
> gup pin taken into account, detecting it has no priority in any form
> over the agreement on how to make a witeback page stable.

migrate just ignore GUPed page and thus there is no issue with migrate.
writeback is a special case here because some filesystem need a stable
page content and also we need to inhibit some fs specific things that
trigger BUG_ON() in set_page_dirty*()

> What seems more important, restriction B above makes C hard to meet
> in any feasible approach trying to keep a writeback page stable, and
> zero-copy makes it harder AFAICS.

writeback can use bounce page, zero copy ie not having to use bounce
page, is not an issue in fact in some cases we already use bounce page
(at the block device level).

>=20
> > In any case my opinion is bounce page is the best thing we can do,
> > from application and FS point of view it mimics the characteristics
> > of regular write-back just as if the write protection window of the
> > write-backed page was infinitly short.
>=20
> A 100-line patch tells more than a 200-line explanation can and helps
> to shorten the discussion prior to reaching an agreement.

It is not that trivial, you need to make sure every layer from fs down
to block device driver properly behave in front of bounce page. We have
such mechanism for bio but it is a the bio level but maybe it can be
dumped one level.

Cheers,
J=E9r=F4me

