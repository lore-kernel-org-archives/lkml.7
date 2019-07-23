Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8FB6C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 20:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E8D621848
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 20:52:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391919AbfGWUwe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 16:52:34 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:49394 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726920AbfGWUwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 16:52:33 -0400
X-IronPort-AV: E=Sophos;i="5.64,300,1559512800"; 
   d="scan'208";a="393054747"
Received: from c-73-22-29-55.hsd1.il.comcast.net (HELO hadrien) ([73.22.29.55])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jul 2019 22:52:32 +0200
Date:   Tue, 23 Jul 2019 15:52:30 -0500 (CDT)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Joe Perches <joe@perches.com>
cc:     cocci <cocci@systeme.lip6.fr>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Fwd: [PATCH 1/2] string: Add stracpy and stracpy_pad
 mechanisms]
In-Reply-To: <66fcdbf607d7d0bea41edb39e5579d63b62b7d84.camel@perches.com>
Message-ID: <alpine.DEB.2.21.1907231546090.2551@hadrien>
References: <7ab8957eaf9b0931a59eff6e2bd8c5169f2f6c41.1563841972.git.joe@perches.com> <66fcdbf607d7d0bea41edb39e5579d63b62b7d84.camel@perches.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 22 Jul 2019, Joe Perches wrote:

> Hello Julia.
>
> I just sent a patch to add yet another string copy mechanism.
>
> This could help avoid misuses of strscpy and strlcpy like this
> patch set:
>
> https://lore.kernel.org/lkml/cover.1562283944.git.joe@perches.com/T/
>
> A possible cocci script to do conversions could be:
>
>    $ cat str.cpy.cocci
>    @@
>    expression e1;
>    expression e2;
>    @@
>
>    - strscpy(e1, e2, sizeof(e1))
>    + stracpy(e1, e2)
>
>    @@
>    expression e1;
>    expression e2;
>    @@
>
>    - strlcpy(e1, e2, sizeof(e1))
>    + stracpy(e1, e2)
>
> This obviously does not match the style of all the
> scripts/coccinelle cocci files, but this might be
> something that could be added improved and added.
>
> This script produces:
>
> $ spatch --in-place -sp-file str.cpy.cocci .
> $ git checkout tools/
> $ git diff --shortstat
>  958 files changed, 2179 insertions(+), 2655 deletions(-)
>
> The remainder of strlcpy and strscpy uses in the
> kernel would generally have a form like:
>
> 	strlcpy(to, from, DEFINE)
>
> where DEFINE is the specified size of to
>
> Could the cocci script above be updated to find
> and correct those styles as well?

I guess it would depend on what "to" is and what DEFINE expands into.  For
example, in cpuidle-powernv.c, I see:

strlcpy(powernv_states[index].name, name, CPUIDLE_NAME_LEN);

and by poking around I see:

struct cpuidle_state {
	char		name[CPUIDLE_NAME_LEN];
	char		desc[CPUIDLE_DESC_LEN];
	...
};

So I guess this case is ok.

I will look into it.

thanks,
julia
