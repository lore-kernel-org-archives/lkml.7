Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1536C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 20:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EAF322CED
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 20:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="G7R57zwJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfH1UTA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 16:19:00 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42607 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbfH1UTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 16:19:00 -0400
Received: by mail-qt1-f194.google.com with SMTP id t12so1034513qtp.9
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 13:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XtILyRH8l1LUvlvqjqN9r44tpqWCdmlEVajO5M2YwAs=;
        b=G7R57zwJime+xE+GzBWwJdF//H/oggEzvdCGb3Sm4QSKceQy4xJX36dlajnviEjIGY
         /Chz/Rqpb5TC9IompxAZv9cado+gjUgTNZfirxP6v5BslLLntwCQow/9oG4Fm/QR98tg
         W4eaEhkxGKBgQ7AELZ0p4EzBvy4FOsHKiXM1dAnNwNEncsrHwFFx5/DTvDQeEQH+wp/v
         hOQkrZigJB9531ETS0wPZGkGtmmNhxJxJ0Wd1Aad/xmc9Uzq2ApiBfSRMnR3XDyyBypt
         rhrVvxGhjNTN40Dpka29XdZu6T6xiCodQVec33YIAyWksfo69xBlStCwi4LJcslcoo4V
         qJ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XtILyRH8l1LUvlvqjqN9r44tpqWCdmlEVajO5M2YwAs=;
        b=db0ehXTNyoOnkrhE8DRxDnz0qtGU+EtUSYaSk1gjpyET7my3eTDMe0eA8irekJWUsL
         uHkOPUSspHTpffahLyk6NUTBvaMxyhA3hllr0kjOKUmGbOp54tbdUlbk+Fj+ZKUeQhH0
         ZyPrHsvWJNrQKg4QX40woWBTeB6milSclF26GIk7j65p31L8IQyMWOIsdvHv78Mxwbx2
         9En0LdHAjXY5r42o4BD0oYP/QtwmApxKRRgkUu9f+6NmxybgBHcBTBkr5VvwVwycJqBc
         BYUQcUzuK8qlrvFnywFQuOldPwiN/Orwrys8pbqYHOowIqAZImPBfKhopLE7gYKhr8o2
         wykA==
X-Gm-Message-State: APjAAAUiBM/VbyKWK6YTcMWD50/Fwgbhujo/tCvkKTgG9F5DESP4016Z
        zvVSGA2QFCImICxKGOUr5I8ynFVh9RI=
X-Google-Smtp-Source: APXvYqzU7b7B+zUOBiS4wMS8VdYSMLF+ly4yTg2sy8ZcKePkRh6wzfscOlpeKWtoEIcjRXIAfVUdzw==
X-Received: by 2002:ac8:1241:: with SMTP id g1mr6305448qtj.145.1567023539198;
        Wed, 28 Aug 2019 13:18:59 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id n62sm91932qkd.124.2019.08.28.13.18.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Aug 2019 13:18:58 -0700 (PDT)
Message-ID: <1567023536.5576.19.camel@lca.pw>
Subject: Re: [PATCH 00/10] OOM Debug print selection and additional
 information
From:   Qian Cai <cai@lca.pw>
To:     Edward Chron <echron@arista.com>, Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        David Rientjes <rientjes@google.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Ivan Delalande <colona@arista.com>
Date:   Wed, 28 Aug 2019 16:18:56 -0400
In-Reply-To: <CAM3twVR_OLffQ1U-SgQOdHxuByLNL5sicfnObimpGpPQ1tJ0FQ@mail.gmail.com>
References: <20190826193638.6638-1-echron@arista.com>
         <20190827071523.GR7538@dhcp22.suse.cz>
         <CAM3twVRZfarAP6k=LLWH0jEJXu8C8WZKgMXCFKBZdRsTVVFrUQ@mail.gmail.com>
         <20190828065955.GB7386@dhcp22.suse.cz>
         <CAM3twVR_OLffQ1U-SgQOdHxuByLNL5sicfnObimpGpPQ1tJ0FQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-08-28 at 12:46 -0700, Edward Chron wrote:
> But with the caveat that running a eBPF script that it isn't standard Linux
> operating procedure, at this point in time any way will not be well
> received in the data center.

Can't you get your eBPF scripts into the BCC project? As far I can tell, the BCC
has been included in several distros already, and then it will become a part of
standard linux toolkits.

> 
> Our belief is if you really think eBPF is the preferred mechanism
> then move OOM reporting to an eBPF. 
> I mentioned this before but I will reiterate this here.

On the other hand, it seems many people are happy with the simple kernel OOM
report we have here. Not saying the current situation is perfect. On the top of
that, some people are using kdump, and some people have resource monitoring to
warn about potential memory overcommits before OOM kicks in etc.
