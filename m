Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 051A9C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 09:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA1E22082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 09:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553679532;
	bh=pOeUWjCEjqIPYdUtHTlQaKJz1adP8wMYU1VnogojRwc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eIiUdQuMsewhB6yRJhWPW9HlevkR7O8GWSURZPQFoIYeNfUAFARqV0wHgLnxqvlAH
	 kWwbCqQB04NpjxvtUVw/nqX+FISHrwB8RQcqTwjtwhe88tx+2OyGj/LOFgOVNKpXGx
	 LZl7LJ0+WKNbe7KcD6LGXrr1TnyF/XyHTYjF0SiI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732800AbfC0Jiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 05:38:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:33012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726305AbfC0Jis (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 05:38:48 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0806D2075E;
        Wed, 27 Mar 2019 09:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553679527;
        bh=pOeUWjCEjqIPYdUtHTlQaKJz1adP8wMYU1VnogojRwc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pOA6xN9juyvv9kYIKtV8CnmOfs9/oyjAdOTiBHgXUVfeuzJT74x8WEuf+GEjBCNAC
         FtI/klsvaLwZG1bx3zfkHj4RIrhRu1H9I0F0PYpBn+qP1XyY/rhrb/8Wr7ZhBV30+o
         vzibzrxCOHrlAM+E2EIZMz6lnzkm8AWEoDKaeJLQ=
Date:   Wed, 27 Mar 2019 11:38:44 +0200
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
Message-ID: <20190327093844.GO22899@mtr-leonro.mtl.com>
References: <20190327090905.5588-1-leon@kernel.org>
 <fef570d91276280f055a0b1c2561b3dd8e20a0c3.camel@perches.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="W/+CTqSGWdiRg+8j"
Content-Disposition: inline
In-Reply-To: <fef570d91276280f055a0b1c2561b3dd8e20a0c3.camel@perches.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--W/+CTqSGWdiRg+8j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 27, 2019 at 02:17:40AM -0700, Joe Perches wrote:
> On Wed, 2019-03-27 at 11:09 +0200, Leon Romanovsky wrote:
> > Kernel is booted with less possible CPUs (possible_cpus kernel boot
> > option) than available CPUs will have prints like this:
> []
> > diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
> []
> > @@ -2305,9 +2305,9 @@ int generic_processor_info(int apicid, int version)
> >  	if (num_processors >= nr_cpu_ids) {
> >  		int thiscpu = max + disabled_cpus;
> >
> > -		pr_warning("APIC: NR_CPUS/possible_cpus limit of %i "
> > -			   "reached. Processor %d/0x%x ignored.\n",
> > -			   max, thiscpu, apicid);
> > +		pr_debug(
> > +			"APIC: NR_CPUS/possible_cpus limit of %i reached. Processor %d/0x%x ignored.\n",
> > +			max, thiscpu, apicid);
>
> 2 lines please
>
> 		pr_debug("APIC: etc...",
> 			 max, thiscpu, ...);

It was two lines before, but I changed for two reasons:
 * It helped me to grep the source code to find the origin of dmesg warning.
 * i got checkpatch warning about spitted string, can you please fix checkpatch do not complain?

>
> And this would probably be better as
>
> 		printk(KERN_DEBUG "APIC: etc...",
> 		 ...)
>
> to avoid the need to compile with DEBUG or enable
> with CONFIG_DYNAMIC_DEBUG

You don't need anything like this, just provide dyndbg parameters
through kernel command line.

Thanks

>
>
>

--W/+CTqSGWdiRg+8j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcm0SkAAoJEORje4g2clinN7QP/jZp/ADzvPaJ9EySTUBmx+9Z
AzQOi6t2y8WQfWIhYUbsXrDKRo9cE2EekNCpZyDj1XVFORoa1lPDAWsMZgY1Isgk
L6MXAt9NmdWXENzmADPdVmgnoEC93EM0+ZLiH9wjLMelAHe3R3ZJd7+ki/XG9h5O
4K1IVlZwZEx7jctvXKXl1AE5Kag2tntF2V1XFjxPDjoLpdKrUnIC2ceDzkSY+RQU
ivffCAaoXA92TysNzyXK+1kjNJkUBMro5Bn1jq5qdFBhc71PuCd3MfFNOm40aTRK
MeG4ncpSTOFFk5JnrYHnYJf9dQOVrN0KvvmT3Jxdy4tnfiJpn6aBd4jSpfcagtM7
N//+Bc1Cmyy41wCB2gaCKsU0C2/uF8Ca5AXN2jfCp8bel6cACHwSabTr7NgR6sRs
UL4K9b5WXycnH3fDMINDMlz6bcr4lbQ9ymlCNA5BP44DkQInHgdCgcjXcd31nQid
GbcDzrXoOf50ycNCEgVw6jcx1rHkcExcGMFQ3PkRJ6a1cYtgtq4MtTVOgsQrK64e
rrhZKhoDraLFQqshg6rBDB9n+P7kEZ00U+dKjsdXCWLjqbZBlv6npbDplbTIGvRJ
a7itpqOBI0/hmdhijj/9kBbuKiRJ98oV7j1ubu3HzKegObLFUQA5i2qWNu+9snmJ
bES/RlwjkYx6zd+Vuz29
=bJ+i
-----END PGP SIGNATURE-----

--W/+CTqSGWdiRg+8j--
