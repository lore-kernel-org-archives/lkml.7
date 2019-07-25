Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F017C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 06:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C51D621850
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 06:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="giC78xbU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729183AbfGYGJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 02:09:26 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:34692 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbfGYGJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 02:09:25 -0400
Received: by mail-vs1-f65.google.com with SMTP id m23so32999783vso.1;
        Wed, 24 Jul 2019 23:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8n+oScGCx7XOhecxHmlqcG+ta+ra65NsPlKdfashxxc=;
        b=giC78xbUtZGlw2pKKUVQXWhgYXtov7f+F+vAMBXe13zQy9KhW+JXMmAwgs8M8abups
         3ou2cRmq59VoizF+dalnKhbqoOzgSUB9OnvIYpEvIsr+J4oxoPaO31Iaj45B3rWianib
         F0tORVau3XntYhNPwf7cDpsCqArA6kgCQVo0YCYgiWkQwitekH0o7baxCBHAjPID8IYH
         raV4pjRnR+aPX0aEBPZLu5SRF8PEPjmqhteynZC8NhnPyOSzdq+Mm2NI6hZE5AP/uc3u
         Jg4PfaiHkwdxlPzu7dZ/lyAXdzffQAqOhlpRijTP70053mtCZa1v8tBZ96dkAizX72hy
         5kgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8n+oScGCx7XOhecxHmlqcG+ta+ra65NsPlKdfashxxc=;
        b=clZSJGzlCjAE9DtbrOJU1pEpRVbX5A2FqIZYMcDacheJWN+7JH0PqOTLo/6plK4vjL
         wm6KZZBAg6LOnomA7wmfAkwziHSVqYqxaxgWcwdOrS/YPS5fS6oQQxF6U9EnAYxtc+Vz
         RsK/n3yxO4pGgarxREGZ4PLVWTRIZSCvzr9DScSOAJDIiJPbhH4r2yyIfzobgizjGWoa
         poEMAJ11uwgwUtmBXaoTteAGNI05T4J8ia2J5YC8OsT8OsaOkY4+oPEqiMLp72+crkPg
         gG2SC6H+VQhsOmao3nN7hsaPJMIZ0lBEPz2Q9n4c7wr93Xev/LXgaxVxHKXDeUAu1fBw
         BC8w==
X-Gm-Message-State: APjAAAWnSAC+/H3vI67rOQAvLxoSaFkyjS0c1Cp1hkAmoDjC8lEIADY3
        M/1eyfkWXZv5tHN7aOd6vkPHMEDoN9w9RJEk3CE=
X-Google-Smtp-Source: APXvYqxJOMoQJ1TicOfUb0mMN+vDK2H8hUL/7uBcPgwwEThqBClMb2rLab75oLaA2sO6jBVg0NPKYx9vmEdL2HciGsU=
X-Received: by 2002:a67:cd1a:: with SMTP id u26mr54804933vsl.155.1564034964325;
 Wed, 24 Jul 2019 23:09:24 -0700 (PDT)
