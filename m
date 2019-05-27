Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D1B7C07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 07:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E552E2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 07:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558942989;
	bh=X7ynL72ha7k9eEdiHV/r0CfG2ObyEzpo6DNq8OOpo4M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ny0Iv7Kpy5aDKE3oLkDTfQqZLrSo8uDWHHjWK62oBEm+DLlImt4UmRIz0FoCGPJFi
	 nc9pSrYBP2ju0GZkReSpf3H7AvyM9XUWg3dDiVprgtHcpiOKg46Ah4RKg7HMvUjrZR
	 CNQFPJfKmx25H0v8XhOPFDgLoWfwgNNojz0VgUfo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbfE0HnH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 03:43:07 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38928 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfE0HnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 03:43:07 -0400
Received: by mail-pl1-f196.google.com with SMTP id g9so6710030plm.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 00:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lXwtkUKjJRctNYznRKr06c91Cgy9C63icBzCRvy/T1w=;
        b=QR6jJPItZ8Rz7z74p4b9j9wtPd8xgqz3msBmmSz49q9GIZ+wNyU8WoH5wmAG5ujTT4
         ZG0ewEzX+SWlNilKu39R1gD2jcTu+0RDpAaENMrl5z4G7OIVnc95SUtK/MnRY8rzIp14
         p9mBhlnuxGq6cWe8nUwhBHVobbuRMb0BG0NiorPdgDrRxwgHtY90D5esPw/xjQ2TEnek
         i5hHksIVCegyo3by8HhykHa7MJAsx+fZhtnMaN4J4+MoX8GoE3O3iM8tBuoKAGGWE2q4
         /kLZLsJEa+mn7ouhwLI9sQnMxIgt50b5cIJ4RtU7MBMfeifeDJAM22at8IK5rxJ37+gC
         jQ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=lXwtkUKjJRctNYznRKr06c91Cgy9C63icBzCRvy/T1w=;
        b=nx/1FMX+N1IXoQQpPCKFmRfx1yPNGSHeBH8fCmpBnOU0ulqFYznWkmOkIe1gwQOfix
         mAO7lwhQTRDbudaY2rasi541W2N9LVtxGmwibPVies3HJk5DoeHUWa8C0csmLppUOI7l
         ZEL3BptdBKAAm19qanKO0Nbtxy3sZUD6yeekIDLhpmJvDE1i5PDVU5HAT8+EGeWZQEhh
         9PEg8M7uyA4sOIBuznJ0ERwqvwVDwjJy9iWHNvaEd6ya0gkR6oHOmhnaIUG1Btut7o2o
         mGtPUM7fsZxwcE5+U0KSm48OzBANfCG/xZmsvxOfUGKAB6dSSbDIdm/oYdsoy0IWPsh7
         2hOw==
X-Gm-Message-State: APjAAAUk6zxYwoy+8urQCspKa6rnhiLVjzdyDeK7dBntq0SAfkdQNWEP
        Grt48E4Tt+umWd/dKUjBCz/vCbNg
X-Google-Smtp-Source: APXvYqxa35u12pQHum/AcABmpbDr09kLk3WP9Gem47sfN0k5HrNMA7iKabi/mN8AIWOV57ysYuVnkw==
X-Received: by 2002:a17:902:ac8b:: with SMTP id h11mr13047842plr.31.1558942986856;
        Mon, 27 May 2019 00:43:06 -0700 (PDT)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id z7sm12464953pfr.23.2019.05.27.00.43.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 27 May 2019 00:43:05 -0700 (PDT)
Date:   Mon, 27 May 2019 16:43:00 +0900
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
Message-ID: <20190527074300.GA6879@google.com>
References: <20190520035254.57579-1-minchan@kernel.org>
 <20190520035254.57579-6-minchan@kernel.org>
 <20190521153113.GA2235@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521153113.GA2235@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the late response. I miseed your comment. :(

On Tue, May 21, 2019 at 05:31:13PM +0200, Oleg Nesterov wrote:
> On 05/20, Minchan Kim wrote:
> >
> > +	rcu_read_lock();
> > +	tsk = pid_task(pid, PIDTYPE_PID);
> > +	if (!tsk) {
> > +		rcu_read_unlock();
> > +		goto err;
> > +	}
> > +	get_task_struct(tsk);
> > +	rcu_read_unlock();
> > +	mm = mm_access(tsk, PTRACE_MODE_ATTACH_REALCREDS);
> > +	if (!mm || IS_ERR(mm)) {
> > +		ret = IS_ERR(mm) ? PTR_ERR(mm) : -ESRCH;
> > +		if (ret == -EACCES)
> > +			ret = -EPERM;
> > +		goto err;
> > +	}
> > +	ret = madvise_core(tsk, start, len_in, behavior);
> 
> IIUC, madvise_core(tsk) plays with tsk->mm->mmap_sem. But this tsk can exit and
> nullify its ->mm right after mm_access() succeeds.

You're absolutely right. I will fix it via passing mm_struct instead of
task_struct.

Thanks!

> 
> another problem is that pid_task(pid) can return a zombie leader, in this case
> mm_access() will fail while it shouldn't.

I'm sorry. I didn't notice that. However, I couldn't understand your point. 
Why do you think mm_access shouldn't fail even though pid_task returns
a zombie leader? I thought it's okay since the target process is exiting
so hinting operation would be meaniness for the process.
