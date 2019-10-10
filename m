Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD995C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 09:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 902C320679
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 09:33:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388107AbfJJJdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 05:33:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38974 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387803AbfJJJdA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 05:33:00 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5D9AE81DF7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 09:32:59 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id i10so2448073wrb.20
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 02:32:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hHaFcnAL50S5bJDTlPYhhk0RlrftYjgtnZsbNVxdruw=;
        b=Ykl1GGreHpaoTqksPuagrOwjABH8j2un+ma0SIl8rrJpAAw/HyS7QnXVXzdv36DE38
         /8okFpOC72bT2rsO7FB1mcKpnjTOUUMb78R/ROqsujN54QnagT3gufhDSnmvPeIS/yK0
         pvW0ikAbMG1hiHFz5dea9mC63AuKF13rtIfhY59eKd4AYfAeK7eNhDjyAkrJ08tvG5Ez
         O46B0ovDvvbt+9QACOQ81psEJOXsV1PeCiRqI5KhgzjcQE919PkpPrd43HUow9hJSm0U
         n8m4ybyYi7tukrt8rEUXvERd2TOirhFj9CturoUi+KWIWcv3F1UiwX5SDuMRLLB4cbVe
         tRuw==
X-Gm-Message-State: APjAAAVS5WEaPtR0Y1Lih4bERZjzWW7tg2ScJS/BzMxXGdnz5M+roKsL
        gb5wws9anStv2HmiRX2N55y3FOlVSdswVizzPz+wkIxvVV4FawlAFF0h4ty6WJ7vKymf7IYVJGq
        kX63O5yqig1/0lGuwHgxuHkPB
X-Received: by 2002:adf:f5c2:: with SMTP id k2mr8086192wrp.0.1570699978014;
        Thu, 10 Oct 2019 02:32:58 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwZYmKYcpphquBJXQEx7PcBznop7/J4yPxwExmJMbotDVgXFZgLM3mbUlPv6hfBGTfBY51rWA==
X-Received: by 2002:adf:f5c2:: with SMTP id k2mr8086156wrp.0.1570699977733;
        Thu, 10 Oct 2019 02:32:57 -0700 (PDT)
Received: from steredhat (host174-200-dynamic.52-79-r.retail.telecomitalia.it. [79.52.200.174])
        by smtp.gmail.com with ESMTPSA id f83sm6597182wmf.43.2019.10.10.02.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 02:32:56 -0700 (PDT)
Date:   Thu, 10 Oct 2019 11:32:54 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Stefan Hajnoczi <stefanha@gmail.com>
Cc:     netdev@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
        linux-hyperv@vger.kernel.org,
        Stephen Hemminger <sthemmin@microsoft.com>,
        kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
        Dexuan Cui <decui@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jorgen Hansen <jhansen@vmware.com>
Subject: Re: [RFC PATCH 07/13] vsock: handle buffer_size sockopts in the core
Message-ID: <20191010093254.aluys4hpsfcepb42@steredhat>
References: <20190927112703.17745-1-sgarzare@redhat.com>
 <20190927112703.17745-8-sgarzare@redhat.com>
 <20191009123026.GH5747@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009123026.GH5747@stefanha-x1.localdomain>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2019 at 01:30:26PM +0100, Stefan Hajnoczi wrote:
> On Fri, Sep 27, 2019 at 01:26:57PM +0200, Stefano Garzarella wrote:
> > @@ -140,18 +145,11 @@ struct vsock_transport {
> >  		struct vsock_transport_send_notify_data *);
> >  	int (*notify_send_post_enqueue)(struct vsock_sock *, ssize_t,
> >  		struct vsock_transport_send_notify_data *);
> > +	int (*notify_buffer_size)(struct vsock_sock *, u64 *);
> 
> Is ->notify_buffer_size() called under lock_sock(sk)?  If yes, please
> document it.

Yes, it is. I'll document it!

> 
> > +static void vsock_update_buffer_size(struct vsock_sock *vsk,
> > +				     const struct vsock_transport *transport,
> > +				     u64 val)
> > +{
> > +	if (val > vsk->buffer_max_size)
> > +		val = vsk->buffer_max_size;
> > +
> > +	if (val < vsk->buffer_min_size)
> > +		val = vsk->buffer_min_size;
> > +
> > +	if (val != vsk->buffer_size &&
> > +	    transport && transport->notify_buffer_size)
> > +		transport->notify_buffer_size(vsk, &val);
> 
> Why does this function return an int if we don't check the return value?
> 

Copy and past :-(
I'll fix it returning void since I don't think it can fail.

> > diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> > index fc046c071178..bac9e7430a2e 100644
> > --- a/net/vmw_vsock/virtio_transport_common.c
> > +++ b/net/vmw_vsock/virtio_transport_common.c
> > @@ -403,17 +403,13 @@ int virtio_transport_do_socket_init(struct vsock_sock *vsk,
> >  	if (psk) {
> >  		struct virtio_vsock_sock *ptrans = psk->trans;
> >  
> > -		vvs->buf_size	= ptrans->buf_size;
> > -		vvs->buf_size_min = ptrans->buf_size_min;
> > -		vvs->buf_size_max = ptrans->buf_size_max;
> >  		vvs->peer_buf_alloc = ptrans->peer_buf_alloc;
> > -	} else {
> > -		vvs->buf_size = VIRTIO_VSOCK_DEFAULT_BUF_SIZE;
> > -		vvs->buf_size_min = VIRTIO_VSOCK_DEFAULT_MIN_BUF_SIZE;
> > -		vvs->buf_size_max = VIRTIO_VSOCK_DEFAULT_MAX_BUF_SIZE;
> >  	}
> >  
> > -	vvs->buf_alloc = vvs->buf_size;
> > +	if (vsk->buffer_size > VIRTIO_VSOCK_MAX_BUF_SIZE)
> > +		vsk->buffer_size = VIRTIO_VSOCK_MAX_BUF_SIZE;
> 
> Hmm...this could be outside the [min, max] range.  I'm not sure how much
> it matters.

The core guarantees that vsk->buffer_size is <= of the max, so since we are
lowering it, the max should be respected. For the min you are right,
but I think this limit is stricter than the min set by the user.

> 
> Another issue is that this patch drops the VIRTIO_VSOCK_MAX_BUF_SIZE
> limit that used to be enforced by virtio_transport_set_buffer_size().
> Now the limit is only applied at socket init time.  If the buffer size
> is changed later then VIRTIO_VSOCK_MAX_BUF_SIZE can be exceeded.  If
> that doesn't matter, why even bother with VIRTIO_VSOCK_MAX_BUF_SIZE
> here?
> 

The .notify_buffer_size() should avoid this issue, since it allows the
transport to limit the buffer size requested after the initialization.

But again the min set by the user can not be respected and in the
previous implementation we forced it to VIRTIO_VSOCK_MAX_BUF_SIZE.

Now we don't limit the min, but we guarantee only that vsk->buffer_size
is lower than VIRTIO_VSOCK_MAX_BUF_SIZE.

Can that be an acceptable compromise?

Thanks,
Stefano
