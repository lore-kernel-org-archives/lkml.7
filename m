Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23CB8C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 18:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3A0C2133D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 18:04:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732036AbfEXSEt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 14:04:49 -0400
Received: from smtprelay0230.hostedemail.com ([216.40.44.230]:60685 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726139AbfEXSEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 14:04:48 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 303EE18047635;
        Fri, 24 May 2019 18:04:47 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: food21_c878d8e4561b
X-Filterd-Recvd-Size: 2257
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Fri, 24 May 2019 18:04:45 +0000 (UTC)
Message-ID: <8c138b300290efbff43631f2c527a37390c504d8.camel@perches.com>
Subject: Re: r8169: Link only up after 16 s (A link change request failed
 with some changes committed already. Interface enp3s0 may have been left
 with an inconsistent configuration, please check.)
From:   Joe Perches <joe@perches.com>
To:     Heiner Kallweit <hkallweit1@gmail.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Realtek linux nic maintainers <nic_swsd@realtek.com>
Cc:     netdev@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Fri, 24 May 2019 11:04:43 -0700
In-Reply-To: <5d25b4f3-20d3-6c93-2c0a-b95fde9e4c40@gmail.com>
References: <a05b0b6c-505c-db61-96ac-813e68a26cc6@molgen.mpg.de>
         <abb2d596-d9fe-5426-8f1d-2ef4a7eb9e1a@gmail.com>
         <48ad419a-65f4-40ca-d7a9-01fafee33d83@molgen.mpg.de>
         <5d25b4f3-20d3-6c93-2c0a-b95fde9e4c40@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-05-24 at 19:55 +0200, Heiner Kallweit wrote:
> On 24.05.2019 17:14, Paul Menzel wrote:
> > I applied the simple change below to `net/core/rtnetlink.c`.
> > 
> >                 if (err < 0)
> > -                       net_warn_ratelimited("A link change request failed with some changes committed already. Interface %s may have been left with an inconsistent configuration, please check.\n",
> > -                                            dev->name);
> > +                       net_warn_ratelimited("A link change request failed with some changes committed already (err = %i). Interface %s may have been left with an inconsistent configuration, please check.\n",
> > +                                            dev->name, err);
> > 
> > I get different results each time.
> > 
> > -304123904
> > -332128256
> > 
> > Any idea, how that can happen?
> > 
> Instead of %i you should use %d, and the order of arguments needs to be reversed.

Doesn't the patch generate a compilation warning?


