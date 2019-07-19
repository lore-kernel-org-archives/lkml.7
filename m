Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1672C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 09:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B09622184E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 09:20:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbfGSJUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 05:20:17 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36922 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfGSJUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 05:20:17 -0400
Received: by mail-wm1-f65.google.com with SMTP id f17so28292652wme.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 02:20:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=d7xtP+xXY/V65lMm7hyePdSkWsPyNf2dDv+CiXw5rLE=;
        b=HAXlUGkuj0cVRJHMz165lGn0sA2Az+U//rW2K1KNfzt6vkirB2Be3m2R2Fg+FLixBd
         DuTLlva6HZES389JfvBXzl0Ycb/sDKlVRpyLpnccTAd/erU7Dbx6CtVLys4pxDJzW0kz
         wrecOEcA+LRK4jF5KB1k6AYFYbmD8XXMwqzooHtXVG5SgI+t/WLtOQBVUoU3KzreQLtN
         PHSgGLNybIlYlSXkvXdG63qbNrcP7m3Z+yi0sa+H2Sv48eWCwqc5TnHpJMQVeQBbCWd4
         D9T0YDtVBpZXvYoyqGVbwzuR+3LrNpuoChHXRpd+oiZ3qnYQZKUUYnf2R9O3nCbSasgC
         zR7w==
X-Gm-Message-State: APjAAAVIydpMxdwNy3/A0rZTLuHH958kuLd9z1Nl4rlgThVc2uUo263E
        8QqHDFX+MB1nwRnnD9Hxc+LRvhoPsnA=
X-Google-Smtp-Source: APXvYqy62hSCfG9ct3WGUrLI/2F1gd44Qr2LvGY4D/nvEZf/p8Jwws1gAc8sewlXn3W8/m75H0THhw==
X-Received: by 2002:a1c:44d7:: with SMTP id r206mr48394331wma.164.1563528014194;
        Fri, 19 Jul 2019 02:20:14 -0700 (PDT)
Received: from steredhat (host122-201-dynamic.13-79-r.retail.telecomitalia.it. [79.13.201.122])
        by smtp.gmail.com with ESMTPSA id l8sm50906682wrg.40.2019.07.19.02.20.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 19 Jul 2019 02:20:13 -0700 (PDT)
Date:   Fri, 19 Jul 2019 11:20:11 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org
Subject: Re: [PATCH v4 4/5] vhost/vsock: split packets to send using multiple
 buffers
Message-ID: <20190719092011.czzju7lepn3lv3up@steredhat>
References: <20190717113030.163499-5-sgarzare@redhat.com>
 <20190717105336-mutt-send-email-mst@kernel.org>
 <CAGxU2F45v40qAOHkm1Hk2E69gCS0UwVgS5NS+tDXXuzdF4EixA@mail.gmail.com>
 <20190718041234-mutt-send-email-mst@kernel.org>
 <CAGxU2F6oo7Cou7t9o=gG2=wxHMKX9xYQXNxVtDYeHq5fyEhJWg@mail.gmail.com>
 <20190718072741-mutt-send-email-mst@kernel.org>
 <20190719080832.7hoeus23zjyrx3cc@steredhat>
 <fcd19719-e5a9-adad-1e6c-c84487187088@redhat.com>
 <20190719083920.67qo2umpthz454be@steredhat>
 <53da84b9-184f-1377-0582-ab7cf42ebdb6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <53da84b9-184f-1377-0582-ab7cf42ebdb6@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 04:51:00PM +0800, Jason Wang wrote:
