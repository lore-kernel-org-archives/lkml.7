Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 458E9C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 16:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B8DC2073B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 16:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576167402;
	bh=tgDhKutPNXEnJqeGjZlKDDqcoxggWm3SHoc4L0ARkZg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XZNqwXOlTNFYAfMTTP/EnEk8npOi6nZ7RM4xxB1Yn+t4PQIA7W1mrlQAkM331o/IK
	 0cf3YCkmgs1IyFvnbfi2pzp7vTvysG5EkZPCICqItP4Mltu1BPNaNB3rBLE59Z49kQ
	 TnNFYZKCK1A7hhiqWBQj4wRn0xHc/6p6CWBv4stw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729828AbfLLQQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 11:16:41 -0500
Received: from foss.arm.com ([217.140.110.172]:52270 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729247AbfLLQQl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 11:16:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2269C30E;
        Thu, 12 Dec 2019 08:16:40 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9560D3F6CF;
        Thu, 12 Dec 2019 08:16:39 -0800 (PST)
Date:   Thu, 12 Dec 2019 16:16:38 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>, Paul Elliott <paul.elliott@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Amit Kachhap <amit.kachhap@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Andrew Jones <drjones@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Kristina =?utf-8?Q?Mart=C5=A1enko?= <kristina.martsenko@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Florian Weimer <fweimer@redhat.com>,
        Sudakshina Das <sudi.das@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH v4 03/12] mm: Reserve asm-generic prot flag 0x10 for arch
 use
Message-ID: <20191212161638.GG4310@sirena.org.uk>
References: <20191211154206.46260-1-broonie@kernel.org>
 <20191211154206.46260-4-broonie@kernel.org>
 <20191212104831.GD18258@arrakis.emea.arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yZnyZsPjQYjG7xG7"
Content-Disposition: inline
In-Reply-To: <20191212104831.GD18258@arrakis.emea.arm.com>
X-Cookie: We have DIFFERENT amounts of HAIR --
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yZnyZsPjQYjG7xG7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 12, 2019 at 10:48:32AM +0000, Catalin Marinas wrote:
> On Wed, Dec 11, 2019 at 03:41:57PM +0000, Mark Brown wrote:

> >  #define PROT_GROWSDOWN	0x01000000	/* mprotect flag: extend change to start of growsdown vma */
> >  #define PROT_GROWSUP	0x02000000	/* mprotect flag: extend change to end of growsup vma */

> Since the BTI will likely be merged before the MTE series, please
> consider reserving 0x20 as well. The updated patch, acked by Arnd:

Sure.

--yZnyZsPjQYjG7xG7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3yZ+UACgkQJNaLcl1U
h9AFgwf+JLQkNkowzE4VQZiMYNn6XUbklliB0rpWOXleb0MSu8ObNB1vPPCslwod
9rFNhVqYJjlcLT+QTOfTC1CybCvKF5/d/DqmqDydGwlZUe64Nig33rAbo2WsvRy7
Q6uZ6+zrz2pfhpOX3Hy8dt7nvxHd1mpwso9njbPcVS1LG29ib7y7cx/q8op4NcS0
t2ZNDzL5VLxNzCP0iGZJz4uvCHw8J16Ox8h0kxG9wWnGH0pKTLtV+LXU+7m9IIdi
ed8GP3QUtVZJ2iAE1mLBfeaheR2zEcBEHlNTyCrXlLBJt8B2pGFHa2tPfYFsLUbm
OehiEmVIVSCFQ5vfxOP+HPspmGnmLw==
=/Udg
-----END PGP SIGNATURE-----

--yZnyZsPjQYjG7xG7--
