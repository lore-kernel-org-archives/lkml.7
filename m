Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF93C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 09:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 272C9248E6
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 09:12:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PsuLWyed"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbfFDJMa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 05:12:30 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36073 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbfFDJM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 05:12:29 -0400
Received: by mail-qt1-f195.google.com with SMTP id u12so12899503qth.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 02:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TZjOmNk5dlZs6JCR0pqtWM8aMInzhb+srND/4pbYH+c=;
        b=PsuLWyedA9S92R+2nWtF2Yz24LzFXCsBTf167zkIv79OiU6qVvTHm192kCwWqn5PvX
         bGrzVcHU8OPPh3E6HCsn2b0QJSLJNlcW5JgGABdRTUHPMbqSTe26UshsIffKE7e7Z1W/
         6O6vN386CdRE1BWTxm9SrDgkV0cP2AqYUTsZW1ySsamxQTiuayOZeK+5/6PGYsQL8Q9C
         xQvIy8hfCQCwodTr/x/oETasbDgn9PU6BdD/lDEmdeH7JNytL7zCOFldJ2rrFURbCD7P
         OOTW7QJJYYv3cEu95tHrkk0a8gANUVx086E3E1eMXlo60vfCEurZ7pPDND+jJmPXlmFi
         r/eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TZjOmNk5dlZs6JCR0pqtWM8aMInzhb+srND/4pbYH+c=;
        b=DG0kWlLJrVQ+G/LPA9oigwC942e2UW6c1BKYWPnjgVw45MJQEOEMwd1/UfdvxAYBbt
         TBqtrPheDWADltuYIjKHmsOh76GapVrpOqUatr/jb5lnBRyUvUhmmtdWVuA2y2UtvJfT
         7390O+OZzhJ6cCwzoT46jJQkSBQ1LPbftZpW7byGZFkORcon4LhGvsAuP3Zny+ZLzR/d
         zy0M0456/tFKPbaOwEWrWd7MXApACy0s1VCAAS14EyC/AmwpfPc3CZspuFDXQxc1Bxy9
         cixGs0omii59zeOMSqR9zXwOE0i9QS54PO6x9+T47sYncaTY7j5eCjiNbQY3PEEBwK7F
         oRiA==
X-Gm-Message-State: APjAAAUyU3FlNK8ZKgZ621ic6Erhh2VdQKeikLLWpoTI7gPioGNRjheu
        w2XOBNS7OntnrXOBQr5AJ3E=
X-Google-Smtp-Source: APXvYqzJFCRwarT7YuE37Vnfr5CY2paBDjWIjpezgSMcODEWMlSy0E4PcULxKDAV7DZ1ZfqvO/ByiQ==
X-Received: by 2002:ac8:3637:: with SMTP id m52mr13924648qtb.238.1559639548638;
        Tue, 04 Jun 2019 02:12:28 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id n6sm1669701qkk.61.2019.06.04.02.12.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 02:12:27 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 0CC8321F2E;
        Tue,  4 Jun 2019 05:12:26 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 04 Jun 2019 05:12:26 -0400
X-ME-Sender: <xms:-DX2XCo34kLGNSzyXGu2-v84wwHqxhEKBOSYo8fYqSbeLf8wJS2W-Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrudefledgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjfgesghdtreertdervdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucffohhmrg
    hinheplhhkmhhlrdhorhhgnecukfhppeeghedrfedvrdduvdekrddutdelnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlh
    hithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehg
    mhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:-DX2XE4uvp98lqk8QiDUfLonyDhcoITdffsqen7pVLR7iy_Po84v7g>
    <xmx:-DX2XCO4Jvftma64FvFiI9AryQM75Q1kpTvCqu0qiSvU_j7sKBvz8Q>
    <xmx:-DX2XGPiLi6VB_SBuhdAO7cjAAjpPQnGAZufW-tget3u6VDvo6DaJw>
    <xmx:-jX2XN6lRvVTJPF_zezHqgA993jytDtYuiSA1NwaHBs9OGirMyOAWdW2Tzw>
Received: from localhost (unknown [45.32.128.109])
        by mail.messagingengine.com (Postfix) with ESMTPA id 60BED8005C;
        Tue,  4 Jun 2019 05:12:23 -0400 (EDT)
