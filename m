Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A0FC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 18:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AB8021473
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 18:23:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729595AbfEVSX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 14:23:56 -0400
Received: from shelob.surriel.com ([96.67.55.147]:40060 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728272AbfEVSX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 14:23:56 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <riel@shelob.surriel.com>)
        id 1hTVtz-0002ay-Uk; Wed, 22 May 2019 14:23:47 -0400
Message-ID: <d8ec196590237c047bbe6805b933ec9dd2ec42c4.camel@surriel.com>
Subject: Re: [PATCH] smp,cpumask: Don't call functions on offline CPUs
From:   Rik van Riel <riel@surriel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Andrew Murray <andrew.murray@arm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Date:   Wed, 22 May 2019 14:23:47 -0400
In-Reply-To: <20190522144918.GH16275@worktop.programming.kicks-ass.net>
References: <20190522111537.27815-1-andrew.murray@arm.com>
         <20190522140921.GD16275@worktop.programming.kicks-ass.net>
         <20190522143711.GC8268@e119886-lin.cambridge.arm.com>
         <20190522144918.GH16275@worktop.programming.kicks-ass.net>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-0vbLQ8PSxJ5AAaklNGAH"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-0vbLQ8PSxJ5AAaklNGAH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-05-22 at 16:49 +0200, Peter Zijlstra wrote:
> On Wed, May 22, 2019 at 03:37:11PM +0100, Andrew Murray wrote:
> > > Is perhaps the problem that on_each_cpu_cond() uses
> > > cpu_onlne_mask
> > > without protection?
> >=20
> > Does this prevent racing with a CPU going offline? I guess this
> > prevents
> > the warning at the expense of a lock - but is only beneficial in
> > the
> > unlikely path. (In the likely path this prevents new CPUs going
> > offline
> > but we don't care because we don't WARN if they aren't they when we
> > attempt to call functions).
> >=20
> > At least this is my limited understanding.
>=20
> Hmm.. I don't think it could matter, we only use the mask when
> preempt_disable(), which would already block offline, due to it using
> stop_machine().
>=20
> So the patch is a no-op.
>=20
> What's the WARN you see? TLB invalidation should pass mm_cpumask(),
> which similarly should not contain offline CPUs I'm thinking.

Does the TLB invalidation code have anything in it
to prevent from racing with the CPU offline code?

In other words, could we end up with the TLB
invalidation code building its bitmask, getting
interrupted (eg. hypervisor preemption, NMI),
and not sending out the IPI to that bitmask of
CPUs until after one of the CPUs in the bitmap
has gotten offlined?

--=20
All Rights Reversed.

--=-0vbLQ8PSxJ5AAaklNGAH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAlzlk7MACgkQznnekoTE
3oMqLwf/Qre0ZBiGCS1ToLsApMEvym3Mq6QzFAX5MSjWE7mfxX56YVeIGWqULrie
fReCb4ubNKv5TSLXTFRLweA07U57LmUfUdgtqLJdBvAgT1W3o32WiS/m83o9Fl9P
Xf7zMtyNoiQXekB2gj85QtZgxsdvySgTwIYdPXRL9c0w2mNHz1gnpXfj9Ah2kV6q
3It3S3D6QOXHwPV/eXP3PghRmWgmVZKo4UHQaBGbUrFnNRSKCO25YZPDenBmc/DX
9ZE0gZM7KMAr8mu0YcI3YsGtuVyZUCv53KSJnpT7c9G9RyfoDjsu0IbW1VxsEfdW
jV19/XX+8iMH29oWqsjVP2YBNXYeAw==
=KvjP
-----END PGP SIGNATURE-----

--=-0vbLQ8PSxJ5AAaklNGAH--

