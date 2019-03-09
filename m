Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1125C10F00
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 17:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4EA0207E0
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 17:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552152833;
	bh=u7uVZo5ivGnFwM+oBBJ+0qPmbgn2hj8QK9Zj2CRoG5Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=hhUipbOm+A4brBwElBz540IGktjhQ2ZRKaYUODfdR6IDxEwgGv5NCkDNTx4d6e2vI
	 RcSS2AhMpDqSktlWFACcMCAu6MVYyToKHDKDG9JTsXEC5TOz72TLSjFwg3UGkJQnOT
	 13luT51b5xegYO8gRJIv+AsTV7kqMsI0kMaNrnLs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfCIRdw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 12:33:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:51264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbfCIRdv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 12:33:51 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5945920652;
        Sat,  9 Mar 2019 17:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552152831;
        bh=u7uVZo5ivGnFwM+oBBJ+0qPmbgn2hj8QK9Zj2CRoG5Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=D9qGCnEtaDm1wY/M4dxJuR0Cpb4BgM+wR10rnAhjGKEz5zGDjPPYoCFkZn35zcbJK
         DmUXsHIwywReCRuUse8J7iN3w6iaks6k+1//NeQzAzidM5JLK2ssXigLEBz4TWL/t2
         YBrkvaXMJKwdTCsBEoOf59R2ayU859ZibbY9B72U=
Date:   Sat, 9 Mar 2019 17:33:46 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Robert Eshleman <bobbyeshleman@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 1/3] iio: light: Add driver for ap3216c
Message-ID: <20190309173346.2a1ea4f8@archlinux>
In-Reply-To: <CAGngYiW0Sf1mg-F18p_NeJZUMsvvceRn4HvNXAkdLaS9AfFDMQ@mail.gmail.com>
References: <42dbbd7568e4216a320c6fd617bd91c1ee045af0.1551037168.git.bobbyeshleman@gmail.com>
        <CAGngYiUkdehPwyN-oEBrUOpBzvkHef=TwyjCXKYawB54pmAdVg@mail.gmail.com>
        <20190303143813.3b5a3f22@archlinux>
        <CAGngYiW0Sf1mg-F18p_NeJZUMsvvceRn4HvNXAkdLaS9AfFDMQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Mar 2019 11:25:01 -0500
Sven Van Asbroeck <thesven73@gmail.com> wrote:

> On Sun, Mar 3, 2019 at 9:38 AM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > Hmm. Just been thinking a bit about the events on here and wondered
> > if it is possible to mask them through careful use of the threshold
> > values - i.e. can we stop the hardware generating the interrupts for
> > the ones we don't want. It would be unusual for hardware to be
> > designed where this wasn't possible.  
> 
> Excellent point! People with power / battery constraints take a dim view of
> receiving interrupts when no-one wants them. So disabling them in h/w
> is definitely the way to go, if possible.
> 
> And yes, this also makes a non-issue of thresh_en visibility concerns, if any.
> 
> >
> > Alternatively if you have a scope or equivalent to verify if it is doing
> > these as a multi byte read and working that would be even better.
> > It is not uncommon for hardware to implement fairly standard i2c features
> > like this and not document them because they weren't what the test code
> > the docs writer got given does! (may not be true here of course)  
> 
> Or alternatively, the current chip rev supports undocumented multi-reads,
> and the next revision silently drops support, thereby breaking the driver...
> Been there, done that, got the T-shirt :(

Indeed it's a risk.  Sadly hardware guys never have a 'we mustn't break
software' rule like we do for userspace! 

Jonathan


