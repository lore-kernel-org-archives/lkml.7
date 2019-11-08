Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D76FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 10:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7CF3214DB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 10:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731435AbfKHKNu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 05:13:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:37980 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729873AbfKHKNu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 05:13:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BE975AB9B;
        Fri,  8 Nov 2019 10:13:48 +0000 (UTC)
Date:   Fri, 8 Nov 2019 11:13:47 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Laurence Oberman <loberman@redhat.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] watchdog/softlockup: Report overall time and some
 cleanup
Message-ID: <20191108101347.iiej2ovybofjbwxd@pathway.suse.cz>
References: <20191024114928.15377-1-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024114928.15377-1-pmladek@suse.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2019-10-24 13:49:25, Petr Mladek wrote:
> This is rework of the softlockup improvements sent as
> https://lkml.kernel.org/r/20190819104732.20966-1-pmladek@suse.com
> based on feedback from Peter Zijlstra.
> 
>       + merged the two patches
>       + moved some cleanup changes into separate patches
>       + improved the code and commit messages
> 
> The main change is in 2nd patch. It fixes the time spent in softlockup.
> 
> Original:
> 
>   [  168.277520] watchdog: BUG: soft lockup - CPU#1 stuck for 22s! [cat:4865]
>   [  196.277604] watchdog: BUG: soft lockup - CPU#1 stuck for 22s! [cat:4865]
>   [  236.277522] watchdog: BUG: soft lockup - CPU#1 stuck for 23s! [cat:4865]
>                                                               ^^^
> 
> New:
> 
>   [  480.372418] watchdog: BUG: soft lockup - CPU#2 stuck for 26s! [cat:4943]
>   [  508.372359] watchdog: BUG: soft lockup - CPU#2 stuck for 52s! [cat:4943]
>   [  548.372359] watchdog: BUG: soft lockup - CPU#2 stuck for 89s! [cat:4943]
>   [  576.372351] watchdog: BUG: soft lockup - CPU#2 stuck for 115s! [cat:4943]
>                                                               ^^^^^
> 1st and 3rd patch clean up the code.
> 
> 
> Petr Mladek (3):
>   watchdog/softlockup: Remove obsolete check of last reported task
>   watchdog/softlockup: Report the overall time of softlockups
>   watchdog/softlockup: Remove logic that tried to prevent repeated
>     reports
> 
>  kernel/watchdog.c | 67 ++++++++++++++++++++++++-------------------------------
>  1 file changed, 29 insertions(+), 38 deletions(-)

Gently ping. I wonder if there is still chance to get this for 5.5.

I hope that this variant is much easier to review than
the previous one.

Best Regards,
Petr
