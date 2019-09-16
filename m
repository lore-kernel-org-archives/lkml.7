Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0689C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 05:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A64520830
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 05:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tBnASPS7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728704AbfIPFSC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 01:18:02 -0400
Received: from mail-qk1-f170.google.com ([209.85.222.170]:32972 "EHLO
        mail-qk1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728172AbfIPFSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 01:18:02 -0400
Received: by mail-qk1-f170.google.com with SMTP id x134so35062131qkb.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2019 22:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KZvLigS0+5seTgQRz6efWKMC3Lfo1NpNBd2v2usYUe8=;
        b=tBnASPS7t7+4LtC0Qm0UFBLHyxGba5UA/wCgG5Erig0FudiQ9U8Xzgx8FONFRg6+cz
         M3ATMIbZaDWZE+UWChyzT8o2cDxLn66F+Vv1egv+G9kiZd6SbNOxcGV9gKh8JvaLcjEp
         bEf9ax4HBkyzptSoYYBgAXytu0ccPbyZhIo5j6+TH6TxcWmitoAwXMRNtqx9Hpqah0HE
         OKQjcjnUat4ji9ZX66MN5Miqyzx5/3LpiNYoLmKwyeMI+Mhd5Bt0Vo0e2JC+Vl9iQ/K+
         WnqzcmQAv6njULFsUIM+WQnvrXT8T0PIUKRRBVvQhq06BmqIYH0LzJtI4kqVb+/iNUZP
         YDJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KZvLigS0+5seTgQRz6efWKMC3Lfo1NpNBd2v2usYUe8=;
        b=gTH9SFd7TRqiufA8HIsf6O+eTUBJINxnW2T00CFW8D086m5mW65ZD98vE+73bHLmIu
         2ARrkChx/yKGLlmXAOgmHFxFFBuMn/c1oXYd9DTFx9Ld7CfQpybsd5qdg8jG1Uh2JHSA
         9iMUP02lSBn1dRkwjCHfpzrIrNZrqzH8qW/ZzVYQ6wc5aM7CSPz49f0BEQHJjW6Xn94k
         U5+5qsxwGcP1kpksHABtN/WMv8/QjC9iuRZiSJk7O9X9klZVCKiDLHdifzD6ovFnPQnF
         2Vc3xW+Aq0/eC99pcIfl1iAbfwfKAptSko65WB3c85EKAVEIEhqxd3tWH80rVqVWVjgF
         a9ig==
X-Gm-Message-State: APjAAAUCcV39Ji9FeaN7QeC1iDRdfj4cziGRJxeCZWiu0MvMzqPyf1g5
        GZGKUGwJ/SVEJlseAQiUL7w=
X-Google-Smtp-Source: APXvYqzhSsWrBD0mvsm7QnOZMaJNVwCBf4gwZpkeELDQrjSk+rRn4RpyHk+DaGZH3oEZEqlmIt+2RA==
X-Received: by 2002:a37:4d83:: with SMTP id a125mr20104745qkb.111.1568611080729;
        Sun, 15 Sep 2019 22:18:00 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id l23sm23000933qta.53.2019.09.15.22.17.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Sep 2019 22:17:59 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 674FA21F41;
        Mon, 16 Sep 2019 01:17:58 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 16 Sep 2019 01:17:58 -0400
X-ME-Sender: <xms:BRt_XSNOg2lB5Q2BaEgnsZSybjetvpu4HFu0gM72XasPVXwsyOy1TA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedruddvgdelhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujggfsehgtderredtredvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecukfhppeeghe
    drfedvrdduvdekrddutdelnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhm
    vghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekhe
    ehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghm
    vgenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:BRt_XSRoMeWwh0u5fedZj2xIsV6tJY7rmWv6jVOQZEtmRWdgyA4Fcg>
    <xmx:BRt_Xd6z-M0__vxENj9DZF8I9OxWL12yAOHqVzx8TumWvkGCTWkheQ>
    <xmx:BRt_XVax4SOVB_9e9GM2U2PzVUrmXIRvahynteyoCGBl6-R6tudI1Q>
    <xmx:Bht_XSX8xZf3E2t27DWd0ZY81Bp0xVjiPD0_9dZYOT58BPudBF7o2AvdUDQ>
Received: from localhost (unknown [45.32.128.109])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1BBA9D60062;
        Mon, 16 Sep 2019 01:17:57 -0400 (EDT)
Date:   Mon, 16 Sep 2019 13:17:53 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Documentation for plain accesses and data races
Message-ID: <20190916051753.GA29216@tardis>
References: <Pine.LNX.4.44L0.1909061405560.1627-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1909061405560.1627-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Alan,

I spend some time reading this, really helpful! Thanks.

Please see comments below:

On Fri, Sep 06, 2019 at 02:11:29PM -0400, Alan Stern wrote:
[...]
> If two memory accesses aren't concurrent then one must execute before
> the other.  Therefore the LKMM decides two accesses aren't concurrent
> if they can be connected by a sequence of hb, pb, and rb links
> (together referred to as xb, for "executes before").  However, there
> are two complicating factors.
>=20
> If X is a load and X executes before a store Y, then indeed there is
> no danger of X and Y being concurrent.  After all, Y can't have any
> effect on the value obtained by X until the memory subsystem has
> propagated Y from its own CPU to X's CPU, which won't happen until
> some time after Y executes and thus after X executes.  But if X is a
> store, then even if X executes before Y it is still possible that X
> will propagate to Y's CPU just as Y is executing.  In such a case X
> could very well interfere somehow with Y, and we would have to
> consider X and Y to be concurrent.
>=20
> Therefore when X is a store, for X and Y to be non-concurrent the LKMM
> requires not only that X must execute before Y but also that X must
> propagate to Y's CPU before Y executes.  (Or vice versa, of course, if
> Y executes before X -- then Y must propagate to X's CPU before X
> executes if Y is a store.)  This is expressed by the visibility
> relation (vis), where X ->vis Y is defined to hold if there is an
> intermediate event Z such that:
>=20
> 	X is connected to Z by a possibly empty sequence of
> 	cumul-fence links followed by an optional rfe link (if none of
> 	these links are present, X and Z are the same event),
>=20

