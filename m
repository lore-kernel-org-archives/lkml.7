Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 016FBC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 06:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA10E2089E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 06:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557900525;
	bh=fowhqUALRBQJMtB9RP4MkFlNPWDsccQyjzeGhlKuCvo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=J3XZSgJf/xu6vyS28f6aUO5TQsqh1p8+vYgosrtcxN1wSn+XmM9PIfvEt7jD6cnZg
	 5vJovQABmn8ZjOm36WQrW3MUrPSHN9yPFeJjDsf69cy+fXkQj5m/OJ2JAI8koClSGv
	 i/b8aZ2p1H9Vy4Je0KkZ2JY+VecPzfkqhfZ0S808=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbfEOGIp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 02:08:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:43962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbfEOGIo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 02:08:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89A7520862;
        Wed, 15 May 2019 06:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557900524;
        bh=fowhqUALRBQJMtB9RP4MkFlNPWDsccQyjzeGhlKuCvo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S3JEB/k6ehXBDa0Ge4cnoCfn+lfnmWYGeTJyP9wx80uZH2VZ1MbNbNxPhPZYGK7t0
         qSlhFGkN2bmRauu23kyife8LNk4tv/y4LbHF2eRzQn+KscuO9adU+zIsyPd2fQLPvb
         r3xi81urldOMBcutENz6dJ2Q2FTfMjNtdXh/mT/U=
Date:   Wed, 15 May 2019 08:08:41 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/security: Fix build break
Message-ID: <20190515060841.GB18988@kroah.com>
References: <20190515045206.10610-1-joel@jms.id.au>
 <20190515051830.GA18166@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190515051830.GA18166@kroah.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2019 at 07:18:30AM +0200, Greg Kroah-Hartman wrote:
> On Wed, May 15, 2019 at 02:22:06PM +0930, Joel Stanley wrote:
> > This fixes a build break introduced in with the recent round of CPU
> > bug patches.
> > 
> >   arch/powerpc/kernel/security.c: In function ‘setup_barrier_nospec’:
> >   arch/powerpc/kernel/security.c:59:21: error: implicit declaration of
> >   function ‘cpu_mitigations_off’ [-Werror=implicit-function-declaration]
> >     if (!no_nospec && !cpu_mitigations_off())
> >                        ^~~~~~~~~~~~~~~~~~~
> > 
> > Fixes: 782e69efb3df ("powerpc/speculation: Support 'mitigations=' cmdline option")
> > Signed-off-by: Joel Stanley <joel@jms.id.au>
> > ---
> > This should be applied to the 4.14 and 4.19 trees. There is no issue
> > with 5.1. The commit message contains a fixes line for the commit in
> > Linus tree.
> > ---
> >  arch/powerpc/kernel/security.c | 1 +
> >  1 file changed, 1 insertion(+)
> 
> Isn't this just commit 42e2acde1237 ("powerpc/64s: Include cpu header")?

Which I have now queued up.
