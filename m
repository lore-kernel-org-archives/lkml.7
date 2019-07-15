Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26240C7618A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 06:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2BC720838
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 06:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729111AbfGOG1F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 02:27:05 -0400
Received: from ozlabs.org ([203.11.71.1]:54999 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726748AbfGOG1F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 02:27:05 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45nD8R095bz9sND;
        Mon, 15 Jul 2019 16:27:02 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Qian Cai <cai@lca.pw>
Cc:     paulus@samba.org, benh@kernel.crashing.org,
        tyreld@linux.vnet.ibm.com, joe@perches.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: Re: [PATCH v3] powerpc/setup_64: fix -Wempty-body warnings
In-Reply-To: <1561730629-5025-1-git-send-email-cai@lca.pw>
References: <1561730629-5025-1-git-send-email-cai@lca.pw>
Date:   Mon, 15 Jul 2019 16:27:00 +1000
Message-ID: <871ryrak3v.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qian Cai <cai@lca.pw> writes:
> At the beginning of setup_64.c, it has,
>
>   #ifdef DEBUG
>   #define DBG(fmt...) udbg_printf(fmt)
>   #else
>   #define DBG(fmt...)
>   #endif
>
> where DBG() could be compiled away, and generate warnings,
>
> arch/powerpc/kernel/setup_64.c: In function 'initialize_cache_info':
> arch/powerpc/kernel/setup_64.c:579:49: warning: suggest braces around
> empty body in an 'if' statement [-Wempty-body]
>     DBG("Argh, can't find dcache properties !\n");
>                                                  ^
> arch/powerpc/kernel/setup_64.c:582:49: warning: suggest braces around
> empty body in an 'if' statement [-Wempty-body]
>     DBG("Argh, can't find icache properties !\n");

Neither of those sites should use DBG(), that's not really early boot
code, they should just use pr_warn().

And the other uses of DBG() in initialize_cache_info() should just be
removed.

In smp_release_cpus() the entry/exit DBG's should just be removed, and
the spinning_secondaries line should just be pr_debug().

That would just leave the two calls in early_setup(). If we taught
udbg_printf() to return early when udbg_putc is NULL, then we could just
call udbg_printf() unconditionally and get rid of the DBG macro entirely.

cheers
