Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9565AC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 15:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 623B920854
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 15:16:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZtV2pRbz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733173AbfJOPQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 11:16:40 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34555 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbfJOPQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 11:16:39 -0400
Received: by mail-qk1-f194.google.com with SMTP id q203so19520673qke.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 08:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+ENnod06Caqrg5Ljmd87Yt4qbZaP4wpuUAg7bNHk8J4=;
        b=ZtV2pRbzJrdjOAavwR4CV6KQ2imC9IgxWDRlw5OB4ercMkjI8kjmROVznvr5lXxprU
         v7AgVXax9XBSGgV+EOpkHw+VxdCVe6Hps1hASeiT23QeQIU3Zdohh1ZscheySwuTPBTU
         6DCw/wiDoTgOIvlovSibjXDAzEladZWAr42iLi/miHlpX98mGBDmUN+U5ioPAq9PT9ez
         pHDlxju/mIFLZhVti5aN0rExgBWXCD10ynXTIxTLr13BQAIkOByef6zeZw1tOnFLaTKP
         fl7+aeUgK1sa0kAySn/xMfWU1WJbuLqmzfwyp+k7NM/HOVOJodGTgPjxoIEa0+eFpByt
         3tpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+ENnod06Caqrg5Ljmd87Yt4qbZaP4wpuUAg7bNHk8J4=;
        b=DOAV4BXI+cI93FWIMFUqgkWoFK8WPjfCoJQAqEfqtGM58w0vuUGqkBuhqjrKFUwXs4
         X9sFIFe48fJjQW3S0l8V7CTGK98Tt01wgWfBJeHiiuLayDUSINIHcCKeX1n0iV0B2spm
         0Gj4IIvmK9ovZbtmJCbyVLfevddQav28wBMEclZ0NiEoM1lRkrKewG1tmYXzUhJ0ckIf
         /CCzEYZUDUx4Hynfi26gri/Z6HX856sdUVLShQD4gR8PTlxwX06mCXI9vG+sqaEvYDcu
         5d7q9EhocV6acnWUcIz5WCXsuvSoOcuEBWrGykp0k2tzG4XaDmEz9NIMgtnTbcmiUHiH
         4e2w==
X-Gm-Message-State: APjAAAUodfGS44QCDs1YtLjY49APpngirdgU4Nsj4XAj9EE5hWopJtjm
        skO+z6NrYGpKBNl+n0sHwpUdrNUAj28=
X-Google-Smtp-Source: APXvYqyg/MlStVdsNtHAjUoR7cprEw40wf5ZHaHg4lEEtE6K7OZFZWjnIkpEiWT1TI0/Iknr+6LCXQ==
X-Received: by 2002:a05:620a:126e:: with SMTP id b14mr36729394qkl.470.1571152598903;
        Tue, 15 Oct 2019 08:16:38 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id j5sm9471723qkd.56.2019.10.15.08.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 08:16:37 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6404C4DD66; Tue, 15 Oct 2019 12:16:35 -0300 (-03)
Date:   Tue, 15 Oct 2019 12:16:35 -0300
To:     Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc:     John Garry <john.garry@huawei.com>, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com, will@kernel.org,
        mark.rutland@arm.com
Subject: Re: [PATCH 0/4] HiSilicon hip08 uncore PMU events additions
Message-ID: <20191015151635.GE25820@kernel.org>
References: <1567612484-195727-1-git-send-email-john.garry@huawei.com>
 <80d5b29a-64fe-7c0f-6e5d-74a030851fd8@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80d5b29a-64fe-7c0f-6e5d-74a030851fd8@hisilicon.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Oct 09, 2019 at 09:14:45AM +0800, Shaokun Zhang escreveu:
> Hi John,
> 
> Thanks for your nice work, these are useful for performance profiling
> if anyone is unfamiliar with the uncore PMU events on hip08.

> For this patchset, please feel free to add
> Reviewed-by: Shaokun Zhang <zhangshaokun@hisilicon.com>

Thanks, added and applied,

- Arnaldo
 
> Thanks,
> Shaokun
> 
> On 2019/9/4 23:54, John Garry wrote:
> > This patchset adds some missing uncore PMU events for the hip08 arm64
> > platform.
> > 
> > The missing events were originally mentioned in
> > https://lkml.org/lkml/2019/6/14/645, when upstreaming the JSONs initially.
> > 
> > It also includes a fix for a DDRC eventname.
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

-- 

- Arnaldo
