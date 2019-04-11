Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F816C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 21:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DDDE20850
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 21:11:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="LFBHGgqx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbfDKVLE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 17:11:04 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37000 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726577AbfDKVLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 17:11:03 -0400
Received: by mail-pg1-f193.google.com with SMTP id e6so4097458pgc.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 14:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=I+PugfY7FgqqWZlX12lcfitAcnPLuri4PjNmIYu5QC0=;
        b=LFBHGgqxaNhM1QkYzfgVAiZNPyPSnPApVPKSjqfzAskaEthnehAuBAC/cJ+VOv3hkG
         zloQJPtt3vojCn51Tud33Z3AD0JyHW4sUB/rdW8EDqKykODjSGjxCScS70wKtsQQoIoO
         eaNctJ67Ms/J+woOhqLxKhBFfRtN/0NGQ7eqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=I+PugfY7FgqqWZlX12lcfitAcnPLuri4PjNmIYu5QC0=;
        b=O7tgR3ffb67IWZiNZnDSUTZLvrixv8lvbUC9gPS6n8WaO0CLcw6uiww8kDnaLBWyu1
         0ywYZ+6ziPFG42d9yE9MVJIXP8H0OHw09w8USfVNgBqNHx+TX7W+yRapG+02NdpUDUSc
         8bXYZC1G5i9eQtrL5k/Ib8AzPioZK/F+cKPgDc5d/P4d/LE+ZueKndwKUzAh48jR5q4U
         WS3v5RpDqrYqGDqag0afjxi3xFR1e7YvTT2abubcL7/1WSMrKiFNzeLFGHToLXGizBgH
         slLIXfoL4Az8aFAOmGk+oJkADEbdzdj85JHuU68der1H2wSL1LSHqbbKlGDWDzon4tQA
         HG5g==
X-Gm-Message-State: APjAAAW3WmYTgysuOSSNDW8d1Shq6guACq8g5H4zGfdCbtu8HD2IGoIi
        kn/LyuqZ+uQSJVZTKtJ/U1AQPQ==
X-Google-Smtp-Source: APXvYqzKotygSk0Un81n8ndkReO8MzVRYC2KJpHXIj5+6OIFGorhASRNEQDfIyC8G4Ox/UkAP8a1mg==
X-Received: by 2002:a62:26c1:: with SMTP id m184mr14958505pfm.102.1555017062281;
        Thu, 11 Apr 2019 14:11:02 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id p7sm71208945pfp.70.2019.04.11.14.11.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Apr 2019 14:11:01 -0700 (PDT)
Date:   Thu, 11 Apr 2019 17:11:00 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        yuzhoujian@didichuxing.com, jrdr.linux@gmail.com, guro@fb.com,
        Johannes Weiner <hannes@cmpxchg.org>,
        penguin-kernel@i-love.sakura.ne.jp, ebiederm@xmission.com,
        shakeelb@google.com, Christian Brauner <christian@brauner.io>,
        Minchan Kim <minchan@kernel.org>,
        Tim Murray <timmurray@google.com>,
        Daniel Colascione <dancol@google.com>,
        Jann Horn <jannh@google.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        lsf-pc@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>
Subject: Re: [RFC 0/2] opportunistic memory reclaim of a killed process
Message-ID: <20190411211100.GB130334@google.com>
References: <20190411014353.113252-1-surenb@google.com>
 <20190411105111.GR10383@dhcp22.suse.cz>
 <CAJWu+oq45tYxXJpLPLAU=-uZaYRg=OnxMHkgp2Rm0nbShb_eEA@mail.gmail.com>
 <20190411181243.GB10383@dhcp22.suse.cz>
 <20190411191430.GA46425@google.com>
 <20190411201151.GA4743@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190411201151.GA4743@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 10:11:51PM +0200, Michal Hocko wrote:
> On Thu 11-04-19 15:14:30, Joel Fernandes wrote:
> > On Thu, Apr 11, 2019 at 08:12:43PM +0200, Michal Hocko wrote:
> > > On Thu 11-04-19 12:18:33, Joel Fernandes wrote:
> > > > On Thu, Apr 11, 2019 at 6:51 AM Michal Hocko <mhocko@kernel.org> wrote:
> > > > >
> > > > > On Wed 10-04-19 18:43:51, Suren Baghdasaryan wrote:
> > > > > [...]
> > > > > > Proposed solution uses existing oom-reaper thread to increase memory
> > > > > > reclaim rate of a killed process and to make this rate more deterministic.
> > > > > > By no means the proposed solution is considered the best and was chosen
> > > > > > because it was simple to implement and allowed for test data collection.
> > > > > > The downside of this solution is that it requires additional “expedite”
> > > > > > hint for something which has to be fast in all cases. Would be great to
> > > > > > find a way that does not require additional hints.
> > > > >
> > > > > I have to say I do not like this much. It is abusing an implementation
> > > > > detail of the OOM implementation and makes it an official API. Also
> > > > > there are some non trivial assumptions to be fullfilled to use the
> > > > > current oom_reaper. First of all all the process groups that share the
> > > > > address space have to be killed. How do you want to guarantee/implement
> > > > > that with a simply kill to a thread/process group?
> > > > 
> > > > Will task_will_free_mem() not bail out in such cases because of
> > > > process_shares_mm() returning true?
> > > 
> > > I am not really sure I understand your question. task_will_free_mem is
> > > just a shortcut to not kill anything if the current process or a victim
> > > is already dying and likely to free memory without killing or spamming
> > > the log. My concern is that this patch allows to invoke the reaper
> > 
> > Got it.
> > 
> > > without guaranteeing the same. So it can only be an optimistic attempt
> > > and then I am wondering how reasonable of an interface this really is.
> > > Userspace send the signal and has no way to find out whether the async
> > > reaping has been scheduled or not.
> > 
> > Could you clarify more what you're asking to guarantee? I cannot picture it.
> > If you mean guaranteeing that "a task is dying anyway and will free its
> > memory on its own", we are calling task_will_free_mem() to check that before
> > invoking the oom reaper.
> 
> No, I am talking about the API aspect. Say you kall kill with the flag
> to make the async address space tear down. Now you cannot really
> guarantee that this is safe to do because the target task might
> clone(CLONE_VM) at any time. So this will be known only once the signal
> is sent, but the calling process has no way to find out. So the caller
> has no way to know what is the actual result of the requested operation.
> That is a poor API in my book.
> 
> > Could you clarify what is the draback if OOM reaper is invoked in parallel to
> > an exiting task which will free its memory soon? It looks like the OOM reaper
> > is taking all the locks necessary (mmap_sem) in particular and is unmapping
> > pages. It seemed to me to be safe, but I am missing what are the main draw
> > backs of this - other than the intereference with core dump. One could be
> > presumably scalability since the since OOM reaper could be bottlenecked by
> > freeing memory on behalf of potentially several dying tasks.
> 
> oom_reaper or any other kernel thread doing the same is a mere
> implementation detail I think. The oom killer doesn't really need the
> oom_reaper to act swiftly because it is there to act as a last resort if
> the oom victim cannot terminate on its own. If you want to offer an
> user space API then you can assume users will like to use it and expect
> a certain behavior but what that is? E.g. what if there are thousands of
> tasks killed this way? Do we care that some of them will not get the
> async treatment? If yes why do we need an API to control that at all?
> 
> Am I more clear now?

Yes, your concerns are more clear now. We will think more about this and your
other responses, thanks a lot.

 - Joel

