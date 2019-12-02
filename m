Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EBF7C432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 16:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AE1D2071F
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 16:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jwrHA4kF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbfLBQro (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 11:47:44 -0500
Received: from mail-yb1-f170.google.com ([209.85.219.170]:37493 "EHLO
        mail-yb1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727438AbfLBQro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 11:47:44 -0500
Received: by mail-yb1-f170.google.com with SMTP id q7so232017ybk.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 08:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2tHpqN0A+VQqqDCB4U60Obh3vL6s2YCa8Z42QOlXUJY=;
        b=jwrHA4kFOPjKjldrEHyPZexm/nKkSJEMJuLFR20LZPDiUuWoMbPCVo5uXxRK9xZfvK
         BBlsVaCWceHlEsYqYf4pj6SCu1UxF0JEmB0RtlXi6Y15275VcQh1UdYvdz0cE5IxxjjG
         /pVqGlctT+gEuPrOfFaHHx9U5Y+lzUhH3+FAJzxZXSs2AWXF6lDptdvnzIq3QagYsnhl
         oUFlPEMxqInhWoTA3hccmC8+R/vdetdjfza/nk3qbLVYbxYoD5ZlVSqzH60rsS3bmCRJ
         qt4DWhR78dkef9em+KhGZLDlWBN75UTdMQfI6rxMtTYkqP+VOQ2q9auCIV2zJJ0h1XBa
         pcNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2tHpqN0A+VQqqDCB4U60Obh3vL6s2YCa8Z42QOlXUJY=;
        b=pvB/jg9bTiMAQ8aXqQy1LrzWe8nuQ8F/cMp4kYRc9DDh4tOpUz6omWH139cLhzRwx4
         vgSPh4D/1m2chaCG2sZpOuVL09nNZ+XyW6GZLSGd+Jr8hppMj3V0ZIX8LMsEhoJxD9tj
         vZ5y5RZ9T2cMUz5JIPVD1XFQcANTJT+8aoLUf3In0K5yIzqXS99/5FVVDEDfnUfyElkd
         zwMUoVVPaAKqKLIT8+f0wJygx9NKf/5WCPuV3HPpWpQSHrtE6RH3lwNNFSg3KSkM6G2A
         c5gWfQUYlDk2DwNcPoPDPkS9bekzVoraMpptxKXXR1Vk7Fevy1q3YUTZUXW3PFO0oCat
         b5aQ==
X-Gm-Message-State: APjAAAXGP2qLUOK/s33oBDqn2g3Mq5HeWh+E4dlemZ+6wbQ/0cktb/r3
        BbGuRi+fJrECHjmL+DYLIpcCwSem
X-Google-Smtp-Source: APXvYqwsEMJXeXBTDP9A6TR+3U6CrBIQBgOcyurRuzUqonTmTfBlGJWgoTBvpJAChkK1yyxHs1sq4g==
X-Received: by 2002:a5b:78d:: with SMTP id b13mr249290ybq.157.1575305261935;
        Mon, 02 Dec 2019 08:47:41 -0800 (PST)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id n18sm65238ywd.50.2019.12.02.08.47.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2019 08:47:40 -0800 (PST)
Received: by mail-yb1-f172.google.com with SMTP id v2so234059ybo.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 08:47:39 -0800 (PST)
X-Received: by 2002:a25:583:: with SMTP id 125mr248789ybf.89.1575305259203;
 Mon, 02 Dec 2019 08:47:39 -0800 (PST)
MIME-Version: 1.0
References: <bc84e68c0980466096b0d2f6aec95747@AcuMS.aculab.com>
 <CAJPywTJYDxGQtDWLferh8ObjGp3JsvOn1om1dCiTOtY6S3qyVg@mail.gmail.com>
 <5f4028c48a1a4673bd3b38728e8ade07@AcuMS.aculab.com> <20191127164821.1c41deff@carbon>
 <0b8d7447e129539aec559fa797c07047f5a6a1b2.camel@redhat.com>
 <2f1635d9300a4bec8a0422e9e9518751@AcuMS.aculab.com> <313204cf-69fd-ec28-a22c-61526f1dea8b@gmail.com>
 <1265e30d04484d08b86ba2abef5f5822@AcuMS.aculab.com> <c46e43d1-ba7d-39d9-688f-0141931df1b0@gmail.com>
 <878snxo5kq.fsf@cloudflare.com> <40f7b16289274e10a30f5d8c6e2cdf08@AcuMS.aculab.com>
In-Reply-To: <40f7b16289274e10a30f5d8c6e2cdf08@AcuMS.aculab.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Mon, 2 Dec 2019 11:47:02 -0500
X-Gmail-Original-Message-ID: <CA+FuTScyuW9v7w4Jzqa6vEav+pKvFySfzJuzb5Xc7ogxX=yWCA@mail.gmail.com>
Message-ID: <CA+FuTScyuW9v7w4Jzqa6vEav+pKvFySfzJuzb5Xc7ogxX=yWCA@mail.gmail.com>
Subject: Re: epoll_wait() performance
To:     David Laight <David.Laight@aculab.com>
Cc:     Jakub Sitnicki <jakub@cloudflare.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Marek Majkowski <marek@cloudflare.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        network dev <netdev@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 2, 2019 at 7:24 AM David Laight <David.Laight@aculab.com> wrote:
>
> From: Jakub Sitnicki <jakub@cloudflare.com>
> > Sent: 30 November 2019 13:30
> > On Sat, Nov 30, 2019 at 02:07 AM CET, Eric Dumazet wrote:
> > > On 11/28/19 2:17 AM, David Laight wrote:
> ...
> > >> How can you do that when all the UDP flows have different destination port numbers?
> > >> These are message flows not idempotent requests.
> > >> I don't really want to collect the packets before they've been processed by IP.
> > >>
> > >> I could write a driver that uses kernel udp sockets to generate a single message queue
> > >> than can be efficiently processed from userspace - but it is a faff compiling it for
> > >> the systems kernel version.
> > >
> > > Well if destinations ports are not under your control,
> > > you also could use AF_PACKET sockets, no need for 'UDP sockets' to receive UDP traffic,
> > > especially it the rate is small.
> >
> > Alternatively, you could steer UDP flows coming to a certain port range
> > to one UDP socket using TPROXY [0, 1].
>
> I don't think that can work, we don't really know the list of valid UDP port
> numbers ahead of time.

How about -j REDIRECT. That does not require all ports to be known
ahead of time.

> > TPROXY has the same downside as AF_PACKET, meaning that it requires at
> > least CAP_NET_RAW to create/set up the socket.
>
> CAP_NET_RAW wouldn't be a problem - we already send from a 'raw' socket.

One other issue when comparing udp and packet sockets is ip
defragmentation. That is critical code that is not at all trivial to
duplicate in userspace.

Even when choosing packet sockets, which normally would not
defragment, there is a trick. A packet socket with fanout and flag
PACKET_FANOUT_FLAG_DEFRAG will defragment before fanout.