> 
> On 2019/7/19 下午4:39, Stefano Garzarella wrote:
> > On Fri, Jul 19, 2019 at 04:21:52PM +0800, Jason Wang wrote:
> > > On 2019/7/19 下午4:08, Stefano Garzarella wrote:
> > > > On Thu, Jul 18, 2019 at 07:35:46AM -0400, Michael S. Tsirkin wrote:
> > > > > On Thu, Jul 18, 2019 at 11:37:30AM +0200, Stefano Garzarella wrote:
> > > > > > On Thu, Jul 18, 2019 at 10:13 AM Michael S. Tsirkin<mst@redhat.com>  wrote:
> > > > > > > On Thu, Jul 18, 2019 at 09:50:14AM +0200, Stefano Garzarella wrote:
> > > > > > > > On Wed, Jul 17, 2019 at 4:55 PM Michael S. Tsirkin<mst@redhat.com>  wrote:
> > > > > > > > > On Wed, Jul 17, 2019 at 01:30:29PM +0200, Stefano Garzarella wrote:
> > > > > > > > > > If the packets to sent to the guest are bigger than the buffer
> > > > > > > > > > available, we can split them, using multiple buffers and fixing
> > > > > > > > > > the length in the packet header.
> > > > > > > > > > This is safe since virtio-vsock supports only stream sockets.
> > > > > > > > > > 
> > > > > > > > > > Signed-off-by: Stefano Garzarella<sgarzare@redhat.com>
> > > > > > > > > So how does it work right now? If an app
> > > > > > > > > does sendmsg with a 64K buffer and the other
> > > > > > > > > side publishes 4K buffers - does it just stall?
> > > > > > > > Before this series, the 64K (or bigger) user messages was split in 4K packets
> > > > > > > > (fixed in the code) and queued in an internal list for the TX worker.
> > > > > > > > 
> > > > > > > > After this series, we will queue up to 64K packets and then it will be split in
> > > > > > > > the TX worker, depending on the size of the buffers available in the
> > > > > > > > vring. (The idea was to allow EWMA or a configuration of the buffers size, but
> > > > > > > > for now we postponed it)
> > > > > > > Got it. Using workers for xmit is IMHO a bad idea btw.
> > > > > > > Why is it done like this?
> > > > > > Honestly, I don't know the exact reasons for this design, but I suppose
> > > > > > that the idea was to have only one worker that uses the vring, and
> > > > > > multiple user threads that enqueue packets in the list.
> > > > > > This can simplify the code and we can put the user threads to sleep if
> > > > > > we don't have "credit" available (this means that the receiver doesn't
> > > > > > have space to receive the packet).
> > > > > I think you mean the reverse: even without credits you can copy from
> > > > > user and queue up data, then process it without waking up the user
> > > > > thread.
> > > > I checked the code better, but it doesn't seem to do that.
> > > > The .sendmsg callback of af_vsock, check if the transport has space
> > > > (virtio-vsock transport returns the credit available). If there is no
> > > > space, it put the thread to sleep on the 'sk_sleep(sk)' wait_queue.
> > > > 
> > > > When the transport receives an update of credit available on the other
> > > > peer, it calls 'sk->sk_write_space(sk)' that wakes up the thread
> > > > sleeping, that will queue the new packet.
> > > > 
> > > > So, in the current implementation, the TX worker doesn't check the
> > > > credit available, it only sends the packets.
> > > > 
> > > > > Does it help though? It certainly adds up work outside of
> > > > > user thread context which means it's not accounted for
> > > > > correctly.
> > > > I can try to xmit the packet directly in the user thread context, to see
> > > > the improvements.
> > > 
> > > It will then looks more like what virtio-net (and other networking device)
> > > did.
> > I'll try ASAP, the changes should not be too complicated... I hope :)
> > 
> > > 
> > > > > Maybe we want more VQs. Would help improve parallelism. The question
> > > > > would then become how to map sockets to VQs. With a simple hash
> > > > > it's easy to create collisions ...
> > > > Yes, more VQs can help but the map question is not simple to answer.
> > > > Maybe we can do an hash on the (cid, port) or do some kind of estimation
> > > > of queue utilization and try to balance.
> > > > Should the mapping be unique?
> > > 
> > > It sounds to me you want some kind of fair queuing? We've already had
> > > several qdiscs that do this.
> > Thanks for pointing it out!
> > 
> > > So if we use the kernel networking xmit path, all those issues could be
> > > addressed.
> > One more point to AF_VSOCK + net-stack, but we have to evaluate possible
> > drawbacks in using the net-stack. (e.g. more latency due to the complexity
> > of the net-stack?)
> 
> 
> Yes, we need benchmark the performance. But as we've noticed, current vsock
> implementation is not efficient, and for stream socket, the overhead should
> be minimal. The most important thing is to avoid reinventing things that has
> already existed.

Got it. I completely agree with you, and I want to avoid reinventing things
(surely in a worse way).

But the idea (suggested also by Micheal) to discover how fast can go a
new protocol separate from the networking stack, is quite attractive :)

Thanks,
Stefano
