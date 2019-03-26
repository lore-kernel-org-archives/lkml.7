Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B68C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 15:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 498832075E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 15:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732023AbfCZPVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 11:21:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49032 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731715AbfCZPVr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 11:21:47 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0A624C1306F8;
        Tue, 26 Mar 2019 15:21:47 +0000 (UTC)
Received: from x1.home (ovpn-116-99.phx2.redhat.com [10.3.116.99])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A5A651759E;
        Tue, 26 Mar 2019 15:21:46 +0000 (UTC)
Date:   Tue, 26 Mar 2019 09:21:46 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Parav Pandit <parav@mellanox.com>
Cc:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kwankhede@nvidia.com" <kwankhede@nvidia.com>
Subject: Re: [PATCH 8/8] vfio/mdev: Improve the create/remove sequence
Message-ID: <20190326092146.6c93ce96@x1.home>
In-Reply-To: <VI1PR0501MB22715E9A784070A9169B7B5BD15F0@VI1PR0501MB2271.eurprd05.prod.outlook.com>
References: <1553296835-37522-1-git-send-email-parav@mellanox.com>
        <1553296835-37522-9-git-send-email-parav@mellanox.com>
        <20190325171831.1ac2a441@x1.home>
        <VI1PR0501MB2271CD34DCA1D1D5EDAFDBD7D15E0@VI1PR0501MB2271.eurprd05.prod.outlook.com>
        <20190325180537.11842c03@x1.home>
        <VI1PR0501MB2271CECD3B2200BB5A7DEC00D15F0@VI1PR0501MB2271.eurprd05.prod.outlook.com>
        <20190325201645.1ba4e9bf@x1.home>
        <VI1PR0501MB227124A89CF30D12E89CF5D8D15F0@VI1PR0501MB2271.eurprd05.prod.outlook.com>
        <VI1PR0501MB22715E9A784070A9169B7B5BD15F0@VI1PR0501MB2271.eurprd05.prod.outlook.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 26 Mar 2019 15:21:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Mar 2019 05:53:22 +0000
Parav Pandit <parav@mellanox.com> wrote:

> > -----Original Message-----
> > From: linux-kernel-owner@vger.kernel.org <linux-kernel-  
> > owner@vger.kernel.org> On Behalf Of Parav Pandit  
> > Sent: Monday, March 25, 2019 10:19 PM
> > To: Alex Williamson <alex.williamson@redhat.com>
> > Cc: kvm@vger.kernel.org; linux-kernel@vger.kernel.org;
> > kwankhede@nvidia.com
> > Subject: RE: [PATCH 8/8] vfio/mdev: Improve the create/remove sequence
> > 
> > 
> >   
> > > -----Original Message-----
> > > From: Alex Williamson <alex.williamson@redhat.com>
> > > Sent: Monday, March 25, 2019 9:17 PM
> > > To: Parav Pandit <parav@mellanox.com>
> > > Cc: kvm@vger.kernel.org; linux-kernel@vger.kernel.org;
> > > kwankhede@nvidia.com
> > > Subject: Re: [PATCH 8/8] vfio/mdev: Improve the create/remove sequence
> > >
> > > On Tue, 26 Mar 2019 01:43:44 +0000
> > > Parav Pandit <parav@mellanox.com> wrote:
> > >  
> > > > > -----Original Message-----
> > > > > From: Alex Williamson <alex.williamson@redhat.com>  
> 
> > > > > I mean the callback iterator on the parent remove can do a WARN_ON
> > > > > if this returns an error while the device remove path can silently
> > > > > return -EBUSY, the common function doesn't need to decide whether
> > > > > the parent ops remove function deserves a dev_err.
> > > > >  
> > > > Ok. I understood.
> > > > But device remove returning silent -EBUSY looks an error that should
> > > > get logged in, because this is something not expected. Its probably
> > > > late for sysfs layer to return report an error by that time it
> > > > prints device name, because put_device() is done. So if remove()
> > > > returns an error, I think its legitimate failure to do WARN_ON or  
> > dev_err().  
> > >
> > > Calling put_device() if the parent remove op fails looks like a bug
> > > introduced by this series, the current code allows that failure
> > > leaving the device in a coherent state and returning errno to the sysfs  
> > store function.  
> > >  
> > Why should it fail?
> > We are taking off the device bus first as describe in commit log.
> > This ensures that everything is closed before calling the remove().
> > We cannot avoid put_device() and put_parent, it all buggy path...  
> 
> I audited remove() callbacks of kvmgt.c, vfio_ccw_ops.c,
> vfio_ap_ops.c, mbochs.c, mdpy.c, mtty.c, who makes the remove
> possible once the device release is executed. This should complete
> once the device is taken off the bus. This was not the case before
> this sequence where remove() is done while device is open...hence the
> check was needed in past. dev_err() is to help catch any errors/bugs
> in this area.
> 
> I doubt we need to retry remove() like vfio_del_group_dev(), in
> mdev_core if release() is not yet complete.

I'm ok with this, I've always thought the 'force' semantics and
allowing remove to fail were not terribly inline with other drivers,
even if ultimately I wish drivers could nak a remove request to avoid
the ugliness of blocking.  But ultimately you'll need to come to an
agreement with Kirti, the drivers we have in-tree are not the complete
set of mdev drivers, but it also doesn't necessarily make sense to cater
to the lone out-of-tree driver either.  Thanks,

Alex
