Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD21C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 14:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FCE6222C0
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 14:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a2tA+/G6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389234AbfJDOhF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 10:37:05 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40153 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389100AbfJDOhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 10:37:04 -0400
Received: by mail-qk1-f195.google.com with SMTP id y144so5975292qkb.7
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 07:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F6mLwkQPDdiYFNuWkZb4XRAWNANkZduE6Qp1fMGHTlE=;
        b=a2tA+/G63bAfQNfNcenU5+9rZeEwkDtMPPO7j6/UyATYoK6zyn3+cRK0hpnx0qUPwZ
         9MiFNQahytV/7COjlJsWs60xHF49bOLaheXvpP2eE/GjJS505zifkwTVdQfCq6nK4hxd
         tkl3V48be75qGKSX7/LiZFfNKkRqf6shbs7so0LQePzHvEs/DDPd+BkyWx4iAxSZSR8a
         QBDedUT67nvtKBtgMcWgMbeIQT5VQZKk2+Y8dlx4HS8ZZ9kySTWevIz6vkUCRWEUgvxI
         yTYZryyetmbmN+AtdnE4q1NBksSrNL+8Dl0v4f3Q6QdR+8PxDUOZlj4f3z+Iom1h5qFm
         ugjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F6mLwkQPDdiYFNuWkZb4XRAWNANkZduE6Qp1fMGHTlE=;
        b=Fh/yHx4046GcBWlPZnKFQTqfGlWfMJ9xSu8kLLFKH/3gAmzGpty5asw+kUZyE7yCgp
         2QWJbYU5UUFWkGWMF+3nQm8alUKAycV+fNLLT3DdpZMv1QdI0v+jgxE38mSkPk+dVJuA
         239dqj8P1f92RffMVxV3xywMFithZMWtHGmg+kmC6n6Uz1yyOMi5vcrxV0K6mJivREB9
         D/wNyVvCZR09zB9nhFZW1ea6+sjkGyzLPakLdbbIl9+zZM4ISirtzZspOiE7KHAxDq0o
         LAJsFpdrok6ytKDZ5oqlpj1HlBBr+ncy1Jp5lu4Cx95QVnfXgjL+2NvzcYK6C0kavDJQ
         GeEA==
X-Gm-Message-State: APjAAAXVsmwULGkOSuvEq5044pnW4pH8RsSdV6NZht9ZiyMmfx6dUMn5
        5YTyLXzzPI0RgErt0ThhC6nOI8Pw
X-Google-Smtp-Source: APXvYqwa3zxxfyeDUgwbEmQSsehJmhUNhLP5Z83CXR2H1C6URjdyL7jDFqeYq61tB70gQtyOgYB/7Q==
X-Received: by 2002:a37:4b54:: with SMTP id y81mr9967636qka.344.1570199821993;
        Fri, 04 Oct 2019 07:37:01 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id y58sm3462199qta.1.2019.10.04.07.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 07:37:00 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id AB6EF40DD3; Fri,  4 Oct 2019 11:36:58 -0300 (-03)
Date:   Fri, 4 Oct 2019 11:36:58 -0300
To:     John Garry <john.garry@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, will@kernel.org, mark.rutland@arm.com,
        zhangshaokun@hisilicon.com
Subject: Re: [PATCH 0/4] HiSilicon hip08 uncore PMU events additions
Message-ID: <20191004143658.GA17687@kernel.org>
References: <1567612484-195727-1-git-send-email-john.garry@huawei.com>
 <27e693fd-124e-1aa8-3b8a-62301a5a1d10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27e693fd-124e-1aa8-3b8a-62301a5a1d10@huawei.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Oct 04, 2019 at 03:30:07PM +0100, John Garry escreveu:
> On 04/09/2019 16:54, John Garry wrote:
> > This patchset adds some missing uncore PMU events for the hip08 arm64
> > platform.
> > 
> > The missing events were originally mentioned in
> > https://lkml.org/lkml/2019/6/14/645, when upstreaming the JSONs initially.
> > 
> > It also includes a fix for a DDRC eventname.
> 
> Hi guys,
> 
> Could I get these JSON updates picked up please? Maybe they were missed
> earlier. Let me know if I should re-post.

Looking at them now.

- Arnaldo
 
> Thanks in advance,
> John
> 
> > 
> > John Garry (4):
> >   perf jevents: Fix Hisi hip08 DDRC PMU eventname
> >   perf jevents: Add some missing events for Hisi hip08 DDRC PMU
> >   perf jevents: Add some missing events for Hisi hip08 L3C PMU
> >   perf jevents: Add some missing events for Hisi hip08 HHA PMU
> > 
> >  .../arm64/hisilicon/hip08/uncore-ddrc.json    | 16 +++++-
> >  .../arm64/hisilicon/hip08/uncore-hha.json     | 23 +++++++-
> >  .../arm64/hisilicon/hip08/uncore-l3c.json     | 56 +++++++++++++++++++
> >  3 files changed, 93 insertions(+), 2 deletions(-)
> > 
> 

-- 

- Arnaldo
