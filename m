Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96883C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 14:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CF3021019
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 14:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560349430;
	bh=Epy3kS13Rkvvvma6r/YPkgen0bYM96jquMd812WLj7s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1QbIB7pEK7D7nNJ58GxpmlTXeuIWS00spa7gLuPD1mIo7WAjrae1O9mTQb/ahhGwA
	 e6d7Sm0HqV2fPA2Fwlh2aO0Xfuu91G4Xu7RlWLssY5kqkjBPaFwCQXf6X64pMN7d8f
	 cgaxGPRjmm9LSi7C7l0FEtc5WFTUrw9SYwdC3tQ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409351AbfFLOXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 10:23:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:44734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407842AbfFLOXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 10:23:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72C47208CA;
        Wed, 12 Jun 2019 14:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560349428;
        bh=Epy3kS13Rkvvvma6r/YPkgen0bYM96jquMd812WLj7s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LkTq40C0qTdaAi59xMNtWhOngjBAjv2RA1O3Cm1GHRWG87eu/iIGkSMAClu9KzsPP
         dKgMgxbntbq3vLUtMeyMUKsEXTV5vS+xrv2jiKHDeRFAq2WUTCTGiJXG/8geCGRAuR
         SU8Xt4frLmZ6Mxumzc42sXXZ15ZMCUmM/oF4n5oI=
Date:   Wed, 12 Jun 2019 16:23:45 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Gen Zhang <blackgod016574@gmail.com>
Cc:     nico@fluxnic.net, kilobyte@angband.pl, textshell@uchuujin.de,
        mpatocka@redhat.com, daniel.vetter@ffwll.ch,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] vt: fix a missing-check bug in con_init()
Message-ID: <20190612142345.GB11563@kroah.com>
References: <20190612131506.GA3526@zhanggen-UX430UQ>
 <20190612133838.GA7748@kroah.com>
 <20190612134449.GA4015@zhanggen-UX430UQ>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612134449.GA4015@zhanggen-UX430UQ>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 09:44:49PM +0800, Gen Zhang wrote:
> On Wed, Jun 12, 2019 at 03:38:38PM +0200, Greg KH wrote:
> > On Wed, Jun 12, 2019 at 09:15:06PM +0800, Gen Zhang wrote:
> > > In function con_init(), the pointer variable vc_cons[currcons].d, vc and 
> > > vc->vc_screenbuf is allocated by kzalloc(). However, kzalloc() returns 
> > > NULL when fails. Therefore, we should check the return value and handle 
> > > the error.
> > > 
> > > Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
> > > ---
> > 
> > What changed from v1, v2, and v3?
> Thanks for your timely response. I am not a native English speaker, so
> I am not sure I understand this correctly. Does this mean that I should
> use "v5", rather than "v4"? 

"v" means "version".

You need to list what you changed with each version of this patch.

The documentation in the kernel tells you how to do this.

> > That always goes below the --- line.
> And I can't see what goes wrong with "---". Could you please make some
> explaination?

Again, please read the documentation, it describes how to do this for
patches that have gone through multiple versions.

thanks,

greg k-h
