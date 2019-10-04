Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE12DC4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 09:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 875712133F
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 09:59:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730434AbfJDJ73 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 05:59:29 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:59890 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbfJDJ73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 05:59:29 -0400
Received: from 79.184.253.225.ipv4.supernova.orange.pl (79.184.253.225) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id d2f42940dd6adecb; Fri, 4 Oct 2019 11:59:26 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Tejun Heo <tj@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        AceLan Kao <acelan.kao@canonical.com>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: System hangs if NVMe/SSD is removed during suspend
Date:   Fri, 04 Oct 2019 11:59:26 +0200
Message-ID: <2367934.HCQFgJ56tP@kreacher>
In-Reply-To: <20191004080340.GB2819@lahna.fi.intel.com>
References: <20191002122136.GD2819@lahna.fi.intel.com> <20191003165033.GC3247445@devbig004.ftw2.facebook.com> <20191004080340.GB2819@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, October 4, 2019 10:03:40 AM CEST Mika Westerberg wrote:
> On Thu, Oct 03, 2019 at 09:50:33AM -0700, Tejun Heo wrote:
> > Hello, Mika.
> > 
> > On Wed, Oct 02, 2019 at 03:21:36PM +0300, Mika Westerberg wrote:
> > > but from that discussion I don't see more generic solution to be
> > > implemented.
> > > 
> > > Any ideas we should fix this properly?
> > 
> > Yeah, the only fix I can think of is not using freezable wq.  It's
> > just not a good idea and not all that difficult to avoid using.
> 
> OK, thanks.
> 
> In that case I will just make a patch that removes WQ_FREEZABLE from
> bdi_wq and see what people think about it :)

I guess that depends on why WQ_FREEZABLE was added to it in the first place. :-)

The reason might be to avoid writes to persistent storage after creating an
image during hibernation, since wqs remain frozen throughout the entire
hibernation including the image saving phase.

Arguably, making the wq freezable is kind of a sledgehammer approach to that
particular issue, but in principle it may prevent data corruption from
occurring, so be careful there.



