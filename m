Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA8FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 06:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 856F92075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 06:02:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OMzUCZ+S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732779AbfC0GCZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 02:02:25 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34982 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfC0GCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 02:02:24 -0400
Received: by mail-pl1-f193.google.com with SMTP id p19so2801575plo.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 23:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :user-agent:message-id:content-transfer-encoding;
        bh=KzoF20xLXXHyuCyJwFWJTRtr4sQQnjQpJ/lE1vgkmDI=;
        b=OMzUCZ+SoT5qG9yhUgwjX7tjNPt4pdrwVBKikzC8q4ys0U+U7jlniqAK67wQfpn2Sb
         ycL2UxyNUjumwbILINLWnq/pk+DeQjNZAnF7oC/Q7YwV0tNl4dPnnNyoeMIYuJIkrITH
         HQtirbdtYx7gOu7gvMyTjQd/3V0MgNfR0kec7bRMlp37RyhZ/RPwlrp3El9CQzfCrVUO
         FIaFeD0tRgDQIJFdbMOYrjTzpJidV74U8FjXIJzX9+zEeQsrJAeVSYpjJu2jf5E4kLVD
         hKLiITEYF51aeNiB8DeaRm9eu+j/tl/nSK9VJKebZmzf/dJF2OSWgtgfj63NwJ6cz+Xm
         guvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:user-agent:message-id:content-transfer-encoding;
        bh=KzoF20xLXXHyuCyJwFWJTRtr4sQQnjQpJ/lE1vgkmDI=;
        b=CEUT1I0SDyh9E/LsFhCB8DNHlLGQJIpCnALIEc14kTVxewUEwbvi4hxNbHsX+47A73
         wTsj9YNB31CetNrcSw9RtJlNeb6DFpfgFAIHIO6/xgupPtoSqAgoLO4Z7TMOADX07X0/
         Ykzwl79i2gnRPq9wh1C8MKYXULADXvdUXUo87QR/ON5Q4kaafePkn8Nz/wiFx2B4/7/U
         +atrhEAv+WyYLzfM4rb1hxi2TN0BurKTz7tKn/WKsty1YgDgjoqAuw0lX2YZ6H4aBybl
         B3z5Ybkh2AM9kl5/9F1RQTFf2yAAbopcWjl+ImiNX6IlAPkcXwhdq5j9nRlbWg2IIlDg
         NEDg==
X-Gm-Message-State: APjAAAW9zoky7GTI8COCnQpBJvA6EegO5zlYn2rNWpbN64psjX5Mgk2j
        NLpneAq9XYJmv8/ZcVQ92Ok=
X-Google-Smtp-Source: APXvYqxZoXL+IoJDc/8cBoh2N4FAo4Gu3+AaV6eO4N/9bOzKfQAxU7wuWbbkiFSkSI5928eYORtmZw==
X-Received: by 2002:a17:902:6b8c:: with SMTP id p12mr35900971plk.282.1553666543898;
        Tue, 26 Mar 2019 23:02:23 -0700 (PDT)
Received: from localhost (14-202-58-188.tpgi.com.au. [14.202.58.188])
        by smtp.gmail.com with ESMTPSA id w123sm31329456pfw.72.2019.03.26.23.02.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Mar 2019 23:02:23 -0700 (PDT)
Date:   Wed, 27 Mar 2019 16:02:16 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2]  arch/powerpc: Rework local_paca to avoid LTO warnings
To:     Alastair D'Silva <alastair@au1.ibm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        =?iso-8859-1?q?Mahesh=0A?= Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        =?iso-8859-1?q?Mike=0A?= Rapoport <rppt@linux.vnet.ibm.com>
References: <20190313034208.13134-1-alastair@au1.ibm.com>
        <20190314023125.10076-1-alastair@au1.ibm.com>
        <1553579424.0r39b9otz6.astroid@bobo.none>
        <8d8a97e145758b92c2760012373f5217877a035c.camel@au1.ibm.com>
