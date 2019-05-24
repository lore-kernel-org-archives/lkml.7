Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C6DC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 16:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4475A21773
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 16:34:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=appneta.com header.i=@appneta.com header.b="RTj7+3ho"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391018AbfEXQe5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 12:34:57 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40491 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390392AbfEXQe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 12:34:57 -0400
Received: by mail-pg1-f194.google.com with SMTP id d30so5336554pgm.7
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 09:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=appneta.com; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=jMjLROklthN+O3Df8yt9TlHidscQVhl/xhe8VKBhLw0=;
        b=RTj7+3ho4OVZTP8Zx35lNiConf8t4mXw1wlWc21/pod0vTNlY8j/MoTM0eGPSLppM8
         sRyavB6yAVpbZgB5HE7IGIRsBTgCs3ES4GnUhWYZCLSSRaWgr4T1k1akNZEbyenwNpap
         KmziuotEvNKVL9Agwn8XZS8+K+40oh3/C2Teo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=jMjLROklthN+O3Df8yt9TlHidscQVhl/xhe8VKBhLw0=;
        b=KxyhalEVDR17ecjAFxr9CoXWIAcL9RcQ2e3YKlyUxRB7woocmnkOh50U7ZrHVWQxta
         +7fO/CN9L7lKi+Sg2AxJjY3j3FQXBDMFlEYcYXmOuw5k56wTVCGR3mCvfyeu6sqysZ/F
         kBbBNlvS2NAJdlRrnNOlCMTK4hk1+TVZUwC8Vmy1ZgYK+Pz89DpPMD9kU+sep8AOKodT
         KfgKzE2x176n1rQtX3Uc0EEbZdFJXUMpXsSVTqgeso0xdKyo4rsFdIUhF7TGE7yPOJnL
         lwyLNazNrPD4s89o3X/mAK2V+iaZalhiC0pelRsqD/vFnTG56qglE6iWVezmZ+nB4XAr
         0mMA==
X-Gm-Message-State: APjAAAU2LEf6MSov0NQhxNMtcwxmhp/r3wLoQrKVMvdqq+QpfydZRUBN
        IA8JCbBxH8qx4S5CCCkAvwxqSw==
X-Google-Smtp-Source: APXvYqyx2N/q7mx3gGOoUYMl3j9OfFC00BbVqsItAFzefwBvP16+2eS7FZ9WPkOnQwkTuBN0z2WxYQ==
X-Received: by 2002:a17:90a:d16:: with SMTP id t22mr10712067pja.130.1558715695943;
        Fri, 24 May 2019 09:34:55 -0700 (PDT)
Received: from jltm109.jaalam.net (vancouver-a.appneta.com. [209.139.228.33])
        by smtp.gmail.com with ESMTPSA id l65sm4818808pfb.7.2019.05.24.09.34.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 09:34:55 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH net 1/4] net/udp_gso: Allow TX timestamp with UDP GSO
From:   Fred Klassen <fklassen@appneta.com>
In-Reply-To: <CAF=yD-LtAKpND601LQrC1+=iF6spSUXVdUapcsbJdv5FYa=5Jg@mail.gmail.com>
Date:   Fri, 24 May 2019 09:34:54 -0700
Cc:     "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Shuah Khan <shuah@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        Willem de Bruijn <willemb@google.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <AFC1ECC8-BFAC-4718-B0C9-97CC4BD1F397@appneta.com>
References: <20190523210651.80902-1-fklassen@appneta.com>
 <20190523210651.80902-2-fklassen@appneta.com>
 <CAF=yD-Jf95De=z_nx9WFkGDa6+nRUqM_1PqGkjwaFPzOe+PfXg@mail.gmail.com>
 <AE8E0772-7256-4B9C-A990-96930E834AEE@appneta.com>
 <CAF=yD-LtAKpND601LQrC1+=iF6spSUXVdUapcsbJdv5FYa=5Jg@mail.gmail.com>
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Interesting. TCP timestamping takes the opposite choice and does
> timestamp the last byte in the sendmsg request.
>=20

I have a difficult time with the philosophy of TX timestamping the last
segment. The actual timestamp occurs just before the last segment
is sent. This is neither the start  nor the end of a GSO packet, which
to me seems somewhat arbitrary. It is even more arbitrary when using
software TX tiimestamping. These are timestamps represent the
time that the packet is queued onto the NIC=E2=80=99s buffer, not actual
time leaving the wire. Queuing to a ring buffer is usually much faster
than wire rates. Therefore, say the timestamp of the last 1500 byte=20
segment of a 64K GSO packet may in reality be representing a time
about half way through the burst.

Since the timestamp of a TX packet occurs just before any data is sent,
I have found it most valuable to timestamp just before the first byte of=20=

the packet or burst. Conversely, I find it most valuable to get an RX
timestamp  after the last byte arrives.

> It sounds like it depends on the workload. Perhaps this then needs to
> be configurable with an SOF_.. flag.
>=20

It would be interesting if a practical case can be made for timestamping
the last segment. In my mind, I don=E2=80=99t see how that would be =
valuable.

> Another option would be to return a timestamp for every segment. But
> they would all return the same tskey. And it causes different behavior
> with and without hardware offload.

When it comes to RX packets, getting per-packet (or per segment)
timestamps is invaluable. They represent actual wire times. However
my previous research into TX timestamping has led me to conclude
that there is no practical value when timestamping every packet of=20
a back-to-back burst.

When using software TX timestamping, The inter-packet timestamps
are typically much faster than line rate. Whereas you may be sending
on a GigE link, you may measure 20Gbps. At higher rates, I have found
that the overhead of per-packet software timestamping can produce
gaps in packets.

When using hardware timestamping, I think you will find that nearly all
adapters only allow one timestamp at a time. Therefore only one
packet in a burst would get timestamped. There are exceptions, for
example I am playing with a 100G Mellanox adapter that has
per-packet TX timestamping. However, I suspect that when I am
done testing, all I will see is timestamps that are representing wire
rate (e.g. 123nsec per 1500 byte packet).

Beyond testing the accuracy of a NIC=E2=80=99s timestamping =
capabilities, I
see very little value in doing per-segment timestamping.


