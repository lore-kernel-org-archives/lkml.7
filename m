Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,PLING_QUERY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EED2C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 12:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CC852189D
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 12:34:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbfH1MeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 08:34:05 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:34394 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726300AbfH1MeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 08:34:04 -0400
X-IronPort-AV: E=Sophos;i="5.64,441,1559512800"; 
   d="scan'208";a="399185289"
Received: from unknown (HELO hadrien) ([101.5.35.205])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Aug 2019 14:33:54 +0200
Date:   Wed, 28 Aug 2019 20:33:51 +0800 (CST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: julia@hadrien
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
cc:     Denis Efremov <efremov@linux.com>, Joe Perches <joe@perches.com>,
        cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>
Subject: Re: [PATCH] scripts: coccinelle: check for !(un)?likely usage
In-Reply-To: <95c32d19-eb4d-a214-6332-038610ec3dbd@rasmusvillemoes.dk>
Message-ID: <alpine.DEB.2.21.1908282033350.2325@hadrien>
References: <20190825130536.14683-1-efremov@linux.com> <b5bae2981e27d133b61d99b08ee60244bf7aabe3.camel@perches.com> <88f6e48e-1230-9488-a973-397f4e6dfbb5@linux.com> <4E9DDF9E-C883-44F0-A3F4-CD49284DB60D@lip6.fr>
 <95c32d19-eb4d-a214-6332-038610ec3dbd@rasmusvillemoes.dk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 28 Aug 2019, Rasmus Villemoes wrote:

> On 25/08/2019 21.19, Julia Lawall wrote:
> >
> >
> >> On 26 Aug 2019, at 02:59, Denis Efremov <efremov@linux.com> wrote:
> >>
> >>
> >>
> >>> On 25.08.2019 19:37, Joe Perches wrote:
> >>>> On Sun, 2019-08-25 at 16:05 +0300, Denis Efremov wrote:
> >>>> This patch adds coccinelle script for detecting !likely and !unlikely
> >>>> usage. It's better to use unlikely instead of !likely and vice versa.
> >>>
> >>> Please explain _why_ is it better in the changelog.
> >>>
> >>
> >> In my naive understanding the negation (!) before the likely/unlikely
> >> could confuse the compiler
> >
> > As a human I am confused. Is !likely(x) equivalent to x or !x?
>
> #undef likely
> #undef unlikely
> #define likely(x) (x)
> #define unlikely(x) (x)
>
> should be a semantic no-op. So changing !likely(x) to unlikely(x) is
> completely wrong. If anything, !likely(x) can be transformed to
> unlikely(!x).

Thanks.  Making the change seems like a good idea.

julia
