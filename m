Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03CFFC282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 20:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C39C02184E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 20:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555013851;
	bh=cY11zXMWgcpfGmOqQQdpPaP50jGVFwnpzYLSnHkYbwI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jkevv8BL5bBpiq0euWHuPd+PxnpmmciJkKf0FIg3nTgFnQJxOYtEAvTdkV3ZkJusg
	 s8pP4A+egJlT4rqvLszStz8FZak3K3ar6SNpcDQd8s8UHpGSsiXxQJCTX3+OpBpBPX
	 Z+C19nbTf3FYjx+vf+Z8VnI26zdASkN0kQZHz+Qs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbfDKURa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 16:17:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:41810 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726538AbfDKUR3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 16:17:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 782F4ADD8;
        Thu, 11 Apr 2019 20:17:28 +0000 (UTC)
Date:   Thu, 11 Apr 2019 22:17:27 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        yuzhoujian@didichuxing.com,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Shakeel Butt <shakeelb@google.com>,
        Christian Brauner <christian@brauner.io>,
        Minchan Kim <minchan@kernel.org>,
        Tim Murray <timmurray@google.com>,
        Daniel Colascione <dancol@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jann Horn <jannh@google.com>, linux-mm <linux-mm@kvack.org>,
        lsf-pc@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Subject: Re: [RFC 0/2] opportunistic memory reclaim of a killed process
Message-ID: <20190411201727.GB4743@dhcp22.suse.cz>
References: <20190411014353.113252-1-surenb@google.com>
 <20190411105111.GR10383@dhcp22.suse.cz>
 <CAJuCfpEqCKSHwAmR_TR3FaQzb=jkPH1nvzvkhAG57=Pb09GVrA@mail.gmail.com>
 <20190411181946.GC10383@dhcp22.suse.cz>
 <CAJuCfpERmBzCpRTj5W1929OOiVEjcdBoSAsYXiYKoq0gsgRyhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpERmBzCpRTj5W1929OOiVEjcdBoSAsYXiYKoq0gsgRyhg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 11-04-19 12:56:32, Suren Baghdasaryan wrote:
> On Thu, Apr 11, 2019 at 11:19 AM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Thu 11-04-19 09:47:31, Suren Baghdasaryan wrote:
> > [...]
> > > > I would question whether we really need this at all? Relying on the exit
> > > > speed sounds like a fundamental design problem of anything that relies
> > > > on it.
> > >
> > > Relying on it is wrong, I agree. There are protections like allocation
> > > throttling that we can fall back to stop memory depletion. However
> > > having a way to free up resources that are not needed by a dying
> > > process quickly would help to avoid throttling which hurts user
> > > experience.
> >
> > I am not opposing speeding up the exit time in general. That is a good
> > thing. Especially for a very large processes (e.g. a DB). But I do not
> > really think we want to expose an API to control this specific aspect.
> 
> Great! Thanks for confirming that the intent is not worthless.
> There were a number of ideas floating both internally and in the 2/2
> of this patchset. I would like to get some input on which
> implementation would be preferable. From your answer sounds like you
> think it should be a generic feature, should not require any new APIs
> or hints from the userspace and should be conducted for all kills
> unconditionally (irrespective of memory pressure, who is waiting for
> victim's death, etc.). Do I understand correctly that this would be
> the preferred solution?

Yes, I think the general tear down solution is much more preferable than
a questionable API. How that solution should look like is an open
question. I am not sure myself to be honest.
-- 
Michal Hocko
SUSE Labs
