Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42408C47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 15:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 163692133F
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 15:19:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IGnbziEL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389825AbfJDPS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 11:18:59 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35999 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389539AbfJDPS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 11:18:58 -0400
Received: by mail-qk1-f194.google.com with SMTP id y189so6149825qkc.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 08:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=okzx2gkxemnX46xhTK+6u6etrbNxaZHfpMJtt79t4uk=;
        b=IGnbziELv8bD3xhiEdNzQHNlBSkCoxoPiw8TA+Y44rWa95aYBev4ZwdHm/ykM1N72B
         UkFnmgo+jEl7JVnez5m7XppyB7I2zWAbzO4qSQOR/yVREpuPAVoCQq3VoFFzLG+QV1RI
         tnbQUguVkM4wEYvDG/FWBw6KaFRhq/2pL0NN74AT0EGyaV/1KG0NzOYkf3o2OHjwztuv
         bNMb+lhOhKTwkCeelYgBiy7LQBWuyaWuQg/WADw0d1kkfVEbP2FaY80Cj3kdyTX4zKkU
         uThV/LSBo9CycgHXC0NpHN1rGN6HzWPPIjEldaGAftyvXWbdf8pq5CKiXJ5eQfoy4Knp
         z4Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=okzx2gkxemnX46xhTK+6u6etrbNxaZHfpMJtt79t4uk=;
        b=H+IllgQh8lNCgsX9mts9ecvf1oVQeUDNRmMKb8ItVTyFGy4kygboQ7TjUSv0TPjURS
         Ib3C6OdIR64hgetummBM6gxdXCzPzAdyLxxo7MNi5gynV+JVLruv1LGTjR43IthNCQQY
         lZA2juYQuqEtSW5fVuZQ35JUwwTolhKn5H24OOIzQxaeHpmho2VTbYGanoPreBp5gmm0
         L0dPhAgp1Mo3Smw/DuRRPzE9JBZymM/M43f5EqycNt1JX1S9CCvssOsOFcjQYG+llsXp
         IoFtNKxFnuoZCpwTLheFIjtSXhIQrvkNmwt0+KkAxYj6SE+DcjEz2FlE2L/q9K2kw7RO
         GgEA==
X-Gm-Message-State: APjAAAVpkhsKaBBhjEJsldrF26oC+bUFs7X6Y7QdSJdHzERAaWPSR/I3
        6SKnCdVO4pvpwnQkUCHsGmg6LeWG
X-Google-Smtp-Source: APXvYqyc59T/hK8PH39lGmvc64VLLVC9uKvnb2+v3Qriy7l8iZI4gxqiALNaKO669aBAjBdYOZMpTQ==
X-Received: by 2002:a37:8f04:: with SMTP id r4mr10762007qkd.244.1570202337585;
        Fri, 04 Oct 2019 08:18:57 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id t199sm3092147qke.36.2019.10.04.08.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 08:18:56 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9953C40DD3; Fri,  4 Oct 2019 12:18:53 -0300 (-03)
Date:   Fri, 4 Oct 2019 12:18:53 -0300
To:     John Garry <john.garry@huawei.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, will@kernel.org, mark.rutland@arm.com,
        zhangshaokun@hisilicon.com, James Clark <James.Clark@arm.com>
Subject: Re: [PATCH 0/4] HiSilicon hip08 uncore PMU events additions
Message-ID: <20191004151853.GC17687@kernel.org>
References: <1567612484-195727-1-git-send-email-john.garry@huawei.com>
 <27e693fd-124e-1aa8-3b8a-62301a5a1d10@huawei.com>
 <20191004143658.GA17687@kernel.org>
 <20191004143835.GB17687@kernel.org>
 <969729ce-6246-6fa7-45c9-3dd9cb07059d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <969729ce-6246-6fa7-45c9-3dd9cb07059d@huawei.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Oct 04, 2019 at 03:59:44PM +0100, John Garry escreveu:
> On 04/10/2019 15:38, Arnaldo Carvalho de Melo wrote:
> > Em Fri, Oct 04, 2019 at 11:36:58AM -0300, Arnaldo Carvalho de Melo escreveu:
> > > Em Fri, Oct 04, 2019 at 03:30:07PM +0100, John Garry escreveu:
> > > > On 04/09/2019 16:54, John Garry wrote:
> > > > > This patchset adds some missing uncore PMU events for the hip08 arm64
> > > > > platform.

> > > > > The missing events were originally mentioned in
> > > > > https://lkml.org/lkml/2019/6/14/645, when upstreaming the JSONs initially.

> > > > > It also includes a fix for a DDRC eventname.

> > > > Could I get these JSON updates picked up please? Maybe they were missed
> > > > earlier. Let me know if I should re-post.

> > > Looking at them now.

> > It would be really good if somehow we managed to have someone from the
> > ARM community to check and provide a Reviewed-by for those, i.e. someone
> > else than the poster to look at it and check that its ok, would that be
> > possible?
 
> For this specific case, I'm not sure how much traction or value there would
> be since we're just adding some missing events for custom IP.

Someone else inside your organization? If nobody is available, then so
be it, let that be clear in the JSON file (see below) and then I
wouldn't be waiting for acks/reviewed-by messages for such cases.
 
> But I do agree that more review of JSONs from the community is required - as
> I brought up here regarding a recent addition:
> https://lore.kernel.org/lkml/749a0b8e-2bfd-28f6-b34d-dc72ef3d3a74@huawei.com/
> 
> Can we enforce that at least linux-arm-kernel@lists.infradead.org and/or
> get_maintainer.pl results is cc'ed on anything ARM specific as a start?

I think this should be the case, would you be willing to add a note to
that effect at the top of the JSON files?

And an extra note at tools/perf/pmu-events/README telling users to look
at the json files to figure out what Reviewed-by tags are required for
something to get merged? One extra Reviewed-by would be ok? Who would be
the reviewers for each arch? Would that be at the top of the JSON file?

- Arnaldo
