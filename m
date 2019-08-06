Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24CA4C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 11:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F23AA2173B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 11:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565089233;
	bh=67vO3QJb1zoj/0VMyLLRdXE0aD2Y2MoYTpLFcYt04Gk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UvrZB/kxvEs/yW3CazETx3s84AR7K/XPfkoKJPA8TGfJG6BZbT5eij5l+eKr9n3E3
	 OGBCbbzdkopnT+a1/aKKMRJkHKrq3I5zBFtuE7Oh0L20sPu7wGVnz03Qbv3Dnjq083
	 oxyR90f/hzmD7HTf5Q6lMoacMRhpZNzW4lPYeSKA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732694AbfHFLAb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 07:00:31 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37229 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730902AbfHFLAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 07:00:31 -0400
Received: by mail-pg1-f193.google.com with SMTP id d1so8585815pgp.4
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 04:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ey/TDb+j3ulf/Kh0DyGVxExM26fXVHaeQeTsCyT/hWk=;
        b=KEqUYzrwilv1Xix2/euOGauUH6pBzvZDAJ4XqIXBsBhfjllP1rTaC1iedXkybgFWVI
         NuMwON0aP//RoKcdjSA3dRQrQKNvYN/1Y2MYcf940QORKaAvbupp2Dx6yWU5xmTL4Th5
         vlOw7wW8DQtzPv1skB7m53NKoknnmnnaScTAb2DBaq3uglPOGK3lJFdmoFgPzMybnbMq
         TTvdH3aS0wrGOwWIPqGP1qwP9Qz31APO31T9pIgCWihZj5ZZ24R14KIZdixbp3KuerIR
         SZrwo0GgH7W1mjrvAYXO7Ry7+OPPirPAZpeoopuq+ieLHQIjfaH0uej/b0BprddCl/LC
         topg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ey/TDb+j3ulf/Kh0DyGVxExM26fXVHaeQeTsCyT/hWk=;
        b=lH27o5X/IzGzeyyl/lWVR1O7nGaAGv4rcQmJTXWtMEYiI+n84qES+qH34Foj1mI6Dy
         fVsiLDy53IdwSs8gwZA8DxA4RUPZ4aJnWOcTpEnGJpWpYS78cmynnVJueuvBGsz1Uvvu
         b4iXLgMW+olTw7WXymClZbrl8/LNHaFV4S4hHXJoi1EBSnNp1zNz02e3p1Ytk+cWY7hz
         IUz0c/trMncRkvFYpAgII33U/vkCDV2q9g7qhOPNNOrgRhZkW9jTbWq+hEZzvn3KHyFh
         7xLjuQthbSRemwx3FyQt2WU8Cyovwy5cnf5Z3VQvjMqRkWi2a2Q6ufsCf5VXjx5hHkah
         nqNw==
X-Gm-Message-State: APjAAAX9SROzF9vAladN72jEvy9JZ0yl4Xjf+/Of3uKc/4GvmSIO3arV
        BSDb0TSP6R9AjDUoXK1UCYs=
X-Google-Smtp-Source: APXvYqwA3k4rZRoc3mC70Gp392chl8mhMwWXeW4M2H/sluIt/TX1w6gunuu5hlyUCqDil/zBoqvVGg==
X-Received: by 2002:a17:90a:bb8b:: with SMTP id v11mr2575447pjr.64.1565089230260;
        Tue, 06 Aug 2019 04:00:30 -0700 (PDT)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id p1sm92628404pff.74.2019.08.06.04.00.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 04:00:29 -0700 (PDT)
Date:   Tue, 6 Aug 2019 20:00:24 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Miguel de Dios <migueldedios@google.com>,
        Wei Wang <wvw@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@techsingularity.net>, lkp@01.org
Subject: Re: [mm]  755d6edc1a:  will-it-scale.per_process_ops -4.1% regression
Message-ID: <20190806110024.GA32615@google.com>
References: <20190729071037.241581-1-minchan@kernel.org>
 <20190806070547.GA10123@xsang-OptiPlex-9020>
 <20190806080415.GG11812@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806080415.GG11812@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 10:04:15AM +0200, Michal Hocko wrote:
> On Tue 06-08-19 15:05:47, kernel test robot wrote:
> > Greeting,
> > 
> > FYI, we noticed a -4.1% regression of will-it-scale.per_process_ops due to commit:
> 
> I have to confess I cannot make much sense from numbers because they
> seem to be too volatile and the main contributor doesn't stand up for
> me. Anyway, regressions on microbenchmarks like this are not all that
> surprising when a locking is slightly changed and the critical section
> made shorter. I have seen that in the past already.

I guess if it's multi process workload. The patch will give more chance
to be scheduled out so TLB miss ratio would be bigger than old.
I see it's natural trade-off for latency vs. performance so only thing
I could think is just increase threshold from 32 to 64 or 128?

> 
> That being said I would still love to get to bottom of this bug rather
> than play with the lock duration by a magic. In other words
> http://lkml.kernel.org/r/20190730125751.GS9330@dhcp22.suse.cz

Yes, if we could remove mark_page_accessed there, it would be best.
I added a commen in the thread.
