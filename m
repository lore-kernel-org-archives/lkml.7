Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5157C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 10:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0A812073B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 10:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="mQ5chb8s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbfLKKwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 05:52:50 -0500
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:22471 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbfLKKwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 05:52:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1576061569; x=1607597569;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tKTCV8zsPOF8wTXhXSHaG6JQ8Pv27HRkM2/blZeasrk=;
  b=mQ5chb8sOBvvxbMCZPjwNhw5FkpiN/IATvwyNmGOEEM3Ly2D0UnUhvvE
   4lgOXHJjJmb/xX22MXbr9Ug62WlXdOPTPJy5bJmSeot6VMvWVB1YNYBgg
   aNKeNEJ16lsPN4P9hv8M5mINWlaBCpyAsCvXIW7v5/mVQ1M+WWv7A81GV
   c=;
IronPort-SDR: G3ZuTYQMWz/pizVnxKE6lqrBU5Ss1htIumjS+vqBhz3mycmQkJSo1HyI3Y3Pg3n8sQgZ55NJbw
 rhQR34RpoCNg==
X-IronPort-AV: E=Sophos;i="5.69,301,1571702400"; 
   d="scan'208";a="8076040"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2c-2225282c.us-west-2.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 11 Dec 2019 10:52:47 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2c-2225282c.us-west-2.amazon.com (Postfix) with ESMTPS id 6304BA06B2;
        Wed, 11 Dec 2019 10:52:46 +0000 (UTC)
Received: from EX13D32EUC002.ant.amazon.com (10.43.164.94) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 11 Dec 2019 10:52:45 +0000
Received: from EX13D32EUC003.ant.amazon.com (10.43.164.24) by
 EX13D32EUC002.ant.amazon.com (10.43.164.94) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 11 Dec 2019 10:52:45 +0000
Received: from EX13D32EUC003.ant.amazon.com ([10.43.164.24]) by
 EX13D32EUC003.ant.amazon.com ([10.43.164.24]) with mapi id 15.00.1367.000;
 Wed, 11 Dec 2019 10:52:45 +0000
From:   "Durrant, Paul" <pdurrant@amazon.com>
To:     =?iso-8859-1?Q?Roger_Pau_Monn=E9?= <roger.pau@citrix.com>
CC:     "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: RE: [PATCH v2 4/4] xen-blkback: support dynamic unbind/bind
Thread-Topic: [PATCH v2 4/4] xen-blkback: support dynamic unbind/bind
Thread-Index: AQHVr02/5BDvv90j7UOwWq+aSG/tNqe0wbIAgAABJIA=
Date:   Wed, 11 Dec 2019 10:52:44 +0000
Message-ID: <93f85e6b45eb4286b34ae12ea726038c@EX13D32EUC003.ant.amazon.com>
References: <20191210113347.3404-1-pdurrant@amazon.com>
 <20191210113347.3404-5-pdurrant@amazon.com>
 <20191211104550.GJ980@Air-de-Roger>
In-Reply-To: <20191211104550.GJ980@Air-de-Roger>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.166.120]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Roger Pau Monn=E9 <roger.pau@citrix.com>
> Sent: 11 December 2019 10:46
> To: Durrant, Paul <pdurrant@amazon.com>
> Cc: xen-devel@lists.xenproject.org; linux-kernel@vger.kernel.org; Konrad
> Rzeszutek Wilk <konrad.wilk@oracle.com>; Jens Axboe <axboe@kernel.dk>;
> Boris Ostrovsky <boris.ostrovsky@oracle.com>; Juergen Gross
> <jgross@suse.com>; Stefano Stabellini <sstabellini@kernel.org>
> Subject: Re: [PATCH v2 4/4] xen-blkback: support dynamic unbind/bind
>=20
> On Tue, Dec 10, 2019 at 11:33:47AM +0000, Paul Durrant wrote:
> > By simply re-attaching to shared rings during connect_ring() rather tha=
n
> > assuming they are freshly allocated (i.e assuming the counters are zero=
)
> > it is possible for vbd instances to be unbound and re-bound from and to
> > (respectively) a running guest.
> >
> > This has been tested by running:
> >
> > while true;
> >   do fio --name=3Drandwrite --ioengine=3Dlibaio --iodepth=3D16 \
> >   --rw=3Drandwrite --bs=3D4k --direct=3D1 --size=3D1G --verify=3Dcrc32;
> >   done
> >
> > in a PV guest whilst running:
> >
> > while true;
> >   do echo vbd-$DOMID-$VBD >unbind;
> >   echo unbound;
> >   sleep 5;
>=20
> Is there anyway to know when the unbind has finished? AFAICT
> xen_blkif_disconnect will return EBUSY if there are in flight
> requests, and the disconnect won't be completed until those requests
> are finished.

Yes, the device sysfs node will disappear when remove() completes.

