Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 409A2C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 23:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEFDC21019
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 23:54:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="q4tx4eEs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbfCMXyp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 19:54:45 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33322 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbfCMXyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 19:54:45 -0400
Received: by mail-pg1-f194.google.com with SMTP id h11so2674653pgl.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 16:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version:content-transfer-encoding;
        bh=4r1t1dMqNtFks28Rn2JjRV6yw+6RsCTbtKIKKd7oQmA=;
        b=q4tx4eEsEbYudnlQn7kAa8a/5AEE/S3NHEv3hQ0QWs0lqGoycQ1lImoPF4WG8bskUM
         pDAjHTnDcv/Xc8GPNvHCU2V1zNhuroC6V39bEPgM0EWPMPsG3Vlj/Ha9VKqy6J7dQCkO
         /xLGd7dVxzBER1NQ73UK+aBfy7qNwnjJ+xvAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=4r1t1dMqNtFks28Rn2JjRV6yw+6RsCTbtKIKKd7oQmA=;
        b=EMvExc9UMoS/KGUvTApJ4pdiHpCXnqNHLsTuH7I+IRotVfldvSuxdKpPBhicWdNLNk
         xXA1GVPw3GN+OSfYx2mt4HL2Ym1J97JeAI0ooH0EsK8jxHejKJrNgFkSSbnkeWksO6jf
         rqPysrqwCtu4NM6o5LGokvOXbXrHO89MzGHg2rGhIOzQtb/sOXTucQpT4TlFdAGnHscw
         zdYB379+/AS20tzx+6K/lByQ6tBx4urqktrKSZHkPeHQVG13nU/lxRit06HfiAT3uTC/
         AVHrpkUFSzxRkILwNpZsyRCb16ck/Qb7yHjM07jdiRuqgeXWAPhhb7IkhESQI2BnOvRy
         Wdjg==
X-Gm-Message-State: APjAAAXpnbW5PupBDYSW/Ec1nWU1WPtq/HP1Y2EB2B+E6ZsWsz4H2hZB
        G+2aOOHTSNcRUJV5HUUctYekR6SCi1g/9Q==
X-Google-Smtp-Source: APXvYqxYcxkGiP+q+kR2RNQ4sqFTC6V+SP1sQIio44bFpazQ8jfIUI+3D/TjuMQs2LtEgSIjEaPTVw==
X-Received: by 2002:a63:1602:: with SMTP id w2mr13338023pgl.406.1552521283908;
        Wed, 13 Mar 2019 16:54:43 -0700 (PDT)
Received: from localhost (124-171-209-25.dyn.iinet.net.au. [124.171.209.25])
        by smtp.gmail.com with ESMTPSA id l184sm19982642pfc.41.2019.03.13.16.54.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Mar 2019 16:54:42 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     Alastair D'Silva <alastair@au1.ibm.com>
Cc:     Alastair D'Silva <alastair@d-silva.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] arch/powerpc: Rework local_paca to avoid LTO warnings
In-Reply-To: <20190313034208.13134-1-alastair@au1.ibm.com>
References: <20190313034208.13134-1-alastair@au1.ibm.com>
Date:   Thu, 14 Mar 2019 10:54:39 +1100
Message-ID: <87ef7atjnk.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Alastair D'Silva" <alastair@au1.ibm.com> writes:

> From: Alastair D'Silva <alastair@d-silva.org>
>
> When building an LTO kernel, the existing code generates warnings:
>     ./arch/powerpc/include/asm/paca.h:37:30: warning: register of
>         =E2=80=98local_paca=E2=80=99 used for multiple global register va=
riables
>      register struct paca_struct *local_paca asm("r13");
>                               ^
>     ./arch/powerpc/include/asm/paca.h:37:30: note: conflicts with
>         =E2=80=98local_paca=E2=80=99
>
> This patch reworks local_paca into an inline getter & setter function,
> which addresses the warning.
>
> Generated ASM from this patch is broadly similar (addresses have
> changed and the compiler uses different GPRs in some places).

Ditto to Christophe's comment; I'd love to know how to build this so I
can actually see the differences. Perhaps you could bundle up all the
required changes and send it as a patch series with a cover letter
explaining this?

> +static inline struct paca_struct *get_paca_no_preempt_check(void)
> +{
> +	register struct paca_struct *paca asm("r13");
> +	return paca;
> +}

Isn't the convention to have the { on the same line as the function, or
am I horrible mis-remembering things?

Should these functions be __always_inline?

Regards,
Daniel

> +
> +static inline struct paca_struct *get_paca(void)
> +{
> +#if defined(CONFIG_DEBUG_PREEMPT) && defined(CONFIG_SMP)
> +	/*
> +	 * Add standard checks that preemption cannot occur when using get_paca=
():
> +	 * otherwise the paca_struct it points to may be the wrong one just aft=
er.
> +	 */
> +	debug_smp_processor_id();
> +#endif
> +	return get_paca_no_preempt_check();
> +}
> +
> +#define local_paca	get_paca_no_preempt_check()
> +
> +static inline void set_paca(struct paca_struct *new)
> +{
> +	register struct paca_struct *paca asm("r13");
> +	paca =3D new;
> +}
> +
> +
>  extern void copy_mm_to_paca(struct mm_struct *mm);
>  extern struct paca_struct **paca_ptrs;
>  extern void initialise_paca(struct paca_struct *new_paca, int cpu);
> diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
> index 913bfca09c4f..ae5c243f9d5a 100644
> --- a/arch/powerpc/kernel/paca.c
> +++ b/arch/powerpc/kernel/paca.c
> @@ -172,7 +172,7 @@ void __init initialise_paca(struct paca_struct *new_p=
aca, int cpu)
>  void setup_paca(struct paca_struct *new_paca)
>  {
>  	/* Setup r13 */
> -	local_paca =3D new_paca;
> +	set_paca(new_paca);
>=20=20
>  #ifdef CONFIG_PPC_BOOK3E
>  	/* On Book3E, initialize the TLB miss exception frames */
> --=20
> 2.20.1
