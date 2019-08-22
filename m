Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18FF2C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 13:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9D5021726
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 13:09:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388927AbfHVNJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 09:09:05 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:53241 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732441AbfHVNJD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 09:09:03 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 46DlGj1KgTz9sPQ; Thu, 22 Aug 2019 23:09:00 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 38a0d0cdb46d3f91534e5b9839ec2d67be14c59d
In-Reply-To: <86b72f0c134367b214910b27b9a6dd3321af93bb.1565774657.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/futex: fix warning: 'oldval' may be used uninitialized in this function
Message-Id: <46DlGj1KgTz9sPQ@ozlabs.org>
Date:   Thu, 22 Aug 2019 23:09:00 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-08-14 at 09:25:52 UTC, Christophe Leroy wrote:
> CC      kernel/futex.o
> kernel/futex.c: In function 'do_futex':
> kernel/futex.c:1676:17: warning: 'oldval' may be used uninitialized in this function [-Wmaybe-uninitialized]
>    return oldval == cmparg;
>                  ^
> kernel/futex.c:1651:6: note: 'oldval' was declared here
>   int oldval, ret;
>       ^
> 
> This is because arch_futex_atomic_op_inuser() only sets *oval
> if ret is NUL and GCC doesn't see that it will use it only when
> ret is NUL.
> 
> Anyway, the non-NUL ret path is an error path that won't suffer from
> setting *oval, and as *oval is a local var in futex_atomic_op_inuser()
> it will have no impact.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/38a0d0cdb46d3f91534e5b9839ec2d67be14c59d

cheers
