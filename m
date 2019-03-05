Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12420C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 12:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1B4B2082C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 12:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551790646;
	bh=dPVwcLKLvReR38rC9WK/ROAn9S5r8TogNO4WHQhmcpc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jq3U2M1GMFdTGobX0FTLlPnozA0RCwEpCCCmQkZswi3nNBZQ6cC3oNv73rzoGlLQk
	 scfz3nObRAoN1301RDUH6yHyt4pKCshKLrGws+FJok3ReEbXUhjgq3lAfq7r3jvoJZ
	 tETSzBG2lt//OPlOgPSKzXE5XhXsmD9UnCFpWaDk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbfCEM5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 07:57:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:42908 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726657AbfCEM5Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 07:57:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6500EAD95;
        Tue,  5 Mar 2019 12:57:23 +0000 (UTC)
Date:   Tue, 5 Mar 2019 13:57:22 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] printk: Introduce "store now but print later" prefix.
Message-ID: <20190305125722.GG28468@dhcp22.suse.cz>
References: <6b97b4bb-a9b9-75b3-17a2-bff99ae7c526@i-love.sakura.ne.jp>
 <20190304142339.mfno5mmjxxsrf47q@pathway.suse.cz>
 <201903050123.x251N312025685@www262.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201903050123.x251N312025685@www262.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 05-03-19 10:23:03, Tetsuo Handa wrote:
[...]
> Also, both nopage_rs in warn_alloc() and oom_rs in oom_kill_process() are not
> working well. This is because ___ratelimit() function assumes that operations
> to be ratelimited complete fast enough to be able to repeat many times within
> a second. If one operation to be ratelimited takes many seconds (or even
> minutes), ___ratelimit() becomes always true and can not ratelimit at all.

And this is a fundamental problem of the ratelimiting and something to
think about and address. The underlying assumption of the ratelimit
implementation that the throttled operation is mostly too short to
consider is just wrong in this and potentially many other cases. Well
basically whenever the API is used for printing. So rather than working
around this and complicating the code around I would focus on making
ratelimit implementation more robust for long taking operations.
-- 
Michal Hocko
SUSE Labs
