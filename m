Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FBF4C10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 23:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 335F420833
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 23:25:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbfDNXZc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 19:25:32 -0400
Received: from 178.115.242.59.static.drei.at ([178.115.242.59]:42455 "EHLO
        mail.osadl.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbfDNXZb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 19:25:31 -0400
Received: by mail.osadl.at (Postfix, from userid 1001)
        id 67F6A5C1578; Mon, 15 Apr 2019 01:24:43 +0200 (CEST)
Date:   Mon, 15 Apr 2019 01:24:43 +0200
From:   Nicholas Mc Guire <der.herr@hofr.at>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Nicholas Mc Guire <hofrat@osadl.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3 RFC] ARM: mvebu: at least warn on kzalloc failure
Message-ID: <20190414232443.GB1215@osadl.at>
References: <1555217391-3552-1-git-send-email-hofrat@osadl.org>
 <20190414172602.z6d4swzk6bjjumls@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190414172602.z6d4swzk6bjjumls@shell.armlinux.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 14, 2019 at 06:26:02PM +0100, Russell King - ARM Linux admin wrote:
> On Sun, Apr 14, 2019 at 06:49:49AM +0200, Nicholas Mc Guire wrote:
> > Although it is very unlikely that the allocation during init would
> > fail any such failure should point to the original cause rather
> > than waiting for a null-pointer dereference to splat.
> > 
> > Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> > ---
> > 
> > Problem located with experimental coccinelle script
> > 
> > While this will not really help much - but kzalloc failures should not
> > go unhandled. 
> 
> Sorry, no, not like this.
>

ok - well I wsa not sure about it either - it just seems wrong
to leave a possible allocation failure without any response.

The issue of generating excessive outout make sense - so will fix
it up to a pr_err() and resend.

thx!
hofrat
 
> With this patch, rather than getting an oops and a stacktrace which
> people can capture and email, we instead end up getting a warning
> line, a stack trace, followed by an oops containing another stack
> trace.
> 
> We _already_ have problems getting people to send us kernel message
> debug information without editing out what they deem to be "unnecessary
> verbage", like all those numbers and function names that comprise a
> stack trace.  We don't need yet more of that stuff, especially when it
> is redundant.
> 
> So, I think throwing WARN_ON() at this case is way too excessive, and
> will only have a detrimental effect on the reports we receive - and
> that is extremely important.
> 
> IMHO, A better solution would be to just print a warning, rather than
> causing the kernel to print several kB of needless messages.
> 
> 	if (!new_compat)
> 		pr_err("new_compat allocation failure in %s()\n",
> 		       __func__);
> 
> > 
> > Patch was compile-tested: mvebu_v7_defconfig (implies MACH_MVEBU_ANY=y)
> > (with some unrelated sparse warnings about missing syscalls)
> > 
> > Patch is against 5.1-rc4 (localversion-next is 20190412)
> > 
> >  arch/arm/mach-mvebu/board-v7.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm/mach-mvebu/board-v7.c b/arch/arm/mach-mvebu/board-v7.c
> > index 0b10acd..37f8cb6 100644
> > --- a/arch/arm/mach-mvebu/board-v7.c
> > +++ b/arch/arm/mach-mvebu/board-v7.c
> > @@ -128,6 +128,7 @@ static void __init i2c_quirk(void)
> >  		struct property *new_compat;
> >  
> >  		new_compat = kzalloc(sizeof(*new_compat), GFP_KERNEL);
> > +		WARN_ON(!new_compat);
> >  
> >  		new_compat->name = kstrdup("compatible", GFP_KERNEL);
> >  		new_compat->length = sizeof("marvell,mv78230-a0-i2c");
> > -- 
> > 2.1.4
> > 
> > 
> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
> According to speedtest.net: 11.9Mbps down 500kbps up
