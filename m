Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D27C3A5A6
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 04:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DBDA207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 04:31:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kp6S8U50"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbfIWEb0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 00:31:26 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35435 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbfIWEb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 00:31:26 -0400
Received: by mail-qk1-f196.google.com with SMTP id w2so14026065qkf.2
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2019 21:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4QM9p6JUL1H2+7ufpY9lHAHlLiqvaNnzuQlbpSFc8tM=;
        b=kp6S8U50H9zQURpbWiVwsIep53fMTjYvYSQ1hH7rsdcVRizx/5hgI1Qg2WKjMdLWXf
         GNwfNzEITwHot/iLdAn1kdRMmbSv/9d4huyEATB08vNHmt3ayXBLr3NCxWoTqlAeb6E8
         3Bgo1CKJjm4lrLM4GSS7TlOUUIm9tDKEnYm2C9xpZGgvbpru+lxyI2YTIrED+Bi6kJTC
         yeA8lBLRLPJVoBCVrQ1d9J/F23Y60pvapHtF77vcyAjLNdZnFiaSXPbIhp9GhSELNX83
         pi1W42HdJTyIQ/61nD4CI3QFycdaT+UanE3kV49bcXrWMkCH7sXRSQEXG4wTl49Vzlqj
         v9sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4QM9p6JUL1H2+7ufpY9lHAHlLiqvaNnzuQlbpSFc8tM=;
        b=RDQ6f1fK5mKGTmEAqApx9QiXrcsWYIQnDeKv7EJ5WGJsh0fYPB2hFLQSopUQ9u3VJg
         uK1aZKS5KvqSw9SZZNVywl71CoOYmPoHubNvazyMWeA06Vja/8PpRHH3S9FCEEbsyFOX
         2Kl+HHorXHRDxujYavxLJpcwZSewYaYNFzc02njznDU6nJsdLed4x91gNO6ZsAYzRZFw
         8PQ/s47adz72o5fakr78/dbkRUkI5GiTR2hu6552BHPD0LmzSCgScdoarjpGqiMzErFP
         xxmdaTGaV4+jz/0xvXgD+3ExEBeIzdr1o9rdjSwU4OdfkrBuDxZXLCDZjqksfmG7g3O+
         5yJg==
X-Gm-Message-State: APjAAAXMsgB2zsIQPSFn4afnZ6L+rRJohcINNgfDwoh2DCtO21Ih/64K
        QoMvx6OtWrQzH6j6Wfmd6V8=
X-Google-Smtp-Source: APXvYqzsHVkE7SQynZNMCQMoUmnHJfj/Gb78B2Fg1LnuuJH0Uv1iwFWC3WWwX2WfjZignt049QbEyQ==
X-Received: by 2002:a37:7041:: with SMTP id l62mr15740747qkc.7.1569213085158;
        Sun, 22 Sep 2019 21:31:25 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id k54sm5680914qtf.28.2019.09.22.21.31.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Sep 2019 21:31:23 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 4D4CE220AA;
        Mon, 23 Sep 2019 00:31:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 23 Sep 2019 00:31:22 -0400
X-ME-Sender: <xms:mUqIXZLWXcLOHduDT8srUfss5BIJ4xJj5zU3TD0he-1DWmuMFpAGzA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvdejgdekiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujggfsehgtderredtredvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuffhomhgrih
    hnpehgihhthhhusgdrtghomhdpuhhsvghnihigrdhorhhgpdhlfihnrdhnvghtnecukfhp
    peeghedrfedvrdduvdekrddutdelnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquh
    hnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudej
    jeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrd
    hnrghmvgenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:mUqIXejTuUx4gqDmyOeK0FASaV1GS4t5wADakmISS3IQ6hdC7VWssw>
    <xmx:mUqIXaPnYPna0kbUzHdqHX4j-38-ubG2XEEbnCJ91cyqQVRi9eRpuw>
    <xmx:mUqIXZ6Q214evmbHeUFLX5FUhsX4IxzFdaWJtZlxaguljMHpvYz1ug>
    <xmx:mkqIXSgHFWi-oMaQFgvYOJAhhqaBn4sxV3ZEza_A-wcU2aiiSWcp3hf_iKE>
Received: from localhost (unknown [45.32.128.109])
        by mail.messagingengine.com (Postfix) with ESMTPA id 20A73D6005E;
        Mon, 23 Sep 2019 00:31:21 -0400 (EDT)
Date:   Mon, 23 Sep 2019 12:31:13 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Will Deacon <will@kernel.org>
Cc:     Marco Elver <elver@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>, paulmck@linux.ibm.com,
        Paul Turner <pjt@google.com>, Daniel Axtens <dja@axtens.net>,
        Anatol Pomazau <anatol@google.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        stern@rowland.harvard.edu, akiyks@gmail.com, npiggin@gmail.com,
        dlustig@nvidia.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr
