Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9B3C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 09:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D67A20850
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 09:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfDLJnX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 05:43:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40386 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726742AbfDLJnW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 05:43:22 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1CD6599CE2;
        Fri, 12 Apr 2019 09:43:22 +0000 (UTC)
Received: from gondolin (dhcp-192-187.str.redhat.com [10.33.192.187])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8212E1778B;
        Fri, 12 Apr 2019 09:43:15 +0000 (UTC)
Date:   Fri, 12 Apr 2019 11:43:13 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Tony Krowiak <akrowiak@linux.ibm.com>
Cc:     Harald Freudenberger <freude@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Reinhard Buendgen <buendgen@de.ibm.com>,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, david@redhat.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        pmorel@linux.ibm.com, pasic@linux.ibm.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com
Subject: Re: [PATCH 1/7] s390: zcrypt: driver callback to indicate resource
 in use
Message-ID: <20190412114313.0156c01b.cohuck@redhat.com>
In-Reply-To: <223c82c7-6a75-7209-3652-c2341c83878f@linux.ibm.com>
References: <1555016604-2008-1-git-send-email-akrowiak@linux.ibm.com>
        <1555016604-2008-2-git-send-email-akrowiak@linux.ibm.com>
        <223c82c7-6a75-7209-3652-c2341c83878f@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Fri, 12 Apr 2019 09:43:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Apr 2019 08:54:54 +0200
Harald Freudenberger <freude@linux.ibm.com> wrote:

> On 11.04.19 23:03, Tony Krowiak wrote:
> > Introduces a new driver callback to prevent a root user from unbinding
> > an AP queue from its device driver if the queue is in use. This prevents
> > a root user from inadvertently taking a queue away from a guest and
> > giving it to the host, or vice versa. The callback will be invoked
> > whenever a change to the AP bus's apmask or aqmask sysfs interfaces may
> > result in one or more AP queues being removed from its driver. If the
> > callback responds in the affirmative for any driver queried, the change
> > to the apmask or aqmask will be rejected with a device in use error.
> >
> > For this patch, only non-default drivers will be queried. Currently,
> > there is only one non-default driver, the vfio_ap device driver. The
> > vfio_ap device driver manages AP queues passed through to one or more
> > guests and we don't want to unexpectedly take AP resources away from
> > guests which are most likely independently administered.
> >
> > Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>  
> 
> Hello Tony
> 
> you are going out with your patches but ... what is the result of the discussions
> we had in the past ? Do we have a common understanding that we want to have
> it this way ? A driver which is able to claim resources and the bus code
> has lower precedence ?

I don't know about previous discussions, but I'm curious how you
arrived at this design. A driver being able to override the bus code
seems odd. Restricting this to 'non-default' drivers looks even more
odd.

What is this trying to solve? Traditionally, root has been able to
shoot any appendages of their choice. I would rather expect that in a
supported setup you'd have some management software keeping track of
device usage and making sure that only unused queues can be unbound. Do
we need to export more information to user space so that management
software can make better choices?

> 
> > ---
> >  drivers/s390/crypto/ap_bus.c | 138 +++++++++++++++++++++++++++++++++++++++++--
> >  drivers/s390/crypto/ap_bus.h |   3 +
> >  2 files changed, 135 insertions(+), 6 deletions(-)
