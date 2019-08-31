Return-Path: <SRS0=k4ck=W3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A487C3A59F
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 04:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1804223426
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 04:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567227563;
	bh=1Bj2Vi6cOufE+DmwfAxaksyeYfqgYkyQepy2wmXLdBY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NtBxTORzQGt76Mghu2MjotSSAXoJf3gS6oLXN4a/jRj0FwkdzpWNUhmskW2WNI4kP
	 cCrmcKeNtYRvNGm7BuyCsZp2QoHqwyUkWnYoT8+QfrPT7FXYTcyCYeVzOSrx6mth6+
	 GWlsEV3YFiqPoCW2IGHCB1EnGrbJl8vQZ1pcSaTo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfHaE6U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 31 Aug 2019 00:58:20 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33536 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbfHaE6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Aug 2019 00:58:20 -0400
Received: by mail-qt1-f195.google.com with SMTP id r5so4764141qtd.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 21:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mCECiP2+069mzWmcV8l55xl39E8bQIWsE91klVArBaU=;
        b=GVZ1mPHH0fYch3s1n7DHRwSWDvPCpjWXExhnDRjqziY/JHlvEMmB56PYLmdv8IyPjz
         YoIeinYsvjJKwUZagmcCNjyLuChS7FW4GDgtZ+fy7ocEEoHNcBUlUyuwWs9ucKzrwSKj
         l/wEY4trG+pGVumRXVG5XDPNADe+p0+owrHHrXwW5SBqtlWnTFnY8RiCZXK9IS80z7X2
         DO3w8w0h8gcEH7I15htBKgzRiDIL9YW57+zq6yaTfkglxRjo+/CbgPNNykIoyMcvxxwi
         rEWK32dPeonrurwz18Oc0tHSCsNN6zo28Qkysmz2tvPXBMSqY1IA6l/Q4prQFa3yEac6
         40ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=mCECiP2+069mzWmcV8l55xl39E8bQIWsE91klVArBaU=;
        b=FLahD8Ntqg7uEVS63MdfhTctc68Nz22hl4TTcXQ1UppsxvhXOWitX9C/O4e7/+qdPq
         8WwYk1M69TvauLyXgpolZwCAflltVTXn84CEHky2Erv4nRyzQ9qiXysuAUcy2NOn+2sZ
         8W+g1i5IqDvK22D47UcgyOcryceJO0n/52NwBkAhwP67DGAR/SoXzIkZyGFBKitDPhSe
         p97uzFrvcu0C7FlHuIuhQjyJVYGik17k/uq8LWnL42rUlVWbkWbjLq8pEO25MC58hXIg
         jhNuPLEaKE0drQMCDy9OaI6aF/u6kGvlSK9QQGuohMVBj4h1653yXroWXabDr+bgWIkg
         boTQ==
X-Gm-Message-State: APjAAAU4buB1r6MrUUvcFhbuf0I/WkkL2mgImHyYja57QhNgQP+Y1mvs
        XBvy9XE45TCegIb6SftUQZ8=
X-Google-Smtp-Source: APXvYqzrprK30YuDIDxL1tTkk6mH7zqeZHvvi36y47uIAjSXJYJKaPCVgy1FAkzizY25k822MTILAg==
X-Received: by 2002:a0c:b92c:: with SMTP id u44mr12595713qvf.146.1567227498928;
        Fri, 30 Aug 2019 21:58:18 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::ca48])
        by smtp.gmail.com with ESMTPSA id j25sm1668741qkl.101.2019.08.30.21.58.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Aug 2019 21:58:17 -0700 (PDT)
Date:   Fri, 30 Aug 2019 21:58:15 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
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
Message-ID: <20190831045815.GE2263813@devbig004.ftw2.facebook.com>
References: <20190828073130.83800-1-namhyung@kernel.org>
 <20190828073130.83800-3-namhyung@kernel.org>
 <20190828144911.GR2263813@devbig004.ftw2.facebook.com>
 <20190831030321.GA93532@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190831030321.GA93532@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sat, Aug 31, 2019 at 12:03:26PM +0900, Namhyung Kim wrote:
> Hmm.. it looks hard to use fhandle as the identifier since perf
> sampling is done in NMI context.  AFAICS the encode_fh part seems ok
> but getting dentry/inode from a kernfs_node seems not.
> 
> I assume kernfs_node_id's ino and gen are same to its inode's.  Then
> we might use kernfs_node for encoding but not sure you like it ;-)

Oh yeah, the whole cgroup id situation is kinda shitty and it's likely
that it needs to be cleaned up a bit for this to be used widely.  The
issues are...

* As identifiers, paths sucks.  It's too big and unwieldy and can be
  rapidly reused for different instances.

* ino is compact but can't be easily mapped to path from userland and
  also not unique.

* The fhandle identifier - currently ino+gen - is better in that it's
  finite sized and compact and can be efficiently mapped to path from
  userspace.  It's also mostly unique.  However, the way gen is
  currently generated still has some chance of the same ID getting
  reused and it isn't easily accessible from inside the kernel right
  now.

Eventually, where we wanna be at is having a single 64bit identifier
which can be easily used everywhere.  It should be pretty straight
forward on 64bit machines - we can just use monotonically increasing
id and use it for everything - ino, fhandle and internal cgroup id.
On 32bit, it gets a bit complicated because ino is 32bit, so it'll
need a custom allocator which bumps gen when the lower 32bit wraps and
skips in-use inos.  Once we have that, we can use that for cgrp->id
and fhandle and derive ino from it.

This is on the to-do list but obviously hasn't happened yet.  If you
wanna take on it, great, but, otherwise, what can be done now is
either moving gen+ino generation into cgroup and tell kernfs to use it
or copy gen+ino into cgroup for easier access.  The former likely is
the better approach given that it brings us closer to where we wanna
be eventually.

Thanks.

-- 
tejun
