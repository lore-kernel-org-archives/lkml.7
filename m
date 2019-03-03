Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E97EFC43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 10:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A670420836
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 10:05:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQsBWKzk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbfCCKFc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 05:05:32 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38416 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbfCCKFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 05:05:31 -0500
Received: by mail-pg1-f196.google.com with SMTP id m2so1107834pgl.5;
        Sun, 03 Mar 2019 02:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :user-agent:message-id:content-transfer-encoding;
        bh=b8vQYc9ep8TfoYWy1t/cwVZtTf+JFWkdkgDvyL2DYys=;
        b=eQsBWKzko1lBtorrWr+b06pWwvf5bv7f9QI8605aY1Kw/dzLGRowS+gxr8N56VREuW
         cABct7IuxrVOSnxC7ndkrBXi65G/LN1zEHDGeEIbTpXKbF46a2X1wSu7DOtVv3Wi3nK8
         wA8xEsNVIs5+CW+h66uTLBqNev9THmAGa6TDrQINOgPFwYvNhFWu7k9uHJl1VtpYPKSp
         QXw0/fbIa7u3XrwRt59pAXtPO1vRdyk5Tk1Oe7k76odFBjyQkE01qP1OIhrbf/IG/Y11
         ZE7zHbC16oti7qnbCmN0U6CMrJ6j8qMmoPOHCYbeFc7KldHoBlJJ4zQDXaEkwgvrL9eH
         xJqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:user-agent:message-id:content-transfer-encoding;
        bh=b8vQYc9ep8TfoYWy1t/cwVZtTf+JFWkdkgDvyL2DYys=;
        b=hXZtSRd2KE5+rzmwiyS2IoY2EfWQWvaDVLuM+vAQJwfEATNlAqPuKQYJ7wK2DH2DVF
         Nyc54pX7dvrFvSBAOMvAln9am6G3xX6UmwOf4464h49krkQldmNbNavazoXUXcSjgLTo
         JsFe+i7w1FsmzZDI7VfsHpmKUB84Wx6En3fDtI3Kx+bJL9jm8yRjuNwInAlQk67eXnp2
         AhQoTmw+ZGA9+xC2g9x/DDrW3P+aTG149A2yds4Fp73hvhTbA3DuOlwCwKIk67jvdcHu
         A2A/6m310MEedqHvz8fhlaHQK5uU62TvVcFJAm7OH+skGD7aF1oXsnzFjY07uqRGKChp
         8lBg==
X-Gm-Message-State: APjAAAV9xF8hiotzSrQT2nOQpNMeTCw9JqBsbwt6h1O5W0vzWUxlhMGW
        12I3Kq6TZVm2+EMuGfp8LSc=
X-Google-Smtp-Source: APXvYqw6VAOgIqjNxc0p0slnJ2hgt5OBEUHaGw1eB/rnwZFE7hXi83hgipthHGM9ezdF/jVjdPWi/g==
X-Received: by 2002:a65:5844:: with SMTP id s4mr13205327pgr.77.1551607530979;
        Sun, 03 Mar 2019 02:05:30 -0800 (PST)
Received: from localhost (193-116-74-175.tpgi.com.au. [193.116.74.175])
        by smtp.gmail.com with ESMTPSA id m20sm5798295pfj.142.2019.03.03.02.05.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 03 Mar 2019 02:05:30 -0800 (PST)
Date:   Sun, 03 Mar 2019 20:05:23 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 01/20] asm-generic/mmiowb: Add generic implementation of
 mmiowb() tracking
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Rich Felker <dalias@libc.org>,
        David Howells <dhowells@redhat.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Ingo Molnar <mingo@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Burton <paul.burton@mips.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Tony Luck <tony.luck@intel.com>,
        Will Deacon <will.deacon@arm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
References: <20190301140348.25175-1-will.deacon@arm.com>
        <20190301140348.25175-2-will.deacon@arm.com>
        <1551575210.6lwpiqtg5k.astroid@bobo.none>
        <CAHk-=whxaYGTmHyoWeegL=ihHMDW_FJehUJVN_nP++Su=foL+g@mail.gmail.com>
        <1551583190.duzqnmfnvg.astroid@bobo.none>
        <CAHk-=whVN58nWh29jvXx+X-Yx9dCC6BeAZOtKak+d01y_UVg=A@mail.gmail.com>
In-Reply-To: <CAHk-=whVN58nWh29jvXx+X-Yx9dCC6BeAZOtKak+d01y_UVg=A@mail.gmail.com>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1551606848.8cceyn7nhv.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds's on March 3, 2019 2:29 pm:
> On Sat, Mar 2, 2019, 19:34 Nicholas Piggin <npiggin@gmail.com> wrote:
>=20
>>
>> It doesn't have to be done all at once with this series, obviously this
>> is a big improvement on its own. But why perpetuate the nomenclature
>> and concept for new code added now?
>>
>=20
> What nomenclature?
>=20
> Nobody will be using mmiowb(). That's the whole point of the patch series=
.
>=20
> It's now an entirely internal name, and nobody cares.

Why even bother with it at all, "internal" or not?  Just get rid of=20
mmiowb, the concept is obsolete.

> And none of this has anything to do with wmb(), since it's about IO being
> ordered across cpu's by spin locks, not by barriers.
>=20
> So I'm not seeing what you're arguing about.

Pretend ia64 doesn't exist for a minute. Now the regular mb/wmb barriers=20
orders IO across CPUs with respect to their cacheable accesses. =20
Regardless of whether that cacheable access is a spin lock, a bit lock,=20
an atomic, a mutex... This is how it was before mmiowb came along.

Nothing wrong with this series to make spinlocks order mmio, but why=20
call it mmiowb? Another patch could rename ia64's mmiowb and then the
name can be removed from the tree completely.

Thanks,
Nick

=
