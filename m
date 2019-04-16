Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21CE7C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E670120674
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555428072;
	bh=6557F7FAe7Nccx60JnRafhCiWm1l+A2CQfVigujl1FY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=klEQ64Q6jyd91iJXFzlGV06RB7a3+AxMA2T8BL+TbMkOP1LquUUYOgxy+sU5Df3Th
	 MIvXpdDof3DyuxsWa4w/wcbiIcZC5Vbh/aDtZxYRy/NX1sg9yqKUFarxhjIWyu0B48
	 c1uRpWPpKeRduHUE1KVEgmaJyGRqtSkkJqVyPW1I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729732AbfDPPVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 11:21:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:36110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727902AbfDPPVI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 11:21:08 -0400
Received: from localhost (lfbn-1-18355-218.w90-101.abo.wanadoo.fr [90.101.143.218])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E306B20656;
        Tue, 16 Apr 2019 15:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555428067;
        bh=6557F7FAe7Nccx60JnRafhCiWm1l+A2CQfVigujl1FY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QNLFn50U8/ZbkzDCX3vClVO1Awzj05VaHDIUITg5yLUVF2nTmRUYafgbjzdp++cay
         +OwW+sEytUGtqhvwFtOveiEl1lMk3U20Gyf3i78YT3hNfG3fdSASfB/8oLCOPeE6bw
         /EYfqaeEKn8rJviwv+Y5FGQ30/c6j2LM+ax4FoPQ=
Date:   Tue, 16 Apr 2019 17:21:04 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 4/4] locking/lockdep: Test all incompatible scenario at
 once in check_irq_usage()
Message-ID: <20190416152102.GA3501@lenoir>
References: <20190402160244.32434-1-frederic@kernel.org>
 <20190402160244.32434-5-frederic@kernel.org>
 <20190409130352.GV4038@hirez.programming.kicks-ass.net>
 <20190410022846.GA30602@lenoir>
 <20190411104632.GH4038@hirez.programming.kicks-ass.net>
 <20190413003543.GA9544@lenoir>
 <20190416112009.GT11158@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416112009.GT11158@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 01:20:09PM +0200, Peter Zijlstra wrote:
> On Sat, Apr 13, 2019 at 02:35:45AM +0200, Frederic Weisbecker wrote:
> > On Thu, Apr 11, 2019 at 12:46:32PM +0200, Peter Zijlstra wrote:
> > Same here:
> > 
> >   As above, we clear bitnr0 (LOCK_*_READ off) with bitmask ops. First, for all bits
> >   with bitnr1 set (LOCK_ENABLED_*) , add those with bitnr1 cleared (LOCK_USED_IN_*).
> >   And then mask out all bitnr1.
> 
> Ha! you failed to spot my failure, all the above should be bitnr0 of
> course :/

Ooops, right.

> Find updated below.

Very good now, thanks a lot!
