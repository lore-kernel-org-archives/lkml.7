Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E50C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 10:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F387B2084D
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 10:08:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbfJGKIl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 06:08:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:53592 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726010AbfJGKIk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 06:08:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CE97CAE8A;
        Mon,  7 Oct 2019 10:08:38 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 1F10F1E481E; Mon,  7 Oct 2019 12:08:38 +0200 (CEST)
Date:   Mon, 7 Oct 2019 12:08:38 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, Tejun Heo <tj@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        AceLan Kao <acelan.kao@canonical.com>, Jan Kara <jack@suse.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: System hangs if NVMe/SSD is removed during suspend
Message-ID: <20191007100838.GA24366@quack2.suse.cz>
References: <20191002122136.GD2819@lahna.fi.intel.com>
 <20191003165033.GC3247445@devbig004.ftw2.facebook.com>
 <20191004080340.GB2819@lahna.fi.intel.com>
 <2367934.HCQFgJ56tP@kreacher>
 <20191004110151.GH2819@lahna.fi.intel.com>
 <99b3ffb8-4205-9795-a48a-09125f5fceec@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99b3ffb8-4205-9795-a48a-09125f5fceec@kernel.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 04-10-19 07:32:40, Jens Axboe wrote:
> On 10/4/19 5:01 AM, Mika Westerberg wrote:
> > On Fri, Oct 04, 2019 at 11:59:26AM +0200, Rafael J. Wysocki wrote:
> >> On Friday, October 4, 2019 10:03:40 AM CEST Mika Westerberg wrote:
> >>> On Thu, Oct 03, 2019 at 09:50:33AM -0700, Tejun Heo wrote:
> >>>> Hello, Mika.
> >>>>
> >>>> On Wed, Oct 02, 2019 at 03:21:36PM +0300, Mika Westerberg wrote:
> >>>>> but from that discussion I don't see more generic solution to be
> >>>>> implemented.
> >>>>>
> >>>>> Any ideas we should fix this properly?
> >>>>
> >>>> Yeah, the only fix I can think of is not using freezable wq.  It's
> >>>> just not a good idea and not all that difficult to avoid using.
> >>>
> >>> OK, thanks.
> >>>
> >>> In that case I will just make a patch that removes WQ_FREEZABLE from
> >>> bdi_wq and see what people think about it :)
> >>
> >> I guess that depends on why WQ_FREEZABLE was added to it in the first place. :-)
> >>
> >> The reason might be to avoid writes to persistent storage after creating an
> >> image during hibernation, since wqs remain frozen throughout the entire
> >> hibernation including the image saving phase.
> > 
> > Good point.
> > 
> >> Arguably, making the wq freezable is kind of a sledgehammer approach to that
> >> particular issue, but in principle it may prevent data corruption from
> >> occurring, so be careful there.
> > 
> > I tried to find the commit that introduced the "freezing" and I think it
> > is this one:
> > 
> >    03ba3782e8dc writeback: switch to per-bdi threads for flushing data
> > 
> > Unfortunately from that commit it is not clear (at least to me) why it
> > calls set_freezable() for the bdi task. It does not look like it has
> > anything to do with blocking writes to storage while entering
> > hibernation but I may be mistaken.
> 
> Wow, a decade ago...
> 
> Honestly, I don't recall why these were marked freezable, and as I wrote
> in the other reply, I don't think there's a good reason for that to be
> the case.

Well, cannot it happen that the flush worker will get stuck in D state
because some subsystem is already suspended and thus hibernation fails
(because AFAIK processes in uninterruptible sleep block hibernation)?

I was also somewhat worried that the hibernation image could be
inconsistent if flush workers do something while hibernation image is being
taken but that does not seem to be a valid concern as all kernel processes
get frozen before hibernation image is taken.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
