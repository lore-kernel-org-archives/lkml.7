Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E1C9C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 23:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A33A2070B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 23:57:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fn117XOy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbfEBX53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 19:57:29 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:34360 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfEBX52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 19:57:28 -0400
Received: by mail-yw1-f65.google.com with SMTP id u14so3007314ywe.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 16:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EE06RsH7Tkva/Npw1lMECDLy4qE+nCcrBntWLVP0R9g=;
        b=fn117XOyH0cSN3O6iusnt/ATsEbkg9rd4BWpkhryuiKm7JI7R66cThuH2lpHr1t8ib
         sgAizKNfgXxZ9IhKaxmDhvhmjqoyIm4w8qMh5gxAMbj9b47ey7XJLs7BFRvkxXTcgkIq
         G3SPBvC6gNbdfA93fTyD0u+0V7FR96ZytAdNGrYHKJh3jcBXXKrjdmSxgKNh+x0K0Zdq
         LCO4KNvIXs64e5Jb7avPrt2mrNatWJjBDRMY3+/qznG+8nVYik30GN/t8cyFI6euGrEV
         N6rOVIsS+ZrD48GP7pzImhHJEKPtgUUZcSVjqQz9P04N9TDNsvYMc0gHjfORtd/ABF6J
         8E1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EE06RsH7Tkva/Npw1lMECDLy4qE+nCcrBntWLVP0R9g=;
        b=ouYMraHDdVpUMPNfBfflHqFXif69+ao+753zKLC8PDgPrtvxl6dmO5tjHPJjnAkPd0
         Z8jH++NwafBGMvQHFkn0rcv6DIb25W6qaIG4dQChOK4Uap0ID15zbPS42LC1iK0Ehghx
         oWH5nyIB2v+VvohJrsbkR6ban7WHZ8REwEro/B3EXAtbU4SULvCTM11zL7p08ujkX7Lg
         Sa9c0c22gkR10ul0d8CsrLyf8r92Ldr5oVTHOa/S0HeYgHt8wNfqM95NyOeLt4VQCrP1
         OhwtfW6scgSEOHmyWuseOnoCkJQPDzaMRt+ZDb2MKW8M8DL9VXkVcc5csnon1I24vDsf
         WWaQ==
X-Gm-Message-State: APjAAAXClAXi2fqIgAtNfO4SmZgz8NE2VojHlR9cYZ8FuscmdetpTG+I
        CFecZTyTDZaTwzGjLr0295ltnWUJ
X-Google-Smtp-Source: APXvYqzupcVaEDBfCwki/SBj2h0ILR1tTa6kGXJlbx3w3zFdETjDayqzZl8bJihWIZ4ZoZid9FJaVQ==
X-Received: by 2002:a25:7313:: with SMTP id o19mr5200829ybc.135.1556841447649;
        Thu, 02 May 2019 16:57:27 -0700 (PDT)
Received: from quaco.ghostprotocols.net (adsl-173-228-226-134.prtc.net. [173.228.226.134])
        by smtp.gmail.com with ESMTPSA id x66sm197514ywg.47.2019.05.02.16.57.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 May 2019 16:57:26 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 50CAC403AD; Thu,  2 May 2019 19:57:25 -0400 (EDT)
Date:   Thu, 2 May 2019 19:57:25 -0400
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Will Deacon <will.deacon@arm.com>, Jiri Olsa <jolsa@redhat.com>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "moderated list:ARM PMU PROFILING AND DEBUGGING" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] perf vendor events arm64: Map Brahma-B53 CPUID to
 cortex-a53 events
Message-ID: <20190502235725.GB22982@kernel.org>
References: <20190405165047.15847-1-f.fainelli@gmail.com>
 <20190408162607.GB7872@fuggles.cambridge.arm.com>
 <46ac3066-fa55-9fb8-dd54-32fb702030cb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46ac3066-fa55-9fb8-dd54-32fb702030cb@gmail.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, May 02, 2019 at 02:28:02PM -0700, Florian Fainelli escreveu:
> On 4/8/19 9:26 AM, Will Deacon wrote:
> > On Fri, Apr 05, 2019 at 09:50:47AM -0700, Florian Fainelli wrote:
> >> Broadcom's Brahma-B53 CPUs support the same type of events that the
> >> Cortex-A53 supports, recognize its CPUID and map it to the cortex-a53
> >> events.
> >>
> >> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> >> ---
> >>  tools/perf/pmu-events/arch/arm64/mapfile.csv | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv b/tools/perf/pmu-events/arch/arm64/mapfile.csv
> >> index 59cd8604b0bd..e97c12484bc6 100644
> >> --- a/tools/perf/pmu-events/arch/arm64/mapfile.csv
> >> +++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
> >> @@ -13,6 +13,7 @@
> >>  #
> >>  #Family-model,Version,Filename,EventType
> >>  0x00000000410fd03[[:xdigit:]],v1,arm/cortex-a53,core
> >> +0x00000000420f100[[:xdigit:]],v1,arm/cortex-a53,core
> >>  0x00000000420f5160,v1,cavium/thunderx2,core
> >>  0x00000000430f0af0,v1,cavium/thunderx2,core
> >>  0x00000000480fd010,v1,hisilicon/hip08,core
> > 
> > Acked-by: Will Deacon <will.deacon@arm.com>
> 
> Thanks! Can this be picked up?

Thanks, applied to perf/core.

- Arnaldo
