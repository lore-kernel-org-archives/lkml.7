Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C828FA372C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 09:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0C35206C3
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 09:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=antmicro.com header.i=@antmicro.com header.b="VrcATMyU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733215AbfKGJ1e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 04:27:34 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:36298 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728051AbfKGJ1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 04:27:33 -0500
Received: by mail-il1-f194.google.com with SMTP id s75so1182261ilc.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 01:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=antmicro.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zxL2pu+aN0ZYRh9GalkED+BEbSMbqeXyiC5lDAJbwEg=;
        b=VrcATMyUB9gM2h1qTNrx6x5YrZ3FNEr1qyLafDIYgxlmwfFjsqta2N4xNBRvzebR+4
         BZ3b3ah/Aw87W/t81zuVu4SsbGYEc6gc/g3/b3VjTmzUOqhQFl7D+E5qWKRTrPltUdRM
         c22lL2pQqtbbN65Pi32E5QEG0JL5LgZ8ontZIBqmZWmVIKDPQ3L0XTyw7OsSWCPxdwHH
         UPNBZscOeDxelrb8gBYlPKFsz9v6R+VMitxFN4+NwB+Y4Ov2NigkJLa5vffsWwXNqK9b
         98zr3ITZjSGkhmeaQznpVGjKnMOZCIGDEnzsK4cCvLGgaud2Du0pSch5zggw9hrntqT5
         a+nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zxL2pu+aN0ZYRh9GalkED+BEbSMbqeXyiC5lDAJbwEg=;
        b=jYFhAyW4Y0zBUu/b46MSe42AVF+KnxuNw8ezsuQCS/UFqa9F4HRbxTLn9sHHprdbWW
         6gGdwjgiLMrSNncP3oMbyU8Bg8nMwij8Fb/P2gEcGnUFlyWCKPF2+3YEAGh+oCNgunkI
         SQKzUjubDv9AwC3N+iNj1D5Je8peOoCrw8f4D6GItZnkU2V1dnhYDApYZ/35Lj282r/n
         dXzVHkDqoek6cvmzKiULjCsX4OOahX8CSD1lur4RzDSQvP35cDQF/JsjPDs4u96yAVPj
         HX0HQU1puCrnclnZ4GUD4pKXJN2OYIjRdmkft0MalulNwcWnhgnvR7jGZvrnCGJAll0/
         prBA==
X-Gm-Message-State: APjAAAXEcpWnAiWE+Bb7tk0/gRqvqHNcLv/FRzv6IJl4eCwXvv3fhlqJ
        YuRRmCwacF/9cJlm3uAH4hUB+EL+0swZOEhN3cA+Hw==
X-Google-Smtp-Source: APXvYqw38hKm1x6/4pq2KfbrFU38zObiPQFdN2X04OcPIWVYeNi+hQaHBgFuDV5xYYxDsyS/D8qOOmpSMltMCoGQW4A=
X-Received: by 2002:a92:3b9a:: with SMTP id n26mr3239330ilh.82.1573118850734;
 Thu, 07 Nov 2019 01:27:30 -0800 (PST)
MIME-Version: 1.0
References: <20191023114634.13657-0-mholenko@antmicro.com> <20191023114634.13657-2-mholenko@antmicro.com>
 <20191026000345.GA10810@bogus>
