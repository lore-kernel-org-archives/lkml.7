Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E0DFC5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 01:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D06F21D79
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 01:46:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728644AbfKHBqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 20:46:32 -0500
Received: from smtprelay0057.hostedemail.com ([216.40.44.57]:43964 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725928AbfKHBqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 20:46:31 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 564B2100E7B44;
        Fri,  8 Nov 2019 01:46:30 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: cough96_558de86610607
X-Filterd-Recvd-Size: 2341
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Fri,  8 Nov 2019 01:46:27 +0000 (UTC)
Message-ID: <2367894118ccee058ed451927412d7c1a33864bd.camel@perches.com>
Subject: Re: [PATCH] phy: allwinner: Fix GENMASK misuse
From:   Joe Perches <joe@perches.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     megous@megous.com, mark.rutland@arm.com,
        devicetree@vger.kernel.org, arnd@arndb.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        mripard@kernel.org, kishon@ti.com, paul.kocialkowski@bootlin.com,
        linux-sunxi@googlegroups.com, robh+dt@kernel.org,
        tglx@linutronix.de, wens@csie.org,
        linux-arm-kernel@lists.infradead.org, icenowy@aosc.io
Date:   Thu, 07 Nov 2019 17:46:14 -0800
In-Reply-To: <20191107233914.GW25745@shell.armlinux.org.uk>
References: <20191020134229.1216351-3-megous@megous.com>
         <20191107204645.13739-1-rikard.falkeborn@gmail.com>
         <20191107233914.GW25745@shell.armlinux.org.uk>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-11-07 at 23:39 +0000, Russell King - ARM Linux admin wrote:
> On Thu, Nov 07, 2019 at 09:46:45PM +0100, Rikard Falkeborn wrote:
> > Arguments are supposed to be ordered high then low.
> > 
> > Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> > ---
> > Spotted while trying to add compile time checks of GENMASK arguments.
> > Patch has only been compile tested.
> 
> My feeling, personally, is that GENMASK() really isn't worth the pain
> it causes.  Can we instead get rid of this thing and just use easier
> to understand and less error-prone hex masks please?
> 
> I don't care what anyone else says, personally I'm going to stick with
> using hex masks as I find them way easier to get right first time than
> a problematical opaque macro - and I really don't want the effort of
> finding out that I've got the arguments wrong when I build it.  It's
> just _way_ easier and less error prone to use a hex mask straight off.

I agree, but there are already more than 8000 uses of this rather
silly (and perhaps backwards argument order) macro in the kernel.


