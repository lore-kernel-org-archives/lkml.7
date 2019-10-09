Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 956A8C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 18:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77769218AC
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 18:51:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731508AbfJISvV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 14:51:21 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:51736 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1730490AbfJISvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 14:51:20 -0400
Received: (qmail 6328 invoked by uid 2102); 9 Oct 2019 14:51:19 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 9 Oct 2019 14:51:19 -0400
Date:   Wed, 9 Oct 2019 14:51:19 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Tony Lindgren <tony@atomide.com>
cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PM / runtime: Add support for wake-up reason for wakeirqs
In-Reply-To: <20191009182803.63742-1-tony@atomide.com>
Message-ID: <Pine.LNX.4.44L0.1910091447510.1603-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Oct 2019, Tony Lindgren wrote:

> With generic wakeirqs we can wake a device, but do not know if the
> device woke to a wakeirq. Let's add pm_runtime_wakeup_is_wakeirq() so
> a device can check the wake-up reason.

People have tried many times over the years to do something like this.  
It's never right.

The problem is simple: It's impossible to know for certain why the
system woke up from suspend.  In fact, there may be many wakeup sources
all active at the same time, and any of them could be the one
responsible for actually waking the system.

All you can do is check to see whether a particular wakeup source is
active at the present moment.  You can't tell whether it was active in
the past (while the system was suspended) or whether it caused the
system to resume.

Alan Stern

