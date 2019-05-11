Return-Path: <SRS0=o7UO=TL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B030CC04AB1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 08:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E26C217F9
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 08:27:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbfEKI1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 May 2019 04:27:11 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38888 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728407AbfEKI1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 04:27:10 -0400
Received: by mail-wr1-f67.google.com with SMTP id v11so10120400wru.5
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2019 01:27:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SdcIkrLxlvfbUBZr0Qh6I0nrjoSmAfdYaMwVRnCWFzs=;
        b=fhhF2wzl2477G/b7P519YSy23v3d9JT9j4y2DufUrrRki88dks45+xHbNrj0McRYYl
         g/KulLauTiX5hMyXRMHSj8YGtlGN7FUbB2CMtQ4hyidoMlQ59mS8mFfV7zYsG8Q9F7wn
         5i92NQIYVrBO7FHTr8xoxl++mJT+eHv0ES675zZ4Yr9t5x10eI8EZWldqv5g9EWIbmlK
         Lu5gWhyu5mlH8wsT0CV/D9VfGDW3R8Pb3uiqrZGbSC0aBlHhgIPeW84YOr0jjKZaAWo4
         o+w0GruyZ+l6g7GazQEpbkPCi7bKOv3cOgJ/K3J3yAZEnxD5M6SBryFK4r0fQacK82qG
         p/4w==
X-Gm-Message-State: APjAAAXVhJxnVUTDtyW9+cTF/zZOifAsCG6LsjydTKv0Su8f/gBLn4U3
        gtliK/aGgaUSNSTz70nPx/YElg==
X-Google-Smtp-Source: APXvYqyj/9N4bztXCrHILbAbwp3dJCqyNjuLPc0pwjnIPNQl6TcYclEpkJFlN8NEOxoqcXldXr0PfA==
X-Received: by 2002:a5d:49c1:: with SMTP id t1mr10376967wrs.247.1557563228981;
        Sat, 11 May 2019 01:27:08 -0700 (PDT)
Received: from steredhat.homenet.telecomitalia.it (host151-251-static.12-87-b.business.telecomitalia.it. [87.12.251.151])
        by smtp.gmail.com with ESMTPSA id g10sm8043541wrw.80.2019.05.11.01.27.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 11 May 2019 01:27:08 -0700 (PDT)
Date:   Sat, 11 May 2019 10:27:05 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     David Miller <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, mst@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        stefanha@redhat.com, jasowang@redhat.com
Subject: Re: [PATCH v2 2/8] vsock/virtio: free packets during the socket
 release
Message-ID: <20190511082705.t62d3rfbgibc4zxi@steredhat.homenet.telecomitalia.it>
References: <20190510125843.95587-1-sgarzare@redhat.com>
 <20190510125843.95587-3-sgarzare@redhat.com>
 <20190510.152008.1902268386064871188.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190510.152008.1902268386064871188.davem@davemloft.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 10, 2019 at 03:20:08PM -0700, David Miller wrote:
> From: Stefano Garzarella <sgarzare@redhat.com>
> Date: Fri, 10 May 2019 14:58:37 +0200
> 
> > @@ -827,12 +827,20 @@ static bool virtio_transport_close(struct vsock_sock *vsk)
> >  
> >  void virtio_transport_release(struct vsock_sock *vsk)
> >  {
> > +	struct virtio_vsock_sock *vvs = vsk->trans;
> > +	struct virtio_vsock_buf *buf;
> >  	struct sock *sk = &vsk->sk;
> >  	bool remove_sock = true;
> >  
> >  	lock_sock(sk);
> >  	if (sk->sk_type == SOCK_STREAM)
> >  		remove_sock = virtio_transport_close(vsk);
> > +	while (!list_empty(&vvs->rx_queue)) {
> > +		buf = list_first_entry(&vvs->rx_queue,
> > +				       struct virtio_vsock_buf, list);
> 
> Please use list_for_each_entry_safe().

Thanks for the review, I'll change it in the v3.

Cheers,
Stefano
