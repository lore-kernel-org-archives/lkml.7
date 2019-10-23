Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAEA9CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 17:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A079121928
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 17:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="uo+vdPpQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732598AbfJWR51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 13:57:27 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39372 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbfJWR51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 13:57:27 -0400
Received: by mail-qk1-f194.google.com with SMTP id 4so20615300qki.6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 10:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wxnBd+F8Nf7wSyQxckHqdi1Fetryll1VVy13XOaIum4=;
        b=uo+vdPpQUGBdDsiOxiU5xzOq3ciq7/h61CPNrbHH6bEnPeZWi70jwzdXokMQ61oSK8
         rTXtFa0lcLXkvqhPULewxxxUtDFV4OdEKkF+3MtGAq3oD4t33ui3rlQmryCA5dHrhbH8
         1L/cOeBr+WvWi8jookl/mPz73fiJY5q2vVKtTsEiemt5411aG6pJeH0tzuqwBPlB2WVx
         GkS5UYatQVBGvg4CBUNn/DBINBMX4y6slxramY0g2OZMbSZhGy9Ery80tGLSo5VV6+z0
         zsvnWlfB8EpmVZSz4gPBC5XrCPkY+2/OWD0KhmrzKkgZHDoG8tL1Vn0iasFo8DSuLlM/
         84Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wxnBd+F8Nf7wSyQxckHqdi1Fetryll1VVy13XOaIum4=;
        b=b51clWvz5C8+JNdpbSwfyibrBK6JjrnjSdDNGQAVXAMD3qk0Bk9Hk7JmHCL45z3N7p
         uEqhm3wOD+hxU0YUWlcGa6LAQNVJrUO6lREdUMHTrLQbK1GnV8WeuOApic2597Db/aGY
         cq9/QCyjyOcKvFjNR4S+GTh4cCAmp+IH/LGs82i3tSco4Jm9XTaAgKe+HplOaLzYWnEL
         4R0Iyx1MDd26ciyNATKcTQaltHTZLsImIxxfhjfP5HUg/cakeRp0iME8r476CEIXzEdy
         HmGMjvuK8Xkbw0KGsWhrbo9Eni9qWsl1kUCNLqvIppQOYhj40CD5sy4H0Ie3v4HCW2zr
         vFDg==
X-Gm-Message-State: APjAAAWx3I9V9Op8yVhQIHm0O7mrLkFB11/oPPTFXKeVuDgCSthHCqFi
        8rO+ISYruEJuFszg+oN9RwhaalAogqk=
X-Google-Smtp-Source: APXvYqxYbgcO74tp3k4i+lmIz9XorffsmYUz6wGRkYQdXBMa1aSlDHfIgcUcydeXFQhdMxs6OJ36wQ==
X-Received: by 2002:a05:620a:140c:: with SMTP id d12mr2216973qkj.375.1571853446084;
        Wed, 23 Oct 2019 10:57:26 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:c4de])
        by smtp.gmail.com with ESMTPSA id 81sm15001008qkd.73.2019.10.23.10.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 10:57:25 -0700 (PDT)
Date:   Wed, 23 Oct 2019 13:57:24 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 2/2] mm: memcontrol: try harder to set a new memory.high
Message-ID: <20191023175724.GD366316@cmpxchg.org>
References: <20191022201518.341216-1-hannes@cmpxchg.org>
 <20191022201518.341216-2-hannes@cmpxchg.org>
 <20191023065949.GD754@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023065949.GD754@dhcp22.suse.cz>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 08:59:49AM +0200, Michal Hocko wrote:
> On Tue 22-10-19 16:15:18, Johannes Weiner wrote:
> > Setting a memory.high limit below the usage makes almost no effort to
> > shrink the cgroup to the new target size.
> > 
> > While memory.high is a "soft" limit that isn't supposed to cause OOM
> > situations, we should still try harder to meet a user request through
> > persistent reclaim.
> > 
> > For example, after setting a 10M memory.high on an 800M cgroup full of
> > file cache, the usage shrinks to about 350M:
> > 
> > + cat /cgroup/workingset/memory.current
> > 841568256
> > + echo 10M
> > + cat /cgroup/workingset/memory.current
> > 355729408
> > 
> > This isn't exactly what the user would expect to happen. Setting the
> > value a few more times eventually whittles the usage down to what we
> > are asking for:
> > 
> > + echo 10M
> > + cat /cgroup/workingset/memory.current
> > 104181760
> > + echo 10M
> > + cat /cgroup/workingset/memory.current
> > 31801344
> > + echo 10M
> > + cat /cgroup/workingset/memory.current
> > 10440704
> > 
> > To improve this, add reclaim retry loops to the memory.high write()
> > callback, similar to what we do for memory.max, to make a reasonable
> > effort that the usage meets the requested size after the call returns.
> 
> That suggests that the reclaim couldn't meet the given reclaim target
> but later attempts just made it through. Is this due to amount of dirty
> pages or what prevented the reclaim to do its job?
> 
> While I am not against the reclaim retry loop I would like to understand
> the underlying issue. Because if this is really about dirty memory then
> we should probably be more pro-active in flushing it. Otherwise the
> retry might not be of any help.

All the pages in my test case are clean cache. But they are active,
and they need to go through the inactive list before reclaiming. The
inactive list size is designed to pre-age just enough pages for
regular reclaim targets, i.e. pages in the SWAP_CLUSTER_MAX ballpark,
In this case, the reclaim goal for a single invocation is 790M and the
inactive list is a small funnel to put all that through, and we need
several iterations to accomplish that.

But 790M is not a reasonable reclaim target to ask of a single reclaim
invocation. And it wouldn't be reasonable to optimize the reclaim code
for it. So asking for the full size but retrying is not a bad choice
here: we express our intent, and benefit if reclaim becomes better at
handling larger requests, but we also acknowledge that some of the
deltas we can encounter in memory_high_write() are just too
ridiculously big for a single reclaim invocation to manage.
