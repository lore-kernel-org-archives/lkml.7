Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86569C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 11:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50F282067B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 11:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q3Igrxw6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731441AbfIPLxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 07:53:06 -0400
Received: from mail-qt1-f179.google.com ([209.85.160.179]:44317 "EHLO
        mail-qt1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727450AbfIPLxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 07:53:06 -0400
Received: by mail-qt1-f179.google.com with SMTP id u40so42862867qth.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 04:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EbozhC1jZLgN0MvkNvtE+3eF64JGJlQbmQhZ5TrVLgU=;
        b=q3Igrxw6BXruWJ7QFcpJVmVVOlZLydMm91Dck+iC6vA3FoEN739kTE/LQRjuDwRZ2p
         T1ZXY1MFrZ1x62cHLrWVsCU1eXSOB87hvqBaFnYO/I0OtnV4vcx5sHiwJmqt0LAAsROD
         v0tm6s1PZvs48QUuW6vzcXbQafx16uyCAkBEEdMJIoNXReNDaaL56mfzLEobRLB6vAtf
         YjeyUKm9Y+rI0aa8UMm3n18si0juCUjVa/4tLJmpjx1lzMKWccREjAtNTNDQaowxv7Mw
         0epW/UvERgHU7iF53LW/tIhmFmzV5MvXRaBxfXOI9yQtX3i0NMfIQElfZGhRnYD6lmk+
         oftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EbozhC1jZLgN0MvkNvtE+3eF64JGJlQbmQhZ5TrVLgU=;
        b=T7sXNfnkPDmqQg7gEw7xapF5bX0QBIa5pP3mjc8KyIn6fwAKL8R4mC1/CX1sn/9V0y
         apOzl1uapE/xlP1JV3XNxq4gt2JmkVJ+Ejs6asZOUqLRA/7xQuTwo92+8XTsIye9QKhM
         8VIOK2UH/yELllOXSM2nc2iIsAreqEWEa5zKX5s0+qpMUWTYeGZnP7674/phw3Vt/7dz
         aY83OetHKAUP3RN6xp7QaMU+lvoaNev1YVfWArpV+w9aEUOOIubbWL33UlqitdxnLr+5
         btAYq0wmE9wqtgKh7MaPRc5UwFYR8ImYOmD/b8xCXFCse4VM2IMN/lDuJ595VXKokNdq
         nTKw==
X-Gm-Message-State: APjAAAVTFViKdrwJa7QNYnIJzFevAzbNWLD9zHjgst2+bznwtioBx2Kv
        HcKcmRuTJowyCS4CCI3qFGU=
X-Google-Smtp-Source: APXvYqwpcG2aabuJJtdEsHZciy/r86C/zmozj57bQLHiXfqadf6AnPev43ha/T+TMqwtVypQL2HNMQ==
X-Received: by 2002:aed:3ef2:: with SMTP id o47mr16450703qtf.314.1568634784858;
        Mon, 16 Sep 2019 04:53:04 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id l14sm498514qtp.8.2019.09.16.04.53.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Sep 2019 04:53:03 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 4901621E97;
        Mon, 16 Sep 2019 07:53:02 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 16 Sep 2019 07:53:02 -0400
X-ME-Sender: <xms:mnd_XfaL0EIdb3rkx2nhXQoxAi1p2WThpV_5W_wpYk7byM58jV0ftg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudefgdegiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujggfsehgtderredtredvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecukfhppeeghe
    drfedvrdduvdekrddutdelnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhm
    vghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekhe
    ehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghm
    vgenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:m3d_XV9r5IGu1rf1oycCO-RYilDeLb-m7ozHH3BhTcqMdO9RfOsnDQ>
    <xmx:m3d_XRkc-P63YEl8LyfDlhidyUMbUfCJQ6Fk6I_EHKkSU6Co5E1k7A>
    <xmx:m3d_XSbMocGN6Bc9q4vbTlXGVdWzt4QUrJ7gWUmYWvemJUvKDDH5eQ>
    <xmx:nnd_XSdFoho90GIdpwO9gDs_hrRwnaQXnQbShR5jpQSTN8tOpbu1jKKjEUc>
Received: from localhost (unknown [45.32.128.109])
        by mail.messagingengine.com (Postfix) with ESMTPA id DD636D60067;
        Mon, 16 Sep 2019 07:52:57 -0400 (EDT)
Date:   Mon, 16 Sep 2019 19:52:54 +0800
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
Message-ID: <20190916115254.GB29216@tardis>
References: <Pine.LNX.4.44L0.1909061405560.1627-100000@iolanthe.rowland.org>
 <20190916051753.GA29216@tardis>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="i9LlY+UWpKt15+FH"
Content-Disposition: inline
In-Reply-To: <20190916051753.GA29216@tardis>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--i9LlY+UWpKt15+FH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 16, 2019 at 01:17:53PM +0800, Boqun Feng wrote:
> Hi Alan,
>=20
> I spend some time reading this, really helpful! Thanks.
>=20
> Please see comments below:
>=20
> On Fri, Sep 06, 2019 at 02:11:29PM -0400, Alan Stern wrote:
> [...]
> > If two memory accesses aren't concurrent then one must execute before
> > the other.  Therefore the LKMM decides two accesses aren't concurrent
> > if they can be connected by a sequence of hb, pb, and rb links
> > (together referred to as xb, for "executes before").  However, there
> > are two complicating factors.
> >=20
> > If X is a load and X executes before a store Y, then indeed there is
> > no danger of X and Y being concurrent.  After all, Y can't have any
> > effect on the value obtained by X until the memory subsystem has
> > propagated Y from its own CPU to X's CPU, which won't happen until
> > some time after Y executes and thus after X executes.  But if X is a
> > store, then even if X executes before Y it is still possible that X
> > will propagate to Y's CPU just as Y is executing.  In such a case X
> > could very well interfere somehow with Y, and we would have to
> > consider X and Y to be concurrent.
> >=20
> > Therefore when X is a store, for X and Y to be non-concurrent the LKMM
> > requires not only that X must execute before Y but also that X must
> > propagate to Y's CPU before Y executes.  (Or vice versa, of course, if
> > Y executes before X -- then Y must propagate to X's CPU before X
> > executes if Y is a store.)  This is expressed by the visibility
> > relation (vis), where X ->vis Y is defined to hold if there is an
> > intermediate event Z such that:
> >=20
> > 	X is connected to Z by a possibly empty sequence of
> > 	cumul-fence links followed by an optional rfe link (if none of
> > 	these links are present, X and Z are the same event),
> >=20
>=20
> I wonder whehter we could add an optional ->coe or ->fre between X and
> the possibly empty sequence of cumul-fence, smiliar to the definition
> of ->prop. This makes sense because if we have
>=20
> 	X ->coe X' (and X' in on CPU C)
>=20
> , X must be already propagated to C before X' executed, according to our
> operation model:
>=20
> "... In particular, it must arrange for the store to be co-later than
> (i.e., to overwrite) any other store to the same location which has
> already propagated to CPU C."
>=20
> In other words, we can define ->vis as:
>=20
> 	let vis =3D prop ; ((strong-fence ; [Marked] ; xbstar) | (xbstar & int))
>=20

