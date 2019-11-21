Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51DFDC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 19:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 257A020672
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 19:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f7hIgrLH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbfKUTo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 14:44:28 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40392 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbfKUTo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 14:44:27 -0500
Received: by mail-wm1-f65.google.com with SMTP id y5so5083607wmi.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 11:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uTIJtrMTYzypNUnthW2Tuvb1wnw9jVilGROuq4bj1cY=;
        b=f7hIgrLHpIfU5/akWKo3g6Aba9HNF1z8VIF40564XgfKxm+Wqz5asZ0K3ga+NNX8JQ
         25tAeHAgC3gHnkLsJRhtHbaULGoBHvRJioPF3pxZ5PHqDVudlac0GuaPUkPNcs6dhgnu
         p8Fts1e3CQrJfY8BcxTBaYyeCBL5JoZ+UUePdxCG00RU4Ihm8O1ByPNci1R++r/fMYGG
         WyUqcKr7yoqgWrXhVrgPhq84rwAQ+p8FfHp86rluJkufqsWmpDRR+y+BLSyD088TPwAA
         apUAECWUpHvdLRILLuj6RAizizlRH48nP5TT4DlolwOHLVP5CBXIcoZnCC7P70JV1iUg
         p+lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uTIJtrMTYzypNUnthW2Tuvb1wnw9jVilGROuq4bj1cY=;
        b=TyKX/nYMzAb4HpPEzVPzsdH+wvUPJsS8S03zDvL8pNbyjcEiF2ibq6sqKRVXMS/UFK
         BZD5kT8tlitB8dedujOfSddOam+h1wPsdJQc+CgCtczFdNi7TTALu4FIvDdl4K/hS/7X
         qzCflWkx4hxSYMr3UCvyRa5cs1xZKLB3eSzdqP9W6ROLzQdiOLnMOr9dx25bf4ZXymoZ
         ithYjxbuH4ihhFAFazsLsn+mtaB+MHFNHTkeMUMtwf8bqiEyiJCe9p55PHabgrNzzSQ3
         yFre5/I8VKq7iWfVsq08qRoISuJi150TIIKlY4tTh9UvXy9937jq7GVfQWfmsMeinta9
         KORg==
X-Gm-Message-State: APjAAAWg+6/UtwX8YiHlGh3PwogViTTtTFwUCumCJhSG4va2mCMfKn5y
        ef1ohanMS06FiEeAd++xN8G8uQ==
X-Google-Smtp-Source: APXvYqzuAWFT3ZJU3dauo2GBA3lqNtP+wGbk4U6pFsTLxKMfy8NQ5iZzpfcEuBVioFbNF0k0Fikd5w==
X-Received: by 2002:a1c:f70a:: with SMTP id v10mr6144619wmh.159.1574365465017;
        Thu, 21 Nov 2019 11:44:25 -0800 (PST)
Received: from google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id m3sm4864233wrb.67.2019.11.21.11.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 11:44:24 -0800 (PST)
Date:   Thu, 21 Nov 2019 20:44:18 +0100
From:   Marco Elver <elver@google.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] spinlock_debug: Fix various data races
Message-ID: <20191121194418.GA239776@google.com>
References: <20191120155715.28089-1-elver@google.com>
 <20191121183257.GA124760@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191121183257.GA124760@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Nov 2019, Ingo Molnar wrote:

> 
> * Marco Elver <elver@google.com> wrote:
> 
> >  static inline void debug_spin_lock_after(raw_spinlock_t *lock)
> >  {
> > -	lock->owner_cpu = raw_smp_processor_id();
> > -	lock->owner = current;
> > +	WRITE_ONCE(lock->owner_cpu, raw_smp_processor_id());
> > +	WRITE_ONCE(lock->owner, current);
> >  }
> 
> debug_spin_lock_after() runs inside the spinlock itself - why do these 
> writes have to be WRITE_ONCE()?
> 
> > @@ -197,8 +197,8 @@ static inline void debug_write_unlock(rwlock_t *lock)
> >  	RWLOCK_BUG_ON(lock->owner != current, lock, "wrong owner");
> >  	RWLOCK_BUG_ON(lock->owner_cpu != raw_smp_processor_id(),
> >  							lock, "wrong CPU");
> > -	lock->owner = SPINLOCK_OWNER_INIT;
> > -	lock->owner_cpu = -1;
> > +	WRITE_ONCE(lock->owner, SPINLOCK_OWNER_INIT);
> > +	WRITE_ONCE(lock->owner_cpu, -1);
> >  }
> 
> This too is running inside the critical section of the spinlock - why are 
> the WRITE_ONCE() calls necessary?

Although the writes are inside the critical section, they are read
concurrently outside the critical section, e.g. in
debug_spin_lock_before(). In other words, the WRITE_ONCE pair with the
READ_ONCE that are *outside* the critical section.

Thanks,
-- Marco

> Thanks,
> 
> 	Ingo
