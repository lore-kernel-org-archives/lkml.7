Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F76ECE58C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 19:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BEC220B7C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 19:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731823AbfJITzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 15:55:11 -0400
Received: from muru.com ([72.249.23.125]:36342 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730490AbfJITzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 15:55:10 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 1D6228140;
        Wed,  9 Oct 2019 19:55:43 +0000 (UTC)
Date:   Wed, 9 Oct 2019 12:55:06 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PM / runtime: Add support for wake-up reason for wakeirqs
Message-ID: <20191009195506.GO5610@atomide.com>
References: <20191009182803.63742-1-tony@atomide.com>
 <Pine.LNX.4.44L0.1910091447510.1603-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1910091447510.1603-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Alan Stern <stern@rowland.harvard.edu> [191009 18:51]:
> On Wed, 9 Oct 2019, Tony Lindgren wrote:
> 
> > With generic wakeirqs we can wake a device, but do not know if the
> > device woke to a wakeirq. Let's add pm_runtime_wakeup_is_wakeirq() so
> > a device can check the wake-up reason.
> 
> People have tried many times over the years to do something like this.  
> It's never right.
> 
> The problem is simple: It's impossible to know for certain why the
> system woke up from suspend.  In fact, there may be many wakeup sources
> all active at the same time, and any of them could be the one
> responsible for actually waking the system.

Hmm yeah good point. Even with dedicated wakeirq it could race
against a timer for the wake-up event.

> All you can do is check to see whether a particular wakeup source is
> active at the present moment.  You can't tell whether it was active in
> the past (while the system was suspended) or whether it caused the
> system to resume.

We can actually do more than that now though :)

With handle_threaded_wake_irq() we could optionally call a handler
before we call pm_runtime_resume() and let the consumer device
driver figure out what the state is.

Regards,

Tony
