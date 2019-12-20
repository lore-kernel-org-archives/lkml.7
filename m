Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA0FBC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 16:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8905520866
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 16:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576861152;
	bh=YhOx7vHjL5MFGI+9Bd40FTXLwMa4kVWMFOswf4gxlz4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gYeBpmmv0/235ZNowf7NdKOtIAUZ2rMsXsFs/7n0wMA4g767HryfoegdTYFazQJMu
	 v3gbsfq+7KMymhoWC0un2rrsTks1zaasybsBKvhmizIIZvo3whePWsB21nvz+HvarW
	 ZpF0rsRIJd5QW4ycyur/W9fW9zTxr1lrpcBxXuLQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbfLTQ7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 11:59:11 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41564 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727270AbfLTQ7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 11:59:11 -0500
Received: by mail-qk1-f195.google.com with SMTP id x129so8165349qke.8;
        Fri, 20 Dec 2019 08:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TFNV1NWSFuHpHDbvDJbGCGSFQdkbgmzuIkzgxcz14KU=;
        b=L1Mxw7+ebCI/ROK7u570qmJ8bGHUsrG8/Iwh3dpXvWg1TfIpiGzBjILCSzJ6a6wAy0
         3aVTsR0KbvVJopGVOTtaQvm8iAtt2bjr1nYkVdtTV+nq1R3XvGoQFDF7TCZnt39huZ+q
         wELoGq/f5eCv12Rk1MldkTz6PaKz5w8VncaTrTKzUQAQCCocV2Rjzkrkvgx83Kqh55hV
         4yD2EGEXPLmv6T2J8KKMbFcDtb6fDaxO5P4Na7MzaOhoGV1yZffam1dksQcIbxajbpuV
         37SmUvMpzmeNvtQp6965SmYj+/3/h2l063bsfav5vEuM5eF5Hs5zm2SrPKW/6t36pyeY
         XprQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=TFNV1NWSFuHpHDbvDJbGCGSFQdkbgmzuIkzgxcz14KU=;
        b=qZdr3Q1kxFChlRSGFhhMIwmWykND6pL3/SV5mz79y2DTPL1x51y6OKpF9lPA8Tj/Zg
         uFgNS+pmQI8y336m8pkW5jsuflxdb5Mg6BkhGKfMdzUHyitlvIKLJT/kJiQSOKR/Z0og
         CvEi3o7bLjcofXR7NtzsYinjh/AVPeHaf2ikmS8pkedlwBvQJ55F2m7nLr1qZGLSIZFX
         zuweCYM6JPhR4YGzNSKmp28kDqYxpd7p3YkTCGSaA2lk/RNNmtG0FPHqAJzTDsVe8HUb
         k8NaqC5GFUWNnzj1mpI7Sy7V8CA5HcCav7kUjfh5fxL+0dcyvCJJIgybj575HJMmuUVv
         F1hA==
X-Gm-Message-State: APjAAAWZx9sy/bOFpi69MMhSvwiNLO04pQX4f4SY4ww/ss/maQdBFV4F
        JgrWwAWX0DRYg2IKTVmJJf4pAAhSKTI=
X-Google-Smtp-Source: APXvYqz7aFmfMyObL+0ikFUH0+DkYP1GcmtMmTR601QkVR1ssJsY2OznXxNfcvKC2nobxj4PRGMXqA==
X-Received: by 2002:a05:620a:133a:: with SMTP id p26mr14265229qkj.50.1576861149971;
        Fri, 20 Dec 2019 08:59:09 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::11e7])
        by smtp.gmail.com with ESMTPSA id t73sm3052987qke.71.2019.12.20.08.59.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Dec 2019 08:59:09 -0800 (PST)
Date:   Fri, 20 Dec 2019 08:59:07 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH 2/9] perf/core: Add PERF_SAMPLE_CGROUP feature
Message-ID: <20191220165907.GI2914998@devbig004.ftw2.facebook.com>
References: <20191220043253.3278951-1-namhyung@kernel.org>
 <20191220043253.3278951-3-namhyung@kernel.org>
 <20191220152324.GG2914998@devbig004.ftw2.facebook.com>
 <20191220164802.GO2827@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191220164802.GO2827@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2019 at 05:48:02PM +0100, Peter Zijlstra wrote:
> That assumes the cgroup is still in existence, which might not be the
> case I presume.

Yeah, if the cgroup is already gone by the time the first event is
looked up, this wouldn't work.

-- 
tejun
