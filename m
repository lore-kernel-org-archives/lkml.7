Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA86C4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 20:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FBDE214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 20:10:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbfIQUKZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 16:10:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58606 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726404AbfIQUKY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 16:10:24 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C29E28665D;
        Tue, 17 Sep 2019 20:10:24 +0000 (UTC)
Received: from treble (ovpn-120-32.rdu2.redhat.com [10.10.120.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DCCB05D6B2;
        Tue, 17 Sep 2019 20:10:23 +0000 (UTC)
Date:   Tue, 17 Sep 2019 15:10:21 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86-ml <x86@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Improve memset
Message-ID: <20190917201021.evoxxj7vkcb45rpg@treble>
References: <20190913072237.GA12381@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190913072237.GA12381@zn.tnic>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 17 Sep 2019 20:10:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 13, 2019 at 09:22:37AM +0200, Borislav Petkov wrote:
> In order to patch on machines which don't set X86_FEATURE_ERMS, I need
> to do a "reversed" patching of sorts, i.e., patch when the x86 feature
> flag is NOT set. See the below changes in alternative.c which basically
> add a flags field to struct alt_instr and thus control the patching
> behavior in apply_alternatives().
> 
> The result is this:
> 
> static __always_inline void *memset(void *dest, int c, size_t n)
> {
>         void *ret, *dummy;
> 
>         asm volatile(ALTERNATIVE_2_REVERSE("rep; stosb",
>                                            "call memset_rep",  X86_FEATURE_ERMS,
>                                            "call memset_orig", X86_FEATURE_REP_GOOD)
>                 : "=&D" (ret), "=a" (dummy)
>                 : "0" (dest), "a" (c), "c" (n)
>                 /* clobbers used by memset_orig() and memset_rep_good() */
>                 : "rsi", "rdx", "r8", "r9", "memory");
> 
>         return dest;
> }

I think this also needs ASM_CALL_CONSTRAINT.

Doesn't this break on older non-ERMS CPUs when the memset() is done
early, before alternative patching?

Could it instead do this?

	ALTERNATIVE_2("call memset_orig",
		      "call memset_rep",	X86_FEATURE_REP_GOOD,
		      "rep; stosb",		X86_FEATURE_ERMS)

Then the "reverse alternatives" feature wouldn't be needed anyway.

-- 
Josh
