Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 663BEC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 11:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CD6F206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 11:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567767757;
	bh=shvV/Zk/BQkSbVSg065+YUhljAGOjzdleh/m0itSkjs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=W1o7vHyaP6vZ14pjby7UpCvVUvELo5duUMX1L3/85dwWWTuZTZxNZWXNcuwzv4xp1
	 GpO6SzkbvckOzHvAZoxDQxyY119OghDKeSuoG5c9uX5RY3tku2c0JB5JxICVlaXRDD
	 PaLRcmO2Dh8NaibN40sOz5TcSTEZHHNuJPz/t2pA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392159AbfIFLCg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 07:02:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:54840 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731418AbfIFLCg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 07:02:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6B409AF2C;
        Fri,  6 Sep 2019 11:02:34 +0000 (UTC)
Date:   Fri, 6 Sep 2019 13:02:33 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     David Rientjes <rientjes@google.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] mm, oom: disable dump_tasks by default
Message-ID: <20190906110233.GE14491@dhcp22.suse.cz>
References: <20190903144512.9374-1-mhocko@kernel.org>
 <af0703d2-17e4-1b8e-eb54-58d7743cad60@i-love.sakura.ne.jp>
 <20190904054004.GA3838@dhcp22.suse.cz>
 <alpine.DEB.2.21.1909041302290.95127@chino.kir.corp.google.com>
 <12bcade2-4190-5e5e-35c6-7a04485d74b9@i-love.sakura.ne.jp>
 <20190905140833.GB3838@dhcp22.suse.cz>
 <20ec856d-0f1e-8903-dbe0-bbc8b7a1847a@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20ec856d-0f1e-8903-dbe0-bbc8b7a1847a@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 06-09-19 19:46:10, Tetsuo Handa wrote:
> On 2019/09/05 23:08, Michal Hocko wrote:
> > On Thu 05-09-19 22:39:47, Tetsuo Handa wrote:
> > [...]
> >> There is nothing that prevents users from enabling oom_dump_tasks by sysctl.
> >> But that requires a solution for OOM stalling problem.
> > 
> > You can hardly remove stalling if you are not reducing the amount of
> > output or get it into a different context. Whether the later is
> > reasonable is another question but you are essentially losing "at the
> > OOM event state".
> > 
> 
> I am not losing "at the OOM event state". Please find "struct oom_task_info"
> (for now) embedded into "struct task_struct" which holds "at the OOM event state".
> 
> And my patch moves "printk() from dump_tasks()" from OOM context to WQ context.

Workers might be blocked for unbound amount of time and so this
information might be printed late.
-- 
Michal Hocko
SUSE Labs
