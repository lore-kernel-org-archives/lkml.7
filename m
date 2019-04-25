Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A1E5C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 10:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10BDF2084B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 10:30:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730345AbfDYKag (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 06:30:36 -0400
Received: from tartarus.angband.pl ([54.37.238.230]:58028 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbfDYKag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 06:30:36 -0400
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.92)
        (envelope-from <kilobyte@angband.pl>)
        id 1hJbeD-0005xy-UO; Thu, 25 Apr 2019 12:30:33 +0200
Date:   Thu, 25 Apr 2019 12:30:33 +0200
From:   Adam Borowski <kilobyte@angband.pl>
To:     Nico Schottelius <nico-kernel-20190425@schottelius.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: How to turn off IPv4 without disabling IPv6
Message-ID: <20190425103033.GA20813@angband.pl>
References: <87pnpaqvk9.fsf@line.ungleich.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87pnpaqvk9.fsf@line.ungleich.ch>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 11:32:38AM +0200, Nico Schottelius wrote:
> running some IPv6 only
> networks. The systems in the IPv6 only networks do not need any IPv4
> support anymore and thus for switches/routers we turned the support off.

> Today we tried to turn off IPv4 in the Linux kernel at compile time.
> But it seems that as soon as we turn off CONFIG_INET, CONFIG_IPV6 is
> automatically turned off as well.

Even if you don't want global nor even link-scope IPv4, way too many
programs assume that at least 127.0.0.1 (ie, lo) is working.  They can't be
reconfigured to use ::1 without patching and rebuilding.

> Coming back to my original question: is there a way or how would we turn
> off IPv4 support in the Linux kernel?

I believe this is not worth your time for today.

Just do what IPv6-haters do on stock modern distros: have no routes for the
other IP version configured; non-buggy programs will do the right thing.

This seems to work well.  Heck, I had a busy dev server with broken IPv4, I
didn't notice that for 1.5 years until I tried to pull something directly
from Github (which is still v4 only).

You're a network admin so you know far more than me wrt anything that goes
over the wire -- but as as a distro developer/user, I'd say there's a
considerable cost to have every of tens of thousands programs shipped by a
distro, and many more that are private to a company/university/etc, updated
to autodetect how to access "localhost" on a particular box.

That's an extra moving part where there was none before.  Complexity is bad.
Having the IPv4 stack built just for the lo interface simplifies things.


Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀
⣾⠁⢠⠒⠀⣿⡁ Did ya know that typing "test -j8" instead of "ctest -j8"
⢿⡄⠘⠷⠚⠋⠀ will make your testsuite pass much faster, and fix bugs?
⠈⠳⣄⠀⠀⠀⠀