MIME-Version: 1.0
References: <1563979112-22483-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1563979112-22483-1-git-send-email-linux@roeck-us.net>
From:   Jun Li <lijun.kernel@gmail.com>
Date:   Thu, 25 Jul 2019 14:09:12 +0800
Message-ID: <CAKgpwJV_gJ7sBvtv6B89GBSFam6Dn97=BxKkBM8waDKmEa72-g@mail.gmail.com>
Subject: Re: [PATCH v2] usb: typec: tcpm: Add NULL check before dereferencing config
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Douglas Gilbert <dgilbert@interlog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guenter Roeck <linux@roeck-us.net> =E4=BA=8E2019=E5=B9=B47=E6=9C=8824=E6=97=
=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=8810:40=E5=86=99=E9=81=93=EF=BC=9A
>
> When instantiating tcpm on an NXP OM 13588 board with NXP PTN5110,
> the following crash is seen when writing into the 'preferred_role'
> sysfs attribute.
>
> Unable to handle kernel NULL pointer dereference at virtual address 00000=
028
> pgd =3D f69149ad
> [00000028] *pgd=3D00000000
> Internal error: Oops: 5 [#1] THUMB2
> Modules linked in: tcpci tcpm
> CPU: 0 PID: 1882 Comm: bash Not tainted 5.1.18-sama5-armv7-r2 #4
> Hardware name: Atmel SAMA5
> PC is at tcpm_try_role+0x3a/0x4c [tcpm]
> LR is at tcpm_try_role+0x15/0x4c [tcpm]
> pc : [<bf8000e2>]    lr : [<bf8000bd>]    psr: 60030033
> sp : dc1a1e88  ip : c03fb47d  fp : 00000000
> r10: dc216190  r9 : dc1a1f78  r8 : 00000001
> r7 : df4ae044  r6 : dd032e90  r5 : dd1ce340  r4 : df4ae054
> r3 : 00000000  r2 : 00000000  r1 : 00000000  r0 : df4ae044
> Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA Thumb  Segment none
> Control: 50c53c7d  Table: 3efec059  DAC: 00000051
> Process bash (pid: 1882, stack limit =3D 0x6a6d4aa5)
> Stack: (0xdc1a1e88 to 0xdc1a2000)
> 1e80:                   dd05d808 dd1ce340 00000001 00000007 dd1ce340 c03f=
b4a7
> 1ea0: 00000007 00000007 dc216180 00000000 00000000 c01e1e03 00000000 0000=
0000
> 1ec0: c0907008 dee98b40 c01e1d5d c06106c4 00000000 00000000 00000007 c019=
4e8b
> 1ee0: 0000000a 00000400 00000000 c01a97db dc22bf00 ffffe000 df4b6a00 df74=
5900
> 1f00: 00000001 00000001 000000dd c01a9c2f 7aeab3be c0907008 00000000 dc22=
bf00
> 1f20: c0907008 00000000 00000000 00000000 00000000 7aeab3be 00000007 dee9=
8b40
> 1f40: 005dc318 dc1a1f78 00000000 00000000 00000007 c01969f7 0000000a c01a=
20cb
> 1f60: dee98b40 c0907008 dee98b40 005dc318 00000000 c0196b9b 00000000 0000=
0000
> 1f80: dee98b40 7aeab3be 00000074 005dc318 b6f3bdb0 00000004 c0101224 dc1a=
0000
> 1fa0: 00000004 c0101001 00000074 005dc318 00000001 005dc318 00000007 0000=
0000
> 1fc0: 00000074 005dc318 b6f3bdb0 00000004 00000007 00000007 00000000 0000=
0000
> 1fe0: 00000004 be800880 b6ed35b3 b6e5c746 60030030 00000001 00000000 0000=
0000
> [<bf8000e2>] (tcpm_try_role [tcpm]) from [<c03fb4a7>] (preferred_role_sto=
re+0x2b/0x5c)
> [<c03fb4a7>] (preferred_role_store) from [<c01e1e03>] (kernfs_fop_write+0=
xa7/0x150)
> [<c01e1e03>] (kernfs_fop_write) from [<c0194e8b>] (__vfs_write+0x1f/0x104=
)
> [<c0194e8b>] (__vfs_write) from [<c01969f7>] (vfs_write+0x6b/0x104)
> [<c01969f7>] (vfs_write) from [<c0196b9b>] (ksys_write+0x43/0x94)
> [<c0196b9b>] (ksys_write) from [<c0101001>] (ret_fast_syscall+0x1/0x62)
>
> Since commit 96232cbc6c994 ("usb: typec: tcpm: support get typec and pd
> config from device properties"), the 'config' pointer in struct tcpc_dev
> is optional when registering a Type-C port. Since it is optional, we have
> to check if it is NULL before dereferencing it.
>
> Reported-by: Douglas Gilbert <dgilbert@interlog.com>
> Cc: Douglas Gilbert <dgilbert@interlog.com>
> Fixes: 96232cbc6c994 ("usb: typec: tcpm: support get typec and pd config =
from device properties")
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: Jun Li <jun.li@nxp.com>

> ---
> v2: Added missing Cc:. Sorry for the noise.
>
> Doug:
>     I didn't add your Tested-by: since I added more code.
>     It would be great if you can re-test.
>
>  drivers/usb/typec/tcpm/tcpm.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.=
c
> index fba32d84e578..77f71f602f73 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -379,7 +379,8 @@ static enum tcpm_state tcpm_default_state(struct tcpm=
_port *port)
>                         return SNK_UNATTACHED;
>                 else if (port->try_role =3D=3D TYPEC_SOURCE)
>                         return SRC_UNATTACHED;
> -               else if (port->tcpc->config->default_role =3D=3D TYPEC_SI=
NK)
> +               else if (port->tcpc->config &&
> +                        port->tcpc->config->default_role =3D=3D TYPEC_SI=
NK)
>                         return SNK_UNATTACHED;
>                 /* Fall through to return SRC_UNATTACHED */
>         } else if (port->port_type =3D=3D TYPEC_PORT_SNK) {
> @@ -4114,7 +4115,7 @@ static int tcpm_try_role(const struct typec_capabil=
ity *cap, int role)
>         mutex_lock(&port->lock);
>         if (tcpc->try_role)
>                 ret =3D tcpc->try_role(tcpc, role);
> -       if (!ret && !tcpc->config->try_role_hw)
> +       if (!ret && (!tcpc->config || !tcpc->config->try_role_hw))
>                 port->try_role =3D role;
>         port->try_src_count =3D 0;
>         port->try_snk_count =3D 0;
> @@ -4701,7 +4702,7 @@ static int tcpm_copy_caps(struct tcpm_port *port,
>         port->typec_caps.prefer_role =3D tcfg->default_role;
>         port->typec_caps.type =3D tcfg->type;
>         port->typec_caps.data =3D tcfg->data;
> -       port->self_powered =3D port->tcpc->config->self_powered;
> +       port->self_powered =3D tcfg->self_powered;
>
>         return 0;
>  }
> --
> 2.7.4
>
