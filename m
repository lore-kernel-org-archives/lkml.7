Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B4CC46460
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 17:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 894382087E
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 17:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="qtHSZPLP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729678AbfERRS6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 13:18:58 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46180 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728283AbfERRS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 13:18:58 -0400
Received: by mail-pl1-f195.google.com with SMTP id r18so4755583pls.13
        for <linux-kernel@vger.kernel.org>; Sat, 18 May 2019 10:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=lInakaH9QIJV2qyTcHK9vy8+So0EobhrfMkTeL58g00=;
        b=qtHSZPLPznbImALkmN2FBZIz4O+T+RKgAdwpltbsjoobbCkfcB1Jl/6+7Tstsc8l+d
         8dxP1VvUIDh45pvv2DeQU+UudRkBSaWmD3IQsH14wPR96NikKq7qdM050+jIbYJyXem9
         F7P/23llmD/DuTFm2v2rz+9ZCdKiB23WQD8AfCIldtIfwR5CoCyKxhOyDQQ+J/enFadU
         KJr7wa2iU8sysixF9jjLSF4I05eZAtCeeJ876hMXIo1In87zvb10xbxm1c4BprhxscR+
         n7LJB6RmeaMqfKX/1F9ahBC1WeItsr/DpOZlDtgGIPk5TFhhJjUU4r8h+t9GF9OFEIw/
         1cag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=lInakaH9QIJV2qyTcHK9vy8+So0EobhrfMkTeL58g00=;
        b=S0Wda6mRH0pER1ROsP0zQ8MzaTmeQGBIjKebVxmMPanMfCjJxcJgv8K70PE2T3vDTr
         SNnpz/L9Z4WKIA6fuCrnPFZCmlFgcCsNpVDCw6Ya5AT8HHhn8HFZM6uVKksjs5clYRDH
         rXJuvR6WYXEeGYXocGAZLJ3oY6LKdj+lleWgGqnM/pQzWzezXkAPifSLK/zSIYgHKdX6
         IVyp4IcMjFNbyf3NMJKOqwtCGuBUlXw/drqRYa4gDREvJ0aV7KsUn8yI9134TiF0cZ5e
         czc0nkb/Wdai4E/LKx2w9BoRuOgHEb0ww8YuRVR+h8reeExX8LEpkfcHFE5MCYUXLY4t
         Q6zA==
X-Gm-Message-State: APjAAAXOOIS/0bN5H7Q0cPvN4VVGw9Mr8sNffj7zptIM9OFEGdkZRspP
        SP9ZtFBET612+/E+qhL1/A8yML2Ip/Q=
X-Google-Smtp-Source: APXvYqwcmysrVwi8eDDoMIdmDMADJBNZKuxiO7AjctFjBc75iOz2YhLkLlg3S/MX0lMnU+XgHh2a7A==
X-Received: by 2002:a17:902:683:: with SMTP id 3mr22168356plh.209.1558199936948;
        Sat, 18 May 2019 10:18:56 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:752c:b986:3395:75e0? ([2601:646:c200:1ef2:752c:b986:3395:75e0])
        by smtp.gmail.com with ESMTPSA id q193sm18551512pfc.52.2019.05.18.10.18.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 May 2019 10:18:55 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2] net: Add UNIX_DIAG_UID to Netlink UNIX socket diagnostics.
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16E227)
In-Reply-To: <20190518034820.16500-1-felipe@felipegasper.com>
Date:   Sat, 18 May 2019 10:18:54 -0700
Cc:     davem@davemloft.net, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <6CDA54A5-56FF-4B42-B6F5-762E72C3FC3B@amacapital.net>
References: <20190518034820.16500-1-felipe@felipegasper.com>
To:     Felipe Gasper <felipe@felipegasper.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 17, 2019, at 8:48 PM, Felipe Gasper <felipe@felipegasper.com> wrote=
:
>=20
> Author: Felipe Gasper <felipe@felipegasper.com>
> Date:   Fri May 17 16:54:40 2019 -0500
>=20
>   net: Add UNIX_DIAG_UID to Netlink UNIX socket diagnostics.
>=20
>   This adds the ability for Netlink to report a socket=E2=80=99s UID along=
 with the
