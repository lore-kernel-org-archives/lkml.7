Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE26C04AA6
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 15:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 395112147A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 15:31:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LVUwgkJE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbfD3Pbf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 11:31:35 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:40672 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfD3Pbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 11:31:34 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3UFVIjv111448;
        Tue, 30 Apr 2019 10:31:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1556638278;
        bh=4QGSJ62ES/Rz1i9PeLAfB7uPMJpr8cbFT9IZNWvLw44=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=LVUwgkJEySc1NQiMsX7SfPcrMmupuezK/cY5XOVpW+9wsYmba8CupcBX2Z/8ciJTn
         eMabujMf2PJ5J2ait6x+tEDoU/sViesLPsZcoq4kWsF5adYVLcbnyUoyCeXl/RYe1z
         wrzaZdhGIF5WnPsr0JL9TqciPofjnJuHifm+FjLk=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3UFVICH095519
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 Apr 2019 10:31:18 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 30
 Apr 2019 10:31:18 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 30 Apr 2019 10:31:18 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3UFVIqs113684;
        Tue, 30 Apr 2019 10:31:18 -0500
Date:   Tue, 30 Apr 2019 10:31:18 -0500
From:   Bin Liu <b-liu@ti.com>
To:     "Matwey V. Kornilov" <matwey@sai.msu.ru>
CC:     <gregkh@linuxfoundation.org>, <matwey.kornilov@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>
Subject: Re: [PATCH 6/6] usb: musb: Decrease URB starting latency in
 musb_advance_schedule()
Message-ID: <20190430153118.GI20993@uda0271908>
Mail-Followup-To: Bin Liu <b-liu@ti.com>,
        "Matwey V. Kornilov" <matwey@sai.msu.ru>,
        gregkh@linuxfoundation.org, matwey.kornilov@gmail.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
References: <20190403185310.8437-1-matwey@sai.msu.ru>
 <20190403185310.8437-7-matwey@sai.msu.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190403185310.8437-7-matwey@sai.msu.ru>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg and all devs,

On Wed, Apr 03, 2019 at 09:53:10PM +0300, Matwey V. Kornilov wrote:
> Previously, the algorithm was the following:
> 
>  1. giveback current URB
>  2. if current qh is not empty
>     then start next URB
>  3. if current qh is empty
>     then dispose the qh, find next qh if any, and start URB.
> 
> It may take a while to run urb->callback inside URB giveback which is
> run synchronously in musb. In order to improve the latency we rearrange
> the function behaviour for the case when qh is not empty: next URB is
> started before URB giveback. When qh is empty then the behaviour is
> intentionally kept in order not to break existing inter qh scheduling:
> URB giveback could potentionally enqueue other URB to the empty qh
> preventing it from being disposed.

This patch changes the sequence of urb giveback in musb.

	before				after
	------				-----
1. giveback current urb			1. start next urb if qh != empty
2. start next urb if qh != empty	2. giveback current urb

I see there is a potential that the urb giveback could be out of order,
for example, if urb giveback in BH and the next urb finishes before BH
runs.

If this potential is possible, is it a problem for any class driver?

Thanks,
-Bin.

> 
> Before this patch, time spent in urb->callback led to the following
> glitches between the host and a hub during isoc transfer (line 4):
> 
>     11.624492 d=  0.000124 [130.6 +  1.050] [  4] SPLIT
>     11.624492 d=  0.000000 [130.6 +  1.467] [  3] IN   : 3.5
>     11.624493 d=  0.000000 [130.6 +  1.967] [ 37] DATA0: aa 08 [skipped...]
>     11.625617 d=  0.001124 [131.7 +  1.050] [  4] SPLIT
>     11.625617 d=  0.000000 [131.7 +  1.467] [  3] IN   : 3.5
>     11.625867 d=  0.000250 [132.1 +  1.050] [  4] SPLIT
>     11.625867 d=  0.000000 [132.1 +  1.467] [  3] IN   : 3.5
>     11.625868 d=  0.000001 [132.1 +  1.983] [  3] DATA0: 00 00
>     11.626617 d=  0.000749 [132.7 +  1.050] [  4] SPLIT
>     11.626617 d=  0.000000 [132.7 +  1.467] [  3] IN   : 3.5
>     11.626867 d=  0.000250 [133.1 +  1.050] [  4] SPLIT
>     11.626867 d=  0.000000 [133.1 +  1.467] [  3] IN   : 3.5
>     11.626868 d=  0.000000 [133.1 +  1.967] [  3] DATA0: 00 00
> 
> After the hub, they look as the following and may lead to broken
> perepherial transfer (as in case of PWC based webcam):
> 
>     11.332004 d=  0.000997 [ 30.0 +  3.417] [  3] IN   : 5.5
>     11.332007 d=  0.000003 [ 30.0 +  6.833] [800] DATA0: 8a 1c [skipped...]
>     11.334004 d=  0.001997 [ 32.0 +  3.417] [  3] IN   : 5.5
>     11.334007 d=  0.000003 [ 32.0 +  6.750] [  3] DATA0: 00 00
>     11.335004 d=  0.000997 [ 33   +  3.417] [  3] IN   : 5.5
>     11.335007 d=  0.000003 [ 33   +  6.750] [  3] DATA0: 00 00
> 
> Removing this glitches makes us able to successfully run 10fps
> video stream from the webcam attached via USB hub. That was
> previously impossible.
> 
> Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>
> ---
>  drivers/usb/musb/musb_host.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
> index ed99ecd4e63a..75be92873b5b 100644
> --- a/drivers/usb/musb/musb_host.c
> +++ b/drivers/usb/musb/musb_host.c
> @@ -85,6 +85,11 @@ static bool musb_qh_empty(struct musb_qh *qh)
>  	return list_empty(&qh->hep->urb_list);
>  }
>  
> +static bool musb_qh_singular(struct musb_qh *qh)
> +{
> +	return list_is_singular(&qh->hep->urb_list);
> +}
> +
>  static void musb_qh_unlink_hep(struct musb_qh *qh)
>  {
>  	if (!qh->hep)
> @@ -362,6 +367,19 @@ static void musb_advance_schedule(struct musb *musb, struct urb *urb,
>  		break;
>  	}
>  
> +	if (ready && !musb_qh_singular(qh)) {
> +		struct urb *next_urb = list_next_entry(urb, urb_list);
> +
> +		musb_dbg(musb, "... next ep%d %cX urb %p", hw_ep->epnum, is_in ? 'R' : 'T', next_urb);
> +		musb_start_urb(musb, is_in, qh, next_urb);
> +
> +		qh->is_ready = 0;
> +		musb_giveback(musb, urb, status);
> +		qh->is_ready = ready;
> +
> +		return;
> +	}
> +
>  	qh->is_ready = 0;
>  	musb_giveback(musb, urb, status);
>  	qh->is_ready = ready;
> -- 
> 2.16.4
> 
