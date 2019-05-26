Return-Path: <SRS0=Y9JJ=T2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE36C282E3
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 17:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF3D1206BA
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 17:20:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbfEZRUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 May 2019 13:20:42 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:53467 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727926AbfEZRUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 13:20:42 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id E829280404; Sun, 26 May 2019 19:20:29 +0200 (CEST)
Date:   Sun, 26 May 2019 19:20:02 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Hugh Dickins <hughd@google.com>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Revert "leds: avoid races with workqueue"?
Message-ID: <20190526172002.GB1282@xo-6d-61-c0.localdomain>
References: <alpine.LSU.2.11.1905241540080.1674@eggly.anvils>
 <20190525093759.GA17767@amd>
 <alpine.LSU.2.11.1905251025300.1112@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.1905251025300.1112@eggly.anvils>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2019-05-25 10:32:31, Hugh Dickins wrote:
> On Sat, 25 May 2019, Pavel Machek wrote:
> 
> > Hi!
> > 
> > > I'm having to revert 0db37915d912 ("leds: avoid races with workqueue")
> > > from my 5.2-rc testing tree, because lockdep and other debug options
> > > don't like it: net/mac80211/led.c arranges for led_blink_setup() to be
> > > called at softirq time, and flush_work() is not good for calling
> > > then.
> > 
> > This should keep X60 working (as well as it is now; X60 will still
> > have problems with lost events in setup like yours).
> > 
> > Can you test this instead of the revert?
> 
> Thanks, Pavel: yes, that works fine for me on the T420s, no debug
> complaints, good and silent; and the wifi LED is blinking as before.

I'd like to prevent recurrence of similar problem, and I wonder if you
can give me a hint.

I can annotate code that can sleep with might_sleep().

How can I annotate code that can not sleep? I might do 

spin_lock(&dummy);
this_should_not_sleep();
spin_unlock(&dummy);

But I don't really need extra serialization. I just want annotations for
lockdep. Any ideas?

								Pavel
