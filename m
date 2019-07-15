Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E40BC76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 19:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 735922077A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 19:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731242AbfGOTim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 15:38:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39844 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730362AbfGOTij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 15:38:39 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A955F3082A9A;
        Mon, 15 Jul 2019 19:38:38 +0000 (UTC)
Received: from treble (ovpn-120-170.rdu2.redhat.com [10.10.120.170])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CF8641001B04;
        Mon, 15 Jul 2019 19:38:36 +0000 (UTC)
Date:   Mon, 15 Jul 2019 14:38:34 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 00/22] x86, objtool: several fixes/improvements
Message-ID: <20190715193834.5tvzukcwq735ufgb@treble>
References: <cover.1563150885.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1563150885.git.jpoimboe@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Mon, 15 Jul 2019 19:38:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 14, 2019 at 07:36:55PM -0500, Josh Poimboeuf wrote:
> There have been a lot of objtool bug reports lately, mainly related to
> Clang and BPF.  As part of fixing those bugs, I added some improvements
> to objtool which uncovered yet more bugs (some kernel, some objtool).
> 
> I've given these patches a lot of testing with both GCC and Clang.  More
> compile testing of objtool would be appreciated, as the kbuild test
> robot doesn't seem to be paying much attention to my branches lately.
> 
> There are still at least three outstanding issues:
> 
> 1) With clang I see:
> 
>      drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o: warning: objtool: .altinstr_replacement+0x88: redundant UACCESS disable
> 
>    I haven't dug into it yet.
> 
> 2) There's also an issue in clang where a large switch table had a bunch
>    of unused (bad) entries.  It's not a code correctness issue, but
>    hopefully it can get fixed in clang anyway.  See patch 20/22 for more
>    details.
> 
> 3) CONFIG_LIVEPATCH is causing some objtool "unreachable instruction"
>    warnings due to the new -flive-patching flag.  I have some fixes
>    pending, but this patch set is already long enough.

These patches are also at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git objtool-many-fixes

-- 
Josh
