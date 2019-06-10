Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21437C43218
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 19:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0A2E20859
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 19:25:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389113AbfFJTZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 15:25:13 -0400
Received: from smtprelay0006.hostedemail.com ([216.40.44.6]:56717 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388793AbfFJTZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 15:25:12 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 2E93918029127;
        Mon, 10 Jun 2019 19:25:11 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: party74_66197af95055a
X-Filterd-Recvd-Size: 2276
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Mon, 10 Jun 2019 19:25:00 +0000 (UTC)
Message-ID: <13f306216ca9bcad563da4d86c55549645e061af.camel@perches.com>
Subject: Re: [PATCH] ipv6: exthdrs: fix warning comparison to bool
From:   Joe Perches <joe@perches.com>
To:     David Miller <davem@davemloft.net>, hariprasad.kelam@gmail.com
Cc:     kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 10 Jun 2019 12:24:58 -0700
In-Reply-To: <20190609.195420.1742255944804133266.davem@davemloft.net>
References: <20190608083532.GA7288@hari-Inspiron-1545>
         <20190609.195420.1742255944804133266.davem@davemloft.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2019-06-09 at 19:54 -0700, David Miller wrote:
> From: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> Date: Sat, 8 Jun 2019 14:05:33 +0530
> 
> > Fix below warning reported by coccicheck
> > 
> > net/ipv6/exthdrs.c:180:9-29: WARNING: Comparison to bool
> > 
> > Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
>  ...
> > diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
> > index ab5add0..e137325 100644
> > --- a/net/ipv6/exthdrs.c
> > +++ b/net/ipv6/exthdrs.c
> > @@ -177,7 +177,7 @@ static bool ip6_parse_tlv(const struct tlvtype_proc *procs,
> >                                       /* type specific length/alignment
> >                                          checks will be performed in the
> >                                          func(). */
> > -                                     if (curr->func(skb, off) == false)
> > +                                     if (!curr->func(skb, off))
> 
> curr->func() returns type 'bool', whats wrong with comparing against the
> same type?
> 
> I'm not applying stuff like this, sorry.

Looking at the function, it seems odd to have
some direct uses of "return false" and others
of "goto bad" where bad: does kfree_skb.

If all of the direct uses of return false are
correct, it could be useful to document why.


