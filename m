Return-Path: <SRS0=HQPa=VE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8EB9C48BDB
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 18:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F3BE20828
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 18:45:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PyLd6w4B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbfGGSpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 14:45:23 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37795 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbfGGSpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 14:45:22 -0400
Received: by mail-wr1-f67.google.com with SMTP id n9so5519864wrr.4
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jul 2019 11:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SyoEZcNMbR30dSLw6YPvBoKoR6uCpMhPS8yqLfypSMU=;
        b=PyLd6w4BNDFzkyrp8BS4diLjeNVJmjAM1OzVBD8hu8DoZ6DixOPh1q5GV5BH49+9cD
         Gw7calZ1w1+8ub6Ix0hss75VejmzHsp4gVflIoksrUy0nXJjwo9zXry1WzvBKx/HQCn9
         GCVbIxbgLZ+Ax6x3xjvKYM6FDLtaX+HXST1EzSQYiuqbZDaL9gvH2u5eQq8XvwVsIwoI
         FZWgcpYjmOtalGhZ7pyXDIqPEcFKHoxx7PFs8NyAirhOX5cd34W0+/W635JhJwUlPs75
         2I6EjzbUAERHWWg1nOR4tLtcdjPqhblH7k/1Tu0Qmw+Jl9srPdz7ksW6m1fnkd2naet+
         FgCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SyoEZcNMbR30dSLw6YPvBoKoR6uCpMhPS8yqLfypSMU=;
        b=lM6tGTrYGuGjPRCPWjj+LgCrheRyBbNJZjI3VewUJKqdPv5vPjHcukvQd313bGIwBD
         rQHjOh7n2vCTcahS4OTwKUeTuYQtbD0fiP02rwPWB54Jc4j0QcjvImeDXyVnEwoVcyUQ
         5ne8yUSIJGJ9ZHd7C5m3eIDdhZl/S9jQm8Aw+W6MXsJw/ZsyzHjO9YDpNG/pkBq5/Ia+
         rR4kXK9qNRwLcOLCgUaCiKmkiPZyQUy7Fc20Yy1Mzl6MsYtl+ZS8DZvkIaIvu6AiFYya
         f65gpnPu+EIVK3ZID8rRLE+LijVW+WM8sGY1tky4ytJx2ghA0qCcesoTK9/naUUPzVUe
         fwrg==
X-Gm-Message-State: APjAAAW9hxkeH2yF4veb9GwaOS6ncVHIbuXWvzPR2AB82DvDxoDWqN/O
        FgzkyjA0PrtweF0rKSkSJphldE1xg4Hm8hB7/WQ=
X-Google-Smtp-Source: APXvYqzTGv24J/JvH7QB35BSNC+3DNS4muQ9GiM7duKJwTzddTzS/wguXzLR8Zqt09/cXTfwYRoi3r7O81pYoZG9S4Q=
X-Received: by 2002:adf:ea8b:: with SMTP id s11mr14234198wrm.100.1562525120417;
 Sun, 07 Jul 2019 11:45:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190627070745.9561-1-yamada.masahiro@socionext.com> <363893471.18166.1561621193771.JavaMail.zimbra@nod.at>
In-Reply-To: <363893471.18166.1561621193771.JavaMail.zimbra@nod.at>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Sun, 7 Jul 2019 20:45:08 +0200
Message-ID: <CAFLxGvz-ukX9BucZ8iGzioJC1iT2Q=jubHBJep6Zup6pogYVJQ@mail.gmail.com>
Subject: Re: [PATCH] mtd: abi: do not use C++ style comments in uapi header
To:     Richard Weinberger <richard@nod.at>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2019 at 9:40 AM Richard Weinberger <richard@nod.at> wrote:
>
> ----- Urspr=C3=BCngliche Mail -----
> > Von: "Masahiro Yamada" <yamada.masahiro@socionext.com>
> > An: "David Woodhouse" <dwmw2@infradead.org>, "Brian Norris" <computersf=
orpeace@gmail.com>, "Marek Vasut"
> > <marek.vasut@gmail.com>, "Miquel Raynal" <miquel.raynal@bootlin.com>, "=
richard" <richard@nod.at>, "Vignesh Raghavendra"
> > <vigneshr@ti.com>, "linux-mtd" <linux-mtd@lists.infradead.org>
> > CC: "Masahiro Yamada" <yamada.masahiro@socionext.com>, "linux-kernel" <=
linux-kernel@vger.kernel.org>
> > Gesendet: Donnerstag, 27. Juni 2019 09:07:45
> > Betreff: [PATCH] mtd: abi: do not use C++ style comments in uapi header
>
> > Linux kernel tolerates C++ style comments these days. Actually, the
> > SPDX License tags for .c files start with //.
> >
> > On the other hand, uapi headers are written in more strict C, where
> > the C++ comment style is forbidden.
> >
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>
> Acked-by: Richard Weinberger <richard@nod.at>

Applied. :-)

--=20
Thanks,
//richard
