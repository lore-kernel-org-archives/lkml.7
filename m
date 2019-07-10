Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED6C7C73C6D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 05:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADB6C20665
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 05:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qIk0DP9T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfGJFaM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 01:30:12 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43555 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbfGJFaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 01:30:12 -0400
Received: by mail-qt1-f194.google.com with SMTP id w17so1130592qto.10
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 22:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Lb6BTl7GtJwB8DZ/Y4hFict/+qZNMvEbXJdbckD3xFE=;
        b=qIk0DP9Tgd6D04Qbkk4W1N3jK+xJvkl4FCoUZL4d9o+xzqSxal1N65M2CpVFgMaAy0
         j/uiEE/qQaXdZWL5PoZmQm0PvqyggVVK7gxcjYuxKx2vLTr2yT4xH42hIIpYfAL04H7v
         7PmwEpLT/IjFbluJdw7y7TiCEmOwy4jwSak6ZU6QGAk9InYQh8XJxZjdh9wzDIVo3p0V
         0MfhVDH2eh57D1iJqS4kLPmrml8J947FfAtIUc+isFDnwnKSx+ZQ8imhBnMuRBxUlEF2
         n4nxBhNPGVjP/GzuUO5bQV+0ueDQ36eZSKzcMOpj0B8BukeCdSUeizbuYPAorew75nn0
         pg5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Lb6BTl7GtJwB8DZ/Y4hFict/+qZNMvEbXJdbckD3xFE=;
        b=bmHK+BxnF3qxJzRxo1NRIHhEc9YSYMkZlPTQOcEObLB4TSQidXBAe7c1FsZhqqEhKE
         9S0+T3+9XkeXVYXlT4QnEYAT6SyUgrCmJkRJvKa49PcR5sZBDSqdNf7O+IGzrKTfSYag
         Vvl9u4OxwJ/5l31rfQPNwCFr6P5nqV8clVncvvGs8ecS/RoFIVsPgvkzPL3lbvZtUkLO
         SOKPBvfS1MJODg/dRQ+15V1mEFkBLMSBwG/eMnG9R/qgbjxSANVwIKRZUiiKc3Az42KH
         SiwP112zHwq0hNvmURuDFfPuEe5i37YeuxQvqygI3ZRgrfTi0eZsDnIPuzJ7e9qwnbsJ
         bJlw==
X-Gm-Message-State: APjAAAXGPcFDam75hZeh1+5kDNWLq0Lonk2u2KfNpk5JdpPLWdL0ikjQ
        0fhByVAbhBFoA6uVlHbLzrU=
X-Google-Smtp-Source: APXvYqyWiE888Ijl8nwBJkihdiRzG+WVMqUCop7r0tBGRMFUqGh7kHhCbUQuAP1ZN33slPUTPAzGlw==
X-Received: by 2002:ac8:2f43:: with SMTP id k3mr22477749qta.179.1562736610801;
        Tue, 09 Jul 2019 22:30:10 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id r189sm632302qkc.60.2019.07.09.22.30.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2019 22:30:09 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 2878922274;
        Wed, 10 Jul 2019 01:30:09 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 10 Jul 2019 01:30:09 -0400
X-ME-Sender: <xms:33clXTxPHO6MHmg9nNCXWWeQ3e_Bss2L-WUnVmZoniQqnxe-v_jruQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrgeehgdegudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujggfsehgtderredtredvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecukfhppeeghe
    drfedvrdduvdekrddutdelnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhm
    vghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekhe
    ehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghm
    vgenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:33clXfmPJYI_rMl1O8vGxf2-TC-3eVBcd5em7jPyfOy81BvAUS34ZA>
    <xmx:33clXce1eKxLAKxAx3BvlUIZWlDFT2tFfYNKV4-OgM6nerURKFMkuw>
    <xmx:33clXVon_LlZshivx9mO0oJJKtv-KXNqBY78CH4l0HxTezcp3c-K3Q>
    <xmx:4XclXfJjomMQnb4yIhnw9yYScHFsbd7zln6qacIwO420dITlXxkECW5qoks>
Received: from localhost (unknown [45.32.128.109])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9FF7938008B;
        Wed, 10 Jul 2019 01:30:06 -0400 (EDT)
Date:   Wed, 10 Jul 2019 13:30:02 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Yuyang Du <duyuyang@gmail.com>
Cc:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org,
        bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        longman@redhat.com, paulmck@linux.vnet.ibm.com
Subject: Re: [PATCH v3 30/30] locking/lockdep: Remove irq-safe to irq-unsafe
 read check
Message-ID: <20190710053002.GC14490@tardis>
References: <20190628091528.17059-1-duyuyang@gmail.com>
 <20190628091528.17059-31-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="H8ygTp4AXg6deix2"
