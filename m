Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218F9CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 10:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6C17214B2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 10:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WuRzfyOw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391129AbfJWKy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 06:54:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34094 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2391111AbfJWKyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 06:54:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571828064;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o8RImXd6KMXv5pjUQ2Eec3anNMeMpMspjOnmOYWmf/E=;
        b=WuRzfyOwtcgIKQvEpeVTGntyI2+HeXnTXUaxU0Qzb9H/WYmzKFTyGGcm9flDkFBEyplJhS
        H0LkByZW2U6MjcE3RK014yI3hcJKy8oZ53s6Ta3CXDSxJi/1PZV9mmFSaO30P3ThKP8JMF
        d6xgA40pj+0hYmhmoB1EK4BpTi+CpaM=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-9YDrv6lnN1G2B2dJsCNdpw-1; Wed, 23 Oct 2019 06:54:17 -0400
Received: by mail-lj1-f200.google.com with SMTP id j10so3537419lja.21
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 03:54:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G1qDVGDD2hGEYDHk/bXX/vmWsyzIpERx2yni4ElYYOw=;
        b=n4U3UuDJI+3PE3rE38r597uiw2dJXuNHx9PEvvazUH9LtcuMqz/PohjduTDj7/o7Pm
         Sjp+4cdaYSDGEUVmRi6hBXHOGURp6XVz7QTk+gBbeFug2y/NcDHP+gcFIc/52XO27Ogj
         Uwgoqy/shX2PGRF8NWHssBrah3/atUqe88FwupA83QtTxwkIQ8DW8nm5V21Q/BxOgnDB
         0R3Zt58WljQ/Gvu8qOOtHLzThiqSU2AnbBu+IjFNBGnINHqQsIvSGAucnyTGUMttmxPr
         M9y1LyaIHjWjLLxPY/Il6sGObRN709L4lPL5Prrv9pisNODkLmjjxGLaoZeRQ2svEV3U
         jHJQ==
X-Gm-Message-State: APjAAAUu3tZv78F6m6agPz5ljSCno58LIy8BFJtXZn0A3qm9Z0u8Wz5H
        qR/UQMXbaTLSGaI11d+kksizgZ737h7XZjHeGHCZ7aDXUM4fs7lHKDLzCnwv/rqCy7IJ6EDZabO
        mUZQCGyDDtZtyGM3Z3IX01dpLEFo8a7hjIyLkNfXn
X-Received: by 2002:a2e:9890:: with SMTP id b16mr21660803ljj.181.1571828054531;
        Wed, 23 Oct 2019 03:54:14 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw0EJ3201DeC5P5Ty9eQ1hPJqAuy8TFfoz8iKKFgkYSvJKqJJi1FELYHSEZbbew23ZlUZWlvFSHBfxWie7IbHw=
X-Received: by 2002:a2e:9890:: with SMTP id b16mr21660771ljj.181.1571828054190;
 Wed, 23 Oct 2019 03:54:14 -0700 (PDT)
MIME-Version: 1.0
References: <20191021200948.23775-1-mcroce@redhat.com> <20191021200948.23775-4-mcroce@redhat.com>
 <20191023100009.GC8732@netronome.com>
In-Reply-To: <20191023100009.GC8732@netronome.com>
From:   Matteo Croce <mcroce@redhat.com>
Date:   Wed, 23 Oct 2019 12:53:37 +0200
Message-ID: <CAGnkfhxg1sXkmiNS-+H184omQaKbp_+_Sy7Vi-9W9qLwGGPU6g@mail.gmail.com>
Subject: Re: [PATCH net-next 3/4] flow_dissector: extract more ICMP information
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
X-MC-Unique: 9YDrv6lnN1G2B2dJsCNdpw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 12:00 PM Simon Horman
<simon.horman@netronome.com> wrote:
> On Mon, Oct 21, 2019 at 10:09:47PM +0200, Matteo Croce wrote:
> > +     switch (ih->type) {
> > +     case ICMP_ECHO:
> > +     case ICMP_ECHOREPLY:
> > +     case ICMP_TIMESTAMP:
> > +     case ICMP_TIMESTAMPREPLY:
> > +     case ICMPV6_ECHO_REQUEST:
> > +     case ICMPV6_ECHO_REPLY:
> > +             /* As we use 0 to signal that the Id field is not present=
,
> > +              * avoid confusion with packets without such field
> > +              */
> > +             key_icmp->id =3D ih->un.echo.id ? : 1;
>
> Its not obvious to me why the kernel should treat id-zero as a special
> value if it is not special on the wire.
>
> Perhaps a caller who needs to know if the id is present can
> check the ICMP type as this code does, say using a helper.
>

Hi,

The problem is that the 0-0 Type-Code pair identifies the echo replies.
So instead of adding a bool is_present value I hardcoded the info in
the ID field making it always non null, at the expense of a possible
collision, which is harmless.


--
Matteo Croce
per aspera ad upstream

