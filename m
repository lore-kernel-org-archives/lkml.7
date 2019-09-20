Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8362C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 21:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7433B205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 21:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569013460;
	bh=VubYVjGnRP2aZyg2jw4IPrIbkXEgM+ozY9rWM9RJIW8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qTlspw64I9dea0Lr4i37z3hM4MkmbZreEDPr9pMLz/mvkfNfefQrA8pu/AdEJmyej
	 FiEHls8p7/iPwyQ2tca5H08qEWopZpVYdtCWB3BGftxJdSngaeLU6nV2ZQW3uIF8tB
	 hG2FyuJODEYovFuD8Pwb3i4tquDsre9vdq1HDwAQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388000AbfITVET (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 17:04:19 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41811 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387479AbfITVET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 17:04:19 -0400
Received: by mail-qt1-f196.google.com with SMTP id x4so10249212qtq.8
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 14:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MclSGY+9kJ6oxOJZqAtmvR1JbCyv4F0ekRMFCKZI+a4=;
        b=W1TT8PeUF03mOyewPJFuLQBqka1UfjINtniTRkofWjYTeZr931izfgfsaaIaGErNvN
         s+tqTvczyGothiXkzQAVqv6bMD+v5POW9PRTP9MCT4B4+kbgaqttHEnYCkIJpNr8KyZq
         J00Yft/zFKYRSbnWXIvIGWuDb8cJkXWFt0ZzMflOGQncVr+QH+AqAwiw6NLyX7QVJTQV
         Gw0ozqgf9/xrI2HCmHhrDE2KIKoets0i+olYMsFxjNPWAfBdkswwXqWtVzs6VBjDhxrM
         F0LZxLpe+peE9RgPikO1I/l0tH87JsT1rZ6wAWb6FjI0RANiw5o6QyWhAVw8F8kujYjZ
         yWOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=MclSGY+9kJ6oxOJZqAtmvR1JbCyv4F0ekRMFCKZI+a4=;
        b=RRQwkPHQ7ISJFO7Wd3dW5oOje89xdFGOBnjubQKLS2Wn1FsOvznS8Gz2Yp+E9NOL2m
         LE2Rki0JKVUYoxht9JKUh0eHJm1DgXOzJYPaqfwUDiBMDn9yhGgVbqfrszq+AyhIRRny
         khPMDP86tpTDzQLnhXqJtIBX7yUhx46Jg7PAcKPMx5EdslpCR1x0rEacSA6ppSGXrjkj
         w+tw7qrSNDVfH67SZcqhs/zdNexeAiX1+coGV6Rub97bXAFulLeugcoPTAu1jfcWYImB
         9xow4rAeoh6BESPDKiK9gQ7d1S7ZPE5dQ2C/xXmIiOXtMiIIHq3MpCQFzlpla8OwzZf4
         Ikhg==
X-Gm-Message-State: APjAAAXQYGEuvqjmnxd2urlz9HOTdiUp9f2ImZQmJWFz4lSO09o3MC65
        xE3tIh1y/LTKzYsRs/52Tlg=
X-Google-Smtp-Source: APXvYqzaXZKtBOUh/fvkW1VV/1BXJ0Ju9+8M/LnxzHTwlxNpqt4wp9bha/+1b4vMaHhbWO5TZz5eRg==
X-Received: by 2002:a0c:82a2:: with SMTP id i31mr14464002qva.160.1569013456404;
        Fri, 20 Sep 2019 14:04:16 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::7520])
        by smtp.gmail.com with ESMTPSA id a72sm1367119qkg.77.2019.09.20.14.04.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Sep 2019 14:04:14 -0700 (PDT)
Date:   Fri, 20 Sep 2019 14:04:11 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Song Liu <liu.song.a23@gmail.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH 2/9] perf/core: Add PERF_SAMPLE_CGROUP feature
Message-ID: <20190920210411.GB2233839@devbig004.ftw2.facebook.com>
References: <20190828073130.83800-1-namhyung@kernel.org>
 <20190828073130.83800-3-namhyung@kernel.org>
 <20190828144911.GR2263813@devbig004.ftw2.facebook.com>
 <20190831030321.GA93532@google.com>
 <20190831045815.GE2263813@devbig004.ftw2.facebook.com>
 <CAPhsuW42ivYU=U5E9jLMWZZgXP_Dv0C_SMFBsiXa53=6bN-=Wg@mail.gmail.com>
 <20190916152325.GD3084169@devbig004.ftw2.facebook.com>
 <CAPhsuW54+YNkj3fnmS6P0=eEdzZ4YvV7Yv+t-d-OnRNNgxPS+Q@mail.gmail.com>
 <CAM9d7cg_AKCyifV7xDm7sJ4=wgG_K=qu013TSTHqLiCRh9m_pg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cg_AKCyifV7xDm7sJ4=wgG_K=qu013TSTHqLiCRh9m_pg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 05:47:45PM +0900, Namhyung Kim wrote:
> Thanks for the sharing information!  For 32-bit, while the ino itself is not
> monotonic, gen << 32 + ino is monotonic right?  I think we can use the

It's not.  gen gets incremented on every allocation, so it has not
high but still realistic chance of collisions.

Thanks.

-- 
tejun
