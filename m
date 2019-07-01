Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7CC2C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 08:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB6EA20673
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 08:06:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbfGAIGi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 04:06:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38436 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727080AbfGAIGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 04:06:38 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 11C73308FB82;
        Mon,  1 Jul 2019 08:06:38 +0000 (UTC)
Received: from gondolin (ovpn-117-220.ams2.redhat.com [10.36.117.220])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EAC43BA4D;
        Mon,  1 Jul 2019 08:06:34 +0000 (UTC)
Date:   Mon, 1 Jul 2019 10:06:32 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     kwankhede@nvidia.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mdev: Send uevents around parent device registration
Message-ID: <20190701100632.31fe96db.cohuck@redhat.com>
In-Reply-To: <20190628095608.7762d6d0@x1.home>
References: <156155924767.11505.11457229921502145577.stgit@gimli.home>
        <20190627101914.32829440.cohuck@redhat.com>
        <20190628095608.7762d6d0@x1.home>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Mon, 01 Jul 2019 08:06:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jun 2019 09:56:08 -0600
Alex Williamson <alex.williamson@redhat.com> wrote:

> On Thu, 27 Jun 2019 10:19:14 +0200
> Cornelia Huck <cohuck@redhat.com> wrote:
> 
> > On Wed, 26 Jun 2019 08:27:58 -0600
> > Alex Williamson <alex.williamson@redhat.com> wrote:

> > > @@ -243,6 +247,8 @@ void mdev_unregister_device(struct device *dev)
> > >  	up_write(&parent->unreg_sem);
> > >  
> > >  	mdev_put_parent(parent);
> > > +
> > > +	kobject_uevent_env(&dev->kobj, KOBJ_CHANGE, envp);    
> > 
> > I'm wondering whether we should indicate this uevent earlier: Once we
> > have detached from the parent list, we're basically done for all
> > practical purposes. So maybe move this right before we grab the
> > unreg_sem?  
> 
> That would make it a "this thing is about to go away" (ie.
> "unregistering") rather than "this thing is gone" ("unregistered").  I
> was aiming for the latter as the former just seems like it might make
> userspace race to remove devices.  Note that I don't actually make use
> of this event in mdevctl currently, so we could maybe save it for
> later, but the symmetry seemed preferable.  Thanks,
> 
> Alex

Fair enough. I was thinking about signaling that it does not make much
sense to register new devices after that point, but if that might
trigger userspace to actually try and remove devices, not much is
gained.
