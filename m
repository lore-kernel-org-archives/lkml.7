Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E0F5C76188
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 03:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A638206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 03:06:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbfGQDGi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 23:06:38 -0400
Received: from smtprelay0182.hostedemail.com ([216.40.44.182]:35905 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726069AbfGQDGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 23:06:37 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 4A32B34A1;
        Wed, 17 Jul 2019 03:06:36 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: cause64_738513b3fb42d
X-Filterd-Recvd-Size: 1832
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Wed, 17 Jul 2019 03:06:33 +0000 (UTC)
Message-ID: <fa656d2d8a1677a0a1fbea4b7f60dfca2661827b.camel@perches.com>
Subject: Re: [PATCH] skbuff: fix compilation warnings in skb_dump()
From:   Joe Perches <joe@perches.com>
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Qian Cai <cai@lca.pw>
Cc:     David Miller <davem@davemloft.net>,
        Willem de Bruijn <willemb@google.com>,
        clang-built-linux@googlegroups.com,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 16 Jul 2019 20:06:32 -0700
In-Reply-To: <CAF=yD-KW-XnDvD0i8VbzrkLGNWEY6cPoaEcHy40hbghGXTo+kA@mail.gmail.com>
References: <1563288840-1913-1-git-send-email-cai@lca.pw>
         <CAF=yD-KW-XnDvD0i8VbzrkLGNWEY6cPoaEcHy40hbghGXTo+kA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-07-16 at 17:04 +0200, Willem de Bruijn wrote:
> On Tue, Jul 16, 2019 at 4:56 PM Qian Cai <cai@lca.pw> wrote:
> > Fix them by using the proper types, and also fix some checkpatch
> > warnings by using pr_info().
> > 
> > WARNING: printk() should include KERN_<LEVEL> facility level
> > +               printk("%ssk family=%hu type=%u proto=%u\n",
> 
> Converting printk to pr_info lowers all levels to KERN_INFO.
> 
> skb_dump takes an explicit parameter level to be able to log at
> KERN_ERR or KERN_WARNING
> 
> I would like to avoid those checkpatch warnings, but this is not the
> right approach.

Just ignore checkpatch when it doesn't know that
the printk actually includes a KERN_<LEVEL> via
"%s...", level


