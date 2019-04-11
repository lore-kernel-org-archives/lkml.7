Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE98EC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 10:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F67820850
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 10:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554979876;
	bh=xNcr/tZnY/by7Ns11RNAqREt4bqBYyWXV39RzwPxPBc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=C8PwmWDTZh0+s7yY1qGfP0on98vj3TY99EKwu5GQ7sYKL5rz3an/qNmTnQtYh5TVJ
	 K486zcLm60jPd/8gAwKFfx7jDCoE05gpTk+ulaP2PsA9iBjMhJlwv/Gwi2t/jvbPJu
	 cKgZPcff7OvDUfnT0TGctEFV3tWimTYoQFagp9Ak=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbfDKKvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 06:51:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:35404 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726640AbfDKKvO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 06:51:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 58915ABAC;
        Thu, 11 Apr 2019 10:51:13 +0000 (UTC)
Date:   Thu, 11 Apr 2019 12:51:11 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, rientjes@google.com,
        willy@infradead.org, yuzhoujian@didichuxing.com,
        jrdr.linux@gmail.com, guro@fb.com, hannes@cmpxchg.org,
        penguin-kernel@I-love.SAKURA.ne.jp, ebiederm@xmission.com,
        shakeelb@google.com, christian@brauner.io, minchan@kernel.org,
        timmurray@google.com, dancol@google.com, joel@joelfernandes.org,
        jannh@google.com, linux-mm@kvack.org,
        lsf-pc@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [RFC 0/2] opportunistic memory reclaim of a killed process
Message-ID: <20190411105111.GR10383@dhcp22.suse.cz>
References: <20190411014353.113252-1-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190411014353.113252-1-surenb@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 10-04-19 18:43:51, Suren Baghdasaryan wrote:
[...]
> Proposed solution uses existing oom-reaper thread to increase memory
> reclaim rate of a killed process and to make this rate more deterministic.
> By no means the proposed solution is considered the best and was chosen
> because it was simple to implement and allowed for test data collection.
> The downside of this solution is that it requires additional “expedite”
> hint for something which has to be fast in all cases. Would be great to
> find a way that does not require additional hints.

I have to say I do not like this much. It is abusing an implementation
detail of the OOM implementation and makes it an official API. Also
there are some non trivial assumptions to be fullfilled to use the
current oom_reaper. First of all all the process groups that share the
address space have to be killed. How do you want to guarantee/implement
that with a simply kill to a thread/process group?

> Other possible approaches include:
> - Implementing a dedicated syscall to perform opportunistic reclaim in the
> context of the process waiting for the victim’s death. A natural boost
> bonus occurs if the waiting process has high or RT priority and is not
> limited by cpuset cgroup in its CPU choices.
> - Implement a mechanism that would perform opportunistic reclaim if it’s
> possible unconditionally (similar to checks in task_will_free_mem()).
> - Implement opportunistic reclaim that uses shrinker interface, PSI or
> other memory pressure indications as a hint to engage.

I would question whether we really need this at all? Relying on the exit
speed sounds like a fundamental design problem of anything that relies
on it. Sure task exit might be slow, but async mm tear down is just a
mere optimization this is not guaranteed to really help in speading
things up. OOM killer uses it as a guarantee for a forward progress in a
finite time rather than as soon as possible.

-- 
Michal Hocko
SUSE Labs
