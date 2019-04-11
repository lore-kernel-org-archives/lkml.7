Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 385E9C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 19:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F30102083E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 19:14:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="ia3huphr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfDKTOf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 15:14:35 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40957 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbfDKTOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 15:14:35 -0400
Received: by mail-pf1-f196.google.com with SMTP id c207so3909946pfc.7
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 12:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=jbC8xetEJpz5qCoylXvogaDQzUVgXMuKyGOB5cXC308=;
        b=ia3huphrOspf9u8RIw/c+ODureqTkw0avu8oKPFJ61uPtSePwnPonhu3vg3z33sVMg
         qsRgemWEItRmseDsDpEqpbvu/il0c7GaqwOFdwMMqls2+xLTWFPuOK4wigUnBbWVbSkL
         SLYBloSZALOpR2IqP1vI/TvWD+4paNjDsUkRE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=jbC8xetEJpz5qCoylXvogaDQzUVgXMuKyGOB5cXC308=;
        b=BDIy7ol+9YTboZN5GSZCamSbfx7RR1ZpsDy4GOTzBBpVopC9PzMPMczKdh6Sall84l
         kaal7v1+/4kYO4AT7qv0APle5idqThlr1Qz7Z9Tidy0wKAP6cV8ya0W0DQpfmUPPHeeY
         HVIAuLG/sJf+diJVys2Jyf87O+zPVD2U7xM8w/eP9XHjtcHbe+1u0O3LRAWgB9Uzm9yM
         J7g4pIpViscp03EHgiMPr+kVscnNzkJmfm1qlhg9pywFfESS3rFXrHVegC547WoSZ0nq
         +TBg8FrLTx5hAoBn82e+tS7W6z/2lnzggrrzffKFWzyKtAQSXiVMPupUk6+G60OF/1ly
         Bw+w==
X-Gm-Message-State: APjAAAUMMc2a6lhLcY7Rf9uWjk3AljGEF+PYCq+Qlgyh0K8PIa+dWOgk
        BTM0EWyWYVQorN15K8AtTdwXCQ==
X-Google-Smtp-Source: APXvYqwDRYJr8j+3gj9Y7YLUM5aUAcJ0bISd6C8+u+eZPyWPILU4906GJsYaezHtsWzaFxOGw/0fRA==
X-Received: by 2002:a63:7153:: with SMTP id b19mr46989049pgn.289.1555010073275;
        Thu, 11 Apr 2019 12:14:33 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id w3sm82743762pfn.179.2019.04.11.12.14.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Apr 2019 12:14:32 -0700 (PDT)
Date:   Thu, 11 Apr 2019 15:14:30 -0400
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
Message-ID: <20190411191430.GA46425@google.com>
References: <20190411014353.113252-1-surenb@google.com>
 <20190411105111.GR10383@dhcp22.suse.cz>
 <CAJWu+oq45tYxXJpLPLAU=-uZaYRg=OnxMHkgp2Rm0nbShb_eEA@mail.gmail.com>
 <20190411181243.GB10383@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190411181243.GB10383@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 08:12:43PM +0200, Michal Hocko wrote:
> On Thu 11-04-19 12:18:33, Joel Fernandes wrote:
> > On Thu, Apr 11, 2019 at 6:51 AM Michal Hocko <mhocko@kernel.org> wrote:
> > >
> > > On Wed 10-04-19 18:43:51, Suren Baghdasaryan wrote:
> > > [...]
> > > > Proposed solution uses existing oom-reaper thread to increase memory
> > > > reclaim rate of a killed process and to make this rate more deterministic.
> > > > By no means the proposed solution is considered the best and was chosen
> > > > because it was simple to implement and allowed for test data collection.
> > > > The downside of this solution is that it requires additional “expedite”
> > > > hint for something which has to be fast in all cases. Would be great to
> > > > find a way that does not require additional hints.
> > >
> > > I have to say I do not like this much. It is abusing an implementation
> > > detail of the OOM implementation and makes it an official API. Also
> > > there are some non trivial assumptions to be fullfilled to use the
> > > current oom_reaper. First of all all the process groups that share the
> > > address space have to be killed. How do you want to guarantee/implement
> > > that with a simply kill to a thread/process group?
> > 
> > Will task_will_free_mem() not bail out in such cases because of
> > process_shares_mm() returning true?
> 
> I am not really sure I understand your question. task_will_free_mem is
> just a shortcut to not kill anything if the current process or a victim
> is already dying and likely to free memory without killing or spamming
> the log. My concern is that this patch allows to invoke the reaper

Got it.

> without guaranteeing the same. So it can only be an optimistic attempt
> and then I am wondering how reasonable of an interface this really is.
> Userspace send the signal and has no way to find out whether the async
> reaping has been scheduled or not.

Could you clarify more what you're asking to guarantee? I cannot picture it.
If you mean guaranteeing that "a task is dying anyway and will free its
memory on its own", we are calling task_will_free_mem() to check that before
invoking the oom reaper.

Could you clarify what is the draback if OOM reaper is invoked in parallel to
an exiting task which will free its memory soon? It looks like the OOM reaper
is taking all the locks necessary (mmap_sem) in particular and is unmapping
pages. It seemed to me to be safe, but I am missing what are the main draw
backs of this - other than the intereference with core dump. One could be
presumably scalability since the since OOM reaper could be bottlenecked by
freeing memory on behalf of potentially several dying tasks.

IIRC this patch is just Ok with being opportunistic and it need not be hidden
behind an API necessarily or need any guarantees. It is just providing a hint
that the OOM reaper could be woken up to expedite things. If a task is going
to be taking a long time to be scheduled and free its memory, the oom reaper
gives a headstart.  Many of the times, background tasks can be killed but
they may not have necessarily sufficient scheduler priority / cpuset (being
in the background) and may be holding onto a lot of memory that needs to be
reclaimed.

I am not saying this the right way to do it, but I also wanted us to
understand the drawbacks so that we can go back to the drawing board and come
up with something better.

Thanks!

 - Joel