In-Reply-To: <8d8a97e145758b92c2760012373f5217877a035c.camel@au1.ibm.com>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1553665102.ow7h62jw1u.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alastair D'Silva's on March 27, 2019 2:37 pm:
> On Tue, 2019-03-26 at 15:58 +1000, Nicholas Piggin wrote:
>> Alastair D'Silva's on March 14, 2019 12:31 pm:
>> > From: Alastair D'Silva <alastair@d-silva.org>
>> >=20
>> > When building an LTO kernel, the existing code generates warnings:
>> >     ./arch/powerpc/include/asm/paca.h:37:30: warning: register of
>> >         =E2=80=98local_paca=E2=80=99 used for multiple global register=
 variables
>> >      register struct paca_struct *local_paca asm("r13");
>> >                                   ^
>> >     ./arch/powerpc/include/asm/paca.h:37:30: note: conflicts with
>> >         =E2=80=98local_paca=E2=80=99
>>=20
>> Isn't this a bogus warning? It doesn't look like there's a way to=20
>> define it any other way.
>=20
> There isn't any other way to define it as a global. However, the
> warning is legitimate.
>=20
> The compiler sees that there are multiple global register variables,
> all pointing at the same register.

It's one variable though, so it's not a legitimate warning (unless
there is a way to declare a "reference" to it that we are not doing).

>=20
> The compiler can only determine this when LTO is used, as otherwise it
> only sees the one in the current compilation unit, whicd disappears by
> the time the kernel is linked.
>=20
>>=20
>> > This patch reworks local_paca into an inline getter & setter
>> > function,
>> > which addresses the warning.
>> >=20
>> > Changelog:
>> > V2
>> >   - Address whitespace issues
>> >   - keep new implementation close to where the old implementation
>> > was
>> >=20
>> > Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
>> > ---
>> >  arch/powerpc/include/asm/paca.h | 37 +++++++++++++++++++++++++--
>> > ------
>> >  arch/powerpc/kernel/paca.c      |  2 +-
>> >  2 files changed, 29 insertions(+), 10 deletions(-)
>> >=20
>> > diff --git a/arch/powerpc/include/asm/paca.h
>> > b/arch/powerpc/include/asm/paca.h
>> > index e843bc5d1a0f..2fa0b43357c9 100644
>> > --- a/arch/powerpc/include/asm/paca.h
>> > +++ b/arch/powerpc/include/asm/paca.h
>> > @@ -34,19 +34,38 @@
>> >  #include <asm/cpuidle.h>
>> >  #include <asm/atomic.h>
>> > =20
>> > -register struct paca_struct *local_paca asm("r13");
>> > -
>> >  #if defined(CONFIG_DEBUG_PREEMPT) && defined(CONFIG_SMP)
>> >  extern unsigned int debug_smp_processor_id(void); /* from
>> > linux/smp.h */
>> > -/*
>> > - * Add standard checks that preemption cannot occur when using
>> > get_paca():
>> > - * otherwise the paca_struct it points to may be the wrong one
>> > just after.
>> > - */
>> > -#define get_paca()	((void) debug_smp_processor_id(), local_paca)
>> > -#else
>> > -#define get_paca()	local_paca
>> >  #endif
>> > =20
>> > +static inline struct paca_struct *get_paca_no_preempt_check(void)
>> > +{
>> > +	register struct paca_struct *paca asm("r13");
>> > +
>> > +	return paca;
>> > +}
>>=20
>> Problem is it now changes the global register variable to a local=20
>> register variable. The compiler would presumably be within its rights
>> to "cache" that return value or use another register for it, which
>> is not really what we want.
>>=20
>>=20
>=20
> I've confirmed that at least with GCC 8.2.0, the generated assembler is
> similar, but yes, the compiler may be free to take a copy into another
> register (although that would be a terrible optimisation), and then
> operate on that value.

Yep.

>=20
> Subsequent uses would still have to call the function (ie. fetch the
> data from r13) regardless, so I believe this scenario is safe.
>=20
> Can you think of a scenario where this is a problem?

It wouldn't be the subsequent use but the one use. If you're preempted
then you can't be using a stale r13 value.

Quite possibly any bug like that would already be buggy now, the cases
where it matters tend to need asm to access it. And it's something we
need to really audit and have proper accessors and preempt warnings
that Ben always harped on about.

But to just work around this warning it seems pretty dangerous to
change this and hope.

Thanks,
Nick

=
