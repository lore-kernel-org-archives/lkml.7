Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4943C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 21:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6E082077C
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 21:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578605121;
	bh=OfONYsywgIj9Whd4PChcEhUaXXyPK2lEFxpo/BO33HQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lKp64/I6OT0C7dd0N0OHY6RqpDFEeNcBoU/rs3N6Cfd6lhhoHgs7b2nRfhExB6JDM
	 o0na2aDfYuAC1K/Rp6erRSWJLfjR4fzJwy/uoO5kUIdjD+UjVpuuBLvJP0WGQCe3ho
	 CqFtJJHJgjkQd8MEBhcOdZjkPajtXPFQnQf4Yxww=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbgAIVZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 16:25:21 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40340 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbgAIVZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 16:25:20 -0500
Received: by mail-wm1-f67.google.com with SMTP id t14so4421356wmi.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 13:25:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M/fC6s3aJPS96C3A0a7p8hYvGSefECWe4S/GhKz+rM4=;
        b=adP70iqefGjq9vy4VQA3VscnC38QXpSQm75lpsKOAlmcckHODdmHXFYEfUVzfQTsT7
         of0rjyQ9xSHYH9Tijq0BSzykoFYjUF3Zfa9DrwPs05y3BjH+cQEaRLg1LwSBfOkXh3GA
         Ud0GGBbCRdXjzGfnVDPphZvaBtEAtFhYUX87hpf+CXxcOReIPIM/c3BGR/MhGVzW9nSp
         0yVzmsgTLGtvHzZtxXXBaBf9q1o6f9qASmCv75eKWNL/2/Py1HsXpOmXIoO3kaEpwizW
         874SyfbcXG2rWfyxjkQoYVaa/wfw7QDWihFt69vXGNCtvk3ZTw+T7aQ/Z6aBbnG4TVUD
         v13A==
X-Gm-Message-State: APjAAAUu017sRkJ2hE0eNMX7GV/X9QW58F2gA5qwBnM6vKIobdzoo7U8
        jP9N2LntCkZjV+wr1VTlGHm8tpBc
X-Google-Smtp-Source: APXvYqw8M4bievOHJLVqpOPRe4k3DoDwDFFbBTUI/8frm+mCFsybwOP5RYcBie/CzQOSQy250fLBLQ==
X-Received: by 2002:a1c:1dcd:: with SMTP id d196mr19577wmd.106.1578605118956;
        Thu, 09 Jan 2020 13:25:18 -0800 (PST)
Received: from localhost (ip-37-188-146-105.eurotel.cz. [37.188.146.105])
        by smtp.gmail.com with ESMTPSA id b21sm4124385wmd.37.2020.01.09.13.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 13:25:17 -0800 (PST)
Date:   Thu, 9 Jan 2020 22:25:16 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@osdl.org>, linux-mm@kvack.org,
        akpm@linux-foundation.org
Subject: Re: OOM killer not nearly agressive enough?
Message-ID: <20200109212516.GA23620@dhcp22.suse.cz>
References: <20200107204412.GA29562@amd>
 <20200109115633.GR4951@dhcp22.suse.cz>
 <20200109210307.GA1553@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109210307.GA1553@duo.ucw.cz>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 09-01-20 22:03:07, Pavel Machek wrote:
> On Thu 2020-01-09 12:56:33, Michal Hocko wrote:
> > On Tue 07-01-20 21:44:12, Pavel Machek wrote:
> > > Hi!
> > > 
> > > I updated my userspace to x86-64, and now chromium likes to eat all
> > > the memory and bring the system to standstill.
> > > 
> > > Unfortunately, OOM killer does not react:
> > > 
> > > I'm now running "ps aux", and it prints one line every 20 seconds or
> > > more. Do we agree that is "unusable" system? I attempted to do kill
> > > from other session.
> > 
> > Does sysrq+f help?
> 
> May try that next time.
> 
> > > Do we agree that OOM killer should have reacted way sooner?
> > 
> > This is impossible to answer without knowing what was going on at the
> > time. Was the system threshing over page cache/swap? In other words, is
> > the system completely out of memory or refaulting the working set all
> > the time because it doesn't fit into memory?
> 
> Swap was full, so "completely out of memory", I guess. Chromium does
> that fairly often :-(.

The oom heuristic is based on the reclaim failure. If the reclaim makes
some progress then the oom killer is not hit. Have a look at
should_reclaim_retry for more details.

> > > Is there something I can tweak to make it behave more reasonably?
> > 
> > PSI based early OOM killing might help. See https://github.com/facebookincubator/oomd
> 
> Um. Before doing that... is there some knob somewhere saying "hey
> oomkiller, one hour to recover machine is a bit too much, can you
> please react sooner"?

No, there is nothing like that.

> PSI is completely different system, but I guess
> I should attempt to tweak the existing one first...

PSI is measuring the cost of the allocation (among other things) and
that can give you some idea on how much time is spent to get memory.
Userspace can implement a policy based on that and act. The kernel oom
killer is the last resort when there is really no memory to allocate.
-- 
Michal Hocko
SUSE Labs
