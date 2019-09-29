Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E36FFC4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 16:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE135217F5
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 16:32:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbfI2QcO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 12:32:14 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:38918 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726149AbfI2QcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 12:32:14 -0400
X-IronPort-AV: E=Sophos;i="5.64,563,1559512800"; 
   d="scan'208";a="403854904"
Received: from 81-65-53-202.rev.numericable.fr (HELO hadrien) ([81.65.53.202])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Sep 2019 18:32:12 +0200
Date:   Sun, 29 Sep 2019 18:32:12 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Yuehaibing <yuehaibing@huawei.com>
cc:     Gilles Muller <Gilles.Muller@lip6.fr>, nicolas.palix@imag.fr,
        michal.lkml@markovi.net, maennich@google.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        cocci@systeme.lip6.fr
Subject: Re: [RFC PATCH] scripts: Fix coccicheck failed
In-Reply-To: <2c109d6b-45ad-b3ca-1951-bde4dac91d2a@huawei.com>
Message-ID: <alpine.DEB.2.21.1909291810300.3346@hadrien>
References: <20190928094245.45696-1-yuehaibing@huawei.com> <alpine.DEB.2.21.1909280542490.2168@hadrien> <2c109d6b-45ad-b3ca-1951-bde4dac91d2a@huawei.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 29 Sep 2019, Yuehaibing wrote:

> On 2019/9/28 20:43, Julia Lawall wrote:
> >
> >
> > On Sat, 28 Sep 2019, YueHaibing wrote:
> >
> >> Run make coccicheck, I got this:
> >>
> >> spatch -D patch --no-show-diff --very-quiet --cocci-file
> >>  ./scripts/coccinelle/misc/add_namespace.cocci --dir .
> >>  -I ./arch/x86/include -I ./arch/x86/include/generated
> >>  -I ./include -I ./arch/x86/include/uapi
> >>  -I ./arch/x86/include/generated/uapi -I ./include/uapi
> >>  -I ./include/generated/uapi --include ./include/linux/kconfig.h
> >>  --jobs 192 --chunksize 1
> >>
> >> virtual rule patch not supported
> >> coccicheck failed
> >>
> >> It seems add_namespace.cocci cannot be called in coccicheck.
> >
> > Could you explain the issue better?  Does the current state cause make
> > coccicheck to fail?  Or is it just silently not being called?
>
> Yes, it cause make coccicheck failed like this:
>
> ...
> ./drivers/xen/xenbus/xenbus_comms.c:290:2-8: preceding lock on line 243
> ./fs/fuse/dev.c:1227:2-8: preceding lock on line 1206
> ./fs/fuse/dev.c:1232:3-9: preceding lock on line 1206
> coccicheck failed
> make[1]: *** [coccicheck] Error 255
> make: *** [sub-make] Error 2

Could you set the verbose options to see what the problem is?  Maybe the
problem would be solved by putting virtual report at the top of the rule.
But it might still fail because nothing can happen without a value for the
virtual metavariable ns.

Should the coccinelle directory be only for things that work with make
coccicheck, or for all Coccinelle scripts?

julia
