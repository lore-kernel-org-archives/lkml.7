Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C22C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 16:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF4BC21852
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 16:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Alh6u2eG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390093AbfIPQm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 12:42:57 -0400
Received: from mail-qt1-f171.google.com ([209.85.160.171]:36012 "EHLO
        mail-qt1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727981AbfIPQm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 12:42:56 -0400
Received: by mail-qt1-f171.google.com with SMTP id o12so633988qtf.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 09:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/JCl5+AcFNZjHwWLbdBMk4uE1g6+dzFlsFeAZIwe6Mg=;
        b=Alh6u2eG8B+vfs3WVleXi1vhIiMXKuFlWwf8Jpk+qwh+zJmnNyBo1T7cRicm6k/9m9
         RUWcZp6gqEfz7MSXhp/oHiLRaQJpx0+EaWxa2cj+9iz1/vkiUxlfVQvHVidUDxb52FEs
         drjlbhRhMx0vluZeHL0IphTcYnGpiPJ7bTpgAzaO8oHnVT62AY4VSvOfUT+2MnSEBWWy
         gNoXkfQ99LACp+HQDm3pyw01eajnBUTcB8eV8dxcpV+RE1hI8ubmotYaM6fJzkE3TRzl
         EgdNH6hEH6AiE7UtcDWKF4Yl6CXds0G+2qAnaYk8lnYXE1VeeFGLpA+QcSoe7SPCA1jq
         i7vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/JCl5+AcFNZjHwWLbdBMk4uE1g6+dzFlsFeAZIwe6Mg=;
        b=m9qBDjmV/2vxsPAWlEVQoBBUszeKHVV0aCJ0AXofAl8VVu6fTQ6jeIdMUNdNvRxwAM
         gM5WMaD6sgFwBnngijjvz5dd8uaPIm0BC/bLkIf0MIl8NjwETULvRzeZx4ta2OFMV4zD
         PTBdEjjwzZOd1O9JhSwJyGrgv4RHXYSWBhO9wLNC/MLZzEbQ5bHTI543AFaPjspAxen7
         v/bV4GPYjim0Dt5e8xOZZr6mNJUy2aWxrJSJ4CHkJjehO5T1AVlmvy8/hodP8RxcIQ8+
         g3/1PWtmVIk3xB/CL6HfTVuKU6qWh6m9j943vHP6qOTYE2ImpTyqix8EA3+h+lIxhypR
         eZwg==
X-Gm-Message-State: APjAAAX1L8G/zVgsPYAHgbfBa8DrUrBhkgItilDRkwImYvSSNL1bPytp
        l4BYCpolCVshI752SfqwPR8=
X-Google-Smtp-Source: APXvYqzZdGmSuhGDuU3TOifHKaMX8qOfchbh3O5ONpzDBPhd9JMIw57RUUkgSKfnow/5fXjDQ0b+6w==
X-Received: by 2002:ac8:1658:: with SMTP id x24mr565705qtk.196.1568652175312;
        Mon, 16 Sep 2019 09:42:55 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id g31sm24706738qte.78.2019.09.16.09.42.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Sep 2019 09:42:54 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 1DB7921F57;
        Mon, 16 Sep 2019 12:42:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 16 Sep 2019 12:42:53 -0400
X-ME-Sender: <xms:i7t_XQM822e4Dh28vLtrVaxaAxxthNwCEAVd9GRmqotC9r2H81toQw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudefgddutdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjfgesghdtreertdervdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucfkphepge
    ehrdefvddruddvkedruddtleenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdo
    mhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejke
    ehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgr
    mhgvnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:i7t_XRDk0MOyRFr9-Td9SQc81IIt4cgp2Kqt46qwONKrqiJz_I3AlA>
    <xmx:i7t_XaLTFHz94I_0geKBaJFkoba5RlBhPqnTOUloAEZia0O5NkxDJA>
    <xmx:i7t_XQqTvumEUXgGocJgR1t7AYPFbd_7SQhMg1oL-lAZ4ScgcAdhBw>
    <xmx:jbt_Xdf88NAyWvvWgo7mVlAayTEjxUW5pIg4-454v3K4SsKi5f8ZXqaNi5g>
Received: from localhost (unknown [45.32.128.109])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1B06A80064;
        Mon, 16 Sep 2019 12:42:51 -0400 (EDT)
Date:   Tue, 17 Sep 2019 00:42:46 +0800
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
Message-ID: <20190916164246.GA7098@tardis>
References: <20190916051753.GA29216@tardis>
 <Pine.LNX.4.44L0.1909161119160.1489-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1909161119160.1489-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 16, 2019 at 11:22:18AM -0400, Alan Stern wrote:
> On Mon, 16 Sep 2019, Boqun Feng wrote:
>=20
> > > executes if Y is a store.)  This is expressed by the visibility
> > > relation (vis), where X ->vis Y is defined to hold if there is an
> > > intermediate event Z such that:
> > >=20
> > > 	X is connected to Z by a possibly empty sequence of
> > > 	cumul-fence links followed by an optional rfe link (if none of
> > > 	these links are present, X and Z are the same event),
> > >=20
> >=20
> > I wonder whehter we could add an optional ->coe or ->fre between X and
> > the possibly empty sequence of cumul-fence, smiliar to the definition
> > of ->prop. This makes sense because if we have
> >=20
> > 	X ->coe X' (and X' in on CPU C)
> >=20
> > , X must be already propagated to C before X' executed, according to our
> > operation model:
> >=20
> > "... In particular, it must arrange for the store to be co-later than
> > (i.e., to overwrite) any other store to the same location which has
> > already propagated to CPU C."
>=20
> You have misinterpreted the text.  The operational model says that if X=
=20
> propagates to CPU C before X' executes then X ->coe X'.  It does _not_=20
> say that if X ->coe X' then X propagates to CPU C before X' executes.
>=20