Subject: Re: Kernel Concurrency Sanitizer (KCSAN)
Message-ID: <20190923043113.GA1080@tardis>
References: <CANpmjNPJ_bHjfLZCAPV23AXFfiPiyXXqqu72n6TgWzb2Gnu1eA@mail.gmail.com>
 <20190920155420.rxiflqdrpzinncpy@willie-the-truck>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
In-Reply-To: <20190920155420.rxiflqdrpzinncpy@willie-the-truck>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 20, 2019 at 04:54:21PM +0100, Will Deacon wrote:
> Hi Marco,
>=20
> On Fri, Sep 20, 2019 at 04:18:57PM +0200, Marco Elver wrote:
> > We would like to share a new data-race detector for the Linux kernel:
> > Kernel Concurrency Sanitizer (KCSAN) --
> > https://github.com/google/ktsan/wiki/KCSAN  (Details:
> > https://github.com/google/ktsan/blob/kcsan/Documentation/dev-tools/kcsa=
n.rst)
> >=20
> > To those of you who we mentioned at LPC that we're working on a
> > watchpoint-based KTSAN inspired by DataCollider [1], this is it (we
> > renamed it to KCSAN to avoid confusion with KTSAN).
> > [1] http://usenix.org/legacy/events/osdi10/tech/full_papers/Erickson.pdf
>=20
> Oh, spiffy!
>=20
> > In the coming weeks we're planning to:
> > * Set up a syzkaller instance.
> > * Share the dashboard so that you can see the races that are found.
> > * Attempt to send fixes for some races upstream (if you find that the
> > kcsan-with-fixes branch contains an important fix, please feel free to
> > point it out and we'll prioritize that).
>=20
> Curious: do you take into account things like alignment and/or access size
> when looking at READ_ONCE/WRITE_ONCE? Perhaps you could initially prune
> naturally aligned accesses for which __native_word() is true?
>=20
> > There are a few open questions:
> > * The big one: most of the reported races are due to unmarked
> > accesses; prioritization or pruning of races to focus initial efforts
> > to fix races might be required. Comments on how best to proceed are
> > welcome. We're aware that these are issues that have recently received
> > attention in the context of the LKMM
> > (https://lwn.net/Articles/793253/).
>=20
> This one is tricky. What I think we need to avoid is an onslaught of
> patches adding READ_ONCE/WRITE_ONCE without a concrete analysis of the
> code being modified. My worry is that Joe Developer is eager to get their
> first patch into the kernel, so runs this tool and starts spamming
> maintainers with these things to the point that they start ignoring KCSAN
> reports altogether because of the time they take up.
>=20
> I suppose one thing we could do is to require each new READ_ONCE/WRITE_ON=
CE
> to have a comment describing the racy access, a bit like we do for memory
> barriers. Another possibility would be to use atomic_t more widely if
> there is genuine concurrency involved.
>=20

Instead of commenting READ_ONCE/WRITE_ONCE()s, how about adding
anotations for data fields/variables that might be accessed without
holding a lock? Because if all accesses to a variable are protected by
proper locks, we mostly don't need to worry about data races caused by
not using READ_ONCE/WRITE_ONCE(). Bad things happen when we write to a
variable using locks but read it outside a lock critical section for
better performance, for example, rcu_node::qsmask. I'm thinking so maybe
we can introduce a new annotation similar to __rcu, maybe call it
__lockfree ;-) as follow:

	struct rcu_node {
		...
		unsigned long __lockfree qsmask;
		...
	}

, and __lockfree indicates that by design the maintainer of this data
structure or variable believe there will be accesses outside lock
critical sections. Note that not all accesses to __lockfree field, need
to be READ_ONCE/WRITE_ONCE(), if the developer manages to build a
complex but working wake/wait state machine so that it could not be
accessed in the same time, READ_ONCE()/WRITE_ONCE() is not needed.

If we have such an annotation, I think it won't be hard for configuring
KCSAN to only examine accesses to variables with this annotation. Also=20
this annotation could help other checkers in the future.

If KCSAN (at the least the upstream version) only check accesses with
such an anotation, "spamming with KCSAN warnings/fixes" will be the
choice of each maintainer ;-)=20

Thoughts?

Regards,
Boqun

> > * How/when to upstream KCSAN?
>=20
> Start by posting the patches :)
>=20
> Will

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAl2ISo4ACgkQSXnow7UH
+rgHOwf7BLuk59YmfLvND3YZHNAzLM2LGXuNIuOZcWlnUL1nI092bou02ChdTEPo
2VRQ41P95dAA6mGX5oIhExPy8KQ+vCMqnNV8ZMT3L134cqiLU6C+UZIp/9GSFub/
0c9cvLyiwQo98gVIarEb/HWk5lSye1hlOPgSud3NpE4A11QFWAzRs4LkcVlFnh3g
ATihIRCxLr0gPOsi9YQI2mBJjCi9yId+VzTFNbGhKfQVwAMUHZMVbRg15Q/OYe8g
1/c449UasaAZ64z/zlHZisjkD4RCUztekNPdFL1R7zrsaAJtpC5xsPncC6Q8EXL+
+6FT4rcFYJy4vRHy9MFnh/AxSEsXyA==
=B1n/
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
