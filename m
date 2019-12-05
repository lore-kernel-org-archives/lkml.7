Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AACDEC2D0C0
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 20:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FB0420659
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 20:46:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="e/WCgfFK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730369AbfLEUqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 15:46:09 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42727 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730349AbfLEUqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 15:46:09 -0500
Received: by mail-lj1-f196.google.com with SMTP id e28so5125083ljo.9
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 12:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=8cyCc55gZLfBZi6qHxanVdv40xMR1/UD2QUcttolUfA=;
        b=e/WCgfFKLXKeMP8B0eieYwfRKnR3bNByH5Wt2Na9dfSWOj+AobBbuhEvat4zrtA3wR
         RwvsiJPia1pEaEIiXl5QtDNJFMsrVPzcBkLj675tNeVMsTRNfCLqc26fO3hf8F15jBvN
         PoXoXLaERjPsYpZuiEAJTizz6M/2Vjw/5aTrXGabVb78ihDvfFWuL0De571QLUI2Ck3Y
         DGQ+t2icfIynwhrUdvoDcV5EA8sAdF/vN+k0iz88Nw83WCfze92GF5UXyNE9svNheZho
         Yr8C0wFqIGrwSAAeBO/ApI+3R+Jo9k+g+F8rJ+6a+69SJ2njxE5Z/dDzCyQH3eCqFipG
         dkeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=8cyCc55gZLfBZi6qHxanVdv40xMR1/UD2QUcttolUfA=;
        b=iV0McLWIenkGH+goxRBrD1PHU8rt46gNKcevsRPiY+CwYL3ZdVmjfr5s3RCFxBBXiR
         xc9EEs+xcNamwJQhLXzQtWT32Oxb9pwEB5Rjvua0b3MO9o8s70ZgCOJ0miPxyuKWP8sS
         8xcnUuLVCYezBipaL1vITTSxw5mHEkHJv/Iabn7C6r7pEMO3w6Vp0CD2eqRJv2IjuWdK
         9p+0l9eRkYbtrmGx3/c/11RFvtSfFGRv5f5cUy5XnWE3ubhn2awHqHZ9Ty5ZtqDbcnph
         5qdFcEpq0gF2DVHXBNKLlFtOVgnivzVy4SjFWl0aX4/cdFwS8VusDBR83Gs4wA70byg+
         WUaQ==
X-Gm-Message-State: APjAAAW6AAijLNudCZ3abaBoXxdH//sPa74cWQUrJ+mzuc9mYk+Zq8Ip
        QPIhYoOC8NWb53QL6ZhcM4Xkng==
X-Google-Smtp-Source: APXvYqzvHwRSD2mB3TiNwn5l/6wFgxrgKCh+PXfV76p0uNtgVFYaLuYVqrDv879O/JwfoezsT0WeIw==
X-Received: by 2002:a2e:85c9:: with SMTP id h9mr6821870ljj.155.1575578767355;
        Thu, 05 Dec 2019 12:46:07 -0800 (PST)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id m18sm5693241ljg.3.2019.12.05.12.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 12:46:07 -0800 (PST)
Date:   Thu, 5 Dec 2019 12:45:59 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Valentin =?UTF-8?B?VmlkacSH?= <vvidic@valentin-vidic.from.hr>
Cc:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Boris Pismenny <borisp@mellanox.com>,
        Aviad Yehezkel <aviadye@mellanox.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Network Development <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] net/tls: Fix return values to avoid ENOTSUPP
Message-ID: <20191205124559.1cbba55f@cakuba.netronome.com>
In-Reply-To: <20191205204343.GA20116@valentin-vidic.from.hr>
References: <20191204.165528.1483577978366613524.davem@davemloft.net>
        <20191205064118.8299-1-vvidic@valentin-vidic.from.hr>
        <20191205113411.5e672807@cakuba.netronome.com>
        <CA+FuTSe=GSP41GG+QYKEmQ0eDUEoFeQ+oGAsgGJEZTe=hJq4Tw@mail.gmail.com>
        <20191205204343.GA20116@valentin-vidic.from.hr>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Dec 2019 21:43:43 +0100, Valentin Vidi=C4=87 wrote:
> > > On Thu,  5 Dec 2019 07:41:18 +0100, Valentin Vidic wrote: =20
> > > > ENOTSUPP is not available in userspace, for example:
> > > >
> > > >   setsockopt failed, 524, Unknown error 524
> > > >
> > > > Signed-off-by: Valentin Vidic <vvidic@valentin-vidic.from.hr> =20
> > > =20
> > > > diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
> > > > index 0683788bbef0..cd91ad812291 100644
> > > > --- a/net/tls/tls_device.c
> > > > +++ b/net/tls/tls_device.c
> > > > @@ -429,7 +429,7 @@ static int tls_push_data(struct sock *sk,
> > > >
> > > >       if (flags &
> > > >           ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL | MSG_SENDPAGE_N=
OTLAST))
> > > > -             return -ENOTSUPP;
> > > > +             return -EOPNOTSUPP;
> > > >
> > > >       if (unlikely(sk->sk_err))
> > > >               return -sk->sk_err;
> > > > @@ -571,7 +571,7 @@ int tls_device_sendpage(struct sock *sk, struct=
 page *page,
> > > >       lock_sock(sk);
> > > >
> > > >       if (flags & MSG_OOB) {
> > > > -             rc =3D -ENOTSUPP;
> > > > +             rc =3D -EOPNOTSUPP; =20
> > >
> > > Perhaps the flag checks should return EINVAL? Willem any opinions? =20
> >=20
> > No strong opinion. Judging from do_tcp_sendpages MSG_OOB is a
> > supported flag in general for sendpage, so signaling that the TLS
> > variant cannot support that otherwise valid request sounds fine to me. =
=20
>=20
> I based these on the description from the sendmsg manpage, but you decide:
>=20
> EOPNOTSUPP
>     Some bit in the flags argument is inappropriate for the socket type.
>=20
> > > > diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
> > > > index bdca31ffe6da..5830b8e02a36 100644
> > > > --- a/net/tls/tls_main.c
> > > > +++ b/net/tls/tls_main.c
> > > > @@ -496,7 +496,7 @@ static int do_tls_setsockopt_conf(struct sock *=
sk, char __user *optval,
> > > >       /* check version */
> > > >       if (crypto_info->version !=3D TLS_1_2_VERSION &&
> > > >           crypto_info->version !=3D TLS_1_3_VERSION) {
> > > > -             rc =3D -ENOTSUPP;
> > > > +             rc =3D -EINVAL; =20
> > >
> > > This one I think Willem asked to be EOPNOTSUPP OTOH. =20
> >=20
> > Indeed (assuming no one disagrees). Based on the same rationale: the
> > request may be valid, it just cannot be accommodated (yet). =20
>=20
> In this case other checks in the same function like crypto_info->cipher_t=
ype
> return EINVAL, so I used the same here.

Thanks for explaining, in that case:

Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>
