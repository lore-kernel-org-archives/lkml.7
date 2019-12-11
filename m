Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA91AC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 16:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A15CF2073D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 16:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a2z+nRqk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388791AbfLKQDR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 11:03:17 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:37405 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731322AbfLKQDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 11:03:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576080194;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6gfZXNRDfcJ0EDIOFFIp2NIhgwIPnf16ocIK/xP3HK0=;
        b=a2z+nRqkyNePq+R9e3R+wfhJsWoBFRn2uXDHxVTrmyHcTtuOcY/hoMUG57fnn6Ld1KDZpb
        Vyik2anr01X/Sp/HGb4D+12lrIKGScE7KlN0tQOihnEs60JOhwJckF1tGx1NOxZF9+dHMY
        w7W+87jqp6AJHv8FEFLzcR8nVt09z00=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-odgPUpKWPu-o4I4OcAgxaw-1; Wed, 11 Dec 2019 11:03:12 -0500
X-MC-Unique: odgPUpKWPu-o4I4OcAgxaw-1
Received: by mail-qt1-f200.google.com with SMTP id o24so4648542qtr.17
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 08:03:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6gfZXNRDfcJ0EDIOFFIp2NIhgwIPnf16ocIK/xP3HK0=;
        b=dQg7OAadZxFlfRJi+AKvkeaFcC6LVcwlHfP9Y1b6AvTNBf6wTCat9j5QrpGZpae7iv
         9bJAFNhMyTARYKY2EBzn9fPObs1l9PfWk5jfzGASkDANUem7/9JsT236MdtnaVZ2SYmU
         gnaks/9Gq9qSvKR2yRM+U60Dp+7eeGKG8gdl9miat7/5ZwSlfedyvr9hT6AI4L/Bv8p9
         l5dcMX2uhwlyPfj3UMruD4XbupyHRq/FLNN5REgMPHwMl5MQaG8hgJdriqXl1fVrX+dz
         xcOXgegq8bL5ICErcPtQvmihwr4MX+QlUPmGRXcFDE54fsTKYOKRBPXoPe3qWGY7RiXG
         YL1g==
X-Gm-Message-State: APjAAAWxRcjLoPIGVLcN0152JXjeq9CcHM/+XnAVrlWLnTrcs1XGBIAZ
        9etceAmVvs4wzhiwhjUf8Z+vL/K03Z4+6Fs55oRKjXfOSmczi6iZHBAlYoYQOOvgv3S5UBOTKWl
        ln4AG8ERgSV4bebUHRv4LfMRn
X-Received: by 2002:a05:620a:2010:: with SMTP id c16mr3515478qka.386.1576080192422;
        Wed, 11 Dec 2019 08:03:12 -0800 (PST)
X-Google-Smtp-Source: APXvYqwQQ2Bwv6/Qhu4cPFoF7Ygb0/S4EIjerRyxmrHRlOtQFWaSfcUrQlX7U0QxQDZ6VV+soS6Sdg==
X-Received: by 2002:a05:620a:2010:: with SMTP id c16mr3515454qka.386.1576080192203;
        Wed, 11 Dec 2019 08:03:12 -0800 (PST)
Received: from redhat.com (bzq-79-181-48-215.red.bezeqint.net. [79.181.48.215])
        by smtp.gmail.com with ESMTPSA id q14sm1027460qtp.48.2019.12.11.08.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 08:03:11 -0800 (PST)
Date:   Wed, 11 Dec 2019 11:03:07 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] vhost/vsock: accept only packets with the right dst_cid
Message-ID: <20191211110235-mutt-send-email-mst@kernel.org>
References: <20191206143912.153583-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191206143912.153583-1-sgarzare@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 06, 2019 at 03:39:12PM +0100, Stefano Garzarella wrote:
> When we receive a new packet from the guest, we check if the
> src_cid is correct, but we forgot to check the dst_cid.
> 
> The host should accept only packets where dst_cid is
> equal to the host CID.
> 
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Stefano can you clarify the impact pls?
E.g. is this needed on stable? Etc.

Thanks!

> ---
>  drivers/vhost/vsock.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> index 50de0642dea6..c2d7d57e98cf 100644
> --- a/drivers/vhost/vsock.c
> +++ b/drivers/vhost/vsock.c
> @@ -480,7 +480,9 @@ static void vhost_vsock_handle_tx_kick(struct vhost_work *work)
>  		virtio_transport_deliver_tap_pkt(pkt);
>  
>  		/* Only accept correctly addressed packets */
> -		if (le64_to_cpu(pkt->hdr.src_cid) == vsock->guest_cid)
> +		if (le64_to_cpu(pkt->hdr.src_cid) == vsock->guest_cid &&
> +		    le64_to_cpu(pkt->hdr.dst_cid) ==
> +		    vhost_transport_get_local_cid())
>  			virtio_transport_recv_pkt(&vhost_transport, pkt);
>  		else
>  			virtio_transport_free_pkt(pkt);
> -- 
> 2.23.0

