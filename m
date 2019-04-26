Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1872C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 21:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8780206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 21:58:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbfDZV6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 17:58:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48934 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726871AbfDZV6u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 17:58:50 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DB70814405D;
        Fri, 26 Apr 2019 21:58:49 +0000 (UTC)
Received: from x1.home (ovpn-116-122.phx2.redhat.com [10.3.116.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 68F5F5D71C;
        Fri, 26 Apr 2019 21:58:49 +0000 (UTC)
Date:   Fri, 26 Apr 2019 15:58:48 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Parav Pandit <parav@mellanox.com>
Cc:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kwankhede@nvidia.com" <kwankhede@nvidia.com>,
        "cjia@nvidia.com" <cjia@nvidia.com>
Subject: Re: [PATCHv1 7/7] vfio/mdev: Fix race conditions with mdev device
 life cycle APIs
Message-ID: <20190426155848.5173e896@x1.home>
In-Reply-To: <AM4PR0501MB22602E3F3480FAC5DC297D4DD13E0@AM4PR0501MB2260.eurprd05.prod.outlook.com>
References: <1553658345-43995-1-git-send-email-parav@mellanox.com>
        <1553658345-43995-8-git-send-email-parav@mellanox.com>
        <20190403152722.24efc561@x1.home>
        <VI1PR0501MB22714BE24CEA00E14A811918D1500@VI1PR0501MB2271.eurprd05.prod.outlook.com>
        <20190404144428.1fa6afb2@x1.home>
        <VI1PR0501MB2271E8894B77BA8F316B6148D1500@VI1PR0501MB2271.eurprd05.prod.outlook.com>
        <20190423132140.18b0d892@x1.home>
        <AM4PR0501MB2260154A21D3E471A838CF5CD13D0@AM4PR0501MB2260.eurprd05.prod.outlook.com>
        <20190426093350.47619260@x1.home>
        <AM4PR0501MB22608CA6D17273F0E2B4A96ED13E0@AM4PR0501MB2260.eurprd05.prod.outlook.com>
        <20190426100924.4bf48708@x1.home>
        <AM4PR0501MB22602E3F3480FAC5DC297D4DD13E0@AM4PR0501MB2260.eurprd05.prod.outlook.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Fri, 26 Apr 2019 21:58:49 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Apr 2019 19:02:40 +0000
Parav Pandit <parav@mellanox.com> wrote:

> Hi Alex,
> 
> 
> > -----Original Message-----
> > From: Alex Williamson <alex.williamson@redhat.com>
> > Sent: Friday, April 26, 2019 11:09 AM
> > To: Parav Pandit <parav@mellanox.com>
> > Cc: kvm@vger.kernel.org; linux-kernel@vger.kernel.org;
> > kwankhede@nvidia.com; cjia@nvidia.com
> > Subject: Re: [PATCHv1 7/7] vfio/mdev: Fix race conditions with mdev device
> > life cycle APIs  
> 
> [..]
> 
> > > > >  
> > > > > > Patch 6 looks ok, except I'd rather see the sanitizing loop stay
> > > > > > until we can otherwise fix the race above.  
> > > > > I can put back the sanitizing look, once it looks valid. Will wait
> > > > > for your response.  
> > > >
> > > > Yep, I think patch 6 is good w/o the removal of the sanitizing loop.
> > > > Will you repost it?
> > > >  
> > > Just the patch-6 or 1 to 6?  
> > 
> > Your choice, please roll in reviews/acks if you repost the rest.
> >   
> > > > > > Patch 7 needed more work, iirc.  Thanks,  
> > > > > For a moment if we assume sanitizing loop exists, than patch-7
> > > > > looks good?  
> > > >
> > > > Patch 7 is a bit less trivial, so I think as we're close to the
> > > > merge window for v5.2, I'd rather push it out to be included with
> > > > the later re-works.  Thanks,
> > > >  
> > > I agree it little less trivial, I tried to place as much comment as possible,  
> > but it is an important fix.  
> > > Let me repost 6-7 and decide if it can be included or not?  
> > 
> > Sounds good.  Thanks,
> >   
> I am dropping patch-7 for today and reworking the patch-6 for now.
> 
> Even after keeping that that crazy loop, I am easily able to create this below [1] call trace on adding file when mdev_remove() fails with the thread sequence we discussed above.
> 
> I think this is high time, we fix the sequence to match the linux bus sequence.
> I have some cycles this week.
> Post these 6 patches,
> I like to get total 3 patches done.
> 1. fix the bus sequence
> 2. race with parent device removal
> 3. do not try to add sysfs file on remove() failure
> 
> Is there any possibility above 3 patches can make to 5.2, given that merge window closes in June?
> If yes, I will get them in 2-3 days. I will test with sample drivers and mlx5 driver.
> Can we get some tests also done from Kirti also done on their hw?

It depends how soon they stabilize and how invasive they are.  These
are bug fixes, so we can consider them for after the merge window
(which will close before the end of May), but the longer they take to
stabilize and the more significant the change, the more likely I'd be
to wait for 5.3.  Thanks,

Alex
