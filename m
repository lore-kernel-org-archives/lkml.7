Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35670C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 00:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 046ED20684
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 00:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hbKam+Yn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbfCEAVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 19:21:51 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39890 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfCEAVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 19:21:51 -0500
Received: by mail-pg1-f193.google.com with SMTP id h8so4262479pgp.6;
        Mon, 04 Mar 2019 16:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :user-agent:message-id:content-transfer-encoding;
        bh=0m3wMkpLhX+1cNPE2hALhrlfJTBLnSc319poZ7NZ9j4=;
        b=hbKam+YnQAfju4duQn8j/ZHFZaYT2DbgP1cLt9Tj7LQiTdPsm9+hYCguBCS4drvXgi
         95eC+BlNp5l8+lrGnsV4+siGp9f1dOaAV3xgneEgWgo3w1QVK6pkiGgzNj3+irTCnA1O
         RQzyOMFmIKa/zrxSVe7BWD3TZAVKJkO7TF6Gws2wx85l0GBkF8keojXdGoFeXwmBVVxj
         IvU1Lb9o5pe7eKEklQPtyjEA7hGADQoRpos3ndTOoro23q3F/Mw9BK6f3yHIGXMtHPiK
         D8hn9OGHFW3XWzVQ4uNJFcDu/JNfYayq3FX6SExp53zc2f+CtBatCEUlJfkvekzolQnl
         wZeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:user-agent:message-id:content-transfer-encoding;
        bh=0m3wMkpLhX+1cNPE2hALhrlfJTBLnSc319poZ7NZ9j4=;
        b=j0oqizRG+Bc/COECgRwodbd81ZdsogsDoCirS2+ysxeDXDV3kQFKJQsi/8L1+r2HLx
         c6l4WwZz5hFWI6zM3Zx1yy1ltOXbpWuRABc9oF9nxDG5UzGxaxsn+d1/gljfnAVwWuep
         f8iiKJenAhpx9/U+OPi65d6eqbzRC06p4wrjy+ElN3QuPQ7FSjkDkf67mMZjo6InEorD
         hl8ycSvrc8yfB6REhtF0eCBC9iDkY9VIiK/0FFbmfiwrtcu1a43TgyClTfML3GH0YiTF
         /+xahGnpcw4MVBuwYsyMxH+4KOn9Hc7akxiMTquTcFMYwmOCs5YEQ1kyS+fHpjaQGw2/
         o76w==
X-Gm-Message-State: APjAAAXQYroNm2u7nCoSIK4AYR+U8MBIjb4CUm0kUBDXS6LE9V85ckOb
        tVNoL93lX1EKGgU/OdcdddUUUp/sz8psAw==
X-Google-Smtp-Source: APXvYqw3WNBH9qdQJtme3AxsshdtYOxveHxK7bkUwgdVQzU9OUYSFBq1tF/1kJC3RD+XUV7wbhJLFQ==
X-Received: by 2002:a63:1a62:: with SMTP id a34mr21227779pgm.60.1551745309805;
        Mon, 04 Mar 2019 16:21:49 -0800 (PST)
Received: from localhost ([1.128.139.55])
        by smtp.gmail.com with ESMTPSA id b8sm9315241pfi.129.2019.03.04.16.21.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Mar 2019 16:21:49 -0800 (PST)
Date:   Tue, 05 Mar 2019 10:21:42 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 01/20] asm-generic/mmiowb: Add generic implementation of
 mmiowb() tracking
To:     linux-arch@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        Will Deacon <will.deacon@arm.com>
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Rich Felker <dalias@libc.org>,
        David Howells <dhowells@redhat.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        linux-kernel@vger.kernel.org,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Ingo Molnar <mingo@kernel.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Burton <paul.burton@mips.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Tony Luck <tony.luck@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
References: <20190301140348.25175-1-will.deacon@arm.com>
        <20190301140348.25175-2-will.deacon@arm.com>
        <1551575210.6lwpiqtg5k.astroid@bobo.none>
        <87tvgkia0k.fsf@concordia.ellerman.id.au>
        <1551607531.yk1v9azmym.astroid@bobo.none>
        <87d0n7bgh7.fsf@concordia.ellerman.id.au>
In-Reply-To: <87d0n7bgh7.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1551744761.r3fh0fxees.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Ellerman's on March 4, 2019 11:01 am:
> Nicholas Piggin <npiggin@gmail.com> writes:
>> Michael Ellerman's on March 3, 2019 7:26 pm:
>>> Nicholas Piggin <npiggin@gmail.com> writes:
> ...
>>>> what was broken about the powerpc one, which is basically:
>>>>
>>>> static inline void mmiowb_set_pending(void)
>>>> {
>>>> 	struct mmiowb_state *ms =3D __mmiowb_state();
>>>> 	ms->mmiowb_pending =3D 1;
>>>> }
>>>>
>>>> static inline void mmiowb_spin_lock(void)
>>>> {
>>>> }
>>>=20
>>> The current powerpc code clears io_sync in spin_lock().
>>>=20
>>> ie, it would be equivalent to:
>>>=20
>>> static inline void mmiowb_spin_lock(void)
>>> {
>>>  	ms->mmiowb_pending =3D 0;
>>> }
>>
>> Ah okay that's what I missed. How about we just not do that?
>=20
> Yeah I thought of that too but it's not great. We'd start semi-randomly
> executing the sync in unlock depending on whether someone had done IO on
> that CPU prior to the spinlock.
>=20
> eg.
>=20
> 	writel(x, y);		// sets paca->io_sync
> 	...=09
>=20
> 	<schedule>
>=20
> 	spin_lock(a);
>         ...
>         // No IO in here
>         ...
>         spin_unlock(a);		// sync() here because other task did writel().
>=20
>=20
> Which wouldn't be *incorrect*, but would be kind of weird.

schedule is probably okay, we could clear pending there. But you
possibly could get interrupts, or some lock free mmios that set the
flag. Does it matter that much? A random cache miss could have the
same effect.

It may matter slightly less for powerpc because we don't inline
spin locks, although I have been hoping to for a while, this might
put the nail in that.

We can always tinker with it later though so I won't insist.

Thanks,
Nick

=
