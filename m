Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 323CAC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 13:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0611521473
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 13:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbfDHNDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 09:03:40 -0400
Received: from ozlabs.org ([203.11.71.1]:33951 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbfDHNDk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 09:03:40 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 44d9bF3KVHz9sQq; Mon,  8 Apr 2019 23:03:36 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: fd427103e8dfcb4b438269afd710b63e7af61463
X-Patchwork-Hint: ignore
In-Reply-To: <aab41779cac995ebdc03e700a9dc7cfc30a28770.1553503163.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Larry Finger <Larry.Finger@lwfinger.net>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: powerpc/rtas: fix early boot failure.
Message-Id: <44d9bF3KVHz9sQq@ozlabs.org>
Date:   Mon,  8 Apr 2019 23:03:36 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-03-25 at 08:43:33 UTC, Christophe Leroy wrote:
> Commit 0df977eafc79 ("powerpc/6xx: Don't use SPRN_SPRG2 for storing
> stack pointer while in RTAS") changes the code to use a field in
> thread struct to store the stack pointer while in RTAS instead of
> using SPRN_SPRG2. It therefore converts all places which were
> manipulating SPRN_SPRG2 to use that field. During early startup,
> the zeroing of SPRN_SPRG2 has been replaced by a zeroing of that
> field in thread struct. But at least in start_here, that's done
> wrongly because it used the physical address of the fields while
> MMU is on at that time.
> 
> So the virtual address of the field should be used instead, but in
> the meantime, thread struct has already been zeroised and initialised
> so we can just drop this initialisation.
> 
> Reported-by: Larry Finger <Larry.Finger@lwfinger.net>
> Fixes: 0df977eafc79 ("powerpc/6xx: Don't use SPRN_SPRG2 for storing stack pointer while in RTAS")
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Tested-by: Larry Finger <Larry.Finger@lwfinger.net>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/fd427103e8dfcb4b438269afd710b63e

cheers
