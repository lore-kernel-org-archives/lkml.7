Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 469D9C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 09:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ED8720678
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 09:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="pBBLnQ1N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbfK0JvJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 04:51:09 -0500
Received: from mail-qv1-f51.google.com ([209.85.219.51]:43245 "EHLO
        mail-qv1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbfK0JvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 04:51:08 -0500
Received: by mail-qv1-f51.google.com with SMTP id cg2so8591259qvb.10
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 01:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H07T8BHh5BcmV80j3lg7IXdBX7ZDvpzBwkD+L/6zGBM=;
        b=pBBLnQ1NyzQyxoM6zl5akl2JKAydiUwno7tA2mwZK83clwOH4PJruUqiaKydGo/wWG
         /C43rPvDuaU9hTqVAPyEsrb+5KQ9cZDEvfHJ364w6GgXKA7KIY7tn6n5LCjd0ZhdTX2H
         pJ1agAMuLszk50LMYYrlc4R61sRY3FnqgMs5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H07T8BHh5BcmV80j3lg7IXdBX7ZDvpzBwkD+L/6zGBM=;
        b=MMUCC5G8+3gsF6Vn/6QccLwRcHCgJe8msaRiFVhdNweG13rYkiygxJJq5HN/7v8Hjh
         90LrUchyAtccRXNDE7SogHTrQcf17GGuUmnmHfSYcOYWJCIDs2B4uzPcw08neiZtKb4n
         wss/oivoruaAnCk2Ib3CUJbxxBHvXM+L32VWXkwbBJWlmRzW1Weenu53tDIg4Qa58FYK
         5Y4oh4vt1zLGbCTQjJlh3CHUrLTkFTQaxg9BFe3HGAeNFLXF74wutyHERIKFb/NYVZJx
         vCKRFp7gB6BDpImJUV0Lu2NTeqMWQ6Oy6McMlg0fS91zDryJIWLPsS6XXvCAn52lDYcA
         pBWg==
X-Gm-Message-State: APjAAAUXdsacPA6xRmoB8v8MtnLSp09F/nJ8pbR2tqbkrW3r+jmv/e5Q
        Lcrka+ecpVPoeYL2no6m6PzXmDb69YvO0HjkaJuHnQ==
X-Google-Smtp-Source: APXvYqzrjvqELTFnUI8Qt8Rmz+NjyPBSdnjdLu3/0P8bQDHlGIKWguE1Ib8kXyYI9epQ0tHjqpx5HfhmtQBnRRqK26A=
X-Received: by 2002:a0c:8e87:: with SMTP id x7mr3797948qvb.112.1574848267041;
 Wed, 27 Nov 2019 01:51:07 -0800 (PST)
MIME-Version: 1.0
References: <bc84e68c0980466096b0d2f6aec95747@AcuMS.aculab.com>
In-Reply-To: <bc84e68c0980466096b0d2f6aec95747@AcuMS.aculab.com>
From:   Marek Majkowski <marek@cloudflare.com>
Date:   Wed, 27 Nov 2019 10:50:55 +0100
Message-ID: <CAJPywTJYDxGQtDWLferh8ObjGp3JsvOn1om1dCiTOtY6S3qyVg@mail.gmail.com>
Subject: Re: epoll_wait() performance
To:     David Laight <David.Laight@aculab.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        network dev <netdev@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 22, 2019 at 12:18 PM David Laight <David.Laight@aculab.com> wrote:
> I'm trying to optimise some code that reads UDP messages (RTP and RTCP) from a lot of sockets.
> The 'normal' data pattern is that there is no data on half the sockets (RTCP) and
> one message every 20ms on the others (RTP).
> However there can be more than one message on each socket, and they all need to be read.
> Since the code processing the data runs every 10ms, the message receiving code
> also runs every 10ms (a massive gain when using poll()).

How many sockets we are talking about? More like 500 or 500k? We had very
bad experience with UDP connected sockets, so if you are using UDP connected
sockets, the RX path is super slow, mostly consumed by udp_lib_lookup()
https://elixir.bootlin.com/linux/v5.4/source/net/ipv4/udp.c#L445

Then we might argue that doing thousands of udp unconnected sockets  - like
192.0.2.1:1234, 192.0.2.2:1234, etc - creates little value. I guess the only
reasonable case for large number of UDP sockets is when you need
large number of source ports.

In such case we experimented with abusing TPROXY:
https://web.archive.org/web/20191115081000/https://blog.cloudflare.com/how-we-built-spectrum/

> While using recvmmsg() to read multiple messages might seem a good idea, it is much
> slower than recv() when there is only one message (even recvmsg() is a lot slower).
> (I'm not sure why the code paths are so slow, I suspect it is all the copy_from_user()
> and faffing with the user iov[].)
>
> So using poll() we repoll the fd after calling recv() to find is there is a second message.
> However the second poll has a significant performance cost (but less than using recvmmsg()).

That sounds wrong. Single recvmmsg(), even when receiving only a
single message, should be faster than two syscalls - recv() and
poll().

> If we use epoll() in level triggered mode a second epoll_wait() call (after the recv()) will
> indicate that there is more data.
>
> For poll() it doesn't make much difference how many fd are supplied to each system call.
> The overall performance is much the same for 32, 64 or 500 (all the sockets).
>
> For epoll_wait() that isn't true.
> Supplying a buffer that is shorter than the list of 'ready' fds gives a massive penalty.
> With a buffer long enough for all the events epoll() is somewhat faster than poll().
> But with a 64 entry buffer it is much slower.
> I've looked at the code and can't see why splicing the unread events back is expensive.

Again, this is surprising.

> I'd like to be able to change the code so that multiple threads are reading from the epoll fd.
> This would mean I'd have to run it in edge mode and each thread reading a smallish
> block of events.
> Any suggestions on how to efficiently read the 'unusual' additional messages from
> the sockets?

Random ideas:
1. Perhaps reducing the number of sockets could help - with iptables or TPROXY.
TPROXY has some performance impact though, so be careful.

2. I played with io_submit for syscall batching, but in my experiments I wasn't
able to show performance boost:
https://blog.cloudflare.com/io_submit-the-epoll-alternative-youve-never-heard-about/
Perhaps the newer io_uring with networking support could help:
https://twitter.com/axboe/status/1195047335182524416

3. SO_BUSYPOLL drastically reduces latency, but I've only used it with
a single socket..

4. If you want to get number of outstanding packets, there is SIOCINQ
and SO_MEMINFO.

My older writeups:
https://blog.cloudflare.com/how-to-receive-a-million-packets/
https://blog.cloudflare.com/how-to-achieve-low-latency/

Cheers,
   Marek

> FWIW the fastest way to read 1 RTP message every 20ms is to do non-blocking recv() every 10ms.
> The failing recv() is actually faster than either epoll() or two poll() actions.
> (Although something is needed to pick up the occasional second message.)
>
>         David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
>
