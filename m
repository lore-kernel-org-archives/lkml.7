Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88914C282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 12:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C6E62184B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 12:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554985001;
	bh=RETkbUAKWSStRRemgTx5lYN/eP08HJMZMrTfdszVBXA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IyPYCYGhnb+YqLGAehOXKzlXt4FRN7O7XVch2YJJSc/pEErEEmWrJPKh4+WqsTJZQ
	 JtizPrY/QaQfWv2J/LZHVWBpVDuBsNW6UQK4a7//4qoewNFoPCksXtRS39o1IyLRSh
	 f+Ze2x+ReWq0lpBwTP5r+OJr/4id/VLdSDwPhtaI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfDKMQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 08:16:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:50314 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726073AbfDKMQj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 08:16:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 80279AC4C;
        Thu, 11 Apr 2019 12:16:37 +0000 (UTC)
Date:   Thu, 11 Apr 2019 14:16:33 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Rik van Riel <riel@surriel.com>
Cc:     Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
        dancol@google.com, jannh@google.com, minchan@kernel.org,
        penguin-kernel@I-love.SAKURA.ne.jp, kernel-team@android.com,
        rientjes@google.com, linux-kernel@vger.kernel.org,
        willy@infradead.org, linux-mm@kvack.org, hannes@cmpxchg.org,
        shakeelb@google.com, jrdr.linux@gmail.com,
        yuzhoujian@didichuxing.com, joel@joelfernandes.org,
        timmurray@google.com, lsf-pc@lists.linux-foundation.org,
        guro@fb.com, christian@brauner.io, ebiederm@xmission.com
Subject: Re: [Lsf-pc] [RFC 0/2] opportunistic memory reclaim of a killed
 process
Message-ID: <20190411121633.GV10383@dhcp22.suse.cz>
References: <20190411014353.113252-1-surenb@google.com>
 <e1fc2c84f5ef2e1408f6fee7228a52a458990b31.camel@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1fc2c84f5ef2e1408f6fee7228a52a458990b31.camel@surriel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 11-04-19 07:51:21, Rik van Riel wrote:
> On Wed, 2019-04-10 at 18:43 -0700, Suren Baghdasaryan via Lsf-pc wrote:
> > The time to kill a process and free its memory can be critical when
> > the
> > killing was done to prevent memory shortages affecting system
> > responsiveness.
> 
> The OOM killer is fickle, and often takes a fairly
> long time to trigger. Speeding up what happens after
> that seems like the wrong thing to optimize.
> 
> Have you considered using something like oomd to
> proactively kill tasks when memory gets low, so
> you do not have to wait for an OOM kill?

AFAIU, this is the point here. They probably have a user space OOM
killer implementation and want to achieve killing to be as swift as
possible.

-- 
Michal Hocko
SUSE Labs
