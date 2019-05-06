Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D714AC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 13:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B12252054F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 13:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbfEFNyP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 09:54:15 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:59145 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726434AbfEFNyM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 09:54:12 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 44yPNf0rL1z9sDQ; Mon,  6 May 2019 23:54:09 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 67d53f30e23ec66aa7bbdd1592d5e64d46876190
X-Patchwork-Hint: ignore
In-Reply-To: <3a330ee8d98fce60c08c3d26054d2f0f8f53b66a.1557130203.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/mm: fix section mismatch for setup_kup()
Message-Id: <44yPNf0rL1z9sDQ@ozlabs.org>
Date:   Mon,  6 May 2019 23:54:09 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-05-06 at 08:10:43 UTC, Christophe Leroy wrote:
> commit b28c97505eb1 ("powerpc/64: Setup KUP on secondary CPUs")
> moved setup_kup() out of the __init section. As stated in that commit,
> "this is only for 64-bit". But this function is also used on PPC32,
> where the two functions called by setup_kup() are in the __init
> section, so setup_kup() has to either be kept in the __init
> section on PPC32 or marked __ref.
> 
> This patch marks it __ref, it fixes the below build warnings.
> 
>   MODPOST vmlinux.o
> WARNING: vmlinux.o(.text+0x169ec): Section mismatch in reference from the function setup_kup() to the function .init.text:setup_kuep()
> The function setup_kup() references
> the function __init setup_kuep().
> This is often because setup_kup lacks a __init
> annotation or the annotation of setup_kuep is wrong.
> 
> WARNING: vmlinux.o(.text+0x16a04): Section mismatch in reference from the function setup_kup() to the function .init.text:setup_kuap()
> The function setup_kup() references
> the function __init setup_kuap().
> This is often because setup_kup lacks a __init
> annotation or the annotation of setup_kuap is wrong.
> 
> Fixes: b28c97505eb1 ("powerpc/64: Setup KUP on secondary CPUs")
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/67d53f30e23ec66aa7bbdd1592d5e64d

cheers