>=20
> >   echo vbd-$DOMID-$VBD >bind;
> >   echo bound;
> >   sleep 3;
> >   done
> >
> > in dom0 from /sys/bus/xen-backend/drivers/vbd to continuously unbind an=
d
> > re-bind its system disk image.
> >
> > This is a highly useful feature for a backend module as it allows it to
> be
> > unloaded and re-loaded (i.e. updated) without requiring domUs to be
> halted.
> > This was also tested by running:
> >
> > while true;
> >   do echo vbd-$DOMID-$VBD >unbind;
> >   echo unbound;
> >   sleep 5;
> >   rmmod xen-blkback;
> >   echo unloaded;
> >   sleep 1;
> >   modprobe xen-blkback;
> >   echo bound;
> >   cd $(pwd);
> >   sleep 3;
> >   done
> >
> > in dom0 whilst running the same loop as above in the (single) PV guest.
> >
> > Some (less stressful) testing has also been done using a Windows HVM
> guest
> > with the latest 9.0 PV drivers installed.
> >
> > Signed-off-by: Paul Durrant <pdurrant@amazon.com>
> > ---
> > Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> > Cc: "Roger Pau Monn=E9" <roger.pau@citrix.com>
> > Cc: Jens Axboe <axboe@kernel.dk>
> > Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> > Cc: Juergen Gross <jgross@suse.com>
> > Cc: Stefano Stabellini <sstabellini@kernel.org>
> >
> > v2:
> >  - Apply a sanity check to the value of rsp_prod and fail the re-attach
> >    if it is implausible
> >  - Set allow_rebind to prevent ring from being closed on unbind
> >  - Update test workload from dd to fio (with verification)
> > ---
> >  drivers/block/xen-blkback/xenbus.c | 59 +++++++++++++++++++++---------
> >  1 file changed, 41 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-
> blkback/xenbus.c
> > index e8c5c54e1d26..13d09630b237 100644
> > --- a/drivers/block/xen-blkback/xenbus.c
> > +++ b/drivers/block/xen-blkback/xenbus.c
> > @@ -181,6 +181,8 @@ static int xen_blkif_map(struct xen_blkif_ring
> *ring, grant_ref_t *gref,
> >  {
> >  	int err;
> >  	struct xen_blkif *blkif =3D ring->blkif;
> > +	struct blkif_common_sring *sring_common;
> > +	RING_IDX rsp_prod, req_prod;
> >
> >  	/* Already connected through? */
> >  	if (ring->irq)
> > @@ -191,46 +193,66 @@ static int xen_blkif_map(struct xen_blkif_ring
> *ring, grant_ref_t *gref,
> >  	if (err < 0)
> >  		return err;
> >
> > +	sring_common =3D (struct blkif_common_sring *)ring->blk_ring;
> > +	rsp_prod =3D READ_ONCE(sring_common->rsp_prod);
> > +	req_prod =3D READ_ONCE(sring_common->req_prod);
> > +
> >  	switch (blkif->blk_protocol) {
> >  	case BLKIF_PROTOCOL_NATIVE:
> >  	{
> > -		struct blkif_sring *sring;
> > -		sring =3D (struct blkif_sring *)ring->blk_ring;
> > -		BACK_RING_INIT(&ring->blk_rings.native, sring,
> > -			       XEN_PAGE_SIZE * nr_grefs);
> > +		struct blkif_sring *sring_native =3D
> > +			(struct blkif_sring *)ring->blk_ring;
>=20
> I think you can constify both sring_native and sring_common (and the
> other instances below).

Yes, I can do that. I don't think the macros would mind.

>=20
> > +		unsigned int size =3D __RING_SIZE(sring_native,
> > +						XEN_PAGE_SIZE * nr_grefs);
> > +
> > +		BACK_RING_ATTACH(&ring->blk_rings.native, sring_native,
> > +				 rsp_prod, XEN_PAGE_SIZE * nr_grefs);
> > +		err =3D (req_prod - rsp_prod > size) ? -EIO : 0;
> >  		break;
> >  	}
> >  	case BLKIF_PROTOCOL_X86_32:
> >  	{
> > -		struct blkif_x86_32_sring *sring_x86_32;
> > -		sring_x86_32 =3D (struct blkif_x86_32_sring *)ring->blk_ring;
> > -		BACK_RING_INIT(&ring->blk_rings.x86_32, sring_x86_32,
> > -			       XEN_PAGE_SIZE * nr_grefs);
> > +		struct blkif_x86_32_sring *sring_x86_32 =3D
> > +			(struct blkif_x86_32_sring *)ring->blk_ring;
> > +		unsigned int size =3D __RING_SIZE(sring_x86_32,
> > +						XEN_PAGE_SIZE * nr_grefs);
> > +
> > +		BACK_RING_ATTACH(&ring->blk_rings.x86_32, sring_x86_32,
> > +				 rsp_prod, XEN_PAGE_SIZE * nr_grefs);
> > +		err =3D (req_prod - rsp_prod > size) ? -EIO : 0;
> >  		break;
> >  	}
> >  	case BLKIF_PROTOCOL_X86_64:
> >  	{
> > -		struct blkif_x86_64_sring *sring_x86_64;
> > -		sring_x86_64 =3D (struct blkif_x86_64_sring *)ring->blk_ring;
> > -		BACK_RING_INIT(&ring->blk_rings.x86_64, sring_x86_64,
> > -			       XEN_PAGE_SIZE * nr_grefs);
> > +		struct blkif_x86_64_sring *sring_x86_64 =3D
> > +			(struct blkif_x86_64_sring *)ring->blk_ring;
> > +		unsigned int size =3D __RING_SIZE(sring_x86_64,
> > +						XEN_PAGE_SIZE * nr_grefs);
> > +
> > +		BACK_RING_ATTACH(&ring->blk_rings.x86_64, sring_x86_64,
> > +				 rsp_prod, XEN_PAGE_SIZE * nr_grefs);
> > +		err =3D (req_prod - rsp_prod > size) ? -EIO : 0;
>=20
> This is repeated for all ring types, might be worth to pull it out of
> the switch...
>=20

I did wonder about that... I'll do in v3.

> >  		break;
> >  	}
> >  	default:
> >  		BUG();
> >  	}
> > +	if (err < 0)
> > +		goto fail;
>=20
> ...and placed here instead?

Indeed.

  Cheers,
    Paul

>=20
> Thanks, Roger.