Alright, I got confused. If X ->coe X', we only have "X must execute
before X' propagated to the CPU of X" (otherwise, we will have X' ->coe
X), so we will only know the execution time of X (not the propagation
time) is before the propagation of X' to the CPU of X, and that won't
help build the visiblity, because we know zero about the propagation
time of X to any CPU.

> > In other words, we can define ->vis as:
> >=20
> > 	let vis =3D prop ; ((strong-fence ; [Marked] ; xbstar) | (xbstar & int=
))
> >=20
> > , and for this document, reference the "prop" section in
> > explanation.txt. This could make the model simple (both for description
> > and explanation), and one better thing is that we won't need commit in
> > Paul's dev branch:
> > =09
> > 	c683f2c807d2 "tools/memory-model: Fix data race detection for unordere=
d store and load"
> >=20
> > , and data race rules will look more symmetrical ;-)
> >=20
> > Thoughts? Or am I missing something subtle here?
>=20
> See above.
>=20

Thanks!

Regards,
Boqun

> Alan
>=20

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAl1/u4IACgkQSXnow7UH
+riWSwf/Qh5r3G2a6SpaN6aJf2TTnJ6jEVSUgwr+Yqx0F61lcC43s5jkt0ZKtqv9
fbxTEr3DzmtSGZfsmBW1hvdnHs93//L+BGB77jAvB3Lb25WZDtfeUFjHtZessGRw
yOxPmFXS+ftvtfOZKUeTXw9C3586NOAGCyiDyMjfvVUYKZTSnlQl/cMbaE+WWBGl
f5CJYIOcI4q9Mj8YpZyxa/aoYwOhhYVvo/TUZIZSuiczRb91+d/sJiMCrYd0rHoZ
oOR3ZTfOEYlDOC9tXqQCwyKbQfMZJfWELtpZn3uJPzOSskEiA7ZfTo0VfgicriA6
jlxx9ENREq7m0e8RqrMX/H8woULzuA==
=bT+E
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
