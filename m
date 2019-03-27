Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CED2C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 09:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B85B2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 09:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553680424;
	bh=T//uHA5hkqtEWcnHai/yejvB8VFvtTa1/LR1juTMOGY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uq0jDfgQ9F807xHf4EBwoiRlxzoQr4QI6p6k8km6Vo816Tw/MiZYuwGx0V8lW/vq6
	 N69aMlyHXZTfn0vRq+MDyNKHOviHXtQnCEVfTvFJoTAixvVAya2EREXtg1g/8Y7yX1
	 6ZrV3M7BRYpPXA4SogbQ9fci5EjPre0bzfZ37a9E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732739AbfC0Jxn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 05:53:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:37414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726319AbfC0Jxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 05:53:42 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83A8E2075C;
        Wed, 27 Mar 2019 09:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553680421;
        bh=T//uHA5hkqtEWcnHai/yejvB8VFvtTa1/LR1juTMOGY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LPU+LwwKmBwFxUw5rroNzSm+BVjxaVkdw71UdkxcyTFRStpgGv+m/yhIWVhUa8poi
         DrWGoS1Y5GEVEAXtY43fxk+fDwNsrCnpprubku0tSMivipVxGtVmOqJx7zPx/UJXtm
         lKv1TrxkWdr7MfeWYuLC1HR8OD0T/r6V3UIfEHk0=
Date:   Wed, 27 Mar 2019 11:53:37 +0200
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
Message-ID: <20190327095337.GP22899@mtr-leonro.mtl.com>
References: <20190327090905.5588-1-leon@kernel.org>
 <fef570d91276280f055a0b1c2561b3dd8e20a0c3.camel@perches.com>
 <20190327093844.GO22899@mtr-leonro.mtl.com>
 <55774b1a8c82e94b2796c992889929f1da905d9b.camel@perches.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="iAzLNm1y1mIRgolD"
Content-Disposition: inline
In-Reply-To: <55774b1a8c82e94b2796c992889929f1da905d9b.camel@perches.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iAzLNm1y1mIRgolD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 27, 2019 at 02:49:02AM -0700, Joe Perches wrote:
> On Wed, 2019-03-27 at 11:38 +0200, Leon Romanovsky wrote:
> > On Wed, Mar 27, 2019 at 02:17:40AM -0700, Joe Perches wrote:
> > > On Wed, 2019-03-27 at 11:09 +0200, Leon Romanovsky wrote:
> > > > Kernel is booted with less possible CPUs (possible_cpus kernel boot
> > > > option) than available CPUs will have prints like this:
> > > []
> > > > diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
> > > []
> > > > @@ -2305,9 +2305,9 @@ int generic_processor_info(int apicid, int version)
> > > >  	if (num_processors >= nr_cpu_ids) {
> > > >  		int thiscpu = max + disabled_cpus;
> > > >
> > > > -		pr_warning("APIC: NR_CPUS/possible_cpus limit of %i "
> > > > -			   "reached. Processor %d/0x%x ignored.\n",
> > > > -			   max, thiscpu, apicid);
> > > > +		pr_debug(
> > > > +			"APIC: NR_CPUS/possible_cpus limit of %i reached. Processor %d/0x%x ignored.\n",
> > > > +			max, thiscpu, apicid);
> > >
> > > 2 lines please
> > >
> > > 		pr_debug("APIC: etc...",
> > > 			 max, thiscpu, ...);
> >
> > It was two lines before, but I changed for two reasons:
> >  * It helped me to grep the source code to find the origin of dmesg warning.
> >  * i got checkpatch warning about spitted string, can you please fix checkpatch do not complain?
>
> Yes, use
>
> 	pr_debug("APIC: NR_CPUS/possible_cpus limit of %i reached. Processor %d/0x%x ignored.\n",
> 		 max, thiscpu, apicid);

Ahh, I see, I got such change from clang formatter.

>
> or better
>
> 	printk(KERN_DEBUG "APIC: NR_CPUS/possible_cpus limit of %i reached. Processor %d/0x%x ignored.\n",
> 	       max, thiscpu, apicid);
>
> > > And this would probably be better as
> > >
> > > 		printk(KERN_DEBUG "APIC: etc...",
> > > 		 ...)
> > >
> > > to avoid the need to compile with DEBUG or enable
> > > with CONFIG_DYNAMIC_DEBUG
> >
> > You don't need anything like this, just provide dyndbg parameters
> > through kernel command line.
>
> That assumes CONFIG_DYNAMIC_DEBUG is always enabled,
> and it is not enabled in many .config files.

No problem.

Thanks

>
>

--iAzLNm1y1mIRgolD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcm0ghAAoJEORje4g2clin2TkQAL5lsnCzSU+icL1QOf/R3agE
/yqUK/BooXbO2coECOqeqBQi6zMHSopgd7cP1at5E2ejcMvSU/dyBcrKRVhlCY3H
6NXDkxLwg/ApLUR1qfgE3mxSiMgvPPyQioaOSKJOmhnufsPfFI8agxtXGCvMXu7v
NlGNZQDb77UhxLZ1srbP6ArAPZpViwfDKI8e0iB53drTGwX+eA2AOxo0l7xOY/Rz
DMFvGzJ1V8pXt48idho6kMpPaBCn+6tqkPvs7ToGaeYoo8o1qRbprc83GfxvWGtT
A6BEfzk1MqSEg7T/a4E6ZAa4qVgqKBaXbk1sCUbzQ9ZfZmB44Lz56xaJky5ck7qS
0iiJULobEMHSqQLq7KiBUWRbkCooYulT0z1zXgZ/O/BmgURQjaT34+gArqsqIOsU
92qzMlhnPGjOzmdJRaa5Mx7FzOSQYKz/pCbjSRpNwTD7tSzULF76McZ38hNb1/TG
E2e6ggtSRkadV3mtFggBSTEuaPONS/Wytpj6g+9waPdRvBqcK39waTPusa0df4s7
K+5KyVvKp32euBl+xpZ6uACQacuVkB5j6mBA6kGysLLeYLOGHFa7G4eJiXKi6fGr
NAZ6793PrZzGmAyyZtnpZ9h1iK3eeDVolILUqxYZy3fX6K4vI5sVhEYsGreclifT
aeQE8DMQjDTuzExzqlQ/
=uaJK
-----END PGP SIGNATURE-----

--iAzLNm1y1mIRgolD--
