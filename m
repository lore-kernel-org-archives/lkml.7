Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC08C43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 01:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 567C520863
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 01:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XcR79mct"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbfCCBra (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 20:47:30 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38070 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbfCCBr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 20:47:29 -0500
Received: by mail-pl1-f194.google.com with SMTP id g37so810862plb.5;
        Sat, 02 Mar 2019 17:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :user-agent:message-id:content-transfer-encoding;
        bh=18FeiCiDw77JTEKmLK281O2l0nYlbRpwErNz8FWY5h8=;
        b=XcR79mctbpDOS+IYIzVYVKaTP8ZOEqpM/s6qUA5UFHkHrztmLzAn5OSSc0CFXweq0O
         CKw9NcrwB8IupI3yVJiswCUtmjjRTjupogHB//5GRwJ1oJhbKPUVtv2YOW4HW8ei13Iy
         DftzGgxPliQtWuMHEDWua43iifW+1Ky0BDXJTdyxJhkdrSmD3ylVMrEy4IXtHjDzMhmB
         0mrdQLSi0+xj37FT4TwvrfbRk+tEGCbxGURoYuM056gLmNg6VOxOYVkUVuLX40u2CTTe
         UXbHDAXaH+9D7iXIQi2gJ1axep5V3NRyjQmgtuoU3kLlnIyvBJvOnvleLcuCt6iEhoES
         HYLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:user-agent:message-id:content-transfer-encoding;
        bh=18FeiCiDw77JTEKmLK281O2l0nYlbRpwErNz8FWY5h8=;
        b=F0jr7fWj3anueC4ZPD3Uipx7V650pFX6hM6TPiLLmQ9w6pjevaatIRWaBUo0NjjMGK
         4Chk8W4UJloEl67ScVr57LirOVI1E5Kgd0yCPDQBcLtZ8KAbq+3IBFqBUj2XCMFyX/MY
         lcTgJ04TgEbsYnrmCpeh6UFwQDfRFlLiNqM/6uOV2DRzaNLV9WyXzW0NAc1ye0+UV4bE
         Pu8wolLWiyZQsEdiuz2opPhXRU7Guux88HIk8Cemh2JrzZmAkmuFqNrXPULYliMywBuO
         O+5nkxxYrMvrJBEcBj9F0tf91QJw0ieGMh2AzMWXtdX13dfosd9ZLaJffhN1eYGaI/Wm
         X/HA==
X-Gm-Message-State: APjAAAVzFOX1RQyBM2+/sAxZPlCTRpjdU52SHeOJSvBTlpDtMOJvs9cZ
        tW1hSgQ59RcZMDtQ9MIdH1NjQLmX
X-Google-Smtp-Source: APXvYqwC0V29+0L7BwMwK4z6aISx9uxzgry6vwCthR9hfQbJqKwvqXJrlR6DZJAbAbsXgLBxoj9spg==
X-Received: by 2002:a17:902:9a84:: with SMTP id w4mr13449565plp.283.1551577648946;
        Sat, 02 Mar 2019 17:47:28 -0800 (PST)
Received: from localhost (193-116-74-175.tpgi.com.au. [193.116.74.175])
        by smtp.gmail.com with ESMTPSA id l64sm3007386pfj.179.2019.03.02.17.47.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 02 Mar 2019 17:47:28 -0800 (PST)
Date:   Sun, 03 Mar 2019 11:47:22 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 03/20] mmiowb: Hook up mmiowb helpers to spinlocks and
 generic I/O accessors
To:     linux-arch@vger.kernel.org, Will Deacon <will.deacon@arm.com>
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Rich Felker <dalias@libc.org>,
        David Howells <dhowells@redhat.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        linux-kernel@vger.kernel.org,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Ingo Molnar <mingo@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Burton <paul.burton@mips.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Tony Luck <tony.luck@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
References: <20190301140348.25175-1-will.deacon@arm.com>
        <20190301140348.25175-4-will.deacon@arm.com>
In-Reply-To: <20190301140348.25175-4-will.deacon@arm.com>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1551577391.707a6tsmt3.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Will Deacon's on March 2, 2019 12:03 am:
> @@ -177,6 +178,7 @@ do {								\
>  static inline void do_raw_spin_lock(raw_spinlock_t *lock) __acquires(loc=
k)
>  {
>  	__acquire(lock);
> +	mmiowb_spin_lock();
>  	arch_spin_lock(&lock->raw_lock);
>  }
> =20
> @@ -188,16 +190,23 @@ static inline void
>  do_raw_spin_lock_flags(raw_spinlock_t *lock, unsigned long *flags) __acq=
uires(lock)
>  {
>  	__acquire(lock);
> +	mmiowb_spin_lock();
>  	arch_spin_lock_flags(&lock->raw_lock, *flags);
>  }

You'd be better to put these inside the spin lock, to match your=20
trylock.

Also it means the mmiowb state can be used inside a lock/unlock pair
without a compiler barrer forcing it to be reloaded, should be better
code generation for very small critical sections on archs which inline
lock and unlock.

> =20
>  static inline int do_raw_spin_trylock(raw_spinlock_t *lock)
>  {
> -	return arch_spin_trylock(&(lock)->raw_lock);
> +	int ret =3D arch_spin_trylock(&(lock)->raw_lock);
> +
> +	if (ret)
> +		mmiowb_spin_lock();
> +
> +	return ret;
>  }
> =20
>  static inline void do_raw_spin_unlock(raw_spinlock_t *lock) __releases(l=
ock)
>  {
> +	mmiowb_spin_unlock();
>  	arch_spin_unlock(&lock->raw_lock);
>  	__release(lock);
>  }

Thanks,
Nick

=
