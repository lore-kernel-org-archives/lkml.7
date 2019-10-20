Return-Path: <SRS0=ATYp=YN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B89F8CA9EA0
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 20:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C20821744
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 20:16:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbfJTUQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Oct 2019 16:16:24 -0400
Received: from smtprelay0030.hostedemail.com ([216.40.44.30]:38572 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725940AbfJTUQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 16:16:24 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 5D9B3182CED28;
        Sun, 20 Oct 2019 20:16:22 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: wheel18_5490528770d3c
X-Filterd-Recvd-Size: 2507
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Sun, 20 Oct 2019 20:16:21 +0000 (UTC)
Message-ID: <7ef650e0a6487a3eefc8df9eaf0ab20b5d26bad1.camel@perches.com>
Subject: Re: [Outreachy kernel] Re: [PATCH v1 1/5] staging: wfx: fix
 warnings of no space is necessary
From:   Joe Perches <joe@perches.com>
To:     Julia Lawall <julia.lawall@lip6.fr>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Jules Irenge <jbi.octave@gmail.com>,
        devel@driverdev.osuosl.org, outreachy-kernel@googlegroups.com,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Date:   Sun, 20 Oct 2019 13:16:19 -0700
In-Reply-To: <alpine.DEB.2.21.1910202149140.10441@hadrien>
References: <20191019140719.2542-1-jbi.octave@gmail.com>
          <20191019140719.2542-2-jbi.octave@gmail.com>
         <20191019142443.GH24678@kadam>
          <alpine.LFD.2.21.1910191603520.6740@ninjahub.org>
          <20191019180514.GI24678@kadam>
          <336960fdf88dbed69dd3ed2689a5fb1d2892ace8.camel@perches.com>
         <20191020191759.GJ24678@kadam>
         <6e6bc92cac0858fe5bd37b28f688d3da043f4bef.camel@perches.com>
         <alpine.DEB.2.21.1910202149140.10441@hadrien>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2019-10-20 at 21:52 +0200, Julia Lawall wrote:
> On Sun, 20 Oct 2019, Joe Perches wrote:
[]
> > There's probably a generic cocci mechanism to check function
> > prototypes and then remove uses of unnecessary void pointer casts
> > in function calls.  I'm not going to try to figure out that syntax.
> 
> With the --recursive-includes option, perhaps:
> 
> @r@
> identifier f;
> parameter list[n] ps;
> type T;
> identifier i;
> @@
> 
> T f(ps, void *i, ...);
> 
> @@
> expression e;
> identifier r.f;
> expression list[r.n] es;
> @@
> 
> f(es,
> - (void *)(e)
> + e
>   ,...)
> 
> This of course only works for functions that have prototypes, and not for
> macros.  It will also run slowly.

You are not kidding about slow, but it doesn't seem to work
for mem<foo>, maybe because system includes aren't analyzed.

Single file processing time on an XPS13 averages more than
100 seconds per file.

Also:

	expression e;

could probably be better as:

	type T;
	T *p;

as some of the expressions cast to void are int or size_t
and it's probably better to restrict the conversions to
just pointer or array types.


