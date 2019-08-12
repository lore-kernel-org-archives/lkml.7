Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF7FC31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 05:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F25B20842
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 05:05:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfHLFFd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 01:05:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49492 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725648AbfHLFFc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 01:05:32 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7F1063B551;
        Mon, 12 Aug 2019 05:05:32 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6B0E45D6D0;
        Mon, 12 Aug 2019 05:05:32 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 553374A460;
        Mon, 12 Aug 2019 05:05:32 +0000 (UTC)
Date:   Mon, 12 Aug 2019 01:05:31 -0400 (EDT)
From:   Pankaj Gupta <pagupta@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     amit@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
        virtualization@lists.linux-foundation.org, jasowang@redhat.com,
        linux-kernel@vger.kernel.org, xiaohli@redhat.com
Message-ID: <904809366.7828013.1565586331773.JavaMail.zimbra@redhat.com>
In-Reply-To: <20190810141213-mutt-send-email-mst@kernel.org>
References: <20190809064847.28918-1-pagupta@redhat.com> <20190809064847.28918-3-pagupta@redhat.com> <20190810141213-mutt-send-email-mst@kernel.org>
Subject: Re: [PATCH v3 2/2] virtio: decrement avail idx with buffer detach
 for packed ring
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.116.104, 10.4.195.22]
Thread-Topic: virtio: decrement avail idx with buffer detach for packed ring
Thread-Index: MiSZup5kLcvoPG95SMeU4GQP1njEJA==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Mon, 12 Aug 2019 05:05:32 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Fri, Aug 09, 2019 at 12:18:47PM +0530, Pankaj Gupta wrote:
> > This patch decrements 'next_avail_idx' count when detaching a buffer
> > from vq for packed ring code. Split ring code already does this in
> > virtqueue_detach_unused_buf_split function. This updates the
> > 'next_avail_idx' to the previous correct index after an unused buffer
> > is detatched from the vq.
> > 
> > Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> 
> I would make this patch 1, not patch 2, otherwise
> patch 1 corrupts the ring.

Sure. Will post this patch as patch 1 in next version.

Thanks,
Pankaj 

> 
> 
> > ---
> >  drivers/virtio/virtio_ring.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index c8be1c4f5b55..7c69181113e2 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -1537,6 +1537,12 @@ static void
> > *virtqueue_detach_unused_buf_packed(struct virtqueue *_vq)
> >  		/* detach_buf clears data, so grab it now. */
> >  		buf = vq->packed.desc_state[i].data;
> >  		detach_buf_packed(vq, i, NULL);
> > +		vq->packed.next_avail_idx--;
> > +		if (vq->packed.next_avail_idx < 0) {
> > +			vq->packed.next_avail_idx = vq->packed.vring.num - 1;
> > +			vq->packed.avail_wrap_counter ^= 1;
> > +		}
> > +
> >  		END_USE(vq);
> >  		return buf;
> >  	}
> > --
> > 2.20.1
> 
