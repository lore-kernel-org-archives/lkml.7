Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A52BEC3A59E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 02:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 783B721881
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 02:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567476796;
	bh=MGWnnNpt/jAdYDDOqjF27U82L4grjDc9Cm4We8Qa6YI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=q+mrMaCFdX/4+T9ZOrOYDMQAdj/36NIpvUxX7pZ6OFWkeOtsKkrI6s3gW7afGFYaM
	 B3PkUA/qK9XsLMs+Ol9zZskYYyhTsXYDJB+O2v031jkykteVlPtztLhd2zyTPa1bo5
	 8vL/urswUAqByljMqpgE6Q/7xXiUcAgl8gKbIT4M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfICCNP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 22:13:15 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43384 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbfICCNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 22:13:15 -0400
Received: by mail-pf1-f194.google.com with SMTP id d15so285226pfo.10
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 19:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3VInfcQ7qP4h3evuGj8sXNU2Mrwan5IYnxfwwmS+P44=;
        b=dMBQaVKfmI3iFVn2+YA6FpHklh/S85boEmA0eHsygiYtXhe6f0s/EIghEi00WZCeC8
         DBNI3MGrZJMAxsdBzBRMZIrsKRtY7+z+bQQLWhROB5qXH0jTtc+LcDg+coqqzNIFPpfr
         BDQrVk8RUhMrD+9jx+tw/jQ074EjQJ3mdtsME87nzRsYFuh7dOK/CzJIB1HFrURoBFEd
         icxH9IkDebNllmxYMQIglJKOgH7bN4ETGl12JFOsFx+kbqJ5XcGxW9tTVGzyNOJN+wum
         it1RQ3Od9oUsh2cI5aVJ+gqw8kQhIKJyzPukX5aTcVGCTXE/aPKClI9NZRlaUu0rBHa2
         V6Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=3VInfcQ7qP4h3evuGj8sXNU2Mrwan5IYnxfwwmS+P44=;
        b=uOcYJTOM80czIBoQ4902A4gK3VNhpcnRbtjzuaD3nh4dDuyavhMX1+6B+JnnYHJVUL
         ojvdkas9s4eVBAxm1Z4Jm2zX1K0gzyUCoXA9BUg6ar26O2iopybZbtvjySCJxP4HYjRZ
         CG9Ua2V3FoqbLmeqSmrFjtn2ZYngWzjXJMMP9KAqIrP0uXvfhaefFOrOX4/5TYFHQ3nU
         IC0meQNVmVH15jlb+elYVy7Zsc7W5pjM84WfgM2CYv/AbihGzFyJ5sadfcVTF6+YdfZ/
         8HMmUJg5N4ew1IIbDjeopkzb1sdgRhhOukEL6+xBHXnZ1/Og7vhoGc7IZ7xIHV0ovVMH
         BG8w==
X-Gm-Message-State: APjAAAXqiENHjFrM1Asu4N+Gx9vsCsFInzb5UBhV4OwxF7zKLGYfM01+
        x7O8Uu6tpkcU6gC9FJs5sGg=
X-Google-Smtp-Source: APXvYqwiM4AcKj1mMwpdDCpQGgjo1W2FNsMxbfFUO8PbeGxU9TypSfphQb0RLe/iudFWI1b3J25HLw==
X-Received: by 2002:a17:90a:9f4a:: with SMTP id q10mr9428604pjv.83.1567476793813;
        Mon, 02 Sep 2019 19:13:13 -0700 (PDT)
Received: from google.com ([2401:fa00:fc:100:428a:171e:fa1b:39e5])
        by smtp.gmail.com with ESMTPSA id o130sm24453109pfg.171.2019.09.02.19.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 19:13:12 -0700 (PDT)
Date:   Tue, 3 Sep 2019 10:13:08 +0800
From:   Namhyung Kim <namhyung@kernel.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH 2/9] perf/core: Add PERF_SAMPLE_CGROUP feature
Message-ID: <20190903021306.GA217888@google.com>
References: <20190828073130.83800-1-namhyung@kernel.org>
 <20190828073130.83800-3-namhyung@kernel.org>
 <20190828144911.GR2263813@devbig004.ftw2.facebook.com>
 <20190831030321.GA93532@google.com>
 <20190831045815.GE2263813@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190831045815.GE2263813@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tejun,

Sorry for the late reply.


On Fri, Aug 30, 2019 at 09:58:15PM -0700, Tejun Heo wrote:
> Hello,
> 
> On Sat, Aug 31, 2019 at 12:03:26PM +0900, Namhyung Kim wrote:
> > Hmm.. it looks hard to use fhandle as the identifier since perf
> > sampling is done in NMI context.  AFAICS the encode_fh part seems ok
> > but getting dentry/inode from a kernfs_node seems not.
> > 
> > I assume kernfs_node_id's ino and gen are same to its inode's.  Then
> > we might use kernfs_node for encoding but not sure you like it ;-)
> 
> Oh yeah, the whole cgroup id situation is kinda shitty and it's likely
> that it needs to be cleaned up a bit for this to be used widely.  The
> issues are...
> 
> * As identifiers, paths sucks.  It's too big and unwieldy and can be
>   rapidly reused for different instances.
> 
> * ino is compact but can't be easily mapped to path from userland and
>   also not unique.
> 
> * The fhandle identifier - currently ino+gen - is better in that it's
>   finite sized and compact and can be efficiently mapped to path from
>   userspace.  It's also mostly unique.  However, the way gen is
>   currently generated still has some chance of the same ID getting
>   reused and it isn't easily accessible from inside the kernel right
>   now.
> 
> Eventually, where we wanna be at is having a single 64bit identifier
> which can be easily used everywhere.  It should be pretty straight
> forward on 64bit machines - we can just use monotonically increasing
> id and use it for everything - ino, fhandle and internal cgroup id.
> On 32bit, it gets a bit complicated because ino is 32bit, so it'll
> need a custom allocator which bumps gen when the lower 32bit wraps and
> skips in-use inos.  Once we have that, we can use that for cgrp->id
> and fhandle and derive ino from it.
> 
> This is on the to-do list but obviously hasn't happened yet.  If you
> wanna take on it, great, but, otherwise, what can be done now is
> either moving gen+ino generation into cgroup and tell kernfs to use it
> or copy gen+ino into cgroup for easier access.  The former likely is
> the better approach given that it brings us closer to where we wanna
> be eventually.

So is my understanding below correct?

 * currently kernfs ino+gen is different than inode's ino+gen
 * but it'd be better to make them same
 * so move (generic?) inode's ino+gen logic to cgroup
 * and kernfs node use the same logic (and number)
 * so perf sampling code (NMI) just access kernfs node
 * and userspace can use file handle for comparison

Thanks,
Namhyung
