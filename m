Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17AD4C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 19:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6A24205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 19:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V1rGNnwt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfK0Tsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 14:48:53 -0500
Received: from mail-yb1-f181.google.com ([209.85.219.181]:44085 "EHLO
        mail-yb1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbfK0Tsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 14:48:52 -0500
Received: by mail-yb1-f181.google.com with SMTP id g38so9451980ybe.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 11:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C7mf6B1IgGIf5vyQN7hY5uSctDozwwpAw15AYVyo+Vc=;
        b=V1rGNnwtITLqT0beOJAg/q2vrY+logPoEpD8UKr85lNI6qZqxfA9cOmBAjaJbano7D
         QP93VYHUxbGz/2cGus6in9tCpm7ZcxQ8TS3yrZK6vOfq0EYUo1ln9NXgVqImkySVYgVm
         zILb+5zLvRn2pRYAUsubFAmldk1ROFRQKcCtUiESMkX2Pd/biZFvJUgx5pLDm6cOPOTX
         p2qwHiCMhIUZIo8L4qVjBYqUu/zBIuHd4naMJoR0pZcAhtbscyXOybYGnzFoeJj+Emb7
         QuaYcynZRc409NKG+W1dp8CpXhTxyoChcW93U1tu3wIju9Aoa33RdtPdsOfZAEqfth3y
         RjFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C7mf6B1IgGIf5vyQN7hY5uSctDozwwpAw15AYVyo+Vc=;
        b=dUBsbLqUvbvf+IyfnLi96ONe2u9PGBMozmDiVU8awGVAc7n/fK2rjAjgqZ/t1nBk/k
         eukQX6uBcegKLjiKFv/Y3HUidPpdkZUNwgOSuA5uNwfcv+8FjOM8eD5FPDAvrhJ6zX84
         hSprhD3edyI4l80ENfGEfb38UBHTNZOiymgYvSpUNV9H+Fxc2xmZ6Scfh4H+OX0lHsz9
         Y0cCN4BarNHevdyJP8GE5EbSMVqZHt/Yu3oa34uQ8C8zmVfG7/HAbu2SdfyAq3F55VNZ
         DcF61GMc4ESxTwvlynQpYKXU9SSFwaK0ZHmnM7wHFscc7tA6le9e4LpdbhoD0Yf5dRrt
         iEYQ==
X-Gm-Message-State: APjAAAUqFttarQG0qNVF9LvCuNy1WP7EBSyhzzKWbmRObxj+1we8as+Q
        I4/YfBpQ+u4IDEkctX6o+ai9Fs/f
X-Google-Smtp-Source: APXvYqzJ5fykla57Il22T5TsDHX1d2Z5ZkVj/9eU8UNhV81NZvvde2iXrAUIKZ4sheEplGz02i9OWw==
X-Received: by 2002:a25:be51:: with SMTP id d17mr32089721ybm.56.1574884130590;
        Wed, 27 Nov 2019 11:48:50 -0800 (PST)
Received: from mail-yw1-f49.google.com (mail-yw1-f49.google.com. [209.85.161.49])
        by smtp.gmail.com with ESMTPSA id w74sm7146044ywd.17.2019.11.27.11.48.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2019 11:48:49 -0800 (PST)
Received: by mail-yw1-f49.google.com with SMTP id 4so8423458ywx.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 11:48:49 -0800 (PST)
X-Received: by 2002:a0d:d911:: with SMTP id b17mr4339680ywe.269.1574884128590;
 Wed, 27 Nov 2019 11:48:48 -0800 (PST)
MIME-Version: 1.0
References: <bc84e68c0980466096b0d2f6aec95747@AcuMS.aculab.com>
 <CAJPywTJYDxGQtDWLferh8ObjGp3JsvOn1om1dCiTOtY6S3qyVg@mail.gmail.com>
 <5f4028c48a1a4673bd3b38728e8ade07@AcuMS.aculab.com> <20191127164821.1c41deff@carbon>
 <5eecf41c7e124d7dbc0ab363d94b7d13@AcuMS.aculab.com>
In-Reply-To: <5eecf41c7e124d7dbc0ab363d94b7d13@AcuMS.aculab.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Wed, 27 Nov 2019 14:48:12 -0500
X-Gmail-Original-Message-ID: <CA+FuTSe8vfEME7EO6xru=i1++OWCNRJGePLNCzta+BVv_TY3Zw@mail.gmail.com>
Message-ID: <CA+FuTSe8vfEME7EO6xru=i1++OWCNRJGePLNCzta+BVv_TY3Zw@mail.gmail.com>
Subject: Re: epoll_wait() performance
To:     David Laight <David.Laight@aculab.com>
Cc:     Jesper Dangaard Brouer <brouer@redhat.com>,
        Marek Majkowski <marek@cloudflare.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        network dev <netdev@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>,
        Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2019 at 11:04 AM David Laight <David.Laight@aculab.com> wrote:
>
> From: Jesper Dangaard Brouer
> > Sent: 27 November 2019 15:48
> > On Wed, 27 Nov 2019 10:39:44 +0000 David Laight <David.Laight@ACULAB.COM> wrote:
> >
> > > ...
> > > > > While using recvmmsg() to read multiple messages might seem a good idea, it is much
> > > > > slower than recv() when there is only one message (even recvmsg() is a lot slower).
> > > > > (I'm not sure why the code paths are so slow, I suspect it is all the copy_from_user()
> > > > > and faffing with the user iov[].)
> > > > >
> > > > > So using poll() we repoll the fd after calling recv() to find is there is a second message.
> > > > > However the second poll has a significant performance cost (but less than using recvmmsg()).
> > > >
> > > > That sounds wrong. Single recvmmsg(), even when receiving only a
> > > > single message, should be faster than two syscalls - recv() and
> > > > poll().
> > >
> > > My suspicion is the extra two copy_from_user() needed for each recvmsg are a
> > > significant overhead, most likely due to the crappy code that tries to stop
> > > the kernel buffer being overrun.
> > >
> > > I need to run the tests on a system with a 'home built' kernel to see how much
> > > difference this make (by seeing how much slower duplicating the copy makes it).
> > >
> > > The system call cost of poll() gets factored over a reasonable number of sockets.
> > > So doing poll() on a socket with no data is a lot faster that the setup for recvmsg
> > > even allowing for looking up the fd.
> > >
> > > This could be fixed by an extra flag to recvmmsg() to indicate that you only really
> > > expect one message and to call the poll() function before each subsequent receive.
> > >
> > > There is also the 'reschedule' that Eric added to the loop in recvmmsg.
> > > I don't know how much that actually costs.
> > > In this case the process is likely to be running at a RT priority and pinned to a cpu.
> > > In some cases the cpu is also reserved (at boot time) so that 'random' other code can't use it.
> > >
> > > We really do want to receive all these UDP packets in a timely manner.
> > > Although very low latency isn't itself an issue.
> > > The data is telephony audio with (typically) one packet every 20ms.
> > > The code only looks for packets every 10ms - that helps no end since, in principle,
> > > only a single poll()/epoll_wait() call (on all the sockets) is needed every 10ms.
> >
> > I have a simple udp_sink tool[1] that cycle through the different
> > receive socket system calls.  I gave it a quick spin on a F31 kernel
> > 5.3.12-300.fc31.x86_64 on a mlx5 100G interface, and I'm very surprised
> > to see a significant regression/slowdown for recvMmsg.
> >
> > $ sudo ./udp_sink --port 9 --repeat 1 --count $((10**7))
> >               run      count          ns/pkt  pps             cycles  payload
> > recvMmsg/32   run:  0 10000000        1461.41 684270.96       5261    18       demux:1
> > recvmsg       run:  0 10000000        889.82  1123824.84      3203    18       demux:1
> > read          run:  0 10000000        974.81  1025841.68      3509    18       demux:1
> > recvfrom      run:  0 10000000        1056.51 946513.44       3803    18       demux:1
> >
> > Normal recvmsg almost have double performance that recvmmsg.
> >  recvMmsg/32 = 684,270 pps
> >  recvmsg     = 1,123,824 pps
>
> Can you test recv() as well?
> I think it might be faster than read().
>
> ...
> > Found some old results (approx v4.10-rc1):
> >
> > [brouer@skylake src]$ sudo taskset -c 2 ./udp_sink --count $((10**7)) --port 9 --connect
> >  recvMmsg/32    run: 0 10000000 537.89  1859106.74      2155    21559353816
> >  recvmsg        run: 0 10000000 552.69  1809344.44      2215    22152468673
> >  read           run: 0 10000000 476.65  2097970.76      1910    19104864199
> >  recvfrom       run: 0 10000000 450.76  2218492.60      1806    18066972794
>
> That is probably nearer what I am seeing on a 4.15 Ubuntu 18.04 kernel.
> recvmmsg() and recvmsg() are similar - but both a lot slower then recv().

Indeed, surprising that recv(from) would be less efficient than recvmsg.

Are the latest numbers with CONFIG_HARDENED_USERCOPY?

I assume that the poll() after recv() is non-blocking. If using
recvmsg, that extra syscall could be avoided by implementing a cmsg
inq hint for udp sockets analogous to TCP_CM_INQ/tcp_inq_hint.

More outlandish would be to abuse the mmsghdr->msg_len field to pass
file descriptors and amortize the kernel page-table isolation cost
across sockets. Blocking semantics would be weird, for starters.
