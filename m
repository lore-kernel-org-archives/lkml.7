Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B13BBC3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 05:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8174F2190F
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 05:28:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729564AbfIBF2y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 01:28:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48324 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbfIBF2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 01:28:54 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F00BF307CDE7;
        Mon,  2 Sep 2019 05:28:53 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-95.ams2.redhat.com [10.36.116.95])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 579F55D6B7;
        Mon,  2 Sep 2019 05:28:53 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 3E46B16E08; Mon,  2 Sep 2019 07:28:52 +0200 (CEST)
Date:   Mon, 2 Sep 2019 07:28:52 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     David Riley <davidriley@chromium.org>
Cc:     dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        =?utf-8?B?U3TDqXBoYW5l?= Marchesin <marcheu@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/virtio: Use vmalloc for command buffer allocations.
Message-ID: <20190902052852.vqejjqrib6tvv2v5@sirius.home.kraxel.org>
References: <20190829212417.257397-1-davidriley@chromium.org>
 <20190830060857.tzrzgoi2hrmchdi5@sirius.home.kraxel.org>
 <CAASgrz2v0DYb_5A3MnaWFM4Csx1DKkZe546v7DG7R+UyLOA8og@mail.gmail.com>
 <20190830111605.twzssycagmjhfa45@sirius.home.kraxel.org>
 <CAASgrz0SXc2bEXq4xPCry_oHMXNbau36Q9i20anbFq1X0FsoMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAASgrz0SXc2bEXq4xPCry_oHMXNbau36Q9i20anbFq1X0FsoMQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Mon, 02 Sep 2019 05:28:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 10:49:25AM -0700, David Riley wrote:
> Hi Gerd,
> 
> On Fri, Aug 30, 2019 at 4:16 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
> >
> >   Hi,
> >
> > > > > -     kfree(vbuf->data_buf);
> > > > > +     kvfree(vbuf->data_buf);
> > > >
> > > > if (is_vmalloc_addr(vbuf->data_buf)) ...
> > > >
> > > > needed here I gues?
> > > >
> > >
> > > kvfree() handles vmalloc/kmalloc/kvmalloc internally by doing that check.
> >
> > Ok.
> >
> > > - videobuf_vmalloc_to_sg in drivers/media/v4l2-core/videobuf-dma-sg.c,
> > > assumes contiguous array of scatterlist and that the buffer being converted
> > > is page aligned
> >
> > Well, vmalloc memory _is_ page aligned.
> 
> True, but this function gets called for all potential enqueuings (eg
> resource_create_3d, resource_attach_backing) and I was concerned that
> some other usage in the future might not have that guarantee.

The vmalloc_to_sg call is wrapped into "if (is_vmalloc())", so this
should not be a problem.

> > sg_alloc_table_from_pages() does alot of what you need, you just need a
> > small loop around vmalloc_to_page() create a struct page array
> > beforehand.
> 
> That feels like an extra allocation when under memory pressure and
> more work, to not gain much -- there still needs to be a function that
> iterates through all the pages.  But I don't feel super strongly about
> it and can change it if you think that it will be less maintenance
> overhead.

Lets see how vmalloc_to_sg looks like when it assumes page-aligned
memory.  It's probably noticeable shorter then.

cheers,
  Gerd

