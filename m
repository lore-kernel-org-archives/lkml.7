Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 287CDC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 10:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9EDD2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 10:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553683831;
	bh=Db8mITDBz2auyZ/GAjUALWuQ3ahr4BmhZ6mHZNin5Lo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GQ+vS65trIDDXo5Gi0V6/xj0m0dQZ3wwFLTrAcpXRNO8AWJZbbS1DialXiTcBbOpp
	 JlApGydvzhvpUVhZWmRweb1mjLv+QrgaOMJQJKqe6iOwf6YrBA6oweHa4Z3F/vu+8j
	 K9zlx8vTZgIJ8KcCiSQyGDG028YPjLnlhZtjKtBQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732906AbfC0Ku3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 06:50:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:33160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731920AbfC0Ku3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 06:50:29 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84B0520811;
        Wed, 27 Mar 2019 10:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553683828;
        bh=Db8mITDBz2auyZ/GAjUALWuQ3ahr4BmhZ6mHZNin5Lo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AlhMQgrXVRS1eubCHKTZcMEcCeHQcM6pZDekeDmT27PfLdBPDv5XV76prGVNzUPAC
         izkoOUS/kht4PL82r4sgFK2QEnVbFbZklxoJJ79n488SJ7yv7aXWAyRi1FODOtyBO2
         tGO5OZu46FYItv6EoLORyK4ptpzEc7aVTaO9oicE=
Date:   Wed, 27 Mar 2019 12:50:24 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Joe Perches <joe@perches.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86 <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-pm <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next v1] x86/apic: Reduce print level of CPU limit
 announcement
Message-ID: <20190327105024.GR22899@mtr-leonro.mtl.com>
References: <20190327090905.5588-1-leon@kernel.org>
 <fef570d91276280f055a0b1c2561b3dd8e20a0c3.camel@perches.com>
 <20190327093844.GO22899@mtr-leonro.mtl.com>
 <55774b1a8c82e94b2796c992889929f1da905d9b.camel@perches.com>
 <20190327095337.GP22899@mtr-leonro.mtl.com>
 <20190327101133.GQ22899@mtr-leonro.mtl.com>
 <20190327101815.GB32571@zn.tnic>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="JLiXfqD9/Kt1b+Pq"
Content-Disposition: inline
In-Reply-To: <20190327101815.GB32571@zn.tnic>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JLiXfqD9/Kt1b+Pq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 27, 2019 at 11:18:15AM +0100, Borislav Petkov wrote:
> On Wed, Mar 27, 2019 at 12:11:33PM +0200, Leon Romanovsky wrote:
> > ok, I tested your variant and it still prints a t least on my systems,
>
> Probably because your loglevel is set to debug. And no, we don't want to
> have to enable some config option in order to see this.

It is how we are internally running verification and development,
with KERN_DEBUG level, we need it to catch bugs.

This "some config option" is dynamic debug prints and most probably it
is enabled in your or any kernel developer in the world.

Please let me know, If you insist on changing pr_debug to printk(KERN_DEBUG ...).

>
> Also, the ugly linebreak needs to go.
>
> --
> Regards/Gruss,
>     Boris.
>
> Good mailing practices for 400: avoid top-posting and trim the reply.

--JLiXfqD9/Kt1b+Pq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcm1VwAAoJEORje4g2clingcQP/RnB1Z/UVemM4hPlm3Y52Jcd
O2Sc9nSfQpilF1X1IBFWyMsgYrX2dhXM2xahRnF/EWtCnRm0QLbzYjhCu1ixiIMT
Kvq2h9raklWrSLZYrYAmv0FhWTTl74+zGBHiBpzga0YX3O28Gm2I5P2uxlV6Fw0W
qKniFe8GGXnHVYaKbcMoB9ZE7CQAxHlyeZ4mbzFMqxMxBrL+Fd6OM7c2xEuqZNgg
ZpSAf++WCdVayez5N4XFzLT6wPYhrN3xilAo5i5AhXOhwVdFqcfl8KpUDeW1+MTu
b7nFIF1M7Wh3RCKAP6i+7WW9Sly1WsnCwA9opPUnOQGEyQJPOMk1xiylpIzDZx9n
hVU+8yg57sO6arfrKBfE6TSbNVk+1VyaI3x51I0HHOzZ97jnKbwK3qTjhyPT3wXh
5HMlWSZMh3o1n9aD0rq2gikUrOZ2AwOAc8VJRTTJqN5UA3ZrdmFJi/akRfmmR/OE
PoH+NfKjUNfZFcgXlDXPw+d1ONLLTAuwyZ4qtGDfn6R1Q/ASrmL2BzvuhapkaNTU
Jz0zvMfPvmPYViXZemDjcm+ccnp0mo8/azgtt+vV78ddEL1pYgaV5UnP/Qr+LGxa
KKJucihRwTSarHtGMqFQs7TyNkzFQhR/P7z0fUEZ+alVdD5gLaOiH3KsHjSRio+H
rkRyZvd9i2/tPWJBNGhE
=ah4c
-----END PGP SIGNATURE-----

--JLiXfqD9/Kt1b+Pq--
