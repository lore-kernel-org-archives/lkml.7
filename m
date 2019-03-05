Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34964C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 04:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1054D20684
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 04:07:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbfCEEHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 23:07:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45336 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726942AbfCEEHQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 23:07:16 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 269F359449;
        Tue,  5 Mar 2019 04:07:16 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E6A3060F8D;
        Tue,  5 Mar 2019 04:07:15 +0000 (UTC)
Date:   Mon, 4 Mar 2019 23:07:15 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        dm-devel@redhat.com
Subject: Re: x86 VM Boot hang with latest linux-next
Message-ID: <20190305040714.GB21739@redhat.com>
References: <CAKgT0UeMqmojVrNV1i-DdY18EBwbJ_4zVTUggAWas5D5yeU1PQ@mail.gmail.com>
 <20190303034847.GA8699@redhat.com>
 <CAKgT0Ue9+wSL60Bj0drkgVQwem=mh_eTrFMda+inX4=qBgi3dA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKgT0Ue9+wSL60Bj0drkgVQwem=mh_eTrFMda+inX4=qBgi3dA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Tue, 05 Mar 2019 04:07:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 03 2019 at 12:06pm -0500,
Alexander Duyck <alexander.duyck@gmail.com> wrote:

> On Sat, Mar 2, 2019 at 7:48 PM Mike Snitzer <snitzer@redhat.com> wrote:
> >
> > On Sat, Mar 02 2019 at  6:34pm -0500,
> > Alexander Duyck <alexander.duyck@gmail.com> wrote:
> >
> > > So I have been seeing an issue with an intermittent boot hang on my
> > > x86 KVM VM with the latest linux-next and have bisected it down to the
> > > following commit:
> > > 1efa3bb79d3de8ca1b7f6770313a1fc0bebe25c7 is the first bad commit
> > > commit 1efa3bb79d3de8ca1b7f6770313a1fc0bebe25c7
> > > Author: Mike Snitzer <snitzer@redhat.com>
> > > Date:   Fri Feb 22 11:23:01 2019 -0500
> > >
> > >     dm: must allocate dm_noclone for stacked noclone devices
> > >
> > >     Otherwise various lvm2 testsuite tests fail because the lower layers of
> > >     the stacked noclone device aren't updated to allocate a new 'struct
> > >     dm_clone' that reflects the upper layer bio that was issued to it.
> > >
> > >     Fixes: 97a89458020b38 ("dm: improve noclone bio support")
> > >     Reported-by: Mikulas Patocka <mpatocka@redhat.com>
> > >     Signed-off-by: Mike Snitzer <snitzer@redhat.com>
> > >
> > > What I am seeing is in about 3 out of 4 boots the startup just hangs
> > > at the filesystem check stage with the following message:
> > > [  OK  ] Reached target Local File Systems (Pre).
> > >          Starting File System Check on /dev/…127-ad57-426f-bb45-363950544c0c...
> > > [    **] (1 of 2) A start job is running for…n on device 252:2 (19s / no limit)
> > >
> > > I did some googling and it looks like a similar issue has been
> > > reported for s390. Based on the request for data there I have the
> > > following info:
> > > [root@localhost ~]# dmsetup ls --tree
> > > fedora-swap (253:1)
> > >  └─ (252:2)
> > > fedora-root (253:0)
> > >  └─ (252:2)
> > >
> > > [root@localhost ~]# dmsetup table
> > > fedora-swap: 0 4194304 linear 252:2 2048
> > > fedora-root: 0 31457280 linear 252:2 4196352
> >
> > Thanks, which version of Fedora are you running?
> 
> The VM is running Fedora 27 with a kernel built off of latest
> linux-next as of March 1st.
> 
> > Your case is more straightforward in that you're clearly using bio-based
> > DM linear (which was updated to leverage "noclone" support); whereas the
> > s390 case is using request-based DM which isn't impacted by the commit
> > in question at all.
> >
> > I'll attempt to reproduce first thing Monday.
> >
> > Mike
> 
> Thanks. The behavior of it has me wondering if we are looking at
> something like an uninitialized data issue or something like that
> since as I mentioned I don't see this occur on every boot, just on
> most of them. So every now and then I can boot up the VM without any
> issues, but most of the time it will boot and then get stuck waiting
> on jobs that take forever.

I just copied you on another related thread, but for the benefit of
anyone on LKML, please see the following for a fix that works for me:

https://www.redhat.com/archives/dm-devel/2019-March/msg00027.html
