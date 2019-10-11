Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E04C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 14:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A40720673
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 14:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbfJKOhq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 10:37:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42916 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726631AbfJKOhq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 10:37:46 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CE9A2C05AA56
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 14:37:45 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id z205so4197637wmb.7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 07:37:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cJdL4DlBZ1DsoqoslBnw04GmuGAbbtWTmEe0mcYukas=;
        b=hYTUjlWEa0MosKejO7gNS70RiLvnfjpmsf1FQxxuWfwFHCZ+4VlOqTaDiQeayF1Bhc
         9B/jUjKV3+coFWEW1if8NVx67nceVT7XhzLLqBxOL0YiBUjr+L8xcpo7lAOZQ+Te/Shs
         jJmeZuxTCcd6PjIIxhKk4w2EhMzM4jr4tYh7rK8fPOn+Dl5Hl9ST4sOfTy2wBkCbBtrn
         dL7vFaDoyiXk4imEnM6c2P7yqYmisq+odA8RrFyDEMNzgesbYOv19DJxJJdF3dM5/8qk
         hLsK2wdSRCbH+3/F+VLOeEsro5qgRjWMOEZsAGozykCiIRh0IH8XTLq94AeDzjutxlfH
         HY7Q==
X-Gm-Message-State: APjAAAWkusM5kxXlowNfS459hH4x9fzmAReh2SuGQPL/qLLYzplbTOHP
        Qr6lzEvnbgjy8TxJTBzyAaykOy34Pk+wcCZxq5cIRXusZkAs3+eHdTQcyHEBRrnj7rZ7j4q2bBQ
        LHNPhrF6AbWONHSaZ9kXk9Urs
X-Received: by 2002:adf:a516:: with SMTP id i22mr14579494wrb.273.1570804664503;
        Fri, 11 Oct 2019 07:37:44 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzNdP5yvb8Rbsm9tLzeyjamBn7Ne70jEAdvVVgHzVT6Bjn+tQzwtYnB8hZDowTkrOmAzV3rXQ==
X-Received: by 2002:adf:a516:: with SMTP id i22mr14579472wrb.273.1570804664273;
        Fri, 11 Oct 2019 07:37:44 -0700 (PDT)
Received: from steredhat (host174-200-dynamic.52-79-r.retail.telecomitalia.it. [79.52.200.174])
        by smtp.gmail.com with ESMTPSA id y14sm13296394wrd.84.2019.10.11.07.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 07:37:43 -0700 (PDT)
Date:   Fri, 11 Oct 2019 16:37:41 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
        Jorgen Hansen <jhansen@vmware.com>,
        "David S. Miller" <davem@davemloft.net>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Adit Ranadive <aditr@vmware.com>,
        Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/2] vsock: add half-closed socket details in the
 implementation notes
Message-ID: <20191011143741.frgdjcyee25wpcmf@steredhat>
References: <20191011130758.22134-1-sgarzare@redhat.com>
 <20191011130758.22134-2-sgarzare@redhat.com>
 <20191011101936-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011101936-mutt-send-email-mst@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 10:22:30AM -0400, Michael S. Tsirkin wrote:
> On Fri, Oct 11, 2019 at 03:07:57PM +0200, Stefano Garzarella wrote:
> > vmci_transport never allowed half-closed socket on the host side.
> > Since we want to have the same behaviour across all transports, we
> > add a section in the "Implementation notes".
> > 
> > Cc: Jorgen Hansen <jhansen@vmware.com>
> > Cc: Adit Ranadive <aditr@vmware.com>
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > ---
> >  net/vmw_vsock/af_vsock.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> > index 2ab43b2bba31..27df57c2024b 100644
> > --- a/net/vmw_vsock/af_vsock.c
> > +++ b/net/vmw_vsock/af_vsock.c
> > @@ -83,6 +83,10 @@
> >   *   TCP_ESTABLISHED - connected
> >   *   TCP_CLOSING - disconnecting
> >   *   TCP_LISTEN - listening
> > + *
> > + * - Half-closed socket is supported only on the guest side. recv() on the host
> > + * side should return EOF when the guest closes a connection, also if some
> > + * data is still in the receive queue.
> >   */
> >  
> >  #include <linux/types.h>
> 
> That's a great way to lose data in a way that's hard to debug.
> 
> VMCI sockets connect to a hypervisor so there's tight control
> of what the hypervisor can do.
> 
> But vhost vsocks connect to a fully fledged Linux, so
> you can't assume this is safe. And application authors do not read
> kernel source.

Thanks for explaining.
Discard this patch, I'll try to add a getsockopt() to allow the tests
(and applications) to understand if half-closed socket is supported or not.

Stefano
