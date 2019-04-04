Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C956DC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 15:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A27E0206DD
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 15:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728777AbfDDPok (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 11:44:40 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36363 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbfDDPoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 11:44:39 -0400
Received: by mail-wm1-f67.google.com with SMTP id h18so3985355wml.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 08:44:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=quvEgu5wfACbSNtM098KbjbidKz06p0TY4PFtqIhRfU=;
        b=XjbZdAALihbQVVJiujAYmnOPJVX5C0W6z1J6gnFVuuJ8D4CP3aqjNQb5JGlYT2jeg/
         Kl0D3T+vUkkzhClIgy1cbNpaJywsJJeNNJWBfi5RrClJbqI7Ppcwt4fF52ANKkLZD59f
         +dN0Zp5O6f/BTinj5I922T2+IN71dAjhwBZXkbxpJCv3G5jX7NX3sQ8ewkmVi7hOykmF
         8oCL0xcAMgXV7pzfNgI1XwefL43f8Gtc4Xo/Lvky+qhzQvKkpyDtj1t3//fZIQ0J+Wui
         WhX4pPribl/gMR+63NwzPgZ1610z0t9Nh+XlvybdEaZV5dV14JLEIgBH2jSegDOphBqf
         NyLw==
X-Gm-Message-State: APjAAAUBVd1jca6QBT/OH+CDkIzhuSBV6dceMh+oduXPBTMBP6mZkdDt
        1ylLQxCQ1kQXMJ4bTizN2PgnzQ==
X-Google-Smtp-Source: APXvYqwC3KkdifxCVan/RXP6UEshEcQAMhQZdIPXmHhjapWt8EJBSG3WbTu4kwmumumGbY8MllIgzg==
X-Received: by 2002:a1c:df89:: with SMTP id w131mr2500408wmg.82.1554392677297;
        Thu, 04 Apr 2019 08:44:37 -0700 (PDT)
Received: from steredhat (host35-203-static.12-87-b.business.telecomitalia.it. [87.12.203.35])
        by smtp.gmail.com with ESMTPSA id j7sm26063448wrt.96.2019.04.04.08.44.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 08:44:36 -0700 (PDT)
Date:   Thu, 4 Apr 2019 17:44:34 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Stefan Hajnoczi <stefanha@gmail.com>
Cc:     netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH RFC 0/4] vsock/virtio: optimizations to increase the
 throughput
Message-ID: <20190404154434.shaxqzfzacfqqyzx@steredhat>
References: <20190404105838.101559-1-sgarzare@redhat.com>
 <20190404141410.GA25152@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190404141410.GA25152@stefanha-x1.localdomain>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2019 at 03:14:10PM +0100, Stefan Hajnoczi wrote:
> On Thu, Apr 04, 2019 at 12:58:34PM +0200, Stefano Garzarella wrote:
> > This series tries to increase the throughput of virtio-vsock with slight
> > changes:
> >  - patch 1/4: reduces the number of credit update messages sent to the
> >               transmitter
> >  - patch 2/4: allows the host to split packets on multiple buffers,
> >               in this way, we can remove the packet size limit to
> >               VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE
> >  - patch 3/4: uses VIRTIO_VSOCK_MAX_PKT_BUF_SIZE as the max packet size
> >               allowed
> >  - patch 4/4: increases RX buffer size to 64 KiB (affects only host->guest)
> > 
> > RFC:
> >  - maybe patch 4 can be replaced with multiple queues with different
> >    buffer sizes or using EWMA to adapt the buffer size to the traffic
> > 
> >  - as Jason suggested in a previous thread [1] I'll evaluate to use
> >    virtio-net as transport, but I need to understand better how to
> >    interface with it, maybe introducing sk_buff in virtio-vsock.
> > 
> > Any suggestions?
> 
> Great performance results, nice job!

:)

> 
> Please include efficiency numbers (bandwidth / CPU utilization) in the
> future.  Due to the nature of these optimizations it's unlikely that
> efficiency has decreased, so I'm not too worried about it this time.

Thanks for the suggestion! I'll measure also the efficiency for future
optimizations.

Cheers,
Stefano
