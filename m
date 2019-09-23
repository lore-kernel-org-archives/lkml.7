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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E5DCC04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 12:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7F49205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 12:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gTN0eZbW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394176AbfIWMc0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 08:32:26 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44192 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbfIWMc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 08:32:26 -0400
Received: by mail-qk1-f193.google.com with SMTP id u22so11643124qkk.11
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 05:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qQR4RW8lfrPuD3QZB1LDLWj8f+xtWt07rFFpVPfxCms=;
        b=gTN0eZbW1YmsD3pcFmh7TmnqUuHc0ZYuHlhG1ElD7ufxif/gOblhyMiDCFVPk/4ynq
         d6fKOpZoEIOHmeJrZtKMHqDTLVUpBgjQHgAsP+9COPqKBz0vWSjMQJ/SPnPxj99jM9fu
         kPghMVoJKlqC3j2CUpNCUS4PKaml+JpiQ7FrlQLQqk2yx3ig6Aa/qXxv6Abokf9pkcjc
         Tp2M0oYZuEkMzp2vRUWgqPt7ehsh4Vht2w2CNeox8BWyrVqOfJj+jwdaKXriBSIQ5Yep
         lmEqWJR+DJSf96R27u/KcRy6hMBGt/4zLFKWzJQfwDDpo7mAtq9ANDsDvQA16b8Gb5eR
         FXuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qQR4RW8lfrPuD3QZB1LDLWj8f+xtWt07rFFpVPfxCms=;
        b=pxhtBF3v0XeYJHPfmXknLQSZTEX57+e4m2MtxAgAqA//vjY716OoGBjJXsqGOLdkat
         JStQqkHFnZlmDz0Vr71rcwuXc3pXRw9SlBOc/Bt5828Fo0Y50jD+XCvHR283qg1DuioZ
         jswR+nzbL0IZg6SWQw+mrxdgi98sgIMjJdmCxohTRO/gY+/EFjTWN2j5H0/8yiSEwb+x
         TIUsZL2Q+XXKBfJXYztHLHpOlKjP8LBq7IksanGaN+Wz7GvoHtPMBvLlM1LQA3ApWIMU
         AtfJV6Uu+SpQO1bcSMzDLLP14yBJODIKqMkcZb/HeoNPy3yd+LVjsnYyP39+fZDXCL7G
         iOUg==
X-Gm-Message-State: APjAAAWzch+A+u2nw3p8jtnTh2Tm8vVHCH3rJ7DwMLvVMpp+N+UbmK3D
        f8tVMjyRHNFEk3HeIjj6JM8=
X-Google-Smtp-Source: APXvYqzwfHS0WPcHtXy5w6RnlovQGJkVFVyvma5fydAm/Aqd5dZLnaLQsJ2iN8t3RsAIz2deDvnyng==
X-Received: by 2002:a37:a1cd:: with SMTP id k196mr17079414qke.189.1569241945011;
        Mon, 23 Sep 2019 05:32:25 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id a190sm5666350qkf.118.2019.09.23.05.32.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Sep 2019 05:32:23 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id A5783223E2;
        Mon, 23 Sep 2019 08:32:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 23 Sep 2019 08:32:22 -0400
X-ME-Sender: <xms:VbuIXTbzizD3l2ifG4tW_l3Ts4PeF9mUFNXwX7ZmicmvkCZa6cW6Bg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvdekgdehfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujggfsehgtderredtredvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuffhomhgrih
    hnpehsphhinhhitghsrdhnvghtpdhgihhthhhusgdrtghomhdpuhhsvghnihigrdhorhhg
    pdhlfihnrdhnvghtnecukfhppeeghedrfedvrdduvdekrddutdelnecurfgrrhgrmhepmh
    grihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithih
    qdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrih
    hlrdgtohhmsehfihigmhgvrdhnrghmvgenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:VbuIXeFKh-UraISkET-mvnSaoAPQnU4EIqnMIIQGMuEYSsHts1OdsQ>
    <xmx:VbuIXSYJwp20PH_QpgOK3LOkj_SDUprUZYtLEknRb2IWQ1_6ND7ijw>
    <xmx:VbuIXSzh-z5T4aa4qMqGMkdJ1nU7I7ILfPymMLxhGPdSaosyEPM8dA>
    <xmx:VruIXfgPr_F91vcnnQgIJ8abQQ-zI9xeVXITUMHi9KwVmf72_fxOkMs87o8>
