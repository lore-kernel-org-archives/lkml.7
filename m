Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CBA7C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 13:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 555262075B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 13:03:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfCDNDR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 08:03:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:15714 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726233AbfCDNDR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 08:03:17 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ABC94C010898;
        Mon,  4 Mar 2019 13:03:16 +0000 (UTC)
Received: from gondolin (ovpn-116-85.ams2.redhat.com [10.36.116.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5FFF05D71D;
        Mon,  4 Mar 2019 13:02:25 +0000 (UTC)
Date:   Mon, 4 Mar 2019 14:02:22 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Tony Krowiak <akrowiak@linux.ibm.com>
Cc:     Pierre Morel <pmorel@linux.ibm.com>, borntraeger@de.ibm.com,
        alex.williamson@redhat.com, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        frankja@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        freude@linux.ibm.com, mimu@linux.ibm.com
Subject: Re: [PATCH v4 6/7] s390: ap: Cleanup on removing the AP device
Message-ID: <20190304140222.6d694479.cohuck@redhat.com>
In-Reply-To: <3f15bd09-8a90-ed8a-e15a-0f3bac1a3528@linux.ibm.com>
References: <1550849400-27152-1-git-send-email-pmorel@linux.ibm.com>
        <1550849400-27152-7-git-send-email-pmorel@linux.ibm.com>
        <3f15bd09-8a90-ed8a-e15a-0f3bac1a3528@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Mon, 04 Mar 2019 13:03:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Feb 2019 13:27:57 -0500
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> On 2/22/19 10:29 AM, Pierre Morel wrote:
> > When the device is remove, we must make sure to
> > clear the interruption and reset the AP device.
> > 
> > We also need to clear the CRYCB of the guest.
> > 
> > Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> > ---
> >   drivers/s390/crypto/vfio_ap_drv.c     | 35 +++++++++++++++++++++++++++++++++++
> >   drivers/s390/crypto/vfio_ap_ops.c     |  3 ++-
> >   drivers/s390/crypto/vfio_ap_private.h |  3 +++
> >   3 files changed, 40 insertions(+), 1 deletion(-)
(...)
> >   /**
> > + * vfio_ap_update_crycb
> > + * @q: A pointer to the queue being removed
> > + *
> > + * We clear the APID of the queue, making this queue unusable for the guest.
> > + * After this function we can reset the queue without to fear a race with
> > + * the guest to access the queue again.
> > + * We do not fear race with the host as we still get the device.
> > + */
> > +static void vfio_ap_update_crycb(struct vfio_ap_queue *q)
> > +{
> > +	struct ap_matrix_mdev *matrix_mdev = q->matrix_mdev;
> > +
> > +	if (!matrix_mdev)
> > +		return;
> > +
> > +	clear_bit_inv(AP_QID_CARD(q->apqn), matrix_mdev->matrix.apm);
> > +
> > +	if (!matrix_mdev->kvm)
> > +		return;
> > +
> > +	kvm_arch_crypto_set_masks(matrix_mdev->kvm,
> > +				  matrix_mdev->matrix.apm,
> > +				  matrix_mdev->matrix.aqm,
> > +				  matrix_mdev->matrix.adm);
> > +}
> > +
> > +/**
> >    * vfio_ap_queue_dev_remove:
> >    *
> >    * Free the associated vfio_ap_queue structure
> > @@ -70,6 +100,11 @@ static void vfio_ap_queue_dev_remove(struct ap_device *apdev)
> >   	struct vfio_ap_queue *q;
> >   
> >   	q = dev_get_drvdata(&apdev->device);
> > +	if (!q)
> > +		return;
> > +
> > +	vfio_ap_update_crycb(q);
> > +	vfio_ap_mdev_reset_queue(q);  
> 
> The reset is unnecessary because once the card is removed from the
> CRYCB, the ZAPQ may fail with because the queue may not exist anymore.
> Besides, once the card is removed from the guest's CRYCB, the bus
> running in the guest will do a reset.

You cannot rely on whatever a sane guest would do, any needed cleanup
needs to be done by the host.

(No idea what actually needs to be done here :)

> 
> >   	list_del(&q->list);
> >   	kfree(q);
> >   }