Content-Disposition: inline
In-Reply-To: <20190628091528.17059-31-duyuyang@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--H8ygTp4AXg6deix2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2019 at 05:15:28PM +0800, Yuyang Du wrote:
> We have a lockdep warning:
>=20
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>   WARNING: possible irq lock inversion dependency detected
>   5.1.0-rc7+ #141 Not tainted
>   --------------------------------------------------------
>   kworker/8:2/328 just changed the state of lock:
>   0000000007f1a95b (&(&host->lock)->rlock){-...}, at: ata_bmdma_interrupt=
+0x27/0x1c0 [libata]
>   but this lock took another, HARDIRQ-READ-unsafe lock in the past:
>    (&trig->leddev_list_lock){.+.?}
>=20
> and interrupts could create inverse lock ordering between them.
>=20
> other info that might help us debug this:
>    Possible interrupt unsafe locking scenario:
>=20
>          CPU0                    CPU1
>          ----                    ----
>     lock(&trig->leddev_list_lock);
>                                  local_irq_disable();
>                                  lock(&(&host->lock)->rlock);
>                                  lock(&trig->leddev_list_lock);
>     <Interrupt>
>       lock(&(&host->lock)->rlock);
>=20
>  *** DEADLOCK ***
>=20
> This splat is a false positive, which is enabled by the addition of

If so, I think the better way is to reorder this patch before recursive
read lock suppport, for better bisect-ability.

Regards,
Boqun

> recursive read locks in the graph. Specifically, trig->leddev_list_lock i=
s a
> rwlock_t type, which was not in the graph before recursive read lock supp=
ort
> was added in lockdep.
>=20
> This false positve is caused by a "false-positive" check in IRQ usage che=
ck.
>=20
> In mark_lock_irq(), the following checks are currently performed:
>=20
>    ----------------------------------
>   |   ->      | unsafe | read unsafe |
>   |----------------------------------|
>   | safe      |  F  B  |    F* B*    |
>   |----------------------------------|
>   | read safe |  F* B* |      -      |
>    ----------------------------------
>=20
> Where:
> F: check_usage_forwards
> B: check_usage_backwards
> *: check enabled by STRICT_READ_CHECKS
>=20
> But actually the safe -> unsafe read dependency does not create a deadlock
> scenario.
>=20
> Fix this by simply removing those two checks, and since safe read -> unsa=
fe
> is indeed a problem, these checks are not actually strict per se, so remo=
ve
> the macro STRICT_READ_CHECKS, and we have the following checks:
>=20
>    ----------------------------------
>   |   ->      | unsafe | read unsafe |
>   |----------------------------------|
>   | safe      |  F  B  |      -      |
>   |----------------------------------|
>   | read safe |  F  B  |      -      |
>    ----------------------------------
>=20
> Signed-off-by: Yuyang Du <duyuyang@gmail.com>
> ---
>  kernel/locking/lockdep.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index c7ba647..d12ab0e 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -3558,8 +3558,6 @@ static int SOFTIRQ_verbose(struct lock_class *class)
>  	return 0;
>  }
> =20
> -#define STRICT_READ_CHECKS	1
> -
>  static int (*state_verbose_f[])(struct lock_class *class) =3D {
>  #define LOCKDEP_STATE(__STATE) \
>  	__STATE##_verbose,
> @@ -3605,7 +3603,7 @@ typedef int (*check_usage_f)(struct task_struct *, =
struct held_lock *,
>  	 * Validate that the lock dependencies don't have conflicting usage
>  	 * states.
>  	 */
> -	if ((!read || STRICT_READ_CHECKS) &&
> +	if ((!read || !dir) &&
>  			!usage(curr, this, excl_bit, state_name(new_bit & ~LOCK_USAGE_READ_MA=
SK)))
>  		return 0;
> =20
> @@ -3616,7 +3614,7 @@ typedef int (*check_usage_f)(struct task_struct *, =
struct held_lock *,
>  		if (!valid_state(curr, this, new_bit, excl_bit + LOCK_USAGE_READ_MASK))
>  			return 0;
> =20
> -		if (STRICT_READ_CHECKS &&
> +		if (dir &&
>  			!usage(curr, this, excl_bit + LOCK_USAGE_READ_MASK,
>  				state_name(new_bit + LOCK_USAGE_READ_MASK)))
>  			return 0;
> --=20
> 1.8.3.1
>=20

--H8ygTp4AXg6deix2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAl0ld9cACgkQSXnow7UH
+rgUsAf9HKSkatoqAeAKDWKIc9pqAIuJD0lGuWOXjqeHMfCZgCkqdnUKecBq4M/k
QyY6QUrzscvr5+7nNJvRkUFDkXtN4sUguty+ig5WW8LCR9NN+X3ZY+ElSAVUzAsV
qrXQnaDaW0o4SRpkwNnFpQLU8V+33yHPxehXbViE4gruarYutcD9shyGrKkNgHhR
lSw2a703Ct5zFTqTKwnJgc8WYZUVA7AN5IGDSaIG1+a2ez25PPug7d61XmhFmlsh
t+w9PZjeFjywtIKoktr6zkCDyYmSjkgH4p5bGGYUKi5DE8XZ0+HIPv2YSPZ09ABE
74SfFMXBgdATqiYqtT3kud3AvaCwCQ==
=tMGO
-----END PGP SIGNATURE-----

--H8ygTp4AXg6deix2--
