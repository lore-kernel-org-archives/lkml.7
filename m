Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C770C282E1
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 00:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4D2021479
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 00:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m11zybd4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfDTA0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 20:26:25 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33510 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbfDTA0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 20:26:24 -0400
Received: by mail-pf1-f193.google.com with SMTP id h5so3177389pfo.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 17:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :user-agent:message-id:content-transfer-encoding;
        bh=M97lh/Y8w6o7iSi4mRxZX5XhNlvzJaIXl2AUVIYqN4w=;
        b=m11zybd4aGBxDVJuWAIj8xFFYzdxlmRFGKlizn7WN73zIb+NWk8994kWTPzzk79pLP
         XH2W/Dz/l50ExU1eIM37sW1DWrMFZcRtTMv5DHxVs6ZUbjOo3dRNzznOTfYVFBGf527e
         Qr/G5nCTlTtha2EsEsqpzEyWgUuVIgfGgl+GRYu/eIV3gM8OIWQi5Mg1E77crBFZCiRk
         rv/TiRcTv0+6HYAClMbqIhn/Sw6L7FmvKyrdj0pCYnG4RnA4cuqTifEVBnDoGRBLVTzF
         9B3XjEhfKC+DtEBkVFAlJOlMTihssLhc+UzE+/L/CNjpsm031D65xTRVRHoVOsIq8onH
         i+zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:user-agent:message-id:content-transfer-encoding;
        bh=M97lh/Y8w6o7iSi4mRxZX5XhNlvzJaIXl2AUVIYqN4w=;
        b=skXlBdUD+Lf5RxOJXgukJDBnINNIahDSWoZsY/J5PiTeEj96WjGUeqVhUUsI0IdO8f
         BcMkfD/mFM7DeIoh5RvKuMks6hyedfZ7HPz2p/bGedvFCVL5HAPrpXZfe4jPvuriMZAX
         ypW+iJkzCJBFc9PkquOcHbr/yPXjiUzUmhASKpSUe5YDmxOPKs16wDRzavGRT1GuFvZm
         0AixShMtqiUrP8POEfZwFAtR2X/qTNYpKu6VEyjqToQ4saX/8ds++SdGF0g/JlVMBesz
         BXrOHwRvdLrvOtHkdCVZgp6sXlkZw0PYa/olyMOJnUWAjKY808SBMh8VWjGak3ux72rU
         kCQg==
X-Gm-Message-State: APjAAAVudbhRP3myxjbTr+ZCCTl8NIJ2JlsmUw9NMdVe8jGYZv/jFeek
        7gcmhcaoSERzrM4N5bpkHE0=
X-Google-Smtp-Source: APXvYqwe0KbKBL11abQwm+QpbTNumrKZj7+yJN2z4kto2FYBaSYkTPPs/nO49b24dz78hbxV6YcqCw==
X-Received: by 2002:a63:4e64:: with SMTP id o36mr6459955pgl.213.1555719983915;
        Fri, 19 Apr 2019 17:26:23 -0700 (PDT)
Received: from localhost (61-68-62-77.tpgi.com.au. [61.68.62.77])
        by smtp.gmail.com with ESMTPSA id p6sm7358980pfd.122.2019.04.19.17.26.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Apr 2019 17:26:22 -0700 (PDT)
Date:   Sat, 20 Apr 2019 10:26:15 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] Documentation: atomic_t.txt: Explain ordering provided by
 smp_mb__{before,after}_atomic()
To:     paulmck@linux.ibm.com, Peter Zijlstra <peterz@infradead.org>
Cc:     LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        Luc Maranget <luc.maranget@inria.fr>,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>
References: <Pine.LNX.4.44L0.1904191312200.1406-100000@iolanthe.rowland.org>
        <20190419180017.GP4038@hirez.programming.kicks-ass.net>
        <20190419182620.GF14111@linux.ibm.com>
In-Reply-To: <20190419182620.GF14111@linux.ibm.com>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1555719429.t9n8gkf70y.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paul E. McKenney's on April 20, 2019 4:26 am:
> On Fri, Apr 19, 2019 at 08:00:17PM +0200, Peter Zijlstra wrote:
>> On Fri, Apr 19, 2019 at 01:21:45PM -0400, Alan Stern wrote:
>> > Index: usb-devel/Documentation/atomic_t.txt
>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > --- usb-devel.orig/Documentation/atomic_t.txt
>> > +++ usb-devel/Documentation/atomic_t.txt
>> > @@ -171,7 +171,10 @@ The barriers:
>> >    smp_mb__{before,after}_atomic()
>> > =20
>> >  only apply to the RMW ops and can be used to augment/upgrade the orde=
ring
>> > -inherent to the used atomic op. These barriers provide a full smp_mb(=
).
>> > +inherent to the used atomic op. Unlike normal smp_mb() barriers, they=
 order
>> > +only the RMW op itself against the instructions preceding the
>> > +smp_mb__before_atomic() or following the smp_mb__after_atomic(); they=
 do
>> > +not order instructions on the other side of the RMW op at all.
>>=20
>> Now it is I who is confused; what?
>>=20
>> 	x =3D 1;
>> 	smp_mb__before_atomic();
>> 	atomic_add(1, &a);
>> 	y =3D 1;
>>=20
>> the stores to both x and y will be ordered as if an smp_mb() where
>> there. There is no order between a and y otoh.
>=20
> Let's look at x86.  And a slightly different example:
>=20
> 	x =3D 1;
> 	smp_mb__before_atomic();
> 	atomic_add(1, &a);
> 	r1 =3D y;
>=20
> The atomic_add() asm does not have the "memory" constraint, which is
> completely legitimate because atomic_add() does not return a value,
> and thus guarantees no ordering.  The compiler is therefore within
> its rights to transform the code into the following:
>=20
> 	x =3D 1;
> 	smp_mb__before_atomic();
> 	r1 =3D y;
> 	atomic_add(1, &a);
>=20
> But x86's smp_mb__before_atomic() is just a compiler barrier, and
> x86 is further allowed to reorder prior stores with later loads.
> The CPU can therefore execute this code as follows:
>=20
> 	r1 =3D y;
> 	x =3D 1;
> 	smp_mb__before_atomic();
> 	atomic_add(1, &a);
>=20
> So in general, the ordering is guaranteed only to the atomic itself,
> not to accesses on the other side of the atomic.

That's interesting. I don't think that's what all our code expects.
I had the same idea as Peter.

IIRC the primitive was originally introduced exactly so x86 would not
need to have the unnecessary hardware barrier with sequences like

  smp_mb();
  ...
  atomic_inc(&v);

The "new" semantics are a bit subtle. One option might be just to
replace it entirely with atomic_xxx_mb() ?

Thanks,
Nick

=