Received: from localhost (unknown [45.32.128.109])
        by mail.messagingengine.com (Postfix) with ESMTPA id 08A71D60062;
        Mon, 23 Sep 2019 08:32:20 -0400 (EDT)
Date:   Mon, 23 Sep 2019 20:32:15 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Marco Elver <elver@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>, Will Deacon <will@kernel.org>,
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
Message-ID: <20190923123215.GD11739@tardis>
References: <CANpmjNPJ_bHjfLZCAPV23AXFfiPiyXXqqu72n6TgWzb2Gnu1eA@mail.gmail.com>
 <20190920155420.rxiflqdrpzinncpy@willie-the-truck>
 <20190923043113.GA1080@tardis>
 <CACT4Y+a8qwBA_cHfZXFyO=E8qt2dFwy-ahy=cd66KcvFbpcyZQ@mail.gmail.com>
 <20190923085409.GB1080@tardis>
 <CACT4Y+YfkV80QF2qxjfHnBghM8Am8m_YHzCtPRfSmOrF-y3bbg@mail.gmail.com>
 <CANpmjNNX5gJ-CRZ-zg3vNzTcBh6+_zEFQzEGTVFKX-z_KwweVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zx4FCpZtqtKETZ7O"
Content-Disposition: inline
In-Reply-To: <CANpmjNNX5gJ-CRZ-zg3vNzTcBh6+_zEFQzEGTVFKX-z_KwweVw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zx4FCpZtqtKETZ7O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2019 at 01:01:27PM +0200, Marco Elver wrote:
> On Mon, 23 Sep 2019 at 10:59, Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > On Mon, Sep 23, 2019 at 10:54 AM Boqun Feng <boqun.feng@gmail.com> wrot=
e:
> > >
> > > On Mon, Sep 23, 2019 at 10:21:38AM +0200, Dmitry Vyukov wrote:
> > > > On Mon, Sep 23, 2019 at 6:31 AM Boqun Feng <boqun.feng@gmail.com> w=
rote:
> > > > >
> > > > > On Fri, Sep 20, 2019 at 04:54:21PM +0100, Will Deacon wrote:
> > > > > > Hi Marco,
> > > > > >
> > > > > > On Fri, Sep 20, 2019 at 04:18:57PM +0200, Marco Elver wrote:
> > > > > > > We would like to share a new data-race detector for the Linux=
 kernel:
> > > > > > > Kernel Concurrency Sanitizer (KCSAN) --
> > > > > > > https://github.com/google/ktsan/wiki/KCSAN  (Details:
> > > > > > > https://github.com/google/ktsan/blob/kcsan/Documentation/dev-=
tools/kcsan.rst)
> > > > > > >
> > > > > > > To those of you who we mentioned at LPC that we're working on=
 a
