Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F18BC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 10:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26C9520823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 10:24:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbfCDKYU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 05:24:20 -0500
Received: from ozlabs.org ([203.11.71.1]:41509 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726032AbfCDKYT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 05:24:19 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44CbjT4CJzz9s4V;
        Mon,  4 Mar 2019 21:24:13 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Nicholas Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org,
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
Subject: Re: [PATCH 01/20] asm-generic/mmiowb: Add generic implementation of mmiowb() tracking
In-Reply-To: <1551575210.6lwpiqtg5k.astroid@bobo.none>
References: <20190301140348.25175-1-will.deacon@arm.com> <20190301140348.25175-2-will.deacon@arm.com> <1551575210.6lwpiqtg5k.astroid@bobo.none>
Date:   Mon, 04 Mar 2019 21:24:12 +1100
Message-ID: <87ef7n7x9v.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nicholas Piggin <npiggin@gmail.com> writes:
> Will Deacon's on March 2, 2019 12:03 am:
>> In preparation for removing all explicit mmiowb() calls from driver
>> code, implement a tracking system in asm-generic based loosely on the
>> PowerPC implementation. This allows architectures with a non-empty
>> mmiowb() definition to have the barrier automatically inserted in
>> spin_unlock() following a critical section containing an I/O write.
>
> Is there a reason to call this "mmiowb"? We already have wmb that
> orders cacheable stores vs mmio stores don't we?
>
> Yes ia64 "sn2" is broken in that case, but that can be fixed (if
> anyone really cares about the platform any more). Maybe that's
> orthogonal to what you're doing here, I just don't like seeing
> "mmiowb" spread.
>
> This series works for spin locks, but you would want a driver to
> be able to use wmb() to order locks vs mmio when using a bit lock
> or a mutex or whatever else.

Without wading into the rest of the discussion, this does raise an
interesting point, ie. what about eg. rwlock's?

They're basically equivalent to spinlocks, and so could reasonably be
expected to have the same behaviour.

But we don't check the io_sync flag in arch_read/write_unlock() etc. and
both of those use lwsync.

Seems like we just forgot they existed? Commit f007cacffc88 ("[POWERPC]
Fix MMIO ops to provide expected barrier behaviour") that added the
io_sync stuff doesn't mention them at all.

Am I missing anything? AFAICS read/write locks were never built on top
of spin locks, so seems like we're just hoping drivers using rwlock do
the right barriers?

cheers
