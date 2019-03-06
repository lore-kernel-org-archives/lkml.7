Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B03C7C10F09
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 03:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8007D20663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 03:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tomli.me header.i=@tomli.me header.b="zhCn6VMO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728981AbfCFDJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 22:09:08 -0500
Received: from tomli.me ([153.92.126.73]:46158 "EHLO tomli.me"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727730AbfCFDJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 22:09:07 -0500
Received: from tomli.me (localhost [127.0.0.1])
        by tomli.me (OpenSMTPD) with ESMTP id 08e0ab28;
        Wed, 6 Mar 2019 03:09:04 +0000 (UTC)
X-HELO: localhost.localdomain
Authentication-Results: tomli.me; auth=pass (login) smtp.auth=tomli
Received: from Unknown (HELO localhost.localdomain) (2402:f000:1:1501:200:5efe:72f4:b31)
 by tomli.me (qpsmtpd/0.95) with ESMTPSA (DHE-RSA-CHACHA20-POLY1305 encrypted); Wed, 06 Mar 2019 03:09:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=tomli.me; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=1490979754; bh=kSJ7a/VDbd9Dw20r3S8ALBpssFMGyhwD5wOohSu/ph4=; b=zhCn6VMOEt8xeY6qBrHucH4IHVxdYztBOsWoVjexmRWepKhT8/4BLUbIInxn+tvBuo1oYBOmr4+jik/r08SxF2ulSQ2AMFMXPGzfW3fWqlK9BNLmUxxq28a3BxbCLxdGR99FHwXD2wcd7/QyItp0a/NBqbKcMnQMMbSDRDKKvyV64NGJcc2G4+EyXEyIzxCOtIjEjTsntAj0WDhBgYHD3E+nhWPvOLAVuvQ9t/MD8EyHZNuVhsHeY/9ljqrZaWcC2G+35nLxLDS1GDOxw170AbADiVxBf20ZdCZpFyYWdq8A/5T7z2jgaDDeVGaeYpDWrJv+cx7kj0yCPE00G93NRg==
Date:   Wed, 6 Mar 2019 11:08:54 +0800
From:   Tom Li <tomli@tomli.me>
To:     Paul Burton <paul.burton@mips.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhc@lemote.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/7] mfd: yeeloong_kb3310b: support KB3310B EC for
 Lemote Yeeloong laptops.
Message-ID: <20190306030854.GA9923@localhost.localdomain>
References: <20190304222848.25037-1-tomli@tomli.me>
 <20190304222848.25037-2-tomli@tomli.me>
 <20190305235050.mdouj2gnxwmilhoy@pburton-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190305235050.mdouj2gnxwmilhoy@pburton-laptop>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2019 at 11:50:51PM +0000, Paul Burton wrote:
> Hi Tom,
> 
> Overall I think this is much better than the older out of tree platform
> driver - thanks for cleaning it up.

I'm glad to hear that.

> One general comment - it would be good to run the patches through
> ./scripts/checkpatch.pl & fix up any warnings it gives unless you have a
> good reason to disagree with them.

The entire patchset has already been checked by checkpatch.pl, and all
generated warnings have been corrected before submission. So I don't think
the script can help me improving the style beyond this point. Thanks for
pointing out all the additional style issues.

> Nit: the lines of asterisks aren't part of the kernel's general comment
> style & I think it would looks cleaner to remove them.

Sure, I will remove these asterisks banners.

In fact I learned to use these asterisks from other kernel drivers to
separate logical sections... and as a said, checkpatch.pl does not generate
a warning about it, so I suspect that, historically, a clear policy about
asterisks banners was never enforced. After finish working on these patches,
perhaps it would a good time to patch checkpatch.pl and add a check for it?

> I'm not sure I follow why the power management code prevents use of
> regmap?
> 
> Are you talking about the wakeup_loongson() function? Perhaps it would
> make sense for the suspend code to be part of one of the possible
> subdrivers you mention. The lemote-2f seems to be the only system that
> provides an implementation of wakeup_loongson() so perhaps a driver
> could instead just register its own struct platform_suspend_ops & avoid
> the need for code in arch/mips to care about the EC.

I'll reword my misleading commit message about using regmap.

Let me clarify it - nothing prevents the use of regmap. I originally thought
it would be a good idea since the manual locking can be eliminated.

But later I realized it would mean more changes. In particular, not only pm.c
needs to be a new subdriver, the shutdown code in ml2f_reboot() also calls
ec_write(), and it needs to be converted to a subdriver in drivers/power/reset/
too. Yes, it would be good to refactor these code and move them to a more
suitable place, but currently, the primary goal is to add platform drivers,
not to touch functions I've just fixed and possibly introduce new regressions...

As you've seen, there is a TODO item in [PATCH 6/7] in this series, it says the
CS5536 code also needs some major refactoring: the GPIO needs to be changed,
the clocksource driver needs to be merged with the clockevent driver under
drivers/clocksource, etc. I think we can, as well, save the pm.c/reset.c for
later. Currently, I think it's better to focus on the platform drivers first.

If you still have objections on it, please let me know.

> > +#define DRV_NAME "yeeloong_kb3310b: "
> 
> Defining pr_fmt() would be cleaner - you wouldn't need to manually
> include DRV_NAME in your messages later.

Noted.

> > +static struct kb3310b_chip *kb3310b_fwinfo;
> > +
> > +static const struct mfd_cell kb3310b_cells[] = {
> > +	{
> > +		.name = "yeeloong_sci"
> > +	},
> > +	{
> > +		.name = "yeeloong_hwmon"
> > +	},
> > +	{
> > +		.name = "yeeloong_battery"
> > +	},
> > +	{
> > +		.name = "yeeloong_backlight"
> > +	},
> > +	{
> > +		.name = "yeeloong_lcd"
> > +	},
> > +	{
> > +		.name = "yeeloong_hotkey"
> > +	},
> 
> Nit: I think it'd look cleaner if you remove the newlines within each
> array entry, eg:
> 
> 	{ .name = "yeeloong_sci" },
> 	{ .name = "yeelong_hwmon" },
> 	...

Yes.

> > +
> > +static DEFINE_SPINLOCK(kb3310b_command_lock);
> 
> Since this is only used in kb3310b_query_seq() could you just declare it
> (still static) inside that function?

No problem.

Thanks for your review, I'll correct all the issues above and send v3 today,
if there's no addition problem in v3, I will start sending the actual platform
drivers (battery/hwmon/etc) for the next round of review.

P.S: This time, I hope Lee Jones, as the MFD subsystem maintainer, has
received my mail and my patch, including this one. Unfortunately, all signs
indicated he hasn't received it. Jones, if you have received this mail but
currently too busy to review, please reply to confirm, thanks!

Sincerely yours,

Tom Li
