Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07422C41514
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 06:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D250F206B8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 06:59:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tessares-net.20150623.gappssmtp.com header.i=@tessares-net.20150623.gappssmtp.com header.b="TFFcxvXe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbfICG7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 02:59:12 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:37352 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbfICG7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 02:59:11 -0400
Received: by mail-ot1-f45.google.com with SMTP id 97so12833443otr.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 23:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XvLI4nhOg17VvgP8/NkdRtVRVRohTIN7xR7OZSWHP1E=;
        b=TFFcxvXeswXxwVv57GhiWDQBgHHv/H7/4OZMAf9BgYQgDHX53QtNvtfHSjiBbLXgjR
         afz+gg4hJ+d22XnMwwrShNQZsz0sBIq0X4qA/svjHa99MEmsyFCZY1/IvTgnuKAqwuEw
         oy9QK6fchWFRoVQXPl9BQpy1wr5OhrWFLSbSljSIv5/YAlB0ZtYe4kDV+SsdlOAmaOqU
         8N5AyUqvY9gjo3BRnXawmCrdPasLSpQ8tTaHMp9f9a2T8cBJrW0mirYmreKV4BPV1pRL
         19FiiExtk0kBFyLp8Ex0PjH3h1kgEHb61NdEhqZamqWm3WQLi25Cfl0PxI40k4oju3RG
         kf+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XvLI4nhOg17VvgP8/NkdRtVRVRohTIN7xR7OZSWHP1E=;
        b=sWFMXPJlri0qjTH3+Zeu9yRJfOHCShQJIH5WYxom+nhztFlsCJ2zKzPVrypHLs1qwI
         fecOapr4AJGYrK66VJJGLE6W5d3X34OzZcHc/Kt741y6T0MlW/vtEDJmU/O07e5a1MlD
         Lr5qI3bDc9enD7x2vJNMeVFVQ7WmKybvYyw7M18miiNRpgEk+lf+7SjhNPZCXkSzlO0N
         vs4LxxYB+wqaPutPZJWE1+Y1J85JZ8UJrEJJJVEi3C+fvtR8ZgHGHFmCMPmXiD5bm1tW
         5u0CLK+0MlcCsEvILEApSE0cdRYVFeW30CzPm1GkSsAgFsq9TXj18on0wuOt74eNSAlP
         YUIw==
X-Gm-Message-State: APjAAAV++eAJthoyqFbhYFgz9DOXrcX1RcW1EDmyByzyt3Rqt1sWj5Zw
        AZ1cWTvMaVnf15YxxF7o3+fHNda6c1aQ+sAzGUH5oEu6gYWv5cqvCfC9N+aRFdQ8QvMp2CeBWS7
        FXbQBxTU9e8T5e6XUqN8tPqEdUxC41IXktQ==
X-Google-Smtp-Source: APXvYqx35cNljM/L2CPC6zi87YfAiEcrAsPoQ0BB/qKtC35yDmXooI9h+LuFXDaaFrOCwntPfDPnZdwyXjKpzImIYXg=
X-Received: by 2002:a05:6830:1054:: with SMTP id b20mr13165770otp.65.1567493950717;
 Mon, 02 Sep 2019 23:59:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190824060351.3776-1-tim.froidcoeur@tessares.net>
 <400C4757-E7AD-4CCF-8077-79563EA869B1@gmail.com> <20190830232657.GL45416@MacBook-Pro-64.local>
 <20190830.192049.1447010488040109227.davem@davemloft.net> <F95AC9340317A84688A5F0DF0246F3F21AAAA8E1@dggeml532-mbs.china.huawei.com>
 <CAOj+RUsqTUF9fuetskRRw26Z=sBM-mELSMcV21Ch06007aP5yQ@mail.gmail.com> <F95AC9340317A84688A5F0DF0246F3F21AAB8F82@dggeml512-mbx.china.huawei.com>
In-Reply-To: <F95AC9340317A84688A5F0DF0246F3F21AAB8F82@dggeml512-mbx.china.huawei.com>
From:   Tim Froidcoeur <tim.froidcoeur@tessares.net>
Date:   Tue, 3 Sep 2019 08:58:33 +0200
Message-ID: <CAOj+RUvXMaoVKzSeDab4oTn3p=-BJtuhgqwKDCUuhCQWHO7bgQ@mail.gmail.com>
Subject: Re: [PATCH 4.14] tcp: fix tcp_rtx_queue_tail in case of empty
 retransmit queue
To:     maowenan <maowenan@huawei.com>
Cc:     David Miller <davem@davemloft.net>,
        "cpaasch@apple.com" <cpaasch@apple.com>,
        "jonathan.lemon@gmail.com" <jonathan.lemon@gmail.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "matthieu.baerts@tessares.net" <matthieu.baerts@tessares.net>,
        "aprout@ll.mit.edu" <aprout@ll.mit.edu>,
        "edumazet@google.com" <edumazet@google.com>,
        "jtl@netflix.com" <jtl@netflix.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mkubecek@suse.cz" <mkubecek@suse.cz>,
        "ncardwell@google.com" <ncardwell@google.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "ycheng@google.com" <ycheng@google.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I also tried to reproduce this in a targeted way, and run into the
same difficulty as you: satisfying the first condition =E2=80=9C
(sk->sk_wmem_queued >> 1) > limit =E2=80=9C.
I will not have bandwidth the coming days to try and reproduce it in
this way. Maybe simply forcing a very small send buffer using sysctl
net.ipv4.tcp_wmem might even do the trick?

I suspect that the bug is easier to trigger with the MPTCP patch like
I did originally, due to the way this patch manages the tcp subflow
buffers (it can temporarily overfill the buffers, satisfying that
first condition more often).

another thing, the stacktrace you shared before seems caused by
another issue (corrupted socket?), it will not be solved by the patch
we submitted.

kind regards,

Tim


On Tue, Sep 3, 2019 at 5:22 AM maowenan <maowenan@huawei.com> wrote:
>
> Hi Tim,
>
>
>
> I try to reproduce it with packetdrill or user application, but I can=E2=
=80=99t.
>
> The first condition =E2=80=9C (sk->sk_wmem_queued >> 1) > limit =E2=80=9C=
    can=E2=80=99t be satisfied,
>
> This condition is to avoid tiny SO_SNDBUF values set by user.
>
> It also adds the some room due to the fact that tcp_sendmsg()
>
> and tcp_sendpage() might overshoot sk_wmem_queued by about one full
>
> TSO skb (64KB size).
>
>
>
>         limit =3D sk->sk_sndbuf + 2 * SKB_TRUESIZE(GSO_MAX_SIZE);
>
>         if (unlikely((sk->sk_wmem_queued >> 1) > limit &&
>
>                      skb !=3D tcp_rtx_queue_head(sk) &&
>
>                      skb !=3D tcp_rtx_queue_tail(sk))) {
>
>                 NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPWQUEUETOOBIG);
>
>                 return -ENOMEM;
>
>         }
>
>
>
> Can you try to reproduce it with packetdrill or C socket application?
>
>



--=20
Tim Froidcoeur | R&D engineer HAG
tim.froidcoeur@tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--=20


Disclaimer: https://www.tessares.net/mail-disclaimer/=20
<https://www.tessares.net/mail-disclaimer/>


