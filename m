Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 086B5C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 13:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7902208C2
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 13:15:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbfHLNPI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 09:15:08 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:40203 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726219AbfHLNPI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 09:15:08 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 466btK49TZz9sN6; Mon, 12 Aug 2019 23:15:05 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: b9ee5e04fd77898208c51b1395fa0b5e8536f9b6
In-Reply-To: <bef479514f4c08329fa649f67735df8918bc0976.1565268248.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Chris Packham <Chris.Packham@alliedtelesis.co.nz>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/64e: drop stale call to smp_processor_id() which hangs SMP startup
Message-Id: <466btK49TZz9sN6@ozlabs.org>
Date:   Mon, 12 Aug 2019 23:15:05 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-08-08 at 12:48:26 UTC, Christophe Leroy wrote:
> Santa commit ebb9d30a6a74 ("powerpc/mm: any thread in one core can be
> the first to setup TLB1") removed the need to know the cpu_id in
> early_init_this_mmu(), but the call to smp_processor_id() which was
> marked __maybe_used remained.
> 
> Since commit ed1cd6deb013 ("powerpc: Activate
> CONFIG_THREAD_INFO_IN_TASK") thread_info cannot be reached before mmu
> is properly set up.
> 
> Drop this stale call to smp_processor_id() which make SMP hang
> when CONFIG_PREEMPT is set.
> 
> Reported-by: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
> Fixes: ebb9d30a6a74 ("powerpc/mm: any thread in one core can be the first to setup TLB1")
> Link: https://github.com/linuxppc/issues/issues/264
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Cc: stable@vger.kernel.org

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/b9ee5e04fd77898208c51b1395fa0b5e8536f9b6

cheers
