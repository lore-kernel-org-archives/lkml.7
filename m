Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D2BC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 10:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C4C1206A5
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 10:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="ZC5kwUK+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbfLKKp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 05:45:59 -0500
Received: from esa6.hc3370-68.iphmx.com ([216.71.155.175]:10135 "EHLO
        esa6.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728696AbfLKKp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 05:45:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1576061157;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Bakm+VQafiA0lPWjjq2Jn5aW7yKdm4BIfPd/HpC9RKg=;
  b=ZC5kwUK+Qz3VJI3ygyk8RfK8/jMJzu1jKOeeCvxQU90KlYH+ncyLpdEu
   9yWf1ZXYhLfcC5l2HtGiIkynoJsl+T810zU7vSWfaFKkX7E2KSfQ1kPR+
   40bjl7y/i6AwPnTafHNynQtfkrw+MN8sH2/ndYHmREKiiIH8Ti7MmDwm3
   0=;
Authentication-Results: esa6.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none; spf=None smtp.pra=roger.pau@citrix.com; spf=Pass smtp.mailfrom=roger.pau@citrix.com; spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa6.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  roger.pau@citrix.com) identity=pra; client-ip=162.221.158.21;
  receiver=esa6.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="roger.pau@citrix.com";
  x-conformance=sidf_compatible
Received-SPF: Pass (esa6.hc3370-68.iphmx.com: domain of
  roger.pau@citrix.com designates 162.221.158.21 as permitted
  sender) identity=mailfrom; client-ip=162.221.158.21;
  receiver=esa6.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="roger.pau@citrix.com";
  x-conformance=sidf_compatible; x-record-type="v=spf1";
  x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
  ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
  ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
  ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83
  ip4:168.245.78.127 ~all"
Received-SPF: None (esa6.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@mail.citrix.com) identity=helo;
  client-ip=162.221.158.21; receiver=esa6.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="postmaster@mail.citrix.com";
  x-conformance=sidf_compatible
IronPort-SDR: I3Ws08a/zEqfI/lgYjM72AHmokfeQppgfWPU3XDYSw2zOVl+VcqZLiua6UdG10JD0HD+CRAwST
 NFDShGwJuQD6it7SIlmiN4CFZ696Ac8hP8twg2eOkSJVeMEdH2l/38FdahtXQ09pzYgq84RHr5
 l+DCF8NNv4uJgRyIeSKWnwogcxpb+RQfM0Mjncvo2Ohmq0VWJyB3jW0FWUYw/lbnmSytU9hw84
 bC58LNAm7aYK5l1pMCtVKXapqHENVca0nipPmZ3N+pP+kA0pu8G36aiva0YL5+HhtiBzwgTFCK
 YAo=
X-SBRS: 2.7
X-MesageID: 9925492
X-Ironport-Server: esa6.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.69,301,1571716800"; 
   d="scan'208";a="9925492"
Date:   Wed, 11 Dec 2019 11:45:50 +0100
From:   Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
To:     Paul Durrant <pdurrant@amazon.com>
CC:     <xen-devel@lists.xenproject.org>, <linux-kernel@vger.kernel.org>,
        "Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: Re: [PATCH v2 4/4] xen-blkback: support dynamic unbind/bind
Message-ID: <20191211104550.GJ980@Air-de-Roger>
References: <20191210113347.3404-1-pdurrant@amazon.com>
 <20191210113347.3404-5-pdurrant@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191210113347.3404-5-pdurrant@amazon.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL03.citrite.net (10.69.22.127)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 11:33:47AM +0000, Paul Durrant wrote:
> By simply re-attaching to shared rings during connect_ring() rather than
> assuming they are freshly allocated (i.e assuming the counters are zero)
> it is possible for vbd instances to be unbound and re-bound from and to
> (respectively) a running guest.
> 
> This has been tested by running:
> 
> while true;
>   do fio --name=randwrite --ioengine=libaio --iodepth=16 \
>   --rw=randwrite --bs=4k --direct=1 --size=1G --verify=crc32;
>   done
> 
> in a PV guest whilst running:
> 
> while true;
>   do echo vbd-$DOMID-$VBD >unbind;
>   echo unbound;
>   sleep 5;

Is there anyway to know when the unbind has finished? AFAICT
xen_blkif_disconnect will return EBUSY if there are in flight
requests, and the disconnect won't be completed until those requests
are finished.

