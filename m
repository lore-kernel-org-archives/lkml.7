Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9611C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 19:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF15020661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 19:25:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LGEsQkRu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730400AbfCFTZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 14:25:07 -0500
Received: from mail-pf1-f172.google.com ([209.85.210.172]:45167 "EHLO
        mail-pf1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730045AbfCFTZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 14:25:06 -0500
Received: by mail-pf1-f172.google.com with SMTP id v21so9382458pfm.12
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 11:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=nIxVnIBmK5Dz7RvSx+eW2Kz/VSS3SsqySiZ+k2TYnLA=;
        b=LGEsQkRuKk2nAodt0UvUAYdMyaoJSgjpwYkitzQ9KextwOGqlwGrMqa0kdlzgad3Ua
         NV0d/7QI4alzP/2IWJK7guZcToVu7orgPrVgYTKEp/3HCq54xJlassVSDuewVkNuirqw
         /h6amjiomdILQHwmNurAPXdUjYaGPFQttc30jT0+jhkj+NTOT7uQkpTo50fZfE5w6v8w
         41AhF0g3hEVU3oIeD+DQY84FrNN9rNe0z0f3J3V9SS7ozINa6gOF2TzJ2+M83wfR4fws
         Fhpy8P+scfHSgg38GVQmdG8TG1XmFAMM735n4BVuK5qNdbMIyiz6gZxAnYy4fqFKlE36
         BK7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=nIxVnIBmK5Dz7RvSx+eW2Kz/VSS3SsqySiZ+k2TYnLA=;
        b=GBGLFDKD09lg7mdidhkD/ufI23uULvU5QpMAWc8kz6a5tSUx7mHNtBAPq7HD/65F8p
         O7A3x40pE63LZCQQ08rDZqGLEmz6WDVdrRtm8Qa3qP/cZoOpMZ+PemSKvZlAinIDMjv+
         pbzyG4aFzRfoOb5624tUhBjUFBePLQk9OEqX5M3OI5lsnXWGay5hAsLmdrOiUGbNzUvu
         shSoUUpzh0SKHSIVKTEE1HSEax5eSoBvPxzJU2/Drv3rOvZs/uaviD7dDWqmpdz/9hD4
         1Q5Hm3nZ25iZgBdwamb8H2YNLpGLl5d5pQgcJ5IRBVbb0MSWh0UeFitCmEPJlIFKRTaE
         rZUw==
X-Gm-Message-State: APjAAAUSt9hvNj1QHk+np75KQ1GEkU+9sZX7S/T4XNKtRrQkXtaYdX7/
        6w6uCO5IxhepEfycePbMR+v8Gi7eLFo=
X-Google-Smtp-Source: APXvYqzFguaQgiqaG8GW3LoLKcUhuz+DCx2pkN+baO5Rye/WE0Otiy10+sbTpj23LPbpHQHKZdUQfw==
X-Received: by 2002:a17:902:14b:: with SMTP id 69mr3899090plb.216.1551900305122;
        Wed, 06 Mar 2019 11:25:05 -0800 (PST)
Received: from bsegall-linux.svl.corp.google.com.localhost ([2620:15c:2cd:202:39d7:98b3:2536:e93f])
        by smtp.gmail.com with ESMTPSA id g12sm4489992pgr.76.2019.03.06.11.25.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Mar 2019 11:25:03 -0800 (PST)
From:   bsegall@google.com
To:     Phil Auld <pauld@redhat.com>
Cc:     mingo@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC]  sched/fair: hard lockup in sched_cfs_period_timer
References: <20190301145209.GA9304@pauld.bos.csb>
        <xm26ef7mzew2.fsf@bsegall-linux.svl.corp.google.com>
        <20190304190510.GB5366@lorien.usersys.redhat.com>
        <xm268sxtyx5u.fsf@bsegall-linux.svl.corp.google.com>
        <20190305200554.GA8786@pauld.bos.csb>
        <xm261s3lyrrl.fsf@bsegall-linux.svl.corp.google.com>
        <20190306162313.GB8786@pauld.bos.csb>
Date:   Wed, 06 Mar 2019 11:25:02 -0800
In-Reply-To: <20190306162313.GB8786@pauld.bos.csb> (Phil Auld's message of
        "Wed, 6 Mar 2019 11:23:13 -0500")
Message-ID: <xm26wolbyfe9.fsf@bsegall-linux.svl.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Phil Auld <pauld@redhat.com> writes:

> On Tue, Mar 05, 2019 at 12:45:34PM -0800 bsegall@google.com wrote:
>> Phil Auld <pauld@redhat.com> writes:
>> 
>> > Interestingly, if I limit the number of child cgroups to the number of 
>> > them I'm actually putting processes into (16 down from 2500) the problem
>> > does not reproduce.
>> 
>> That is indeed interesting, and definitely not something we'd want to
>> matter. (Particularly if it's not root->a->b->c...->throttled_cgroup or
>> root->throttled->a->...->thread vs root->throttled_cgroup, which is what
>> I was originally thinking of)
>> 
>
> The locking may be a red herring.
>
> The setup is root->throttled->a where a is 1-2500. There are 4 threads in
> each of the first 16 a groups.  The parent, throttled, is where the 
> cfs_period/quota_us are set. 
>
> I wonder if the problem is the walk_tg_tree_from() call in unthrottle_cfs_rq(). 
>
> The distribute_cfg_runtime looks to be O(n * m) where n is number of 
> throttled cfs_rqs and m is the number of child cgroups. But I'm not 
> completely clear on how the hierarchical cgroups play together here. 
>
> I'll pull on this thread some. 
>
> Thanks for your input.
>
>
> Cheers,
> Phil

Yeah, that isn't under the cfs_b lock, but is still part of distribute
(and under rq lock, which might also matter). I was thinking too much
about just the cfs_b regions. I'm not sure there's any good general
optimization there.

I suppose cfs_rqs (tgs/cfs_bs?) could have "nearest
ancestor with a quota" pointer and ones with quota could have
"descendants with quota" list, parallel to the children/parent lists of
tgs. Then throttle/unthrottle would only have to visit these lists, and
child cgroups/cfs_rqs without their own quotas would just check
cfs_rq->nearest_quota_cfs_rq->throttle_count. throttled_clock_task_time
can also probably be tracked there.