Hmm.. so the problem with this approach is that the (xbstar & int) part
doesn't satisfy the requirement of visibility... i.e.

	X ->prop Z ->(xbstar & int) Y

may not guarantee when Y executes, X is already propagated to Y's CPU.

Lemme think more on this...

Regards,
Boqun

> , and for this document, reference the "prop" section in
> explanation.txt. This could make the model simple (both for description
> and explanation), and one better thing is that we won't need commit in
> Paul's dev branch:
> =09
> 	c683f2c807d2 "tools/memory-model: Fix data race detection for unordered =
store and load"
>=20
> , and data race rules will look more symmetrical ;-)
>=20
> Thoughts? Or am I missing something subtle here?
>=20
> Regards,
> Boqun
> =09
> > and either:
> >=20
> > 	Z is connected to Y by a strong-fence link followed by a
> > 	possibly empty sequence of xb links,
> >=20
> > or:
> >=20
> > 	Z is on the same CPU as Y and is connected to Y by a possibly
> > 	empty sequence of xb links (again, if the sequence is empty it
> > 	means Z and Y are the same event).
> >=20
> > The motivations behind this definition are straightforward:
> >=20
> > 	cumul-fence memory barriers force stores that are po-before
> > 	the barrier to propagate to other CPUs before stores that are
> > 	po-after the barrier.
> >=20
> > 	An rfe link from an event W to an event R says that R reads
> > 	from W, which certainly means that W must have propagated to
> > 	R's CPU before R executed.
> >=20
> > 	strong-fence memory barriers force stores that are po-before
> > 	the barrier, or that propagate to the barrier's CPU before the
> > 	barrier executes, to propagate to all CPUs before any events
> > 	po-after the barrier can execute.
> >=20
> > To see how this works out in practice, consider our old friend, the MP
> > pattern (with fences and statement labels, but without the conditional
> > test):
> >=20
> > 	int buf =3D 0, flag =3D 0;
> >=20
> > 	P0()
> > 	{
> > 		X: WRITE_ONCE(buf, 1);
> > 		   smp_wmb();
> > 		W: WRITE_ONCE(flag, 1);
> > 	}
> >=20
> > 	P1()
> > 	{
> > 		int r1;
> > 		int r2 =3D 0;
> >=20
> > 		Z: r1 =3D READ_ONCE(flag);
> > 		   smp_rmb();
> > 		Y: r2 =3D READ_ONCE(buf);
> > 	}
> >=20
> > The smp_wmb() memory barrier gives a cumul-fence link from X to W, and
> > assuming r1 =3D 1 at the end, there is an rfe link from W to Z.  This
> > means that the store to buf must propagate from P0 to P1 before Z
> > executes.  Next, Z and Y are on the same CPU and the smp_rmb() fence
> > provides an xb link from Z to Y (i.e., it forces Z to execute before
> > Y).  Therefore we have X ->vis Y: X must propagate to Y's CPU before Y
> > executes.
> >=20
> [...]



--i9LlY+UWpKt15+FH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAl1/d48ACgkQSXnow7UH
+rj1zQf/fXWjpiHq3iUIeLzjZpvvDpmE2WQp1r3BaswB6uPk8EmMhETCOitfNzLS
9ADJ5iQuMGVyqrMu5BBBubBaxIMwaJ2lWWRj4ZRZC/0RPJ3fiUDSYeenLjufYJc1
bk9rTm6odfDW5XzB6dqfbdaQptor5xK/WqS+lpcHwdhopNLHDp1ToMImBQuVMZIS
MTBqoIUzaw3e2DirwVogqRA/axkawtpzcyc86ejVfEP0w4L7/Fto8UnDgjYqfrm+
NXlYr8iGMaOmOfwQ+x1Q20zCpFt4osFA65sQov/0NkR1ga4HIBLx3igye565Hi33
1UGTzAu7eUwsvCQ2nOnUpvw+ZTLgAw==
=c7aw
-----END PGP SIGNATURE-----

--i9LlY+UWpKt15+FH--
