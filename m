Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE50C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 09:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BB5C20833
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 09:13:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbfDIJNF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 05:13:05 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39356 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbfDIJNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 05:13:05 -0400
Received: by mail-wm1-f68.google.com with SMTP id n25so2401089wmk.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 02:13:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=EvkmXYCaWirnY1s+s7C/6aFEffoZoYGGkm+UIEVxfz0=;
        b=OY2mCihC3L3Rgii7kJj5boa66VJr6ocTzZ1Zp7GFpzqCORYCLar/YgdQ9kUioq/QFE
         7UT7wFAGe0vaKV6/1Nt6iI9nGQEdYIy9dzUurvqSiQa5Bn+bmOm2IXPhBVLkL8fk2l/q
         osFupG6CxKbAZ0fSh1aH9Z2m59Pt6yhdKxrJisF/yXZXTnMb6QMmDJz8JW2oUdmmsh6o
         6Z77CBQaBheiQhJNhAF/EoB7oMfTbFGJCGGjWCso5uZ98etoYJXaIWV2zUxKKzTiN3kJ
         3e9pFp+EGRb682v1H9P590jGAqbWkja/1PryaRjYE7kBmy3+wTKw5cy9GArNzyVsjlqA
         8g/g==
X-Gm-Message-State: APjAAAVq2ZFfDWG6n8pvllsJF7irrINcKJ2tK6Tf6LaPUd19B+vDF3Fc
        xfpSs+q6kCuhDi1YqLJh7Z6smw==
X-Google-Smtp-Source: APXvYqyq1D2PodB/LAaL3pI7nizSvTWVjhg+LXuQhttc67bepRP3YJvEu+lDTl1A/gCxqVjc8P1kRA==
X-Received: by 2002:a1c:4844:: with SMTP id v65mr20830195wma.139.1554801183174;
        Tue, 09 Apr 2019 02:13:03 -0700 (PDT)
Received: from steredhat (host35-203-static.12-87-b.business.telecomitalia.it. [87.12.203.35])
        by smtp.gmail.com with ESMTPSA id 7sm111242704wrc.81.2019.04.09.02.13.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Apr 2019 02:13:02 -0700 (PDT)
Date:   Tue, 9 Apr 2019 11:13:00 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH RFC 0/4] vsock/virtio: optimizations to increase the
 throughput
Message-ID: <20190409091300.uozhdyikycb5blmn@steredhat>
References: <20190404105838.101559-1-sgarzare@redhat.com>
 <a98d194d-e257-41ff-82e7-de2d16d2f4d4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a98d194d-e257-41ff-82e7-de2d16d2f4d4@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2019 at 02:43:28PM +0800, Jason Wang wrote:
> 
> On 2019/4/4 下午6:58, Stefano Garzarella wrote:
> > This series tries to increase the throughput of virtio-vsock with slight
> > changes:
> >   - patch 1/4: reduces the number of credit update messages sent to the
> >                transmitter
> >   - patch 2/4: allows the host to split packets on multiple buffers,
> >                in this way, we can remove the packet size limit to
> >                VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE
> >   - patch 3/4: uses VIRTIO_VSOCK_MAX_PKT_BUF_SIZE as the max packet size
> >                allowed
> >   - patch 4/4: increases RX buffer size to 64 KiB (affects only host->guest)
> > 
> > RFC:
> >   - maybe patch 4 can be replaced with multiple queues with different
> >     buffer sizes or using EWMA to adapt the buffer size to the traffic
> 
> 
> Or EWMA + mergeable rx buffer, but if we decide to unify the datapath with
> virtio-net, we can reuse their codes.
> 
> 
> > 
> >   - as Jason suggested in a previous thread [1] I'll evaluate to use
> >     virtio-net as transport, but I need to understand better how to
> >     interface with it, maybe introducing sk_buff in virtio-vsock.
> > 
> > Any suggestions?
> 
> 
> My understanding is this is not a must, but if it makes things easier, we
> can do this.

Hopefully it should simplify the maintainability and avoid duplicated code.

> 
> Another thing that may help is to implement sendpage(), which will greatly
> improve the performance.

Thanks for your suggestions!
I'll try to implement sendpage() in VSOCK to measure the improvement.

Cheers,
Stefano