> > > > > > > watchpoint-based KTSAN inspired by DataCollider [1], this is =
it (we
> > > > > > > renamed it to KCSAN to avoid confusion with KTSAN).
> > > > > > > [1] http://usenix.org/legacy/events/osdi10/tech/full_papers/E=
rickson.pdf
> > > > > >
> > > > > > Oh, spiffy!
> > > > > >
> > > > > > > In the coming weeks we're planning to:
> > > > > > > * Set up a syzkaller instance.
> > > > > > > * Share the dashboard so that you can see the races that are =
found.
> > > > > > > * Attempt to send fixes for some races upstream (if you find =
that the
> > > > > > > kcsan-with-fixes branch contains an important fix, please fee=
l free to
> > > > > > > point it out and we'll prioritize that).
> > > > > >
> > > > > > Curious: do you take into account things like alignment and/or =
access size
> > > > > > when looking at READ_ONCE/WRITE_ONCE? Perhaps you could initial=
ly prune
> > > > > > naturally aligned accesses for which __native_word() is true?
> > > > > >
> > > > > > > There are a few open questions:
> > > > > > > * The big one: most of the reported races are due to unmarked
> > > > > > > accesses; prioritization or pruning of races to focus initial=
 efforts
> > > > > > > to fix races might be required. Comments on how best to proce=
ed are
> > > > > > > welcome. We're aware that these are issues that have recently=
 received
> > > > > > > attention in the context of the LKMM
> > > > > > > (https://lwn.net/Articles/793253/).
> > > > > >
> > > > > > This one is tricky. What I think we need to avoid is an onslaug=
ht of
> > > > > > patches adding READ_ONCE/WRITE_ONCE without a concrete analysis=
 of the
> > > > > > code being modified. My worry is that Joe Developer is eager to=
 get their
> > > > > > first patch into the kernel, so runs this tool and starts spamm=
ing
> > > > > > maintainers with these things to the point that they start igno=
ring KCSAN
> > > > > > reports altogether because of the time they take up.
> > > > > >
> > > > > > I suppose one thing we could do is to require each new READ_ONC=
E/WRITE_ONCE
> > > > > > to have a comment describing the racy access, a bit like we do =
for memory
> > > > > > barriers. Another possibility would be to use atomic_t more wid=
ely if
> > > > > > there is genuine concurrency involved.
> > > > > >
> > > > >
> > > > > Instead of commenting READ_ONCE/WRITE_ONCE()s, how about adding
> > > > > anotations for data fields/variables that might be accessed witho=
ut
> > > > > holding a lock? Because if all accesses to a variable are protect=
ed by
> > > > > proper locks, we mostly don't need to worry about data races caus=
ed by
> > > > > not using READ_ONCE/WRITE_ONCE(). Bad things happen when we write=
 to a
> > > > > variable using locks but read it outside a lock critical section =
for
> > > > > better performance, for example, rcu_node::qsmask. I'm thinking s=
o maybe
> > > > > we can introduce a new annotation similar to __rcu, maybe call it
> > > > > __lockfree ;-) as follow:
> > > > >
> > > > >         struct rcu_node {
> > > > >                 ...
> > > > >                 unsigned long __lockfree qsmask;
> > > > >                 ...
> > > > >         }
> > > > >
> > > > > , and __lockfree indicates that by design the maintainer of this =
data
> > > > > structure or variable believe there will be accesses outside lock
> > > > > critical sections. Note that not all accesses to __lockfree field=
, need
> > > > > to be READ_ONCE/WRITE_ONCE(), if the developer manages to build a
> > > > > complex but working wake/wait state machine so that it could not =
be
> > > > > accessed in the same time, READ_ONCE()/WRITE_ONCE() is not needed.
> > > > >
> > > > > If we have such an annotation, I think it won't be hard for confi=
guring
> > > > > KCSAN to only examine accesses to variables with this annotation.=
 Also
> > > > > this annotation could help other checkers in the future.
> > > > >
> > > > > If KCSAN (at the least the upstream version) only check accesses =
with
> > > > > such an anotation, "spamming with KCSAN warnings/fixes" will be t=
he
> > > > > choice of each maintainer ;-)
> > > > >
> > > > > Thoughts?
> > > >
> > > > But doesn't this defeat the main goal of any race detector -- findi=
ng
> > > > concurrent accesses to complex data structures, e.g. forgotten
> > > > spinlock around rbtree manipulation? Since rbtree is not meant to
> > > > concurrent accesses, it won't have __lockfree annotation, and thus =
we
> > > > will ignore races on it...
> > >
> > > Maybe, but for forgotten locks detection, we already have lockdep and
> > > also sparse can help a little.
> >
> > They don't do this at all, or to the necessary degree.
> >
> > > Having a __lockfree annotation could be
> > > benefical for KCSAN to focus on checking the accesses whose race
> > > conditions could only be detected by KCSAN at this time. I think this
> > > could help KCSAN find problem more easily (and fast).
>=20
> Just to confirm, the annotation is supposed to mean "this variable
> should not be accessed concurrently". '__lockfree' may be confusing,
> as "lock-free" has a very specific meaning ("lock-free algorithm"),
> and I initially thought the annotation means the opposite. Maybe more
> intuitive would be '__nonatomic'.
>=20

