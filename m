Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B339C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 10:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E61102075D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 10:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553681500;
	bh=lb8kyi9UgtzW+n/NXE7ZRR8RfEqPmCtZuRkpLsoDdXw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZhwRTZAxQCE1WlK0w9DnC81+rRKgS+Pxupl/ODFpkuax0g3eg33m1f1bUj/AtTwwD
	 lAvRJRkaLCHBZNRaIrgj/wUgRAr8km8/XWDMftz3NX6zDZcu480vHBlrCkp002J6Bn
	 +345MC4hNRn10Xn7/yB7i08MootzNrNEco9oIHxs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733149AbfC0KLi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 06:11:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:46492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726305AbfC0KLi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 06:11:38 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 781862070B;
        Wed, 27 Mar 2019 10:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553681497;
        bh=lb8kyi9UgtzW+n/NXE7ZRR8RfEqPmCtZuRkpLsoDdXw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qKUKRJrRnFG++TI2shZDtwUlrmOphuOfmiK1WQ5fbgFs/AaqvVmLU/xF95le1v15T
         yk5SBJstfmeA/uXur9azIiLmOxHkK/DEcJnL8cU5FOvj3egrcIi+3ZEPPYlRgkpQQG
         V5CDdYimk5Oyh8SHZProSp09Tg/fzXyZLiD78q7o=
Date:   Wed, 27 Mar 2019 12:11:33 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86 <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-pm <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next v1] x86/apic: Reduce print level of CPU limit
 announcement
Message-ID: <20190327101133.GQ22899@mtr-leonro.mtl.com>
References: <20190327090905.5588-1-leon@kernel.org>
 <fef570d91276280f055a0b1c2561b3dd8e20a0c3.camel@perches.com>
 <20190327093844.GO22899@mtr-leonro.mtl.com>
 <55774b1a8c82e94b2796c992889929f1da905d9b.camel@perches.com>
 <20190327095337.GP22899@mtr-leonro.mtl.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="xtx0sNU5lZ46KfgK"
Content-Disposition: inline
In-Reply-To: <20190327095337.GP22899@mtr-leonro.mtl.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xtx0sNU5lZ46KfgK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 27, 2019 at 11:53:37AM +0200, Leon Romanovsky wrote:
> On Wed, Mar 27, 2019 at 02:49:02AM -0700, Joe Perches wrote:
> > On Wed, 2019-03-27 at 11:38 +0200, Leon Romanovsky wrote:
> > > On Wed, Mar 27, 2019 at 02:17:40AM -0700, Joe Perches wrote:
> > > > On Wed, 2019-03-27 at 11:09 +0200, Leon Romanovsky wrote:
> > > > > Kernel is booted with less possible CPUs (possible_cpus kernel boot
> > > > > option) than available CPUs will have prints like this:
> > > > []
> > > > > diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
> > > > []
> > > > > @@ -2305,9 +2305,9 @@ int generic_processor_info(int apicid, int version)
> > > > >  	if (num_processors >= nr_cpu_ids) {
> > > > >  		int thiscpu = max + disabled_cpus;
> > > > >
> > > > > -		pr_warning("APIC: NR_CPUS/possible_cpus limit of %i "
> > > > > -			   "reached. Processor %d/0x%x ignored.\n",
> > > > > -			   max, thiscpu, apicid);
> > > > > +		pr_debug(
> > > > > +			"APIC: NR_CPUS/possible_cpus limit of %i reached. Processor %d/0x%x ignored.\n",
> > > > > +			max, thiscpu, apicid);
> > > >
> > > > 2 lines please
> > > >
> > > > 		pr_debug("APIC: etc...",
> > > > 			 max, thiscpu, ...);
> > >
> > > It was two lines before, but I changed for two reasons:
> > >  * It helped me to grep the source code to find the origin of dmesg warning.
> > >  * i got checkpatch warning about spitted string, can you please fix checkpatch do not complain?
> >
> > Yes, use
> >
> > 	pr_debug("APIC: NR_CPUS/possible_cpus limit of %i reached. Processor %d/0x%x ignored.\n",
> > 		 max, thiscpu, apicid);
>
> Ahh, I see, I got such change from clang formatter.
>
> >
> > or better
> >
> > 	printk(KERN_DEBUG "APIC: NR_CPUS/possible_cpus limit of %i reached. Processor %d/0x%x ignored.\n",
> > 	       max, thiscpu, apicid);
> >
> > > > And this would probably be better as
> > > >
> > > > 		printk(KERN_DEBUG "APIC: etc...",
> > > > 		 ...)
> > > >
> > > > to avoid the need to compile with DEBUG or enable
> > > > with CONFIG_DYNAMIC_DEBUG
> > >
> > > You don't need anything like this, just provide dyndbg parameters
> > > through kernel command line.
> >
> > That assumes CONFIG_DYNAMIC_DEBUG is always enabled,
> > and it is not enabled in many .config files.
>
> No problem.

ok, I tested your variant and it still prints a t least on my systems,
so it won't solve my problem. I'll keep this patch as is.

Thanks for the review.

>
> Thanks
>
> >
> >



--xtx0sNU5lZ46KfgK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcm0xVAAoJEORje4g2clinwAkP/AqMkyPfgg3jJorgJEFjlDgG
yAU3UZD1CbLSjkGi1/QN3KxJDUsowtHNGL8S+a5Yx79AxGgBfj30uNahrr0SiXPq
8pk2ScTQZY9Bbp4UATALpnpml/OH7pePpKjKMY4c78Web/W6jPOesmpyxQ2CRGcs
f8SgmcFHZM80Rdn2oc3pAH1Gtmo3RK4BmUv5osi4QLogfJ/nKW2ztZPSqVuRlZxq
HIFzoTuZZd/grzHCVFicSjh1ahXF94wOlLnEBeeEtye0Ua5DsuurMV9tEEsuXW1S
3bcBbTAsN/UuBYehjk2oKS4qy2fhqajBHcbf7m5pxuT+dJXozY0+noRgh938OYgR
FP/9fHpjZTQWe671tngjBr4XihSyPBXKBgDallb6ztFJyJS3yRIDRAGeMVNlq5Jr
IbaU+m7SeIq0D8R/WTnnKLYTyii5uHvWQPqohimDRdExuLt5D3Cr1jzyVGc7wED2
tdfiEjzZyv1Nwy/PMWiJFXr+bI8+IvoWB7DHetSt9JGtDWqvcqs0/iCnfyaaw5xd
23AKveeVmJLbLdBZu7a0dSoZ0Q8hxeHctMVB9uS9eY5NGhH5xtlgIoGeD0wTT+zY
COVEOyP1eAHrHsvomdmWTwdPexuY+yBzVMxRvNxQ7YZH1Dx62cHp8eWMnZMlTd58
yzXVZG5Pkm1rDiwSSmuG
=cPX/
-----END PGP SIGNATURE-----

--xtx0sNU5lZ46KfgK--
