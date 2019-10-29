Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFDC6CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 23:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B89FF2083E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 23:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hhwS+uYo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbfJ2XUe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 19:20:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24583 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725951AbfJ2XUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 19:20:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572391233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zYrZ9qZ2zWpBH4PiUs3Dx0qyoqOMS6/RWHc3sb1XR3Y=;
        b=hhwS+uYo03FWE0bhR8js0IGBepkxKufpvR/joa2FyYZ6pXnDC47UKi0GHsQpoYz+m1UMCc
        rZNdC95SXu6YZzIsxyuPVpDA4rlVBbtVHxhgNoGW3GCEz4Gl+0QMkGD3eEnrRTFYOwlQkq
        wWor/0+34U6SdM+ruMJYnPx//iJO8Xs=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-BhkU4ZsiPnW_tDWi1rsovA-1; Tue, 29 Oct 2019 19:20:29 -0400
Received: by mail-ot1-f69.google.com with SMTP id z39so143065ota.7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 16:20:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y8T+eUd2N5DPhgiGOedRryry9FtRQaSq7h4Wr10JfYs=;
        b=SCPKtQB+hk08DqqQHtH6vL3I8HRsNiQAYk1tAIj5c2IO29g7hu4YFzhjZdXytK/eBX
         Mt1Wf/1k6CKnUWWbZ80ztttKCRe9IEm8nPrVg7L8OqQZc9q+7YyQ/kNU617gXlNPQ7wQ
         1/gKdE/HTy6Tl+32XsoHvIL94U0P1wqjUsbok6/CxXWrP9tfOjP84lEa7kF/QpVATF6v
         QJqnsWzkcD/lPlK2iOILqUapIY3iY8/0Fg2xCBH6lMZgCePyaI3QfM9cl8qOpPE1b69N
         Lib6rBI/OrhImCfOfOHvtlLrAkRggZlC3piRjVqJoh277ZKW8iZnWD/pmK66cAuZMzH6
         22nw==
X-Gm-Message-State: APjAAAUJDGOqPk48DZAUxZKNjorPEvUIrsUa6vymwCxwUHXlDbfW0gkI
        d9k1zIIKj2XfgOOFxbe1zB+/EXm3VyJKNCFvl05AMsyuHROHDNdf1F2JUGPq6Z0iyq67fsKtSkm
        eU4vV0eE5SRCChoTIFGgST1I/L1ZMOz71t97CFBuR
X-Received: by 2002:a9d:ef0:: with SMTP id 103mr19811706otj.2.1572391228948;
        Tue, 29 Oct 2019 16:20:28 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyX2+DJAAyNg860k7Boi5HEX3GTIpndbmJ3I5lT4rE07JAmXWIQisZEeV+os4zRBJoNncNLhedcRv1X9WtrxyI=
X-Received: by 2002:a9d:ef0:: with SMTP id 103mr19811680otj.2.1572391228689;
 Tue, 29 Oct 2019 16:20:28 -0700 (PDT)
MIME-Version: 1.0
References: <20191029135053.10055-1-mcroce@redhat.com> <20191029135053.10055-5-mcroce@redhat.com>
 <5be14e4e-807f-486d-d11a-3113901e72fe@cumulusnetworks.com>
 <576a4a96-861b-6a86-b059-6621a22d191c@gmail.com> <CAGnkfhzEgaH1-YNWw1_HzB5FOhZHjKewLD9NP+rnTP21Htxnjw@mail.gmail.com>
 <43abab53-1425-0bff-9f79-50bd47567605@gmail.com>
In-Reply-To: <43abab53-1425-0bff-9f79-50bd47567605@gmail.com>
From:   Matteo Croce <mcroce@redhat.com>
Date:   Wed, 30 Oct 2019 00:19:52 +0100
Message-ID: <CAGnkfhyaXzMx608jZqqjdywv6BZst97QSmGe++aSc=-xOQSWzg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 4/4] bonding: balance ICMP echoes in layer3+4 mode
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        netdev <netdev@vger.kernel.org>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "David S . Miller" <davem@davemloft.net>,
        Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Paul Blakey <paulb@mellanox.com>,
        LKML <linux-kernel@vger.kernel.org>
X-MC-Unique: BhkU4ZsiPnW_tDWi1rsovA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2019 at 12:14 AM Eric Dumazet <eric.dumazet@gmail.com> wrot=
e:
>
>
>
> On 10/29/19 4:03 PM, Matteo Croce wrote:
>
> > Hi Eric,
> >
> > this would work for locally generated echoes, but what about forwarded =
packets?
> > The point behind my changeset is to provide consistent results within
> > a session by using the same path for request and response,
> > but avoid all sessions flowing to the same path.
> > This should resemble what happens with TCP and UDP: different
> > connections, different port, probably a different path. And by doing
> > this in the flow dissector, other applications could benefit it.
>
> In principle it is fine, but I was not sure of overall impact of your cha=
nge
> on performance for 99.9% of packets that are not ICMP :)
>

Good point. I didn't measure it (I will) but all the code additions
are under some if (proto =3D=3D ICMP) or similar.
My guess is that performance shouldn't change for non ICMP traffic,
but I'm curious to test it.

--=20
Matteo Croce
per aspera ad upstream

