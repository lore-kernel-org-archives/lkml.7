Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 224B0C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 14:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06A6A206BB
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 14:47:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732593AbfFLOrx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 10:47:53 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:33315 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732557AbfFLOrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 10:47:51 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hb4XT-0006mN-FT; Wed, 12 Jun 2019 16:47:47 +0200
Date:   Wed, 12 Jun 2019 16:47:47 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Soeren Moch <smoch@web.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, tglx@linutronix.de
Subject: Re: [PATCH] Revert "usb: core: remove local_irq_save() around
 ->complete() handler"
Message-ID: <20190612144747.mf7hwunsl2zi3uxo@linutronix.de>
References: <fb64b378-57a1-19f4-0fd2-1689fc3d8540@web.de>
 <Pine.LNX.4.44L0.1906121033550.1557-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1906121033550.1557-100000@iolanthe.rowland.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-06-12 10:38:11 [-0400], Alan Stern wrote:
> > 
> > When stopping hostapd after it hangs:
> > [  903.504475] ieee80211 phy0: rt2x00queue_flush_queue: Warning - Queue
> > 14 failed to flush
> 
> Instead of reverting the original commit, can you prevent the problem 
> by adding local_irq_save() and local_irq_restore() to the URB 
> completion routines in that wireless driver?
> 
> Probably people who aren't already pretty familiar with the driver code
> won't easily be able to locate the race.  Still, a little overkill may
> be an acceptable solution.

Not from RT point of view because you do
	local_irq_save() -> spin_lock()

but it might be worth checking if the local_irq_save() within that
wireless driver avoids the race or not.

> Alan Stern

Sebastian
