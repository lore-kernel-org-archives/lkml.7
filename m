Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB111C31E5D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 09:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99001206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 09:30:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729538AbfFRJal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 05:30:41 -0400
Received: from smtprelay0132.hostedemail.com ([216.40.44.132]:36303 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726330AbfFRJaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 05:30:39 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id F029D837F24D;
        Tue, 18 Jun 2019 09:30:37 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: form78_227b3de72b623
X-Filterd-Recvd-Size: 2187
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Tue, 18 Jun 2019 09:30:36 +0000 (UTC)
Message-ID: <3499a5a2058c246d48f8eb96682ce371833563b2.camel@perches.com>
Subject: Re: [PATCH] Use fall-through attribute rather than magic comments
From:   Joe Perches <joe@perches.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Shawn Landden <shawn@git.icu>, linux-kernel@vger.kernel.org,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Andy Whitcroft <apw@canonical.com>
Date:   Tue, 18 Jun 2019 02:30:35 -0700
In-Reply-To: <20190618073407.GA786@amd>
References: <20190316033841.7659-1-shawn@git.icu>
         <20190617155643.GA32544@amd>
         <45e070039e66b1cb1490a78d4805bc73cc09f571.camel@perches.com>
         <20190618073407.GA786@amd>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-06-18 at 09:34 +0200, Pavel Machek wrote:
> On Mon 2019-06-17 09:25:56, Joe Perches wrote:
> > On Mon, 2019-06-17 at 17:56 +0200, Pavel Machek wrote:
> > > Hi!
> > > 
> > > > +/*
> > > > + *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html#index-Wimplicit-fallthrough
> > > > + *   gcc: https://developers.redhat.com/blog/2017/03/10/wimplicit-fallthrough-in-gcc-7/
> > > > + */
> > > > +#if __has_attribute(__fallthrough__)
> > > > +# define __fallthrough                    __attribute__((__fallthrough__))
> > > > +#else
> > > > +# define __fallthrough
> > > > +#endif
> > > 
> > > Is it good idea to add the __'s ? They look kind of ugly. 
> > 
> > Dunno.
> > 
> > I agree it's kind of ugly, but it should always work.
> > 
> > I think the generic problem is introducing a new unprefixed
> > reserved identifier.  Underscored identifiers are reserved.
> 
> We are not userland, and we control whole codebase. These rules don't
> apply.

except include/uapi where some static inline switch might

> We can use unprefixed identifier and fix up any problems... I don't
> expect too many.

but there aren't any existing uses there.


