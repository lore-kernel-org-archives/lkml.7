Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F643C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 18:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2D672084D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 18:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555006368;
	bh=96jafUIENx1PPCwDS/x5yEN1lOtiAlERND6FtWwJDcs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NPIL97dYPEuD1aQVDtSEQlKnohfFQ3K3b5QMN9Qh2D7JOPJqETlCg1sQyB+8DWeXa
	 z+yJCD16uqehmXZpp9VDKEc0OcFNi9g1s2UyWuhdB1w2ISUEsl0wGMPuCxA7NGNJsA
	 33a7A9yfdOc75Jz56udDhj04Rg7sm/VWQ+ys17PA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfDKSMr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 14:12:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:35006 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726599AbfDKSMr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 14:12:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 89FBEAD37;
        Thu, 11 Apr 2019 18:12:45 +0000 (UTC)
Date:   Thu, 11 Apr 2019 20:12:43 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Joel Fernandes <joelaf@google.com>
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
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Jann Horn <jannh@google.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        lsf-pc@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>
Subject: Re: [RFC 0/2] opportunistic memory reclaim of a killed process
Message-ID: <20190411181243.GB10383@dhcp22.suse.cz>
References: <20190411014353.113252-1-surenb@google.com>
 <20190411105111.GR10383@dhcp22.suse.cz>
 <CAJWu+oq45tYxXJpLPLAU=-uZaYRg=OnxMHkgp2Rm0nbShb_eEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJWu+oq45tYxXJpLPLAU=-uZaYRg=OnxMHkgp2Rm0nbShb_eEA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 11-04-19 12:18:33, Joel Fernandes wrote:
> On Thu, Apr 11, 2019 at 6:51 AM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Wed 10-04-19 18:43:51, Suren Baghdasaryan wrote:
> > [...]
> > > Proposed solution uses existing oom-reaper thread to increase memory
> > > reclaim rate of a killed process and to make this rate more deterministic.
> > > By no means the proposed solution is considered the best and was chosen
> > > because it was simple to implement and allowed for test data collection.
> > > The downside of this solution is that it requires additional “expedite”
> > > hint for something which has to be fast in all cases. Would be great to
> > > find a way that does not require additional hints.
> >
> > I have to say I do not like this much. It is abusing an implementation
> > detail of the OOM implementation and makes it an official API. Also
> > there are some non trivial assumptions to be fullfilled to use the
> > current oom_reaper. First of all all the process groups that share the
> > address space have to be killed. How do you want to guarantee/implement
> > that with a simply kill to a thread/process group?
> 
> Will task_will_free_mem() not bail out in such cases because of
> process_shares_mm() returning true?

I am not really sure I understand your question. task_will_free_mem is
just a shortcut to not kill anything if the current process or a victim
is already dying and likely to free memory without killing or spamming
the log. My concern is that this patch allows to invoke the reaper
without guaranteeing the same. So it can only be an optimistic attempt
and then I am wondering how reasonable of an interface this really is.
Userspace send the signal and has no way to find out whether the async
reaping has been scheduled or not.
-- 
Michal Hocko
SUSE Labs
