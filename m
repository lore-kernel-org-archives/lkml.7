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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3CCBC3A5A6
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 08:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EEFD20820
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 08:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CjgRm9zM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404665AbfIWIyW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 04:54:22 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37014 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731817AbfIWIyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 04:54:19 -0400
Received: by mail-qt1-f196.google.com with SMTP id d2so16208991qtr.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 01:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2HTTegD4xnUb2DPrlY/Y5rzaeP5y5DbCzcsegVnbQgA=;
        b=CjgRm9zMtItUC4kbjnGmXiyNvTfXsyUaAcZCfZmIbnghjYAr6+luCrJ3/2981u4EvL
         qBdW7lmcBZUhtL61WnEGagIz8xt0CzZTA9Mp4GIMcdENHAWNP5M1xzYtsXzpiT9mSt/L
         REEbAGGkTy1bt8I+IJljxhGNoRcRejXpKNWEfGupXBhM+lxUIgk4AWFw302cc8RQnI+i
         p5gmTmsMLMC1KPpB/VK7GSgfrpB4UVCraMkGHclSJs+wucU1WHQH7nW4KtitusyEOw++
         743r/5Vi/gBDngEJuDF33Xmk/8dGI3IHj4ra8RAjfuMPdq4ROKWduxIYQvqJfi5CGfu4
         O2zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2HTTegD4xnUb2DPrlY/Y5rzaeP5y5DbCzcsegVnbQgA=;
        b=WpC+gg6XigB2Xs39JDXA2YmyuCvYw9kR9TEbz/Wg1kdwEeEvOQU/O1OvDxULxL7uQg
         HFd7LL4w5ylaTeVMZWrTl6ogMsZGR9PlkW/cLgDPrS53DS0KKIAlTGIYz04zzEYii1b8
         NXQz85c4dWfbCv//LnH+7rJzHR5AKP6Z8aGd9xU+qzE+nvawZHFJffyv2mHN5rDVvkLY
         pciUtawyQfBdszSb4uCupub9eoELtdawEjfuULMiaoBdsXDyyV/sBYWAidnDaSrAn+MV
         iQ5evDFeyxFITDn0NW9gPHi1lAzE5jrugRMVjBcDbNuP199RHVbln+vD3KwZhvbT9q+f
         ydOw==
X-Gm-Message-State: APjAAAVGAkOmkyQORIzt0OD9TQ7jBJCIRE69YySr3Nh0rxZkM3oK3iI4
        Pvg7+bRf080hkyvh9ySiSUY=
X-Google-Smtp-Source: APXvYqw1ch+1hXHZ0BQ6u7yqZcn3UH6BcMZKmNYcAYvMFS/Xenesl1MjUZFZm0bHOGFBvArLQuEB/Q==
X-Received: by 2002:a0c:aadb:: with SMTP id g27mr23296635qvb.149.1569228856661;
        Mon, 23 Sep 2019 01:54:16 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id h184sm4929661qkf.89.2019.09.23.01.54.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Sep 2019 01:54:15 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id CAE6E22340;
        Mon, 23 Sep 2019 04:54:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 23 Sep 2019 04:54:14 -0400
X-ME-Sender: <xms:NYiIXdiVLRkTw8ju_fEG5N8fv9Qrl9XuEcc_aQEmoir3gE_bBntPZg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvdekgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujggfsehgtderredtredvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuffhomhgrih
    hnpehgihhthhhusgdrtghomhdpuhhsvghnihigrdhorhhgpdhlfihnrdhnvghtnecukfhp
    peeghedrfedvrdduvdekrddutdelnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquh
    hnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudej
    jeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrd
    hnrghmvgenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:NYiIXcoMqaEGdCLyukkqIKZpbt29sNk6G2aDvhssACUWH0YwD7nukg>
    <xmx:NYiIXTGkUb752-vBAJansb_FJ5igS68D5xVuMs5p30XWG8Ble7lagg>
    <xmx:NYiIXR7reQauwbMGobl7NgODOxX1_K3PNh-YEAVRIs10v2ZoF8270w>
    <xmx:NoiIXQPqQ6waDEnuc3cd-wTtT6odV9HIJt0aUQ29thVCrMlpDMVkvJo2JIs>
