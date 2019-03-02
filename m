Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D37EC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 12:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 241E420857
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 12:56:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfCBM4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 07:56:49 -0500
Received: from ozlabs.org ([203.11.71.1]:58517 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbfCBM4t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 07:56:49 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44BRBN5tbnz9s47;
        Sat,  2 Mar 2019 23:56:44 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Ingo Molnar <mingo@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH 00/20] Remove Mysterious Macro Intended to Obscure Weird Behaviours (mmiowb())
In-Reply-To: <CAHk-=wio4duTk=dPJZ+yW-Y-65Q4O8Hc09bexAqs4OQV1R3WhQ@mail.gmail.com>
References: <20190301140348.25175-1-will.deacon@arm.com> <CAHk-=wio4duTk=dPJZ+yW-Y-65Q4O8Hc09bexAqs4OQV1R3WhQ@mail.gmail.com>
Date:   Sat, 02 Mar 2019 23:56:44 +1100
Message-ID: <871s3pjuyb.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Love the acronym, and the series looks good to me.
>
> Michael - can you check (or maybe you already did?) that this works
> for ppc too, and doesn't have any gotcha's?

Yeah it looks fine to me.

I gave it a quick boot with a patch to count how many mb()s we actually
issue in the spin_unlock() path and it's definitely hitting that path
correctly. So it works at least as well as the old code.

cheers
