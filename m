Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA139C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 10:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE08220675
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 10:33:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbfKNKd6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 05:33:58 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:43785 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfKNKd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 05:33:58 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iVCRj-00027f-Rr; Thu, 14 Nov 2019 11:33:51 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iVCRi-0000a9-3i; Thu, 14 Nov 2019 11:33:50 +0100
Date:   Thu, 14 Nov 2019 11:33:50 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] checkpatch: don't warn about new vsprintf pointer
 extension '%pe'
Message-ID: <20191114103350.z3fe4vzgepsb52y6@pengutronix.de>
References: <20191114100416.23928-1-u.kleine-koenig@pengutronix.de>
 <20191114102440.msyuahilbagaz7aw@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191114102440.msyuahilbagaz7aw@pathway.suse.cz>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2019 at 11:24:40AM +0100, Petr Mladek wrote:
> On Thu 2019-11-14 11:04:16, Uwe Kleine-König wrote:
> > This extension was introduced in commit 57f5677e535b ("printf: add
> > support for printing symbolic error names").
> 
> Great catch!

It wasn't hard to catch. checkpatch pelted me with bogus warnings when I
started to make use of %pe :-)

> > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > ---
> >  scripts/checkpatch.pl | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > index 6fcc66afb088..31cd9b767c1e 100755
> > --- a/scripts/checkpatch.pl
> > +++ b/scripts/checkpatch.pl
> > @@ -6022,7 +6022,7 @@ sub process {
> >  				while ($fmt =~ /(\%[\*\d\.]*p(\w))/g) {
> >  					$specifier = $1;
> >  					$extension = $2;
> > -					if ($extension !~ /[SsBKRraEhMmIiUDdgVCbGNOxt]/) {
> > +					if ($extension !~ /[SsBKRraeEhMmIiUDdgVCbGNOxt]/) {
> 
> I am going to push it into printk.git. I will just change the ordering
> "eE" -> "Ee". So that it follows the existing convention.

Fine for me. Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