Received: from localhost (unknown [45.32.128.109])
        by mail.messagingengine.com (Postfix) with ESMTPA id 36FD680065;
        Mon, 23 Sep 2019 04:54:13 -0400 (EDT)
Date:   Mon, 23 Sep 2019 16:54:09 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Will Deacon <will@kernel.org>, Marco Elver <elver@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Paul Turner <pjt@google.com>, Daniel Axtens <dja@axtens.net>,
        Anatol Pomazau <anatol@google.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>
Subject: Re: Kernel Concurrency Sanitizer (KCSAN)
Message-ID: <20190923085409.GB1080@tardis>
References: <CANpmjNPJ_bHjfLZCAPV23AXFfiPiyXXqqu72n6TgWzb2Gnu1eA@mail.gmail.com>
 <20190920155420.rxiflqdrpzinncpy@willie-the-truck>
 <20190923043113.GA1080@tardis>
 <CACT4Y+a8qwBA_cHfZXFyO=E8qt2dFwy-ahy=cd66KcvFbpcyZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mojUlQ0s9EVzWg2t"
Content-Disposition: inline
In-Reply-To: <CACT4Y+a8qwBA_cHfZXFyO=E8qt2dFwy-ahy=cd66KcvFbpcyZQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mojUlQ0s9EVzWg2t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2019 at 10:21:38AM +0200, Dmitry Vyukov wrote:
> On Mon, Sep 23, 2019 at 6:31 AM Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > On Fri, Sep 20, 2019 at 04:54:21PM +0100, Will Deacon wrote:
> > > Hi Marco,
> > >
> > > On Fri, Sep 20, 2019 at 04:18:57PM +0200, Marco Elver wrote:
> > > > We would like to share a new data-race detector for the Linux kerne=
l:
> > > > Kernel Concurrency Sanitizer (KCSAN) --
> > > > https://github.com/google/ktsan/wiki/KCSAN  (Details:
> > > > https://github.com/google/ktsan/blob/kcsan/Documentation/dev-tools/=
kcsan.rst)
> > > >
> > > > To those of you who we mentioned at LPC that we're working on a
> > > > watchpoint-based KTSAN inspired by DataCollider [1], this is it (we
> > > > renamed it to KCSAN to avoid confusion with KTSAN).
> > > > [1] http://usenix.org/legacy/events/osdi10/tech/full_papers/Erickso=
n.pdf
> > >
> > > Oh, spiffy!
> > >
> > > > In the coming weeks we're planning to:
> > > > * Set up a syzkaller instance.
> > > > * Share the dashboard so that you can see the races that are found.
> > > > * Attempt to send fixes for some races upstream (if you find that t=
he
> > > > kcsan-with-fixes branch contains an important fix, please feel free=
 to
> > > > point it out and we'll prioritize that).
> > >
> > > Curious: do you take into account things like alignment and/or access=
 size
> > > when looking at READ_ONCE/WRITE_ONCE? Perhaps you could initially pru=
ne
> > > naturally aligned accesses for which __native_word() is true?
> > >
> > > > There are a few open questions:
> > > > * The big one: most of the reported races are due to unmarked
> > > > accesses; prioritization or pruning of races to focus initial effor=
ts
> > > > to fix races might be required. Comments on how best to proceed are
> > > > welcome. We're aware that these are issues that have recently recei=
ved
> > > > attention in the context of the LKMM
> > > > (https://lwn.net/Articles/793253/).
> > >
> > > This one is tricky. What I think we need to avoid is an onslaught of
> > > patches adding READ_ONCE/WRITE_ONCE without a concrete analysis of the
> > > code being modified. My worry is that Joe Developer is eager to get t=
heir
> > > first patch into the kernel, so runs this tool and starts spamming
> > > maintainers with these things to the point that they start ignoring K=
CSAN
> > > reports altogether because of the time they take up.
> > >
> > > I suppose one thing we could do is to require each new READ_ONCE/WRIT=
E_ONCE
> > > to have a comment describing the racy access, a bit like we do for me=
mory
> > > barriers. Another possibility would be to use atomic_t more widely if
> > > there is genuine concurrency involved.
> > >
> >
> > Instead of commenting READ_ONCE/WRITE_ONCE()s, how about adding
> > anotations for data fields/variables that might be accessed without
> > holding a lock? Because if all accesses to a variable are protected by
> > proper locks, we mostly don't need to worry about data races caused by
> > not using READ_ONCE/WRITE_ONCE(). Bad things happen when we write to a
> > variable using locks but read it outside a lock critical section for
> > better performance, for example, rcu_node::qsmask. I'm thinking so maybe
> > we can introduce a new annotation similar to __rcu, maybe call it
> > __lockfree ;-) as follow:
> >
> >         struct rcu_node {
> >                 ...
> >                 unsigned long __lockfree qsmask;
> >                 ...
> >         }
> >
> > , and __lockfree indicates that by design the maintainer of this data
> > structure or variable believe there will be accesses outside lock
> > critical sections. Note that not all accesses to __lockfree field, need
> > to be READ_ONCE/WRITE_ONCE(), if the developer manages to build a
> > complex but working wake/wait state machine so that it could not be
> > accessed in the same time, READ_ONCE()/WRITE_ONCE() is not needed.
> >
> > If we have such an annotation, I think it won't be hard for configuring
> > KCSAN to only examine accesses to variables with this annotation. Also
> > this annotation could help other checkers in the future.
> >
> > If KCSAN (at the least the upstream version) only check accesses with
> > such an anotation, "spamming with KCSAN warnings/fixes" will be the
> > choice of each maintainer ;-)
> >
> > Thoughts?
>=20
> But doesn't this defeat the main goal of any race detector -- finding
> concurrent accesses to complex data structures, e.g. forgotten
> spinlock around rbtree manipulation? Since rbtree is not meant to
> concurrent accesses, it won't have __lockfree annotation, and thus we
> will ignore races on it...

