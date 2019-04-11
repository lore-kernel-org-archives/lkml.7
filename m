Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E58C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E94A2184B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:12:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfDKNMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 09:12:55 -0400
Received: from smtprelay0206.hostedemail.com ([216.40.44.206]:35521 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726106AbfDKNMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 09:12:54 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 825268368EF3;
        Thu, 11 Apr 2019 13:12:52 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: clam65_35f28fb14ab49
X-Filterd-Recvd-Size: 3705
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Thu, 11 Apr 2019 13:12:50 +0000 (UTC)
Message-ID: <d01faa59eea249323ac92c3c5598eb27650203c9.camel@perches.com>
Subject: Re: [PATCH RFC] clk: ux500: add range to usleep_range
From:   Joe Perches <joe@perches.com>
To:     Nicholas Mc Guire <der.herr@hofr.at>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Nicholas Mc Guire <hofrat@opentech.at>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 11 Apr 2019 06:12:49 -0700
In-Reply-To: <20190411125918.GB8986@osadl.at>
References: <1554606804-29453-1-git-send-email-hofrat@opentech.at>
         <155493683173.20095.12913107010666279046@swboyd.mtv.corp.google.com>
         <20190411025602.GB5487@osadl.at>
         <c333da513d0e47af3fa91e735ecc6620658f5050.camel@perches.com>
         <20190411125918.GB8986@osadl.at>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-04-11 at 14:59 +0200, Nicholas Mc Guire wrote:
> On Thu, Apr 11, 2019 at 04:51:25AM -0700, Joe Perches wrote:
> > On Thu, 2019-04-11 at 04:56 +0200, Nicholas Mc Guire wrote:
> > > On Wed, Apr 10, 2019 at 03:53:51PM -0700, Stephen Boyd wrote:
> > > > Quoting Nicholas Mc Guire (2019-04-06 20:13:24)
> > > > > Providing a range for usleep_range() allows the hrtimer subsystem to
> > > > > coalesce timers - the delay is runtime configurable so a factor 2
> > > > > is taken to provide the range.
> > > > > 
> > > > > Signed-off-by: Nicholas Mc Guire <hofrat@opentech.at>
> > > > > ---
> > > > 
> > > > I think this driver is in maintenance mode. I'll wait for Ulf to ack or
> > > > review this change before applying.
> > > > 
> > > > > diff --git a/drivers/clk/ux500/clk-sysctrl.c b/drivers/clk/ux500/clk-sysctrl.c
> > > > > index 7c0403b..a1fa3fb 100644
> > > > > --- a/drivers/clk/ux500/clk-sysctrl.c
> > > > > +++ b/drivers/clk/ux500/clk-sysctrl.c
> > > > > @@ -42,7 +42,7 @@ static int clk_sysctrl_prepare(struct clk_hw *hw)
> > > > >                                 clk->reg_bits[0]);
> > > > >  
> > > > >         if (!ret && clk->enable_delay_us)
> > > > > -               usleep_range(clk->enable_delay_us, clk->enable_delay_us);
> > > > > +               usleep_range(clk->enable_delay_us, clk->enable_delay_us*2);
> > > > 
> > > > Please add space around that multiply.
> > > > 
> > > I can do that but it does not seem common and also checkpatch
> > > did not complain about this - now a simple grep -re "\*10" on the
> > > kernel shows that it seems more common not to use spaces around *
> > > that to use them.
> > 
> > Not really
> > 
> > $ git grep -P '\*\s*10' | grep -oh -P '\*\s*10' | \
> >   sort | uniq -c | sort -rn | head 
> >   11800 * 10
> >    1705 *10
> >     179 *  10
> >      74 *   10
> >      67 *	10
> >      20 *     10
> >      20 *      10
> >      14 *    10
> >      14 *		10
> >      12 *         10
> 
> yup - my bad - If you restrict it to code lines - its 1:10
> not quite sure how I got the first numbers - sloppy check.
> 
> hofrat@debian:~/git/linux-next$ grep -re '.*\*\s*10.*;$' * | grep -oh '\*\s*10' | sort | uniq -c | sort -nr | more 
>    8568 * 10
>     860 *10

The ratio is about the same in any case.

> Anyway - is there a reason checkpatch will not flag this ?

Because the style is not mentioned in coding style.
checkpatch flags it only when using the --strict option


