Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4FDCC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 18:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D7562133D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 18:54:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbfCRSym (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 14:54:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:7409 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726812AbfCRSyl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 14:54:41 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 16C704E92A;
        Mon, 18 Mar 2019 18:54:41 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.236])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C4DE25DD97;
        Mon, 18 Mar 2019 18:54:39 +0000 (UTC)
Date:   Mon, 18 Mar 2019 14:54:38 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH 00/10] HMM updates for 5.1
Message-ID: <20190318185437.GB6786@redhat.com>
References: <20190129165428.3931-1-jglisse@redhat.com>
 <20190313012706.GB3402@redhat.com>
 <20190313091004.b748502871ba0aa839b924e9@linux-foundation.org>
 <20190318170404.GA6786@redhat.com>
 <CAPcyv4geu34vgZszALiDxJWR8itK+A3qSmpR+_jOq29whGngNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPcyv4geu34vgZszALiDxJWR8itK+A3qSmpR+_jOq29whGngNg@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Mon, 18 Mar 2019 18:54:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 11:30:15AM -0700, Dan Williams wrote:
> On Mon, Mar 18, 2019 at 10:04 AM Jerome Glisse <jglisse@redhat.com> wrote:
> >
> > On Wed, Mar 13, 2019 at 09:10:04AM -0700, Andrew Morton wrote:
> > > On Tue, 12 Mar 2019 21:27:06 -0400 Jerome Glisse <jglisse@redhat.com> wrote:
> > >
> > > > Andrew you will not be pushing this patchset in 5.1 ?
> > >
> > > I'd like to.  It sounds like we're converging on a plan.
> > >
> > > It would be good to hear more from the driver developers who will be
> > > consuming these new features - links to patchsets, review feedback,
> > > etc.  Which individuals should we be asking?  Felix, Christian and
> > > Jason, perhaps?
> > >
> >
> > So i am guessing you will not send this to Linus ? Should i repost ?
> > This patchset has 2 sides, first side is just reworking the HMM API
> > to make something better in respect to process lifetime. AMD folks
> > did find that helpful [1]. This rework is also necessary to ease up
> > the convertion of ODP to HMM [2] and Jason already said that he is
> > interested in seing that happening [3]. By missing 5.1 it means now
> > that i can not push ODP to HMM in 5.2 and it will be postpone to 5.3
> > which is also postoning other work ...
> >
> > The second side is it adds 2 new helper dma map and dma unmap both
> > are gonna be use by ODP and latter by nouveau (after some other
> > nouveau changes are done). This new functions just do dma_map ie:
> >     hmm_dma_map() {
> >         existing_hmm_api()
> >         for_each_page() {
> >             dma_map_page()
> >         }
> >     }
> >
> > Do you want to see anymore justification than that ?
> 
> Yes, why does hmm needs its own dma mapping apis? It seems to
> perpetuate the perception that hmm is something bolted onto the side
> of the core-mm rather than a native capability.

Seriously ?

Kernel is fill with example where common code pattern that are not
device specific are turn into helpers and here this is exactly what
it is. A common pattern that all device driver will do which is turn
into a common helper.

Moreover this allow to share the same error code handling accross
driver when mapping one page fails. So this avoid the needs to
duplicate same boiler plate code accross different drivers.

Is code factorization not a good thing ? Should i duplicate every-
thing in every single driver ?


If that's not enough, this will also allow to handle peer to peer
and i posted patches for that [1] and again this is to avoid
duplicating common code accross different drivers.


It does feel that you oppose everything with HMM in its name just
because you do not like it. It is your prerogative to not like some-
thing but you should propose something that achieve the same result
instead of constantly questioning every single comma.

Cheers,
Jérôme

[1] https://lwn.net/ml/linux-kernel/20190129174728.6430-1-jglisse@redhat.com/
