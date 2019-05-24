Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89019C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 01:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 491D0217D9
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 01:38:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=appneta.com header.i=@appneta.com header.b="kGOO7QJj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388729AbfEXBis (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 21:38:48 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40062 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbfEXBis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 21:38:48 -0400
Received: by mail-pf1-f195.google.com with SMTP id u17so4272787pfn.7
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 18:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=appneta.com; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=fIG1/oNez6GVfieaNVvRGqClWbB80a7VpaI4ZVWlUTY=;
        b=kGOO7QJjYShPVPBvs/ZZX4VQ4eRHKxuNroC1T1gSIH+LURunL1GYc8S5KkMJ4304nt
         D0vjJP1zY0itozAzVofvfnp6vwc37FxbJCWVEjzCPHkvqiNeBjdFsXbkJdDIa+f/G+o7
         l2A9DZTeNt5XJA8Qxui7ybi7g1aIi80biu8DQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=fIG1/oNez6GVfieaNVvRGqClWbB80a7VpaI4ZVWlUTY=;
        b=EWOIncXhiOrCfcgumLnc6MYCzm0p4Q4P2muTKLefblrgyWN+2JAE2SrrAcOv1ctDsV
         1TlSMUHAox8Yo0bFumVxquMgYnfV4CoWloYrpZtYIHhJgi7BqZFRieHztieK5d/s4o/G
         VdqePgbnId5WeINT71WfuNNBJEl5ZykkbYF0Qg73QvZEvjG3GjMMRNspnLEZ7xmY1U2v
         uuZZyQ638BA6Lx8gZY3FotIFtFEFZxPbzi9SkRw4g8KmZywestUfsO+KPgVrubl1nc6J
         EspI2U7ilDwmEeLkOExFOiLB1yRAuTtzz4cJh/vvWfNCopNesdEtKtE+azUTChAuGKqQ
         CTaw==
X-Gm-Message-State: APjAAAV06B+wzhNmPq9uXXdGnOzGWtDflSR4c8b9n5m5ofoLrjaAYB5o
        Ub2PDkQd5TeE0pGXPaZiMTIE/Q==
X-Google-Smtp-Source: APXvYqxbCF0d1RN2Gw85wpBkrv/MWoagSl5+oFwhvvoDBMmfB9ADuQlYwD4bfak3BfVpG5B/MM3VLA==
X-Received: by 2002:a63:d016:: with SMTP id z22mr102922046pgf.116.1558661926884;
        Thu, 23 May 2019 18:38:46 -0700 (PDT)
Received: from [10.0.1.19] (S010620c9d00fc332.vf.shawcable.net. [70.71.167.160])
        by smtp.gmail.com with ESMTPSA id f36sm524732pgb.76.2019.05.23.18.38.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 18:38:46 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH net 1/4] net/udp_gso: Allow TX timestamp with UDP GSO
From:   Fred Klassen <fklassen@appneta.com>
In-Reply-To: <CAF=yD-Jf95De=z_nx9WFkGDa6+nRUqM_1PqGkjwaFPzOe+PfXg@mail.gmail.com>
Date:   Thu, 23 May 2019 18:38:44 -0700
Cc:     "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Shuah Khan <shuah@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        Willem de Bruijn <willemb@google.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <AE8E0772-7256-4B9C-A990-96930E834AEE@appneta.com>
References: <20190523210651.80902-1-fklassen@appneta.com>
 <20190523210651.80902-2-fklassen@appneta.com>
 <CAF=yD-Jf95De=z_nx9WFkGDa6+nRUqM_1PqGkjwaFPzOe+PfXg@mail.gmail.com>
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Thanks for the report.
>=20
> Zerocopy notification reference count is managed in skb_segment. That
> should work.
>=20
> Support for timestamping with the new GSO feature is indeed an
> oversight. The solution is similar to how TCP associates the timestamp
> with the right segment in tcp_gso_tstamp.
>=20
> Only, I think we want to transfer the timestamp request to the last
> datagram, not the first. For send timestamp, the final byte leaving
> the host is usually more interesting.

TX Timestamping the last packet of a datagram is something that would
work poorly for our application. We need to measure the time it takes
for the first bit that is sent until the first bit of the last packet is =
received.
Timestaming the last packet of a burst seems somewhat random to me
and would not be useful. Essentially we would be timestamping a=20
random byte in a UDP GSO buffer.

I believe there is a precedence for timestamping the first packet. With
IPv4 packets, the first packet is timestamped and the remaining =
fragments
are not.=