Well, "__lockfree" means the variable will be accessed without holding a
lock, most likely in a lock-free algorithm. But I admit I haven't
thought too much about the name, so maybe it's a bad one ;-)

> My view, however, is that this will not scale. 1) Our goal is to
> *avoid* more annotations if possible. 2) Furthermore, any such

Understood. I don't have any objection to your goal, and I think
achieving that will really help developers.

> annotation assumes the developer already has understanding of all
> concurrently accessed variables; however, this may not be the case for
> the next person touching the code, resulting in an error. By

By introducing annotations as __lockfree/__nonatomic, won't it help pass
the understanding between developers? "the next person" should learn
about the design by reading the code (or document) rather than adding
some random code and see if KCSAN yells.

Just to be clear, my initial thought of introduing the annotation is to
have a better way to document the variable that cannot be accessed
"plainly" in a non mutual-exclusive environment, so that the fixes that
add READ_ONCE or WRITE_ONCE to accesses of those variables should be
considered useful.

> "whitelisting" variables, we would likely miss almost every serious
> bug.
>=20
> To enable/disable KCSAN for entire subsystems, it's already possible
> to use 'KCSAN_SANITIZE :=3Dn' in the Makefile, or 'KCSAN_SANITIZE_file.o
> :=3D n' for individual files.
>=20
> > > Out of curiosity, does KCSAN ever find a problem with forgotten locks
> > > involved? I didn't see any in the -with-fixes branch (that's
> > > understandable, given the seriousness, the fixes of this kind of
> > > problems could already be submitted to upstream once KCSAN found it.)
>=20
> The sheer volume of 'benign' data-races makes it difficult to filter
> through and get to these, but it certainly detects such issues.
>=20
> Thanks,
> -- Marco
>=20
> > This one comes to mind:
> > https://www.spinics.net/lists/linux-mm/msg92677.html
> >

Yeah, this one is a "forgotten lock" case in the wild.

> > Maybe some others here, but I don't remember which ones now:
> > https://github.com/google/ktsan/wiki/KTSAN-Found-Bugs

Thank you both for the information!

Regards,
Boqun

--zx4FCpZtqtKETZ7O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAl2Iu0sACgkQSXnow7UH
+rgDqAf/blPQEppraEPp0L0MMMBL11v6v8tzlcck+j4FhNyajoaqiye/sG4uW+Mu
fIl25HkknEqzJvPnNVIalxBHL3yYm4UgOpAzRsPXaELrebvJRmTvq1OCzYDZkaP2
UTiv4FLEuLdjhw8pDaBfqgwjF6IzPrHo+CzSQrK0VJxJQcyhUYy3tZxVc5S4KCmc
ZXNV9zwguQtfSVMj+r5i0y45ybbgf0zmcP7h1x92/ucE04ea2K5v3giR2Y5VmnKa
vk+Lx9EOKFP+pM2f9oXh9j86Rjei+paMgS6Tm5Ds7pxcWbp85I40dmu76/vJv8Dw
M06gzd840Y7KtjInz7BKHsC3RWXPhw==
=/P5z
-----END PGP SIGNATURE-----

--zx4FCpZtqtKETZ7O--
