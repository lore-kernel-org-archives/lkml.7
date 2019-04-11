Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D2F4C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 18:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07E5C2084D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 18:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555006790;
	bh=erla34GshncnxpolJ449wDmS39PvkK4ufukuKwAHXts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wITwWrb4LrP+2GCtaQw6TbncK/t7wEUFH8tIE0ptlnVDC9ptkBm7lEgSa1ZtjAeok
	 HycMEh69UsSXyvJOtmHx+xDIWXaJmfVBtiq05tod+GkbNwR5zT7eYjyvNA9Mp08/s0
	 x7Nn+7lAWsrx6FnY8F2FCcQ6AR5jZeC+knerPYwc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfDKSTs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 14:19:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:36728 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726577AbfDKSTs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 14:19:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1E593AD3E;
        Thu, 11 Apr 2019 18:19:47 +0000 (UTC)
Date:   Thu, 11 Apr 2019 20:19:46 +0200
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
        ebiederm@xmission.com, Shakeel Butt <shakeelb@google.com>,
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
Message-ID: <20190411181946.GC10383@dhcp22.suse.cz>
References: <20190411014353.113252-1-surenb@google.com>
 <20190411105111.GR10383@dhcp22.suse.cz>
 <CAJuCfpEqCKSHwAmR_TR3FaQzb=jkPH1nvzvkhAG57=Pb09GVrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpEqCKSHwAmR_TR3FaQzb=jkPH1nvzvkhAG57=Pb09GVrA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 11-04-19 09:47:31, Suren Baghdasaryan wrote:
[...]
> > I would question whether we really need this at all? Relying on the exit
> > speed sounds like a fundamental design problem of anything that relies
> > on it.
> 
> Relying on it is wrong, I agree. There are protections like allocation
> throttling that we can fall back to stop memory depletion. However
> having a way to free up resources that are not needed by a dying
> process quickly would help to avoid throttling which hurts user
> experience.

I am not opposing speeding up the exit time in general. That is a good
thing. Especially for a very large processes (e.g. a DB). But I do not
really think we want to expose an API to control this specific aspect.
-- 
Michal Hocko
SUSE Labs
