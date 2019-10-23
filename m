Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E2ACA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 16:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8FB221906
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 16:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KIudtqZj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfJWQ65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 12:58:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38528 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726712AbfJWQ65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 12:58:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571849936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=svxKy9PpZYdSp7My5GoLpaiAHrwdkyewTYZPNZNZ5xI=;
        b=KIudtqZjdSyR0zAwaz6uW/Fz4HUw9nQfkvJ3MgudY31zLvPENQikR2tUlJhSI/UPfFJEGk
        cv73hbsoTUoB5iI1skqD7TCy7GGmtTrFYSzOzL0Qr8et+gGSXecWNfsQXkvrgNmwLT4lBG
        k+kpgfF8K6BqhjVWsLsS9EvKGvxR4zI=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-VU-4ulozMBecvazaRcXPaQ-1; Wed, 23 Oct 2019 12:58:54 -0400
Received: by mail-lf1-f71.google.com with SMTP id x20so4292462lfe.14
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 09:58:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WadZePlEGvqCjR+F4g4l9zs3Tb/z+tEXc700EM0+NZE=;
        b=EdR7DaXFM0kE57+VCqbWYgZGGJ4Zm/4sfhsArOl5u9XozV9QTz2qxsD2lUZlb9HIzu
         sXLbCVL5MQ3ZmlFfQlfVk12fL93TThYO2gdvfGAN0cpKSe/O9CI5TJqRBPl3QBsjgYNk
         rWoOb8geVrFWZuk/BnguJOwRR4AfjLm/cr/NTun/UcdK9RbprbocldgYhoIOz8z8dsnu
         I96rt4mM2UoQoOs8llgjaZnmYuCJcXQv1C5co1EtzS3ps7xARQsLk8gcUR54mqSNxxrs
         /tiE/nQ/9o5ile87ndqEG48hGEhxD08YcT+y1nTqjwaqU+q31fqhx2eF0kBp1hgrzEh3
         diNA==
X-Gm-Message-State: APjAAAUAM8F9lmNz9GTYVvkZnoB/EfRZGualAB9paQFxObEW+LN+M+R6
        2TT1KThUwr3JiMmG+DAqmIVElnxRIbRE27ixnk6f5wqoAN7WF1EYa3djwuKOQJeCLTTOACdNlQ2
        PkAaJgedKWy8tTjqfsRoTRttGqTw7z5ees7oEj+4x
X-Received: by 2002:a19:f707:: with SMTP id z7mr12684775lfe.0.1571849932884;
        Wed, 23 Oct 2019 09:58:52 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxzuAJ3SiF0de98rFTJPLLTmMZ3yLAQ4bENcIP+wrr2Kj8d3MAxXL/CqGOvxQJUi82d4cSF+Pao0feEKCQuYsA=
X-Received: by 2002:a19:f707:: with SMTP id z7mr12684749lfe.0.1571849932584;
 Wed, 23 Oct 2019 09:58:52 -0700 (PDT)
MIME-Version: 1.0
References: <20191021200948.23775-1-mcroce@redhat.com> <20191021200948.23775-5-mcroce@redhat.com>
 <20191023100132.GD8732@netronome.com>
In-Reply-To: <20191023100132.GD8732@netronome.com>
From:   Matteo Croce <mcroce@redhat.com>
Date:   Wed, 23 Oct 2019 18:58:16 +0200
Message-ID: <CAGnkfhy1rsm0Dp_jsuHhfXY0kzMc_hShYmYSX=X8=q-HMtNczg@mail.gmail.com>
Subject: Re: [PATCH net-next 4/4] bonding: balance ICMP echoes in layer3+4 mode
To:     Simon Horman <simon.horman@netronome.com>
Cc:     netdev <netdev@vger.kernel.org>,
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
X-MC-Unique: VU-4ulozMBecvazaRcXPaQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 12:01 PM Simon Horman
<simon.horman@netronome.com> wrote:
>
> On Mon, Oct 21, 2019 at 10:09:48PM +0200, Matteo Croce wrote:
> > The bonding uses the L4 ports to balance flows between slaves.
> > As the ICMP protocol has no ports, those packets are sent all to the
> > same device:
> >
> >     # tcpdump -qltnni veth0 ip |sed 's/^/0: /' &
> >     # tcpdump -qltnni veth1 ip |sed 's/^/1: /' &
> >     # ping -qc1 192.168.0.2
> >     1: IP 192.168.0.1 > 192.168.0.2: ICMP echo request, id 315, seq 1, =
length 64
> >     1: IP 192.168.0.2 > 192.168.0.1: ICMP echo reply, id 315, seq 1, le=
ngth 64
> >     # ping -qc1 192.168.0.2
> >     1: IP 192.168.0.1 > 192.168.0.2: ICMP echo request, id 316, seq 1, =
length 64
> >     1: IP 192.168.0.2 > 192.168.0.1: ICMP echo reply, id 316, seq 1, le=
ngth 64
> >     # ping -qc1 192.168.0.2
> >     1: IP 192.168.0.1 > 192.168.0.2: ICMP echo request, id 317, seq 1, =
length 64
> >     1: IP 192.168.0.2 > 192.168.0.1: ICMP echo reply, id 317, seq 1, le=
ngth 64
> >
> > But some ICMP packets have an Identifier field which is
> > used to match packets within sessions, let's use this value in the hash
> > function to balance these packets between bond slaves:
> >
> >     # ping -qc1 192.168.0.2
> >     0: IP 192.168.0.1 > 192.168.0.2: ICMP echo request, id 303, seq 1, =
length 64
> >     0: IP 192.168.0.2 > 192.168.0.1: ICMP echo reply, id 303, seq 1, le=
ngth 64
> >     # ping -qc1 192.168.0.2
> >     1: IP 192.168.0.1 > 192.168.0.2: ICMP echo request, id 304, seq 1, =
length 64
> >     1: IP 192.168.0.2 > 192.168.0.1: ICMP echo reply, id 304, seq 1, le=
ngth 64
> >
> > Signed-off-by: Matteo Croce <mcroce@redhat.com>
>
> I see where this patch is going but it is unclear to me what problem it i=
s
> solving. I would expect ICMP traffic to be low volume and thus able to be
> handled by a single lower-device of a bond.
>
> ...

Hi,

The problem is not balancing the volume, even if it could increase due
to IoT devices pinging some well known DNS servers to check for
connection.
If a bonding slave is down, people using pings to check for
connectivity could fail to detect a broken link if all the packets are
sent to the alive link.
Anyway, although I didn't measure it, the computational overhead of
this changeset should be minimal, and only affect ICMP packets when
the ICMP dissector is used.

Regards,
--=20
Matteo Croce
per aspera ad upstream

