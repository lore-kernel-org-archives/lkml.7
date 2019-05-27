Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0733DC04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 23:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD6642081C
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 23:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558999995;
	bh=0oR+pSEGzh6djZbfHvjpM8tBWs3WW18V9v8rjmo7SoI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NGcz76ldLGj7egVrre9NFOqmHYFyYn7Gsb52iy8c36T5dw022z6w1PoUxAHTu6q65
	 w2XoTNhu9c4hIm5Zsni0SKNXYOOU1BdH/laDNh90xiTr15Dk68KFgMkCLiMxWYlHfy
	 VMZXJey9pZSv8rgxWIp+gw+hFH6PMBO/dtRhZ8sM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbfE0XdO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 19:33:14 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35687 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727134AbfE0XdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 19:33:14 -0400
Received: by mail-pg1-f196.google.com with SMTP id t1so9787708pgc.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 16:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+Tzevj0aBFVFkJCWK4eLpOvzUlkBo2BfRqQfZEvwMvs=;
        b=Pcm1ooQR7nJPiwEsinFV/L6nU72jYejpbNC7QlSuOh8Pr/Z7jHPUQy9LUaDpG3ZZiM
         +y0KLQUxNoHblKkmwGb+K2LT3jNmHSweUA8KOn53jFvOagl8BB01uHMmr4Urgm7G7kzD
         i9oE0PzDFV3dp3p4jzFvhv08fTGoOAyudo4yFzXQ/AYO1FA/npUwnQLAk0eTJe8aRySd
         xpHXTeOT1+LNS9vzNUHPyk3kEzHbL8xv+pWQfDUV7yC6yNTdtI7zVh6xRdi56muGJLNV
         vrxlxGW79TUzoRd+V1xYEHmU+3m+Re5rThIDKwi1R9C/6KzcnUuFWJPjFMXqnM9HA3Tt
         aC1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=+Tzevj0aBFVFkJCWK4eLpOvzUlkBo2BfRqQfZEvwMvs=;
        b=JDf5St6kYSCwrS0xXDffllueRIt7td1srN6biB5/moa6/w6UGPH4VOdjKVr3/1JyVh
         yB0L6df6Dj/UDGsrJNLLrv2KS65kjMl4jTV7RIs/j1mDlRFBomkrbvhy12Np/zy44y5M
         hSJx7RqH80fMBBEds0Q3zngdiDSyjoPQTYfI4SWSkb+YDVbCTLB7dQvZE8r3PwSwL61X
         O1WLy0RqmWvzcyQD72mg21Nf+jfspyU3r8NUNtJrBHEs5ig4ptA60yz6X510cn8YlAL3
         JjeK58m3YWaX7kLzacHtvtjzoUwMxPhpJsF10BmPQLPWMSeNdadBmI/c7KrYZFthegMg
         /KfA==
X-Gm-Message-State: APjAAAXjB7KHxAJsfVGYtFloqmQR0kxZTOodrNuflKbBdioBHZo1me+G
        vmNBWSa0HM7PWQS8O0+z3bk=
X-Google-Smtp-Source: APXvYqw64MwbF8rBzoFZuNCZfbyzEPvHcK3q4MMq9vzVc16EWSgge+/RGsYDd+RrqQ/wO+LlCjxZUw==
X-Received: by 2002:a62:d41c:: with SMTP id a28mr40306175pfh.31.1558999993555;
        Mon, 27 May 2019 16:33:13 -0700 (PDT)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id n2sm10802478pgp.27.2019.05.27.16.33.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 27 May 2019 16:33:12 -0700 (PDT)
Date:   Tue, 28 May 2019 08:33:06 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>
Subject: Re: [RFC 5/7] mm: introduce external memory hinting API
Message-ID: <20190527233306.GE6879@google.com>
References: <20190520035254.57579-1-minchan@kernel.org>
 <20190520035254.57579-6-minchan@kernel.org>
 <20190521153113.GA2235@redhat.com>
 <20190527074300.GA6879@google.com>
 <20190527151201.GB8961@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190527151201.GB8961@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 05:12:02PM +0200, Oleg Nesterov wrote:
> On 05/27, Minchan Kim wrote:
> >
> > > another problem is that pid_task(pid) can return a zombie leader, in this case
> > > mm_access() will fail while it shouldn't.
> >
> > I'm sorry. I didn't notice that. However, I couldn't understand your point.
> > Why do you think mm_access shouldn't fail even though pid_task returns
> > a zombie leader?
> 
> The leader can exit (call sys_exit(), not sys_exit_group()), this won't affect
> other threads. In this case the process is still alive even if the leader thread
> is zombie. That is why we have find_lock_task_mm().

Thanks for clarification, Oleg. Then, Let me have a further question.

It means process_vm_readv, move_pages have same problem too because find_task_by_vpid
can return a zomebie leader and next line checks for mm_struct validation makes a
failure. My understand is correct? If so, we need to fix all places.
