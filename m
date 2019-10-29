Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C91CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 14:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 121F52087E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 14:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kuv0pAGs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389025AbfJ2OJb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 10:09:31 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44104 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfJ2OJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 10:09:30 -0400
Received: by mail-pg1-f196.google.com with SMTP id e10so9646567pgd.11
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 07:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WobDQl+ZOmcJRtws6Kg/bAZe9wMlwbuZqxsY+56Wc1A=;
        b=kuv0pAGsJqTozhp8CyzPokAc41FCgexaugwyipCaSbbNqgzJJwe/dXEJoLsRbd9h9v
         Q6i+AvzHkUM+eTBBUb2k+tctzM0/KTzXFxR7fDfxT0BsPlk4657QqCO+dTv+rRM3g/Ik
         YcyzdV0mMhADwrEcQi16MkVgni7w9CQyRTreGUwNyfspnysmvqhskQi27G5IqCSz5Iq/
         3phxXw17mTQeft7HRBYJ93ACkYZFSppx+XB5w4n4vK27+8TegivPjyFK6YNEdgXlZqFU
         JH3Wf0sEj0wpXqFb4xMMmXPvA8scJ1M5ouV8SZt35bE3GbaBqqhMq+S/RtNDAjMFtvlN
         mghQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WobDQl+ZOmcJRtws6Kg/bAZe9wMlwbuZqxsY+56Wc1A=;
        b=Hix1VbEscHOLC7ggOWH4KipKvuJfuf+Eqn99StcORUJv+WjMyjJKcuRtU69sMEExuW
         kskLDwiu59Z5vmuekdhPFo5HeuoSd3XNeGKoP4+RtmA2G63GRonvaJRwKIi3ttrxiTPR
         iYDRzJF+qSf07lcXhDtD9TivT2izOtuScuhttrvgzJ542RMm1wRHgv7X1INT4QB1iHA8
         3F5np6ew24q7CIcuQhqCT7Iwj2UU117sNENDsMYjupu6f8O2Mx72+e3EglFoz7ZqlJPE
         Ks73AEDQ9GjVwMTALIy5YHn6uGz1uj6BpFjlHCxpXAffiXX82Pu0pPdfoYMEKxACjF8M
         WdAw==
X-Gm-Message-State: APjAAAUxds6IXzcDwH54H5PiHljEHdB9rX35p9i3lGAdYyVB7vvgKxlE
        TDugihrn7XNKy88GOHukFnG8UC79Ssk=
X-Google-Smtp-Source: APXvYqzUTfhAjmZNJ8ZltcFF97u9OKZKgpjJ8JkrX8PSbYYAvBKfi+ADJHxDcrOY+BP8Au/UnWqYxQ==
X-Received: by 2002:a63:200e:: with SMTP id g14mr27746054pgg.91.1572358169909;
        Tue, 29 Oct 2019 07:09:29 -0700 (PDT)
Received: from pek-khao-d2.corp.ad.wrs.com (unknown-103-217.windriver.com. [147.11.103.217])
        by smtp.gmail.com with ESMTPSA id h25sm1665420pfn.47.2019.10.29.07.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 07:09:28 -0700 (PDT)
Date:   Tue, 29 Oct 2019 22:09:21 +0800
From:   Kevin Hao <haokexin@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] dump_stack: Avoid the livelock of the dump_lock
Message-ID: <20191029140921.GF23786@pek-khao-d2.corp.ad.wrs.com>
References: <20191029092423.17825-1-haokexin@gmail.com>
 <CAHk-=wjU9ASiPYFqmGJtOqG-0KtuNtu-aNPPY4M1AbcPdrfz7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UBnjLfzoMQYIXCvq"
Content-Disposition: inline
In-Reply-To: <CAHk-=wjU9ASiPYFqmGJtOqG-0KtuNtu-aNPPY4M1AbcPdrfz7A@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UBnjLfzoMQYIXCvq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2019 at 01:46:40PM +0100, Linus Torvalds wrote:
> Sorry for html crud, I'm at a conference without my laptop, so reading em=
ail on
> my phone..
>=20
> On Tue, Oct 29, 2019, 10:31 Kevin Hao <haokexin@gmail.com> wrote:
>=20
>     In the current code, we uses the atomic_cmpxchg() to serialize the
>     output of the dump_stack(), but this implementation suffers the
>     thundering herd problem. Actually we can use a spinlock here and leve=
rage
>     the
>=20
>     implementation of the spinlock(either ticket or queued spinlock) to
>     mediate such kind of livelock. Since the dump_stack() runs with the
>     irq disabled, so use the raw_spinlock_t to make it safe for rt kernel.
>=20
>=20
> The problem with this is that I think it will deadlock easily with NMI's,=
 won't
> it?
>=20
> There is a window between getting the spin lock and setting 'dump_cpu' wh=
ere an
> incoming NMI would then deadlock because it also tries to get the lock, b=
ecause
> it hasn't seen the fact that this cpu already got it.

Indeed, sorry I missed that.

>=20
> The cmpxchg is supposed to protect against that, and make the locking be =
atomic
> with the CPU setting.
>=20
> Can you try instead to make the retry loop not jump right back to the cmp=
xchg,
> but start looping just reading the CPU value, and only jumping back when =
it
> becomes -1?

Do you mean something like this?
diff --git a/lib/dump_stack.c b/lib/dump_stack.c
index 5cff72f18c4a..a0f1293a3638 100644
--- a/lib/dump_stack.c
+++ b/lib/dump_stack.c
@@ -107,6 +107,7 @@ asmlinkage __visible void dump_stack(void)
 	} else {
 		local_irq_restore(flags);
 		cpu_relax();
+		while (atomic_read(&dump_lock) !=3D -1);
 		goto retry;
 	}
=20
It does help. I will send a v2 if it pass more stress test.

Thanks,
Kevin

>=20
> =A0 =A0 =A0 Linus

--UBnjLfzoMQYIXCvq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEHc6qFoLCZqgJD98Zk1jtMN6usXEFAl24SBEACgkQk1jtMN6u
sXGMuwf+OUOSTXauyoNMAE+7QY0v8cAL7bHXX7y4n14f9FsHp7xQ5FKG3RO0dlDJ
XOVsDpDUjdire3V0wl4rjdsAIqGSl/MmC+4II2FtO5SJcjwEEarx+iRwJXEhQuMu
FoY+BtA0B3lbL/QYgFfowEuYVIxeNEHf70Bmzd9koRyG1n9UCD4laMeOjrXsyG+M
QWpF5iaIi9KTp1/8ymoQrgOi8/9r6RoNeG8BoeOHg49mqTaT/gVTZ1JFRuurHxgC
Ry8kxWRlZuXGwr9mh0HPdL6i7dxDIOrYM84k9cegRKsq5tD0cPWrt+rQdpTHafY9
3dO1OuNliCSMug35mKMbkVEc3z0ZdA==
=D2oW
-----END PGP SIGNATURE-----

--UBnjLfzoMQYIXCvq--
