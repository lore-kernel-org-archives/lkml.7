Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B863EC3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C7F021881
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:59:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732343AbfIDQ7c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 12:59:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:40716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731580AbfIDQ7c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 12:59:32 -0400
Received: from oasis.local.home (bl11-233-114.dsl.telepac.pt [85.244.233.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E335D21670;
        Wed,  4 Sep 2019 16:59:29 +0000 (UTC)
Date:   Wed, 4 Sep 2019 12:59:23 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     Zhengjun Xing <zhengjun.xing@linux.intel.com>, mingo@redhat.com,
        tom.zanussi@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] trace:Add "gfp_t" support in synthetic_events
Message-ID: <20190904125923.7b1e66b8@oasis.local.home>
In-Reply-To: <1567602838.13841.1.camel@kernel.org>
References: <20190712015308.9908-1-zhengjun.xing@linux.intel.com>
        <1562947506.12920.0.camel@kernel.org>
        <20190904064327.28876d71@oasis.local.home>
        <1567602838.13841.1.camel@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 Sep 2019 08:13:58 -0500
Tom Zanussi <zanussi@kernel.org> wrote:

> Hi Steve,
> 
> On Wed, 2019-09-04 at 06:43 -0400, Steven Rostedt wrote:
> > On Fri, 12 Jul 2019 11:05:06 -0500
> > Tom Zanussi <zanussi@kernel.org> wrote:
> >   
> > > Hi Zhengjun,
> > > 
> > > On Fri, 2019-07-12 at 09:53 +0800, Zhengjun Xing wrote:  
> > > > Add "gfp_t" support in synthetic_events, then the "gfp_t" type
> > > > parameter in some functions can be traced.
> > > > 
> > > > Prints the gfp flags as hex in addition to the human-readable
> > > > flag
> > > > string.  Example output:
> > > > 
> > > >   whoopsie-630 [000] ...1 78.969452: testevent: bar=b20
> > > > (GFP_ATOMIC|__GFP_ZERO)
> > > >     rcuc/0-11  [000] ...1 81.097555: testevent: bar=a20
> > > > (GFP_ATOMIC)
> > > >     rcuc/0-11  [000] ...1 81.583123: testevent: bar=a20
> > > > (GFP_ATOMIC)
> > > > 
> > > > Signed-off-by: Tom Zanussi <zanussi@kernel.org>  
> > 
> > Why is this Signed-off-by Tom? Tom, did you author part of this??
> >   
> 
> Yeah, I added the part that prints the flag names.
> 

OK, I'll comment that in the patch change log.

Thanks!

-- Steve