>   other UNIX diagnostic information that is already available. This will
>   allow diagnostic tools greater insight into which users control which so=
cket.
>=20
>   Signed-off-by: Felipe Gasper <felipe@felipegasper.com>
>=20
> diff --git a/include/uapi/linux/unix_diag.h b/include/uapi/linux/unix_diag=
.h
> index 5c502fd..a198857 100644
> --- a/include/uapi/linux/unix_diag.h
> +++ b/include/uapi/linux/unix_diag.h
> @@ -20,6 +20,7 @@ struct unix_diag_req {
> #define UDIAG_SHOW_ICONS    0x00000008    /* show pending connections */
> #define UDIAG_SHOW_RQLEN    0x00000010    /* show skb receive queue len */=

> #define UDIAG_SHOW_MEMINFO    0x00000020    /* show memory info of a socke=
t */
> +#define UDIAG_SHOW_UID        0x00000040    /* show socket's UID */
>=20
> struct unix_diag_msg {
>    __u8    udiag_family;
> @@ -40,6 +41,7 @@ enum {
>    UNIX_DIAG_RQLEN,
>    UNIX_DIAG_MEMINFO,
>    UNIX_DIAG_SHUTDOWN,
> +    UNIX_DIAG_UID,
>=20
>    __UNIX_DIAG_MAX,
> };
> diff --git a/net/unix/diag.c b/net/unix/diag.c
> index 3183d9b..e40f348 100644
> --- a/net/unix/diag.c
> +++ b/net/unix/diag.c
> @@ -4,9 +4,11 @@
> #include <linux/unix_diag.h>
> #include <linux/skbuff.h>
> #include <linux/module.h>
> +#include <linux/uidgid.h>
> #include <net/netlink.h>
> #include <net/af_unix.h>
> #include <net/tcp_states.h>
> +#include <net/sock.h>
>=20
> static int sk_diag_dump_name(struct sock *sk, struct sk_buff *nlskb)
> {
> @@ -110,6 +112,12 @@ static int sk_diag_show_rqlen(struct sock *sk, struct=
 sk_buff *nlskb)
>    return nla_put(nlskb, UNIX_DIAG_RQLEN, sizeof(rql), &rql);
> }
>=20
> +static int sk_diag_dump_uid(struct sock *sk, struct sk_buff *nlskb)
> +{
> +    uid_t uid =3D from_kuid_munged(sk_user_ns(sk), sock_i_uid(sk));
> +    return nla_put(nlskb, UNIX_DIAG_UID, sizeof(uid_t), &uid);

This still looks wrong. You=E2=80=99re reporting the uid of the socket as se=
en by that socket.  Presumably you actually want the uid of the socket as se=
en by the *diagnostic* socket. This might be sk_user_ns(nlskb->sk).

You can test this with a command like unshare -U -r nc -l 12345 run as no -r=
oot. Then run you user diagnostic tool to find the uid of the socket. It sho=
uld not be zero. Similarly, if you run unshare -U -r bash and then open a so=
cket and run your diagnostic tool, both from that same session, you should s=
ee 0 as the uid since bash and all its children think they=E2=80=99re uid 0.=


> +}

> +
> static int sk_diag_fill(struct sock *sk, struct sk_buff *skb, struct unix_=
diag_req *req,
>        u32 portid, u32 seq, u32 flags, int sk_ino)
> {
> @@ -156,6 +164,10 @@ static int sk_diag_fill(struct sock *sk, struct sk_bu=
ff *skb, struct unix_diag_r
>    if (nla_put_u8(skb, UNIX_DIAG_SHUTDOWN, sk->sk_shutdown))
>        goto out_nlmsg_trim;
>=20
> +    if ((req->udiag_show & UDIAG_SHOW_UID) &&
> +        sk_diag_dump_uid(sk, skb))
> +        goto out_nlmsg_trim;
> +
>    nlmsg_end(skb, nlh);
>    return 0;
>=20
