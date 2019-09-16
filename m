Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F3C4C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 15:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20219206A4
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 15:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568647412;
	bh=HD1otUSksHYoUXxfPmzXPiT/pVsZS0aKC/mCNZdpGMI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nB3Fw/txLaXvlpXkB3wF0qsZueSqjgzH6chUNo4KnAHCKrUrLDi7741T8rjtQfbCE
	 tqF/9cn9XGRfr4Spnh07hS5DgI0pYPMi+Sl/V4wuEEvp+iXMHzkgspPJpvjpfZpmIh
	 aDoaJLUh1bEmwvDyvuIl5DA4dtwXE/9kGJiGW2K8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389028AbfIPPXb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 11:23:31 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37039 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbfIPPXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 11:23:30 -0400
Received: by mail-qt1-f193.google.com with SMTP id d2so277011qtr.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 08:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nXWNgep+1YflTSaskCxEpFxvmBVqHx26c0TsXfFEqu8=;
        b=FqwOsq4sSVz7PLYpAuBocc9uJP6xW4sLjN5WzxPH1zUoWj3CQrHS9GJaeJ1y8k7IY2
         jEjnVGWYf3q7DC0vzDFsqZiKNetE0Rru2sjW7pO9cAFxY/cygnlgDWxwdwlnB5LU8gAv
         byjFoveAviLi3MdF/48qUo3fh+UHzZ9jbcYs+/MQC4KKGemGXpFLePN0uITsGz25qQZo
         Ezr+xFYsm0ZrJtugEuNIusKSS/lTndN+SgRWs5UFjym4ghSlaKA4nVqeNnMPa4K5wjFn
         5HUnZtJLwbKnJFolk+bmDBHWhZfat8p/ehWpz/1Oe59WGnGm4OsNuGSDfeL3g1SfSd03
         UofQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=nXWNgep+1YflTSaskCxEpFxvmBVqHx26c0TsXfFEqu8=;
        b=py0YIt50F4gr8g+uWOp/zDtImoy0vW9cnXRyKNPui7Zo0ivbjb2IcqLO0IJ3+dMdNi
         dVDIEvVGJw0e+vSt5VHDYOPDC/DIxQ4t59KnACeG9VJgSVrH/HnkT86P1tEJXRHKVIWs
         mTuE934FfABzsiNJg5kH6MbgxkQSCr95eMNrWO0aKZpUVwnew4WnWfheOM1eIf2VepJ/
         Lws/TzxSDgfQ9U68jQCyXdkAc/3px834PiaXeJCiKcBflYLVfP7oTq1nX1zAP26GZs2u
         IUda34d6J5opzkCRMkaAZLLxDEBmmEaAc2Gz1j5o9/SvecDdR+x9aIBHVWoIXp+5MQ3W
         Wv6A==
X-Gm-Message-State: APjAAAWknD2IKll/vGseTUdfHCai38Mz+4zmnhufkerekNZmP2c+kTbc
        lW0uXydOmCM4f58D0ZmpCdo=
X-Google-Smtp-Source: APXvYqzxE6mv/QiiW8w0Y8Ompjdj3xFsuLB8d0PRVWltSP/6/c5aeZjQHtiiVpvrdYMgyjH8YGOP4g==
X-Received: by 2002:ac8:48c4:: with SMTP id l4mr77438qtr.235.1568647409728;
        Mon, 16 Sep 2019 08:23:29 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::c30c])
        by smtp.gmail.com with ESMTPSA id g8sm22446452qta.67.2019.09.16.08.23.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Sep 2019 08:23:26 -0700 (PDT)
Date:   Mon, 16 Sep 2019 08:23:25 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Song Liu <liu.song.a23@gmail.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH 2/9] perf/core: Add PERF_SAMPLE_CGROUP feature
Message-ID: <20190916152325.GD3084169@devbig004.ftw2.facebook.com>
References: <20190828073130.83800-1-namhyung@kernel.org>
 <20190828073130.83800-3-namhyung@kernel.org>
 <20190828144911.GR2263813@devbig004.ftw2.facebook.com>
 <20190831030321.GA93532@google.com>
 <20190831045815.GE2263813@devbig004.ftw2.facebook.com>
 <CAPhsuW42ivYU=U5E9jLMWZZgXP_Dv0C_SMFBsiXa53=6bN-=Wg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPhsuW42ivYU=U5E9jLMWZZgXP_Dv0C_SMFBsiXa53=6bN-=Wg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Song.

On Sat, Sep 14, 2019 at 03:02:51PM +0100, Song Liu wrote:
> I think we don't need a perfect identifier in this case. IIUC, the goal of

I really don't want different versions of imperfect identifiers
proliferating.

> this patchset is to map each sample with a cgroup name (or full path).
> To achieve this, we need
> 
> 1. PERF_RECORD_CGROUP, that maps
>            "64-bit number" => cgroup name/path
> 2. PERF_SAMPLE_CGROUP, that adds "64-bit number" to each sample.
> 
> I call the id a "64-bit number" because it is not required to be a globally
> unique id. As long as it is consistent within the same perf-record session,
> we won't get any confusion. Since we add PERF_RECORD_CGROUP
> for each cgroup creation, we will map most of samples correctly even
> when the  "64-bit number" is recycled within the same perf-record session.
> 
> At the moment, I think ino is good enough for the "64-bit number" even
> for 32-bit systems. If we don't call it "ino" (just call it "cgroup_tag" or
> "cgroup_id", we can change it when kernfs provides a better 64-bit id.

So, a firm nack on this direction.

> About full path name: The user names the full path here. If the user gives
> two different workloads the same name/path, we really cannot change that.
> Reasonable users would be able to make sense from the full path.

I don't see why we wanna be causing this avoidable problem to users.

Thanks.

-- 
tejun
