Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 145B4C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1102206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbfG2Qlk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 12:41:40 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36977 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbfG2Qlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 12:41:39 -0400
Received: by mail-oi1-f193.google.com with SMTP id t76so45769856oih.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 09:41:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qEnidYZvMtI0djmi8U0ZEWcmJ8XfKi49GrC/Gx0OghM=;
        b=LAUdTEN33lwGb3Dhe7Qy00N2LdOn3/Q2wyCkXxtLpdrrcyJMlbEwsDjDuFAShEc/Wz
         dm/bZQ+2+qm+aXVYY+pzvgLYIFR/1x6JP80hN6AYirExAnpYme92KT1tkjo011V90Ab0
         mvZPtuifzOlGuZjdtkmgyJ8LxmPFOrWRny2MlnJe2XdOGA9svRVAM4m3ZfDKaNs/NE4h
         prUWlU61Jw1D3b2S3YkA4cnA7lkuLPkWcbZmELgvokQ63aflLRXUCcY9sRP3XojVysWB
         p7Lf2RiXcixeL8WDDUQhZpERJXWpBYZoWxZwXznVKOSmlcnfNpJjvt1aK2N52SOOh6mK
         Z/HA==
X-Gm-Message-State: APjAAAVlhKqGQu0Fbt52nYuj2QU7R3izV/Ey0l1kzZqBrSX2o3SInIa2
        5noZVl0CcB7ArqDqgQf80T336HhvgVIDpJC8Uq4WTA==
X-Google-Smtp-Source: APXvYqwLmyK1E/4jrfGUT98xeH//0WmrilX5ZcE9+u6f94aZr6eu7bn4vAgIsx2aZWLhabtNB/WLd0Vdna3tzy2IXKU=
X-Received: by 2002:aca:1803:: with SMTP id h3mr20756041oih.24.1564418498709;
 Mon, 29 Jul 2019 09:41:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190717113030.163499-1-sgarzare@redhat.com> <20190717113030.163499-2-sgarzare@redhat.com>
 <20190729095956-mutt-send-email-mst@kernel.org> <20190729153656.zk4q4rob5oi6iq7l@steredhat>
 <20190729115904-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190729115904-mutt-send-email-mst@kernel.org>
From:   Stefano Garzarella <sgarzare@redhat.com>
Date:   Mon, 29 Jul 2019 18:41:27 +0200
Message-ID: <CAGxU2F5F1KcaFNJ6n7++ApZiYMGnoEWKVRgo3Vc4h5hpxSJEZg@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] vsock/virtio: limit the memory used per-socket
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 12:01:37PM -0400, Michael S. Tsirkin wrote:
> On Mon, Jul 29, 2019 at 05:36:56PM +0200, Stefano Garzarella wrote:
> > On Mon, Jul 29, 2019 at 10:04:29AM -0400, Michael S. Tsirkin wrote:
> > > On Wed, Jul 17, 2019 at 01:30:26PM +0200, Stefano Garzarella wrote:
> > > > Since virtio-vsock was introduced, the buffers filled by the host
> > > > and pushed to the guest using the vring, are directly queued in
> > > > a per-socket list. These buffers are preallocated by the guest
> > > > with a fixed size (4 KB).
> > > >
> > > > The maximum amount of memory used by each socket should be
> > > > controlled by the credit mechanism.
> > > > The default credit available per-socket is 256 KB, but if we use
> > > > only 1 byte per packet, the guest can queue up to 262144 of 4 KB
> > > > buffers, using up to 1 GB of memory per-socket. In addition, the
> > > > guest will continue to fill the vring with new 4 KB free buffers
> > > > to avoid starvation of other sockets.
> > > >
> > > > This patch mitigates this issue copying the payload of small
> > > > packets (< 128 bytes) into the buffer of last packet queued, in
> > > > order to avoid wasting memory.
> > > >
> > > > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > >
> > > This is good enough for net-next, but for net I think we
> > > should figure out how to address the issue completely.
> > > Can we make the accounting precise? What happens to
> > > performance if we do?
> > >
> >
> > In order to do more precise accounting maybe we can use the buffer size,
> > instead of payload size when we update the credit available.
> > In this way, the credit available for each socket will reflect the memory
> > actually used.
> >
> > I should check better, because I'm not sure what happen if the peer sees
> > 1KB of space available, then it sends 1KB of payload (using a 4KB
> > buffer).
> > The other option is to copy each packet in a new buffer like I did in
> > the v2 [2], but this forces us to make a copy for each packet that does
> > not fill the entire buffer, perhaps too expensive.
> >
> > [2] https://patchwork.kernel.org/patch/10938741/
> >
>
> So one thing we can easily do is to under-report the
> available credit. E.g. if we copy up to 256bytes,
> then report just 256bytes for every buffer in the queue.
>

Ehm sorry, I got lost :(
Can you explain better?


Thanks,
Stefano
