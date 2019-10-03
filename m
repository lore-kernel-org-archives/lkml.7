Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2259C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 13:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B07E5215EA
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 13:25:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gn/d0klq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730399AbfJCNZh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 09:25:37 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42590 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfJCNZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 09:25:36 -0400
Received: by mail-qk1-f195.google.com with SMTP id f16so2290879qkl.9
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 06:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RBWAdGFiPaVF7xHv33PTzjWf18foUqQK8H9n24b6WuQ=;
        b=gn/d0klq4fHlF7txrOQy8xmJGO+/PYCuM3W4epHvJCzMp93QLakLIeleCILOcis5bM
         jM5Xz6XTyHGsuOsqGC/t4ARgq42QsmM1Q8z6pKQbkgrIsp82kHJgLTl8W67EObiW5Ezc
         qiz6jbfs8jWXW6LSgXKSjIuwFNLP6a2/NFOn1Aewn0HI+ZYQdUgKwS/Efms5BPfW+GH8
         2+ZFWjmGQKr3JS6NqLely0UXrQVo9UN9jJFwfkfGg9696ys1EhDze97r39g+JtwUwZ3e
         ZNRLjOCnh2kEIikwcjq/vvXXMlJT5VWkH67RELg1zBtnGCwvuA9a9B6YAmlhDwUj9zAT
         BSsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RBWAdGFiPaVF7xHv33PTzjWf18foUqQK8H9n24b6WuQ=;
        b=Vc1UKnCqEu2LSYs4Psm5GbZ5/+LdevitAqK7Y1zUSpvSU4i+WRczffvV2WyeSWu9lu
         JK+jvuCLsMvNv4ijyfv8UFEHSeC0GbHFVyMgSHO3X5S65KQ7m9cUfgYPCHofJU5XIwLr
         nQRWZZj30ZQX824U6/1EDrQmXJS25o2UGlIvb80E+Heul5VMQQVUI3FnL45qSE6pqHG9
         DwpQ7Dnv9kzuI1ezp/qNcmIJJ00RBicoFnRBxHntj4ogl8czumKPQr7y6QFmRNsNeQvt
         gHiNCqpQELjNGnyCE3JvbClYJV6KYTgC4fq/A8iOpdqmVTAp7Bta/lxA0YwYOKUst+FR
         t5oA==
X-Gm-Message-State: APjAAAWsyY27gwImSoUlzrvdmyWYp+5CuAV4NvNRzDpT6yPfW9D0q/62
        kBOalH2diQi3L1BZZwL73NM=
X-Google-Smtp-Source: APXvYqyTfdNt3OVNE0ccaFDQIXi/nGE0g0fclgAjb16jTizTDL6c9f7aUU6ihaPyivaOZRvlSJPOdA==
X-Received: by 2002:a37:a9c1:: with SMTP id s184mr4307487qke.360.1570109135284;
        Thu, 03 Oct 2019 06:25:35 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id b50sm1646593qte.48.2019.10.03.06.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 06:25:33 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8CFE940DD3; Thu,  3 Oct 2019 10:25:31 -0300 (-03)
Date:   Thu, 3 Oct 2019 10:25:31 -0300
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] perf scripts python: exported-sql-viewer.py: Add
 Time chart by CPU
Message-ID: <20191003132531.GA9369@kernel.org>
References: <20190821083216.1340-1-adrian.hunter@intel.com>
 <6f55cdb7-a431-bd1b-8e7f-f8caf92399af@intel.com>
 <ed9138ac-d035-1be7-9fbd-e82e7f9ca6d0@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed9138ac-d035-1be7-9fbd-e82e7f9ca6d0@intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Oct 03, 2019 at 02:01:16PM +0300, Adrian Hunter escreveu:
> On 6/09/19 11:57 AM, Adrian Hunter wrote:
> > On 21/08/19 11:32 AM, Adrian Hunter wrote:
> >> Hi
> >>
> >> These patches to exported-sql-viewer.py, add a time chart based on context
> >> switch information.  Context switch information was added to the database
> >> export fairly recently, so the chart menu option will only appear if
> >> context switch information is in the database.  Refer to the Exported SQL
> >> Viewer Help option for more information about the chart.
> >>
> >>
> >> Adrian Hunter (6):
> >>       perf scripts python: exported-sql-viewer.py: Add LookupModel()
> >>       perf scripts python: exported-sql-viewer.py: Add HBoxLayout and VBoxLayout
> >>       perf scripts python: exported-sql-viewer.py: Add global time range calculations
> >>       perf scripts python: exported-sql-viewer.py: Tidy up Call tree call_time
> >>       perf scripts python: exported-sql-viewer.py: Add ability for Call tree to open at a specified task and time
> >>       perf scripts python: exported-sql-viewer.py: Add Time chart by CPU
> >>
> >>  tools/perf/scripts/python/exported-sql-viewer.py | 1555 +++++++++++++++++++++-
> >>  1 file changed, 1531 insertions(+), 24 deletions(-)
> > 
> > Any comments?
> > 
> 
> ping

Nice stuff, but please next time, when you add a new UI accessible
visualization, provide precise steps to collect, then generate the DB
and finally run the GUI, so that interested people (like me, when
testing) can follow those instructions and compare the result described
to the graph the test would see following these instructions.

I'm trying to do that now.

- Arnaldo
