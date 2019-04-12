Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3FAAC282CE
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 06:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 804062077C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 06:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555051998;
	bh=EcTuRdda4ii5j6K0LpuZIYhpRXNvT8pk6CXn0wkNiQg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Qg4bDGQG12Q2QXxyt5Dh/O5F5RBojSBRu/Q/PC7n5qGwyYOdAzBWPrsCSLDr6GLHP
	 cygjtm0fpIBMNEpz25FafRqa4m9qJnqY7bc0kq81VlzlKYi7DBwXCz3XMDlh3RQczL
	 2H5kmZySjJ10XxcoS9VtIvPlvsQgC+2/pSQJzn9c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfDLGxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 02:53:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:58002 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726101AbfDLGxQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 02:53:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 786A0ADDB;
        Fri, 12 Apr 2019 06:53:15 +0000 (UTC)
Date:   Fri, 12 Apr 2019 08:53:14 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
        rientjes@google.com, yuzhoujian@didichuxing.com,
        jrdr.linux@gmail.com, guro@fb.com, hannes@cmpxchg.org,
        penguin-kernel@I-love.SAKURA.ne.jp, ebiederm@xmission.com,
        shakeelb@google.com, christian@brauner.io, minchan@kernel.org,
        timmurray@google.com, dancol@google.com, joel@joelfernandes.org,
        jannh@google.com, linux-mm@kvack.org,
        lsf-pc@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [RFC 2/2] signal: extend pidfd_send_signal() to allow expedited
 process killing
Message-ID: <20190412065314.GC13373@dhcp22.suse.cz>
References: <20190411014353.113252-1-surenb@google.com>
 <20190411014353.113252-3-surenb@google.com>
 <20190411153313.GE22763@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190411153313.GE22763@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 11-04-19 08:33:13, Matthew Wilcox wrote:
> On Wed, Apr 10, 2019 at 06:43:53PM -0700, Suren Baghdasaryan wrote:
> > Add new SS_EXPEDITE flag to be used when sending SIGKILL via
> > pidfd_send_signal() syscall to allow expedited memory reclaim of the
> > victim process. The usage of this flag is currently limited to SIGKILL
> > signal and only to privileged users.
> 
> What is the downside of doing expedited memory reclaim?  ie why not do it
> every time a process is going to die?
 
Well, you are tearing down an address space which might be still in use
because the task not fully dead yeat. So there are two downsides AFAICS.
Core dumping which will not see the reaped memory so the resulting
coredump might be incomplete. And unexpected #PF/gup on the reaped
memory will result in SIGBUS. These are things that we have closed our
eyes in the oom context because they likely do not matter. If we want to
use the same technique for other usecases then we have to think how much
that matter again.

-- 
Michal Hocko
SUSE Labs
