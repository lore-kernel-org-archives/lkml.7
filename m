Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC87C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 12:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA40721871
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 12:15:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mY+Wld5f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728982AbfCOMPp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 08:15:45 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55992 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728934AbfCOMPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 08:15:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ZsM3UBWajgyMamixPtpjgFQzUMJGGE2hq6RgCGdr5hw=; b=mY+Wld5f4v6nZzZzxKHxmhYCen
        i/7K2l1CGUtCX4a6oIS+c1QeJ1hGznbStjmyaKMf0sfGFAzZ81OQ37wezTX+LXJRyaQrpzfiOwtvB
        es5k5aeSYnRAQDk81m4NUTN0cGkPq72MzjMIB7FBnIcvYSB3HjC+W+EFdaeoZuRvLD4bMclqh3PJQ
        zuFPKyh9SlLcjFuLrivgb6/mAW3kt0Lx8uStuWQS4xnM/o/+6cZUmSXfQObWVSNBxR0PzkYbflGAD
        94ZXB0FVw/bUxKs3pcquZy7W3r+UrwkVgem+Pa60sHmPRwHzUDgnHmTnU68jSe0v8QBe23ieB3x42
        iMMhzt1A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h4lkV-00024r-KK; Fri, 15 Mar 2019 12:15:43 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 11B0B21419E57; Fri, 15 Mar 2019 13:15:41 +0100 (CET)
Date:   Fri, 15 Mar 2019 13:15:41 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas =?iso-8859-1?Q?M=FCller?= <thomas@mathtm.de>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: disabling secondary CPU hangs / system fails to suspend with
 kernel 4.19+
Message-ID: <20190315121541.GD6058@hirez.programming.kicks-ass.net>
References: <5c48095e-028a-404f-aaa1-964f83c83817@mathtm.de>
 <20190315090950.GT5996@hirez.programming.kicks-ass.net>
 <cbaafd35-a17d-8331-4cef-281a562b91b5@mathtm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cbaafd35-a17d-8331-4cef-281a562b91b5@mathtm.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 12:41:00PM +0100, Thomas Müller wrote:

> > What .config do you have?
> The one packaged by Fedora. I've attached the one for 4.20.15 as reference.

Thanks, I'll have a poke, see what, if anything, is different from the
kernels I ran.

> > And what, if anything do you see on the
> > console when it goes funny?
> Nothing unfortunately.
> When trying to suspend the display immediately goes blank, the system becomes unresponsive and the
> status LED within the power button start flashing rapidly (just like it does when the power cord is
> attached).
> 
> 
> > I think you wrote that hot-un-plug never completes? Is there anything in
> > dmesg when it's stuck in:
> > 
> >   echo 0 > /sys/devices/system/cpu/cpu1/online
> > 
> > ?
> I've just tried that again and the system immediately froze.

Hmm, I tought you said the system remained semi usable, just that reboot
stopped working thereafter and it needed a power cycle.

> `journalctl -f` was running in a second window but it had no chance to output anything... :/

Ah, you're using a GUI!

Stop doing that ;-)

See if you can use the VGA console; not a FB console or a DRM console,
but the real ancient, proper text mode, VGA console.

Now, don't ask me how to do that, because I don't know, I've been
running on pure serial console output for the past 10 years or so, heck
I don't even have systemd.

And you might have to do something like: dmesg -n8, to get the console
to print the kernel messages or something.

