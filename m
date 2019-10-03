Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC21C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 11:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD0CE215EA
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 11:51:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730276AbfJCLvj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 07:51:39 -0400
Received: from tartarus.angband.pl ([54.37.238.230]:40722 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbfJCLvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 07:51:39 -0400
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.92)
        (envelope-from <kilobyte@angband.pl>)
        id 1iFzds-0004Po-Ja; Thu, 03 Oct 2019 13:51:32 +0200
Date:   Thu, 3 Oct 2019 13:51:32 +0200
From:   Adam Borowski <kilobyte@angband.pl>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Kurt Roeckx' <kurt@roeckx.be>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: Stop breaking the CSRNG
Message-ID: <20191003115132.GA14301@angband.pl>
References: <20191002165533.GA18282@roeckx.be>
 <b193685d90c0474aa0727555f936528b@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b193685d90c0474aa0727555f936528b@AcuMS.aculab.com>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2019 at 10:13:39AM +0000, David Laight wrote:
> From: Kurt Roeckx
> > Sent: 02 October 2019 17:56
> > As OpenSSL, we want cryptograhic secure random numbers. Before
> > getrandom(), Linux never provided a good API for that, both
> > /dev/random and /dev/urandom have problems. getrandom() fixed
> > that, so we switched to it were available.
> 
> The fundamental problem is that you can't always get ' cryptograhic secure
> random numbers'. No API changes are ever going to change that.
> 
> The system can either return an error or sleep (possibly indefinitely)
> until some 'reasonably random' numbers are available.
> 
> A RISC-V system running on an FGPA (I've only used Altera NIOS cpu)
> may have absolutely no sources of randomness at boot time.

I'd say this is a hardware security vulnerability; no different from eg.
having no or faulty MMU, speculation that allows exfiltrating data, etc.
We did not understand the seriousness of lacking hardware sources of
randomness, but that's a common thing to many other security
vulnerabilities.

Machines that lack any sources of entropy have their uses, but they're akin
to processors with no MMU.  You should never run a world-accessible ssh
daemon on either of them.

> Saying the architecture must include a random number instruction
> doesn't help!

It won't fix existing systems, and is irrelevant to deeply embedded, but
communicating this requirement to SoC designers sounds like a good idea to
me.  IoTrash appliance makers won't care but their security is already so
atrocious that lack of entropy is nowhere near the easiest way to get in,
while anyone else will at least notice the warning.

Any real-silicon hardware can include an entropy source, and if it doesn't,
shaming the maker is the way to go.  Calling the problem a security
vulnerability (which I say it is) sends a stronger message.


Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀ A MAP07 (Dead Simple) raspberry tincture recipe: 0.5l 95% alcohol,
⣾⠁⢠⠒⠀⣿⡁ 1kg raspberries, 0.4kg sugar; put into a big jar for 1 month.
⢿⡄⠘⠷⠚⠋⠀ Filter out and throw away the fruits (can dump them into a cake,
⠈⠳⣄⠀⠀⠀⠀ etc), let the drink age at least 3-6 months.
