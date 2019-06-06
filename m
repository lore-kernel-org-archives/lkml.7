Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3643C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 09:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BC742070B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 09:01:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="FB10sAGB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbfFFJBA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 05:01:00 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:60762 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727450AbfFFJBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 05:01:00 -0400
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x5690csu027438
        for <linux-kernel@vger.kernel.org>; Thu, 6 Jun 2019 18:00:39 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x5690csu027438
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1559811640;
        bh=TBwtdfm16uGyBAXSj/TNuY/KhFKFlouLYXyh5UH4Y40=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FB10sAGBQSJIApf3wQAOgtgLqwKuP4kG5Ac7dNBDlaJ7+1tNGZBp1UUpf0A0bsFHF
         b7QEqa9u5vvp/olgm9EW295zjBuLLa3auQ8qsUk5y+KFTB6S2On/Ww/A2VzxpG0FyR
         C2ljWxkfeDk926BSSi0iskGazGgnrzL09vJEc9triKWx3GQg3O7jkX4gb5Ecp/4YNS
         RCV2qIdkXJvRG1mL0wd6Q+zeLe7JUt65zm8XxPenZ/6DTfiNrFTTiiPpXgRpVPjau0
         5Kgs46dpqtYsQlQ46yEhvFTAhcatPAH2zZqgrb2/ZcHjhQmM3WYi2JkZ9cjhNY9DA6
         6ZAmgR6b7VVoQ==
X-Nifty-SrcIP: [209.85.217.50]
Received: by mail-vs1-f50.google.com with SMTP id n21so739527vsp.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 02:00:39 -0700 (PDT)
X-Gm-Message-State: APjAAAW2j+c3bzUL5AjdQ0bXaNaAgJtaILEo4nv6WBAl5eaZZqRilCm7
        y9LMKHE9h8cw+dN2V/UYaQdVduq0R04i2i/AyYg=
X-Google-Smtp-Source: APXvYqwb6RbzmXpl729o6DP9QlUu6snm+nAvBpVaX/mpqeH8Au7h14UR5ZfnVhlceWVEmWYfPAR6PjkdLjEHX/TcxMU=
X-Received: by 2002:a67:ed04:: with SMTP id l4mr6217862vsp.179.1559811638421;
 Thu, 06 Jun 2019 02:00:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190604111632.22479-1-yamada.masahiro@socionext.com>
 <90aa6d91-7592-17b0-17fd-e33676bd0a46@linux.ibm.com> <CAK7LNASV9Chjd+o3+2ZbA0WHu=dVBFf2AC1dT=eLSf3_2pe12Q@mail.gmail.com>
 <ab22b27e-dd07-1c83-af60-19403c98c6a2@linux.ibm.com>
In-Reply-To: <ab22b27e-dd07-1c83-af60-19403c98c6a2@linux.ibm.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 6 Jun 2019 18:00:02 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ2eurVdK=uu=ysExjpbXPY+SaPatad-SGv8T4JfDmXew@mail.gmail.com>
Message-ID: <CAK7LNAQ2eurVdK=uu=ysExjpbXPY+SaPatad-SGv8T4JfDmXew@mail.gmail.com>
Subject: Re: [PATCH] ocxl: do not use C++ style comments in uapi header
To:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Frederic Barrat <fbarrat@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Joe Perches <joe@perches.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Donnellan <ajd@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On Wed, Jun 5, 2019 at 3:18 PM Andrew Donnellan <ajd@linux.ibm.com> wrote:
>
> On 4/6/19 10:12 pm, Masahiro Yamada wrote:
> > On Tue, Jun 4, 2019 at 8:54 PM Frederic Barrat <fbarrat@linux.ibm.com> =
wrote:
> >>
> >>
> >>
> >> Le 04/06/2019 =C3=A0 13:16, Masahiro Yamada a =C3=A9crit :
> >>> Linux kernel tolerates C++ style comments these days. Actually, the
> >>> SPDX License tags for .c files start with //.
> >>>
> >>> On the other hand, uapi headers are written in more strict C, where
> >>> the C++ comment style is forbidden.
> >>>
> >>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> >>> ---
> >>
> >> Thanks!
> >> Acked-by: Frederic Barrat <fbarrat@linux.ibm.com>
> >>
> >
> > Please hold on this patch until
> > we get consensus about the C++ comment style.
> >
> > Discussion just started here:
> > https://lore.kernel.org/patchwork/patch/1083801/
>
> If you choose to proceed with this patch:
>
> Acked-by: Andrew Donnellan <ajd@linux.ibm.com>

After some discussion,
the other one was applied to the media subsystem.

Please pick up this one with Frederic and Andrew's Ack.

Thanks.



--=20
Best Regards
Masahiro Yamada