>   echo vbd-$DOMID-$VBD >bind;
>   echo bound;
>   sleep 3;
>   done
> 
> in dom0 from /sys/bus/xen-backend/drivers/vbd to continuously unbind and
> re-bind its system disk image.
> 
> This is a highly useful feature for a backend module as it allows it to be
> unloaded and re-loaded (i.e. updated) without requiring domUs to be halted.
> This was also tested by running:
> 
> while true;
>   do echo vbd-$DOMID-$VBD >unbind;
>   echo unbound;
>   sleep 5;
>   rmmod xen-blkback;
>   echo unloaded;
>   sleep 1;
>   modprobe xen-blkback;
>   echo bound;
>   cd $(pwd);
>   sleep 3;
>   done
> 
> in dom0 whilst running the same loop as above in the (single) PV guest.
> 
> Some (less stressful) testing has also been done using a Windows HVM guest
> with the latest 9.0 PV drivers installed.
> 
> Signed-off-by: Paul Durrant <pdurrant@amazon.com>
> ---
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Cc: "Roger Pau Monné" <roger.pau@citrix.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> 
> v2:
>  - Apply a sanity check to the value of rsp_prod and fail the re-attach
>    if it is implausible
>  - Set allow_rebind to prevent ring from being closed on unbind
>  - Update test workload from dd to fio (with verification)
> ---
>  drivers/block/xen-blkback/xenbus.c | 59 +++++++++++++++++++++---------
>  1 file changed, 41 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
> index e8c5c54e1d26..13d09630b237 100644
> --- a/drivers/block/xen-blkback/xenbus.c
> +++ b/drivers/block/xen-blkback/xenbus.c
> @@ -181,6 +181,8 @@ static int xen_blkif_map(struct xen_blkif_ring *ring, grant_ref_t *gref,
>  {
>  	int err;
>  	struct xen_blkif *blkif = ring->blkif;
> +	struct blkif_common_sring *sring_common;
> +	RING_IDX rsp_prod, req_prod;
>  
>  	/* Already connected through? */
>  	if (ring->irq)
> @@ -191,46 +193,66 @@ static int xen_blkif_map(struct xen_blkif_ring *ring, grant_ref_t *gref,
>  	if (err < 0)
>  		return err;
>  
> +	sring_common = (struct blkif_common_sring *)ring->blk_ring;
> +	rsp_prod = READ_ONCE(sring_common->rsp_prod);
> +	req_prod = READ_ONCE(sring_common->req_prod);
> +
>  	switch (blkif->blk_protocol) {
>  	case BLKIF_PROTOCOL_NATIVE:
>  	{
> -		struct blkif_sring *sring;
> -		sring = (struct blkif_sring *)ring->blk_ring;
> -		BACK_RING_INIT(&ring->blk_rings.native, sring,
> -			       XEN_PAGE_SIZE * nr_grefs);
> +		struct blkif_sring *sring_native =
> +			(struct blkif_sring *)ring->blk_ring;

I think you can constify both sring_native and sring_common (and the
other instances below).

> +		unsigned int size = __RING_SIZE(sring_native,
> +						XEN_PAGE_SIZE * nr_grefs);
> +
> +		BACK_RING_ATTACH(&ring->blk_rings.native, sring_native,
> +				 rsp_prod, XEN_PAGE_SIZE * nr_grefs);
> +		err = (req_prod - rsp_prod > size) ? -EIO : 0;
>  		break;
>  	}
>  	case BLKIF_PROTOCOL_X86_32:
>  	{
> -		struct blkif_x86_32_sring *sring_x86_32;
> -		sring_x86_32 = (struct blkif_x86_32_sring *)ring->blk_ring;
> -		BACK_RING_INIT(&ring->blk_rings.x86_32, sring_x86_32,
> -			       XEN_PAGE_SIZE * nr_grefs);
> +		struct blkif_x86_32_sring *sring_x86_32 =
> +			(struct blkif_x86_32_sring *)ring->blk_ring;
> +		unsigned int size = __RING_SIZE(sring_x86_32,
> +						XEN_PAGE_SIZE * nr_grefs);
> +
> +		BACK_RING_ATTACH(&ring->blk_rings.x86_32, sring_x86_32,
> +				 rsp_prod, XEN_PAGE_SIZE * nr_grefs);
> +		err = (req_prod - rsp_prod > size) ? -EIO : 0;
>  		break;
>  	}
>  	case BLKIF_PROTOCOL_X86_64:
>  	{
> -		struct blkif_x86_64_sring *sring_x86_64;
> -		sring_x86_64 = (struct blkif_x86_64_sring *)ring->blk_ring;
> -		BACK_RING_INIT(&ring->blk_rings.x86_64, sring_x86_64,
> -			       XEN_PAGE_SIZE * nr_grefs);
> +		struct blkif_x86_64_sring *sring_x86_64 =
> +			(struct blkif_x86_64_sring *)ring->blk_ring;
> +		unsigned int size = __RING_SIZE(sring_x86_64,
> +						XEN_PAGE_SIZE * nr_grefs);
> +
> +		BACK_RING_ATTACH(&ring->blk_rings.x86_64, sring_x86_64,
> +				 rsp_prod, XEN_PAGE_SIZE * nr_grefs);
> +		err = (req_prod - rsp_prod > size) ? -EIO : 0;

This is repeated for all ring types, might be worth to pull it out of
the switch...

>  		break;
>  	}
>  	default:
>  		BUG();
>  	}
> +	if (err < 0)
> +		goto fail;

...and placed here instead?

Thanks, Roger.
