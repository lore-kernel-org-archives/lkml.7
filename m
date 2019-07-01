Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F9AC5B578
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 06:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D72F212F5
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 06:52:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbfGAGwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 02:52:39 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:32972 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbfGAGwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 02:52:38 -0400
Received: by mail-wm1-f68.google.com with SMTP id h19so13817370wme.0
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2019 23:52:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZanPqiEPVMdySHonMbQBl/5/VvjKUDnA16ZAnUCifwo=;
        b=qdSWVW2TSjRVT4hqR5Q1Un6Uov090iDyqZzRmHFRNfGjwcwJIEwnkhublC7h7Qr+vY
         M34ry4zO0B73wKNSZ2E6L0uY9/H72ZHMSf1nhnKWC5iadxSwEFNU0uL3Wdhn/iDazWt6
         hDkStCYDG0JJtnLcrAK8DBtIVrJmBAmp0b3e/upEQ2k2fzbNNX2lKebYneuN3l30cZM5
         uudrfc28TYm7vqCg+8jxW6p3u4TVapSkAsaApUp7BH2CZkKlLrf85Smt8/UIWcmbz6Ic
         rN4YOO9Jm6N2eN3Vy9YP+qzi4uQ0NI7ixZNUT7sBXDkVv7cKS3HvABv/2kgPCNFHCfbn
         6k2w==
X-Gm-Message-State: APjAAAWlyw+6vn3glGHGARCAFpssO02ns5xmG3nlcPhTwGh+0h0fGevH
        DVJ+WHNPE6DjeAb2NCutPnOmmA==
X-Google-Smtp-Source: APXvYqyAJZ4botdtSJ3zU9ORTAwwQRPjpGAfhDs9AIdatmN70PBO8LqjP2idy/zV96eTgzly1dbG3w==
X-Received: by 2002:a1c:dc07:: with SMTP id t7mr16638183wmg.164.1561963956698;
        Sun, 30 Jun 2019 23:52:36 -0700 (PDT)
Received: from localhost.localdomain ([151.15.224.253])
        by smtp.gmail.com with ESMTPSA id h21sm10492932wmb.47.2019.06.30.23.52.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 30 Jun 2019 23:52:35 -0700 (PDT)
Date:   Mon, 1 Jul 2019 08:52:33 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, rostedt@goodmis.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org, lizefan@huawei.com,
        cgroups@vger.kernel.org, Prateek Sood <prsood@codeaurora.org>
Subject: Re: [PATCH v8 6/8] cgroup/cpuset: Change cpuset_rwsem and hotplug
 lock order
Message-ID: <20190701065233.GA26005@localhost.localdomain>
References: <20190628080618.522-1-juri.lelli@redhat.com>
 <20190628080618.522-7-juri.lelli@redhat.com>
 <20190628130308.GU3419@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628130308.GU3419@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 28/06/19 15:03, Peter Zijlstra wrote:
> On Fri, Jun 28, 2019 at 10:06:16AM +0200, Juri Lelli wrote:
> > cpuset_rwsem is going to be acquired from sched_setscheduler() with a
> > following patch. There are however paths (e.g., spawn_ksoftirqd) in
> > which sched_scheduler() is eventually called while holding hotplug lock;
> > this creates a dependecy between hotplug lock (to be always acquired
> > first) and cpuset_rwsem (to be always acquired after hotplug lock).
> > 
> > Fix paths which currently take the two locks in the wrong order (after
> > a following patch is applied).
> > Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> 
> This all reminds me of this:
> 
>   https://lkml.kernel.org/r/1510755615-25906-1-git-send-email-prsood@codeaurora.org
> 
> Which sadly got reverted again. If we do this now (I've always been a
> proponent), then we can make that rebuild synchronous again, which
> should also help here IIRC.

Why was that reverted? Perf regression of some type?

Thanks,

Juri