Maybe, but for forgotten locks detection, we already have lockdep and
also sparse can help a little. Having a __lockfree annotation could be
benefical for KCSAN to focus on checking the accesses whose race
conditions could only be detected by KCSAN at this time. I think this
could help KCSAN find problem more easily (and fast).

Out of curiosity, does KCSAN ever find a problem with forgotten locks
involved? I didn't see any in the -with-fixes branch (that's
understandable, given the seriousness, the fixes of this kind of
problems could already be submitted to upstream once KCSAN found it.)

Regards,
Boqun

--mojUlQ0s9EVzWg2t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAl2IiCkACgkQSXnow7UH
+rhPFgf/TJZhR+De2cHda5tb/9QSVnk0DgSAkdDkEBpDiafGVUPPv02aDRzknBML
60CgOciTh/CBR83TpFvZvc/WWLp42pQHxySeO+ATFAaH9ayaH7CeNE4ZjpRZPoUG
1+i2B1/cO6e4XPEig9Dq6CuObYEdNRZyLmIk4VZUf9/bvIAHjC9A6qNQ+52vY7mj
jnf3N2bR/ni2aTI+meIybbaKpW7tCLsRmD9ZgWIAu9q+KEUuien0Zfa6CK6Qt8yF
ZGVw/P4fRQgivOj7+7j1kFnx0SiRgZYNjdmsjmdbCbT/Dtgu6SZUR2RO8u/p4meI
V6OeAnxTbYGrf5CKGSQwceqhxpiXyA==
=F7nQ
-----END PGP SIGNATURE-----

--mojUlQ0s9EVzWg2t--
