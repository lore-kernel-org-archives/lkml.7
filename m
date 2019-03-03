Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1857C43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 01:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2A4420863
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 01:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zl598qyo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbfCCBnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 20:43:18 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35118 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726844AbfCCBnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 20:43:17 -0500
Received: by mail-pf1-f196.google.com with SMTP id j5so765611pfa.2;
        Sat, 02 Mar 2019 17:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :user-agent:message-id:content-transfer-encoding;
        bh=DGWCRfUosDElPHB3SQZ2iLkUcwwhNImJK3htTmAZteY=;
        b=Zl598qyoYd374RSTLU224SNcJ/pdJMpoUC4gpbDYL0G00R3LYjsCDjGEQDHHpc/A3m
         ZoX+a//vjt4XUVY8CA+zt0EoqqMWxOclNMNJfkwB978MNsPHXok6Xu5JyGtecSNhEeRY
         KCQ0J0fijz2Xv0Ziz4+G2qfK/TxG66Za95Xlx8r6PE4ZrCMYroYnqr2ui7598A6K8rRF
         CjOreUKsvfHs51MxjqVdGWm9+3iX3FUFcN4O0TtqRqib6hh4a/8tV1VWW2svBFiMdMur
         Qfix3k6uxMeEKgC69SU8rrtWkXqOLF5kT7QWvzdR0ertSvxJWPNGaF+yRJxNHTmXIGGd
         bxOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:user-agent:message-id:content-transfer-encoding;
        bh=DGWCRfUosDElPHB3SQZ2iLkUcwwhNImJK3htTmAZteY=;
        b=m4FQDt6AGoLhVYq4EGRP9TByvAEPjCfPkcpARJDPUKyFIL9qZO8hL3xbyDCS87xkNr
         8+zeuaAcTn0rbTICrn1ZHpv66haXdrK1y5BNLisdKiyX4HRWPnrxF8yX0vvCPai2Ze8v
         eosQd0fZGACuiR6XFEo7ehrS2p7tuzttuCALVqj7w1yrKsVyP86FMCRFv8giN7SOexPE
         29vqwJasGueK6awZk72ABmV6wkzsEwh2msA16u/reqhIZb+aFPoy9UA6AooXQARap3si
         8OIz03rm/zjA53GzR+1QZm5tAX05ObVC/s/im03WYmnYS9NH9L4DznWB3fV71ZV4cQR5
         pxrg==
X-Gm-Message-State: APjAAAWeuzwKgUCynN1+kQpNuZHLCGmX+avm/VozPemFbDNwcyfxLHrF
        NJkXbERziJ5/zomtCAR2e2mbYSaJ
X-Google-Smtp-Source: AHgI3IYbZvh4um1rPgfGYyvI5+cng3aKb0avMxlHzjfJrNpILPMOEA+bwM55UhlNc+s57NKxx0GmZQ==
X-Received: by 2002:a62:3990:: with SMTP id u16mr13232126pfj.80.1551577396276;
        Sat, 02 Mar 2019 17:43:16 -0800 (PST)
Received: from localhost (193-116-74-175.tpgi.com.au. [193.116.74.175])
        by smtp.gmail.com with ESMTPSA id v6sm3188241pgb.2.2019.03.02.17.43.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 02 Mar 2019 17:43:15 -0800 (PST)
Date:   Sun, 03 Mar 2019 11:43:09 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 01/20] asm-generic/mmiowb: Add generic implementation of
 mmiowb() tracking
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
        <20190301140348.25175-2-will.deacon@arm.com>
In-Reply-To: <20190301140348.25175-2-will.deacon@arm.com>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1551575210.6lwpiqtg5k.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Will Deacon's on March 2, 2019 12:03 am:
> In preparation for removing all explicit mmiowb() calls from driver
> code, implement a tracking system in asm-generic based loosely on the
> PowerPC implementation. This allows architectures with a non-empty
> mmiowb() definition to have the barrier automatically inserted in
> spin_unlock() following a critical section containing an I/O write.

Is there a reason to call this "mmiowb"? We already have wmb that
orders cacheable stores vs mmio stores don't we?

Yes ia64 "sn2" is broken in that case, but that can be fixed (if
anyone really cares about the platform any more). Maybe that's
orthogonal to what you're doing here, I just don't like seeing
"mmiowb" spread.

This series works for spin locks, but you would want a driver to
be able to use wmb() to order locks vs mmio when using a bit lock
or a mutex or whatever else. Calling your wmb-if-io-is-pending
version io_mb_before_unlock() would kind of match with existing
patterns.

> +static inline void mmiowb_set_pending(void)
> +{
> +	struct mmiowb_state *ms =3D __mmiowb_state();
> +	ms->mmiowb_pending =3D ms->nesting_count;
> +}
> +
> +static inline void mmiowb_spin_lock(void)
> +{
> +	struct mmiowb_state *ms =3D __mmiowb_state();
> +	ms->nesting_count++;
> +}
> +
> +static inline void mmiowb_spin_unlock(void)
> +{
> +	struct mmiowb_state *ms =3D __mmiowb_state();
> +
> +	if (unlikely(ms->mmiowb_pending)) {
> +		ms->mmiowb_pending =3D 0;
> +		mmiowb();
> +	}
> +
> +	ms->nesting_count--;
> +}

Humour me for a minute and tell me what this algorithm is doing, or
what was broken about the powerpc one, which is basically:

static inline void mmiowb_set_pending(void)
{
	struct mmiowb_state *ms =3D __mmiowb_state();
	ms->mmiowb_pending =3D 1;
}

static inline void mmiowb_spin_lock(void)
{
}

static inline void mmiowb_spin_unlock(void)
{
	struct mmiowb_state *ms =3D __mmiowb_state();

	if (unlikely(ms->mmiowb_pending)) {
		ms->mmiowb_pending =3D 0;
		mmiowb();
	}
}

> diff --git a/include/asm-generic/mmiowb_types.h b/include/asm-generic/mmi=
owb_types.h
> new file mode 100644
> index 000000000000..8eb0095655e7
> --- /dev/null
> +++ b/include/asm-generic/mmiowb_types.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __ASM_GENERIC_MMIOWB_TYPES_H
> +#define __ASM_GENERIC_MMIOWB_TYPES_H
> +
> +#include <linux/types.h>
> +
> +struct mmiowb_state {
> +	u16	nesting_count;
> +	u16	mmiowb_pending;
> +};

Really need more than 255 nested spin locks? I had the idea that 16
bit operations were a bit more costly than 8 bit on some CPUs... may
not be true, but at least the smaller size packs a bit better on
powerpc.

Thanks,
Nick

=