I wonder whehter we could add an optional ->coe or ->fre between X and
the possibly empty sequence of cumul-fence, smiliar to the definition
of ->prop. This makes sense because if we have

	X ->coe X' (and X' in on CPU C)

, X must be already propagated to C before X' executed, according to our
operation model:

"... In particular, it must arrange for the store to be co-later than
(i.e., to overwrite) any other store to the same location which has
already propagated to CPU C."

In other words, we can define ->vis as:

	let vis =3D prop ; ((strong-fence ; [Marked] ; xbstar) | (xbstar & int))

, and for this document, reference the "prop" section in
explanation.txt. This could make the model simple (both for description
and explanation), and one better thing is that we won't need commit in
Paul's dev branch:
=09
	c683f2c807d2 "tools/memory-model: Fix data race detection for unordered st=
ore and load"

, and data race rules will look more symmetrical ;-)

Thoughts? Or am I missing something subtle here?

Regards,
Boqun
=09
> and either:
>=20
> 	Z is connected to Y by a strong-fence link followed by a
> 	possibly empty sequence of xb links,
>=20
> or:
>=20
> 	Z is on the same CPU as Y and is connected to Y by a possibly
> 	empty sequence of xb links (again, if the sequence is empty it
> 	means Z and Y are the same event).
>=20
> The motivations behind this definition are straightforward:
>=20
> 	cumul-fence memory barriers force stores that are po-before
> 	the barrier to propagate to other CPUs before stores that are
> 	po-after the barrier.
>=20
> 	An rfe link from an event W to an event R says that R reads
> 	from W, which certainly means that W must have propagated to
> 	R's CPU before R executed.
>=20
> 	strong-fence memory barriers force stores that are po-before
> 	the barrier, or that propagate to the barrier's CPU before the
> 	barrier executes, to propagate to all CPUs before any events
> 	po-after the barrier can execute.
>=20
> To see how this works out in practice, consider our old friend, the MP
> pattern (with fences and statement labels, but without the conditional
> test):
>=20
> 	int buf =3D 0, flag =3D 0;
>=20
> 	P0()
> 	{
> 		X: WRITE_ONCE(buf, 1);
> 		   smp_wmb();
> 		W: WRITE_ONCE(flag, 1);
> 	}
>=20
> 	P1()
> 	{
> 		int r1;
> 		int r2 =3D 0;
>=20
> 		Z: r1 =3D READ_ONCE(flag);
> 		   smp_rmb();
> 		Y: r2 =3D READ_ONCE(buf);
> 	}
>=20
> The smp_wmb() memory barrier gives a cumul-fence link from X to W, and
> assuming r1 =3D 1 at the end, there is an rfe link from W to Z.  This
> means that the store to buf must propagate from P0 to P1 before Z
> executes.  Next, Z and Y are on the same CPU and the smp_rmb() fence
> provides an xb link from Z to Y (i.e., it forces Z to execute before
> Y).  Therefore we have X ->vis Y: X must propagate to Y's CPU before Y
> executes.
>=20
[...]

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAl1/Gv0ACgkQSXnow7UH
+rijYgf/amCY1JVvgZbpte/JiCIWYIZRd/Ymk+tBsifgwLh4uUO8iRDjXCRiBHiK
jupxsMlUpQ194qoQ5LXsAvGhA1dpmZLO6FHRNNdAySYjAtaLxq4CZWoKgMRnnLBC
VpjqJSE7Yz3R7mmL3J8k2tTv4O3PMvertz2vb4dXbwl9/tKTNBGUSTsUxiZKPBoi
7EqljLL92sBGVSpyeIOCMney/05/YvCndlGsiwnTfygvoI2yvtrYJwfHtImpghb3
Gj7a41rdX3HZVW8FFDKxI7ADkUmN/KH1izk/KEYERa5TPwNI1ewq2aXNNKGahyQM
1KKIaWJUQAq3RVN+UlagBfxP0cyp0w==
=gaHm
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
