Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E6AC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 15:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7617216C8
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 15:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbfG2PhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 11:37:02 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40256 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbfG2PhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 11:37:01 -0400
Received: by mail-wr1-f68.google.com with SMTP id r1so62357724wrl.7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 08:36:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kbdqHLDZjC9a+s2gzn3LKNYZtrgZuml85rJixr3NhMA=;
        b=WpEpoZQZZ9PDYpfnO7sTpeHWy1slYQ9JUt3NCK1aXFPqPAfgRIhMG17DK5BIbefwnZ
         XTJa2sVb5R7Q0QSQOIbgdnMLiE7s5EUcOvMb6SBm4BGKkp3GyOdpgHUQecn+OfJ69g6T
         D0oN4rXaoeIC95gRUmz8yb88OyoF2pVKAQYpf/99OOta6zR3GEQouuSLwEnucsGgfBcK
         1+PD99+YrsOC3ADcaz6X29SK2AYmrRnEO0I3gpuzsmsq2USB30qW199VcdxJDokH87Xo
         z+uMixplN0sKEZbI4ddjIWG+6KT/utCJbfqDUHMQtpqtBclhBtz66aoef/LSBMdvCVQE
         LsEg==
X-Gm-Message-State: APjAAAXJEeqwlcABode0wWNjnYHJLLIX13+KNpT5XCM684ddDEvb8llt
        Rj8DLDcNGPpl3HEJw/fXjxX2bQ==
X-Google-Smtp-Source: APXvYqyIgEmmE4cqBkrJP3fc56zTUtO2PgG0o7WjOjV8vL0usOvWpBwWKxfFJk/mZ144VJ835dKMgA==
X-Received: by 2002:adf:e705:: with SMTP id c5mr73459454wrm.270.1564414619334;
        Mon, 29 Jul 2019 08:36:59 -0700 (PDT)
Received: from steredhat (host122-201-dynamic.13-79-r.retail.telecomitalia.it. [79.13.201.122])
        by smtp.gmail.com with ESMTPSA id p63sm13455498wmp.45.2019.07.29.08.36.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 08:36:58 -0700 (PDT)
Date:   Mon, 29 Jul 2019 17:36:56 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org
Subject: Re: [PATCH v4 1/5] vsock/virtio: limit the memory used per-socket
Message-ID: <20190729153656.zk4q4rob5oi6iq7l@steredhat>
References: <20190717113030.163499-1-sgarzare@redhat.com>
 <20190717113030.163499-2-sgarzare@redhat.com>
 <20190729095956-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729095956-mutt-send-email-mst@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 10:04:29AM -0400, Michael S. Tsirkin wrote:
> On Wed, Jul 17, 2019 at 01:30:26PM +0200, Stefano Garzarella wrote:
> > Since virtio-vsock was introduced, the buffers filled by the host
> > and pushed to the guest using the vring, are directly queued in
> > a per-socket list. These buffers are preallocated by the guest
> > with a fixed size (4 KB).
> > 
> > The maximum amount of memory used by each socket should be
> > controlled by the credit mechanism.
> > The default credit available per-socket is 256 KB, but if we use
> > only 1 byte per packet, the guest can queue up to 262144 of 4 KB
> > buffers, using up to 1 GB of memory per-socket. In addition, the
> > guest will continue to fill the vring with new 4 KB free buffers
> > to avoid starvation of other sockets.
> > 
> > This patch mitigates this issue copying the payload of small
> > packets (< 128 bytes) into the buffer of last packet queued, in
> > order to avoid wasting memory.
> > 
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> 
> This is good enough for net-next, but for net I think we
> should figure out how to address the issue completely.
> Can we make the accounting precise? What happens to
> performance if we do?
> 

In order to do more precise accounting maybe we can use the buffer size,
instead of payload size when we update the credit available.
In this way, the credit available for each socket will reflect the memory
actually used.

I should check better, because I'm not sure what happen if the peer sees
1KB of space available, then it sends 1KB of payload (using a 4KB
buffer).

The other option is to copy each packet in a new buffer like I did in
the v2 [2], but this forces us to make a copy for each packet that does
not fill the entire buffer, perhaps too expensive.

[2] https://patchwork.kernel.org/patch/10938741/


Thanks,
Stefano
