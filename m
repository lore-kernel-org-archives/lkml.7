Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9457CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 23:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B55A20862
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 23:04:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TNkctK6s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbfJ2XEY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 19:04:24 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:46437 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725839AbfJ2XEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 19:04:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572390262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lC6RkTPds4S9HR6LQLQv9YuO8abma8vmlimyl+6x1u8=;
        b=TNkctK6svAjv8dWEkHmFd8p89zIJ8Wq3Jt/O4Cno/9leNrsuByWrY1dc91La/U3QmRVGpk
        1By8073rr9a29bqI4qIOhfDO64bEnv+7JZkWLILZ5e2QW2j+VnLaTHpRjA7fAiDr07HdUp
        b27aAdVszhbAt/psjiYgi+6uY7x5HGY=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-3gaDilifMLuRBjmj9mbfbg-1; Tue, 29 Oct 2019 19:04:15 -0400
Received: by mail-oi1-f200.google.com with SMTP id t185so198239oif.13
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 16:04:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wl7YIQbPAgHE/Mh/x+ZbND7svWyQMZORYikb1F19SjY=;
        b=ICUkgH/NZY93hAnFuONj5B1fNGmI57i9z7JEMoLSDw9LXD1zZeJGs0MUdMjrAcbcTI
         YyeTE+T5N964aC1utWVnNtVU+XOm/XRztrs6AfNWqOE62iBa6C2i6VAC8jvLqTGxpXH5
         ElOGSPsl/MgYgJyYAkaK3tfp7wEvgijmgFG9rjnNHC0EYAr29jafz8Ku26DHeOt4qBOa
         YxDpbBK0QnTFCWLsjh/8Luc877pVj8VpJ8hKXAb+JLQtOGpuZlJGyF+Cf83dExBW0Xkh
         5/raGT7nK9GG5upnEWPCPQMMpcivfTG8o81R7WnrpzLClmQ21AAcr6K3+xLvtFT/lU3K
         0q6A==
X-Gm-Message-State: APjAAAUGmomnN/XYZ314sh3C1550lWh7pmGNmXelr1yREFJZc9hiI742
        RI2CXznT4y+5YSMDZLhmTPvXLl9xJmflXeM1io6ntLTYiYAUe3NlOVJ4JEmQEuaPfnwX/0fqMD8
        fI/k4rPQyPaDQPw7Ze0fkR5X+htxS/hIXrmlqy8o/
X-Received: by 2002:aca:5148:: with SMTP id f69mr6344032oib.159.1572390255135;
        Tue, 29 Oct 2019 16:04:15 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyrOvo2ebV8RyPvfdiZT6nEJRpNOU3bEpPZCDUbj09hF/s+Zdz/zPptHOhdj4P6FjVeiauQvnuRwh7Ip1+jFHU=
X-Received: by 2002:aca:5148:: with SMTP id f69mr6344005oib.159.1572390254853;
 Tue, 29 Oct 2019 16:04:14 -0700 (PDT)
MIME-Version: 1.0
References: <20191029135053.10055-1-mcroce@redhat.com> <20191029135053.10055-5-mcroce@redhat.com>
 <5be14e4e-807f-486d-d11a-3113901e72fe@cumulusnetworks.com> <576a4a96-861b-6a86-b059-6621a22d191c@gmail.com>
In-Reply-To: <576a4a96-861b-6a86-b059-6621a22d191c@gmail.com>
From:   Matteo Croce <mcroce@redhat.com>
Date:   Wed, 30 Oct 2019 00:03:38 +0100
Message-ID: <CAGnkfhzEgaH1-YNWw1_HzB5FOhZHjKewLD9NP+rnTP21Htxnjw@mail.gmail.com>
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
X-MC-Unique: 3gaDilifMLuRBjmj9mbfbg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2019 at 10:03 PM Eric Dumazet <eric.dumazet@gmail.com> wrot=
e:
>
>
>
> On 10/29/19 11:35 AM, Nikolay Aleksandrov wrote:
>
> > Hi Matteo,
> > Wouldn't it be more useful and simpler to use some field to choose the =
slave (override the hash
> > completely) in a deterministic way from user-space ?
> > For example the mark can be interpreted as a slave id in the bonding (s=
hould be
> > optional, to avoid breaking existing setups). ping already supports -m =
and
> > anything else can set it, this way it can be used to do monitoring for =
a specific
> > slave with any protocol and would be a much simpler change.
> > User-space can then implement any logic for the monitoring case and as =
a minor bonus
> > can monitor the slaves in parallel. And the opposite as well - if peopl=
e don't want
> > these balanced for some reason, they wouldn't enable it.
> >
>
> I kind of agree giving user more control. But I do not believe we need to=
 use the mark
> (this might be already used by other layers)
>
> TCP uses sk->sk_hash to feed skb->hash.
>
> Anything using skb_set_owner_w() is also using sk->sk_hash if set.
>
> So presumably we could add a generic SO_TXHASH socket option to let user =
space
> read/set this field.
>

Hi Eric,

this would work for locally generated echoes, but what about forwarded pack=
ets?
The point behind my changeset is to provide consistent results within
a session by using the same path for request and response,
but avoid all sessions flowing to the same path.
This should resemble what happens with TCP and UDP: different
connections, different port, probably a different path. And by doing
this in the flow dissector, other applications could benefit it.

Also, this should somewhat balance the traffic of a router forwarding
those packets. Maybe it's not so much in percentage, but in some
gateways be a considerable volume.

Regards,
--=20
Matteo Croce
per aspera ad upstream

