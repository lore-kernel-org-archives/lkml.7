Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84FC2ECE58E
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 14:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 682B1206A1
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 14:22:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728615AbfJKOWh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 10:22:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38664 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728348AbfJKOWh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 10:22:37 -0400
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 44A088E582
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 14:22:37 +0000 (UTC)
Received: by mail-qt1-f200.google.com with SMTP id z12so9609112qtn.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 07:22:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3/69IjnpthyAsYWKUyauhiINSOqY8C5ksx6fR2DlmR8=;
        b=gh84plDS5SG17U9P3KnDGJyJbdzc1GFQExtDS2gmTr2CaaoTf2IVr8DiAhL5KD+TNo
         mbVnh2+GxZb4kUR+2zfvBwirKQj8FDZhDwUXKp4jWwCGRnoPFQSYFzZI8ko+SE7fojZn
         yf8sBTIm3bzOdg/5raQqAUZn0jN2WWjjVgCOqEFGD4OuUaPMjioOlBV7+MTVTYMJD9ne
         vg2OW88hKEPy64c+amBG2dTTyCDP2cNabP/Ywqa6T3ihnNbw2QBjozyS6H3aiz55erdJ
         rQ0tHyzHcErwMco2YrvUfxSduz+OnzLgmOgOpXJtSydoul17JMly45HVPDL42v0moY0j
         vAuQ==
X-Gm-Message-State: APjAAAUCc2l7+cm7maQT0Gk8NEy43OsFWFwitrgIZoDp1F6jgi2Bl5Ge
        GprprGiVblEp7pt+izcwDD+NEOpHq0Rh2f9JpXVgDZRqBbxmAAy+R6coagZk73r+/01u1ZR1Jl1
        fJTOy8qXUoZyud3xA14FliX3+
X-Received: by 2002:ac8:6c4:: with SMTP id j4mr17178007qth.235.1570803756536;
        Fri, 11 Oct 2019 07:22:36 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyypmt8JVfwhZN2RwBVS/3yah5jYZ2+VyE0up3EqHheFxjCMjltd5zsKzuYpHN6h2SBGBQ1eg==
X-Received: by 2002:ac8:6c4:: with SMTP id j4mr17177991qth.235.1570803756356;
        Fri, 11 Oct 2019 07:22:36 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
        by smtp.gmail.com with ESMTPSA id q47sm6531138qtq.95.2019.10.11.07.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 07:22:35 -0700 (PDT)
Date:   Fri, 11 Oct 2019 10:22:30 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
        Jorgen Hansen <jhansen@vmware.com>,
        "David S. Miller" <davem@davemloft.net>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Adit Ranadive <aditr@vmware.com>,
        Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/2] vsock: add half-closed socket details in the
 implementation notes
Message-ID: <20191011101936-mutt-send-email-mst@kernel.org>
References: <20191011130758.22134-1-sgarzare@redhat.com>
 <20191011130758.22134-2-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011130758.22134-2-sgarzare@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 03:07:57PM +0200, Stefano Garzarella wrote:
> vmci_transport never allowed half-closed socket on the host side.
> Since we want to have the same behaviour across all transports, we
> add a section in the "Implementation notes".
> 
> Cc: Jorgen Hansen <jhansen@vmware.com>
> Cc: Adit Ranadive <aditr@vmware.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  net/vmw_vsock/af_vsock.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index 2ab43b2bba31..27df57c2024b 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
> @@ -83,6 +83,10 @@
>   *   TCP_ESTABLISHED - connected
>   *   TCP_CLOSING - disconnecting
>   *   TCP_LISTEN - listening
> + *
> + * - Half-closed socket is supported only on the guest side. recv() on the host
> + * side should return EOF when the guest closes a connection, also if some
> + * data is still in the receive queue.
>   */
>  
>  #include <linux/types.h>

That's a great way to lose data in a way that's hard to debug.

VMCI sockets connect to a hypervisor so there's tight control
of what the hypervisor can do.

But vhost vsocks connect to a fully fledged Linux, so
you can't assume this is safe. And application authors do not read
kernel source.

> -- 
> 2.21.0