Date:   Tue, 4 Jun 2019 17:12:20 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Yuyang Du <duyuyang@gmail.com>
Cc:     Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH v8 07/19] locking/rwsem: Implement lock handoff to
 prevent lock starvation
Message-ID: <20190604091220.GA29633@tardis>
References: <20190520205918.22251-1-longman@redhat.com>
 <20190520205918.22251-8-longman@redhat.com>
 <CAHttsrYx=pgen5yVpYfCKaymoCaA7iJ52B8t_ycD2UcDR2848Q@mail.gmail.com>
 <CAHttsrZCGMqBi4ifj7A1rO3G3nOz-0pbD8TXRtUQ1rGQRAGiUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline
In-Reply-To: <CAHttsrZCGMqBi4ifj7A1rO3G3nOz-0pbD8TXRtUQ1rGQRAGiUw@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 04, 2019 at 11:26:30AM +0800, Yuyang Du wrote:
> On Tue, 4 Jun 2019 at 11:03, Yuyang Du <duyuyang@gmail.com> wrote:
> >
> > Hi Waiman,
> >
> > On Tue, 21 May 2019 at 05:01, Waiman Long <longman@redhat.com> wrote:
> > >
> > > Because of writer lock stealing, it is possible that a constant
> > > stream of incoming writers will cause a waiting writer or reader to
> > > wait indefinitely leading to lock starvation.
> > >
> > > This patch implements a lock handoff mechanism to disable lock steali=
ng
> > > and force lock handoff to the first waiter or waiters (for readers)
> > > in the queue after at least a 4ms waiting period unless it is a RT
> > > writer task which doesn't need to wait. The waiting period is used to
> > > avoid discouraging lock stealing too much to affect performance.
> >
> > I was working on a patchset to solve read-write lock deadlock
> > detection problem (https://lkml.org/lkml/2019/5/16/93).
> >
> > One of the mistakes in that work is that I considered the following
> > case as deadlock:
>=20
> Sorry everyone, but let me rephrase:
>=20
> One of the mistakes in that work is that I considered the following
> case as no deadlock:
>=20
> >
> >   T1            T2
> >   --            --
> >
> >   down_read1    down_write2
> >
> >   down_write2   down_read1
> >

Not sure I understand the whole context here, but isn't adding a third
independent task makes this a deadlock?

	 T1            T2		T3
	 --            --		--

	 down_read1    down_write2
	 				down_write1
	 down_write2   down_read1

=66rom the perspective of lockdep, we cannot be sure whether there will
a T3 or not.

In case that I mis-understood you, maybe your point is about in the
above case whether "down_read1" on T2 can *gauranteedly* steal (in the
sense of breaking the fairness) the read lock after Waiman modification?
If so, I will wait for Waiman's response ;-)

Regards,
Boqun

> > So I was trying to understand what really went wrong and find the
> > problem is that if I understand correctly the current rwsem design
> > isn't showing real fairness but priority in favor of write locks, and
> > thus one of the bad effects is that read locks can be starved if write
> > locks keep coming.
> >
> > Luckily, I noticed you are revamping rwsem and seem to have thought
> > about it already. I am not crystal sure what is your work's
> > ramification on the above case, so hope that you can shed some light
> > and perhaps share your thoughts on this.
> >
> > Thanks,
> > Yuyang

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAlz2Ne0ACgkQSXnow7UH
+rjhfwf9FR6yMoJ+Xw63WFRRFgZR2LvoYKvDKMAPANUVVKrnzKjKCcpbNj0wZN7G
zNPKiuh8gSrEWfPXo0bWSjiGacJMZ1p6huLIXO1A+QEQOPXiUtBHS5IgPwYSvjEp
jPb9T9Tf5VHdytBK+Kez4obcrAavUA/9w9bnd2oeq3ZQLzIPJu4sNIrmZwlwPqRF
IMYsimqaVlrXX3tVnoBy2b6J2qexaOFkde8rpqfRYkxilnWcD0neSeQhoqg6/hOs
mTV11Pw7469wY/AAS+G74BvUEKwFbWUWRovTuNlI+6OnRyoGLmkl8ZzkUJ/c86Rb
g74f+qU0zZgUhG2JlJUynGbzxoheIA==
=ZMS6
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--
