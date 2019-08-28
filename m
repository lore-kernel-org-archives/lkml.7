Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,PLING_QUERY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 315F8C3A5A6
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 11:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1211E22CED
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 11:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbfH1L7d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 07:59:33 -0400
Received: from smtprelay0028.hostedemail.com ([216.40.44.28]:57783 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725991AbfH1L7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 07:59:33 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id D6B92182CF66A;
        Wed, 28 Aug 2019 11:59:31 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: bells05_52ff9a104e953
X-Filterd-Recvd-Size: 2554
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Wed, 28 Aug 2019 11:59:30 +0000 (UTC)
Message-ID: <84c7410d1d3ef56370c698c4e603e5422e337abc.camel@perches.com>
Subject: Re: [PATCH] scripts: coccinelle: check for !(un)?likely usage
From:   Joe Perches <joe@perches.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Denis Efremov <efremov@linux.com>
Cc:     cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>
Date:   Wed, 28 Aug 2019 04:59:29 -0700
In-Reply-To: <95c32d19-eb4d-a214-6332-038610ec3dbd@rasmusvillemoes.dk>
References: <20190825130536.14683-1-efremov@linux.com>
         <b5bae2981e27d133b61d99b08ee60244bf7aabe3.camel@perches.com>
         <88f6e48e-1230-9488-a973-397f4e6dfbb5@linux.com>
         <4E9DDF9E-C883-44F0-A3F4-CD49284DB60D@lip6.fr>
         <95c32d19-eb4d-a214-6332-038610ec3dbd@rasmusvillemoes.dk>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-08-28 at 13:33 +0200, Rasmus Villemoes wrote:
> On 25/08/2019 21.19, Julia Lawall wrote:
> > > On 26 Aug 2019, at 02:59, Denis Efremov <efremov@linux.com> wrote:
> > > > On 25.08.2019 19:37, Joe Perches wrote:
> > > > > On Sun, 2019-08-25 at 16:05 +0300, Denis Efremov wrote:
> > > > > This patch adds coccinelle script for detecting !likely and !unlikely
> > > > > usage. It's better to use unlikely instead of !likely and vice versa.
> > > > Please explain _why_ is it better in the changelog.
> > > In my naive understanding the negation (!) before the likely/unlikely
> > > could confuse the compiler
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

likely and unlikely use __builtin_expect

https://gcc.gnu.org/onlinedocs/gcc/Other-Builtins.html#index-_005f_005fbuiltin_005fexpect
https://stackoverflow.com/questions/7346929/what-is-the-advantage-of-gccs-builtin-expect-in-if-else-statements

It's probable that of the more than 20K uses of
likely and unlikely in the kernel, most have no
real performance effect.


