Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84CFFC04E84
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 04:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 575CC20879
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 04:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558069159;
	bh=wn472IRdgwSTmAQxOlJ/TuR65yPV4PLu1QbTI1KzXZU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=O771uLzqezyzwtrYLbyJfFG7+05/VEKe65ne/unlHm0Zqtb7il4FJCsb+TGEUvOw8
	 NrQanq736QOFlB046k1eNvxTU14igAM1qZggGTLS3717fn7zmXemX6NPTjxmxvRXT6
	 3culrpMZlOLZ4cQaKtLw6T6BSIGPKnvRtwCqzjfo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbfEQE7S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 00:59:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:37026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725929AbfEQE7R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 00:59:17 -0400
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E8C120879
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 04:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558069156;
        bh=wn472IRdgwSTmAQxOlJ/TuR65yPV4PLu1QbTI1KzXZU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eaIpNd90DK2//QGPdxnHMx1w5XMd4XWQJk+S1SkUSgByFc2xJxya9zH2K8syt32kw
         ymb32N0jsurDwfDLWZDy9zKPpg/BPMGVQHilwhl9u/YZ4d0JAOeHVucEhsWufCrOrX
         1vVYJNl6eVnliev49liAwN5dHKRQIvQgFJldG67s=
Received: by mail-wr1-f51.google.com with SMTP id b18so5554996wrq.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 21:59:16 -0700 (PDT)
X-Gm-Message-State: APjAAAWCLg2yuVCZ1MOGLXh/O60MhwuWiIoT272IwMqm2bwk3NKxZ7pE
        Tx2syZ3y/5qe8Q7jmruF/Fuz7lw+YM2JYR/rhJQpZg==
X-Google-Smtp-Source: APXvYqzrXACnyPa8ejF2asmlRChu4kEILQCxLR0vnSQ2bz6Vk4VDCYAyPYlAg09EEOnjcM+Q5YUwTyVYJi+mDfcutbI=
X-Received: by 2002:adf:dc4b:: with SMTP id m11mr2344176wrj.66.1558069155028;
 Thu, 16 May 2019 21:59:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190517032505.19921-1-felipe@felipegasper.com>
In-Reply-To: <20190517032505.19921-1-felipe@felipegasper.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 16 May 2019 21:59:03 -0700
X-Gmail-Original-Message-ID: <CALCETrUaTamZ1ZGbWpu+4kDAEFRqyESoa_4tgwpAmMh3NVQ4pQ@mail.gmail.com>
Message-ID: <CALCETrUaTamZ1ZGbWpu+4kDAEFRqyESoa_4tgwpAmMh3NVQ4pQ@mail.gmail.com>
Subject: Re: [PATCH] Add UNIX_DIAG_UID to Netlink UNIX socket diagnostics.
To:     Felipe <felipe@felipegasper.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On May 16, 2019, at 8:25 PM, Felipe <felipe@felipegasper.com> wrote:
>
> Author: Felipe Gasper <felipe@felipegasper.com>
> Date:   Thu May 16 12:16:53 2019 -0500
>
>    Add UNIX_DIAG_UID to Netlink UNIX socket diagnostics.
>
>    This adds the ability for Netlink to report a socket=E2=80=99s UID alo=
ng with the
>    other UNIX socket diagnostic information that is already available. Th=
is will
>    allow diagnostic tools greater insight into which users control which =
socket.
>
>    Signed-off-by: Felipe Gasper <felipe@felipegasper.com>
>
> diff --git a/include/uapi/linux/unix_diag.h b/include/uapi/linux/unix_dia=
g.h
> index 5c502fd..a198857 100644
> --- a/include/uapi/linux/unix_diag.h
> +++ b/include/uapi/linux/unix_diag.h
> @@ -20,6 +20,7 @@ struct unix_diag_req {
> #define UDIAG_SHOW_ICONS    0x00000008    /* show pending connections */
> #define UDIAG_SHOW_RQLEN    0x00000010    /* show skb receive queue len *=
/
> #define UDIAG_SHOW_MEMINFO    0x00000020    /* show memory info of a sock=
et */
> +#define UDIAG_SHOW_UID        0x00000040    /* show socket's UID */
>
> struct unix_diag_msg {
>    __u8    udiag_family;
> @@ -40,6 +41,7 @@ enum {
>    UNIX_DIAG_RQLEN,
>    UNIX_DIAG_MEMINFO,
>    UNIX_DIAG_SHUTDOWN,
> +    UNIX_DIAG_UID,
>
>    __UNIX_DIAG_MAX,
> };
> diff --git a/net/unix/diag.c b/net/unix/diag.c
> index 3183d9b..011f56c 100644
> --- a/net/unix/diag.c
> +++ b/net/unix/diag.c
> @@ -110,6 +110,11 @@ static int sk_diag_show_rqlen(struct sock *sk, struc=
t sk_buff *nlskb)
>    return nla_put(nlskb, UNIX_DIAG_RQLEN, sizeof(rql), &rql);
> }
>
> +static int sk_diag_dump_uid(struct sock *sk, struct sk_buff *nlskb)
> +{
> +    return nla_put(nlskb, UNIX_DIAG_UID, sizeof(kuid_t), &(sk->sk_uid));

That type is called *k* uid_t because it=E2=80=99s internal to the kernel. =
You
probably want from_kuid_munged(), which will fix it up for an
appropriate userns.  Presumably you want sk=E2=80=99s netns=E2=80=99s usern=
s.