In-Reply-To: <20191026000345.GA10810@bogus>
From:   Mateusz Holenko <mholenko@antmicro.com>
Date:   Thu, 7 Nov 2019 10:27:19 +0100
Message-ID: <CAPk366Qo916k_UggtMog875J98s5PkagiReJbO8s7eNpGZrr=g@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] litex: add common LiteX header
To:     Rob Herring <robh@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, devicetree@vger.kernel.org,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Stafford Horne <shorne@gmail.com>,
        Karol Gugala <kgugala@antmicro.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Filip Kokosinski <fkokosinski@internships.antmicro.com>,
        Joel Stanley <joel@jms.id.au>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Maxime Ripard <mripard@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sob., 26 pa=C5=BA 2019 o 02:03 Rob Herring <robh@kernel.org> napisa=C5=82(a=
):
>
> On Wed, Oct 23, 2019 at 11:47:04AM +0200, Mateusz Holenko wrote:
> > It provides helper CSR access functions used by all
> > LiteX drivers.
> >
> > Signed-off-by: Mateusz Holenko <mholenko@antmicro.com>
> > ---
> > This commit has been introduced in v2 of the patchset.
> >
> >  MAINTAINERS           |  6 +++++
> >  include/linux/litex.h | 59 +++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 65 insertions(+)
> >  create mode 100644 include/linux/litex.h
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 296de2b51c83..eaa51209bfb2 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -9493,6 +9493,12 @@ F:     Documentation/misc-devices/lis3lv02d.rst
> >  F:   drivers/misc/lis3lv02d/
> >  F:   drivers/platform/x86/hp_accel.c
> >
> > +LITEX PLATFORM
> > +M:   Karol Gugala <kgugala@antmicro.com>
> > +M:   Mateusz Holenko <mholenko@antmicro.com>
> > +S:   Maintained
> > +F:   include/linux/litex.h
> > +
> >  LIVE PATCHING
> >  M:   Josh Poimboeuf <jpoimboe@redhat.com>
> >  M:   Jiri Kosina <jikos@kernel.org>
> > diff --git a/include/linux/litex.h b/include/linux/litex.h
> > new file mode 100644
> > index 000000000000..e793d2d7c881
> > --- /dev/null
> > +++ b/include/linux/litex.h
> > @@ -0,0 +1,59 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Common LiteX header providing
> > + * helper functions for accessing CSRs.
> > + *
> > + * Copyright (C) 2019 Antmicro <www.antmicro.com>
> > + */
> > +
> > +#ifndef _LINUX_LITEX_H
> > +#define _LINUX_LITEX_H
> > +
> > +#include <linux/io.h>
> > +#include <linux/types.h>
> > +#include <linux/compiler_types.h>
> > +
> > +#define LITEX_REG_SIZE             0x4
> > +#define LITEX_SUBREG_SIZE          0x1
> > +#define LITEX_SUBREG_SIZE_BIT      (LITEX_SUBREG_SIZE * 8)
> > +
> > +#ifdef __LITTLE_ENDIAN
> > +# define LITEX_READ_REG(addr)                  ioread32(addr)
> > +# define LITEX_READ_REG_OFF(addr, off)         ioread32(addr + off)
> > +# define LITEX_WRITE_REG(val, addr)            iowrite32(val, addr)
> > +# define LITEX_WRITE_REG_OFF(val, addr, off)   iowrite32(val, addr + o=
ff)
> > +#else
> > +# define LITEX_READ_REG(addr)                  ioread32be(addr)
> > +# define LITEX_READ_REG_OFF(addr, off)         ioread32be(addr + off)
> > +# define LITEX_WRITE_REG(val, addr)            iowrite32be(val, addr)
> > +# define LITEX_WRITE_REG_OFF(val, addr, off)   iowrite32be(val, addr +=
 off)
>
> Defining custom accessors makes it harder for others to understand
> the code. The __raw_readl/writel accessors are native endian, so use
> those. One difference though is they don't have a memory barrier, but
> based on the below functions, you may want to do your own barrier
> anyways. And if DMA is not involved you don't need the barriers either.

LiteX CSRs are always little endian (even when combined with a big endian C=
PU),
so using just __raw_readl/writel won't work in all cases. This is the reaso=
n why
we proposed a custom accessors defined based on host CPU endianness.
Would adding a comment explaining this be enough or do you have other ideas=
?

> The _OFF variants don't add anything. LITEX_READ_REG(addr + off) is just
> as easy to read if not easier than LITEX_READ_REG_OFF(addr, off).

I agree, LITEX_READ_REG/LITEX_WRITE_REG is enough.

> > +#endif
> > +
> > +/* Helper functions for manipulating LiteX registers */
> > +
> > +static inline void litex_set_reg(void __iomem *reg, u32 reg_size, u32 =
val)
> > +{
> > +     u32 shifted_data, shift, i;
> > +
> > +     for (i =3D 0; i < reg_size; ++i) {
> > +             shift =3D ((reg_size - i - 1) * LITEX_SUBREG_SIZE_BIT);
> > +             shifted_data =3D val >> shift;
> > +             LITEX_WRITE_REG(shifted_data, reg + (LITEX_REG_SIZE * i))=
;
> > +     }
> > +}
>
> The problem with this is it hides whether you need to do any locking.
> Normally, you would assume a register access is atomic when it's not
> here. You could add locking in this function, but then you're doing
> locking even when not needed.
>
> It doesn't look like you actually use this in your series, so maybe
> remove until you do.

That's right. I added those functions in advance, having in mind
further drivers,
but maybe it will be better to drop them for now and re-introduce later.

> > +
> > +static inline u32 litex_get_reg(void __iomem *reg, u32 reg_size)
> > +{
> > +     u32 shifted_data, shift, i;
> > +     u32 result =3D 0;
> > +
> > +     for (i =3D 0; i < reg_size; ++i) {
> > +             shifted_data =3D LITEX_READ_REG(reg + (LITEX_REG_SIZE * i=
));
> > +             shift =3D ((reg_size - i - 1) * LITEX_SUBREG_SIZE_BIT);
> > +             result |=3D (shifted_data << shift);
> > +     }
> > +
> > +     return result;
> > +}
> > +
> > +#endif /* _LINUX_LITEX_H */
> > --
> > 2.23.0



--
Mateusz Holenko
Antmicro Ltd | www.antmicro.com
Roosevelta 22, 60-829 Poznan, Poland
