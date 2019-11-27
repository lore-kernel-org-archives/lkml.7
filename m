Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19580C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 15:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFE67206F0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 15:17:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bW9AS2bp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfK0PRC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 10:17:02 -0500
Received: from mail-qk1-f174.google.com ([209.85.222.174]:39310 "EHLO
        mail-qk1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbfK0PRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 10:17:02 -0500
Received: by mail-qk1-f174.google.com with SMTP id d124so4610955qke.6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 07:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j9s8MIAwgP2V8q4FHQD5j26d80Tql8W6mTALFA+V5ts=;
        b=bW9AS2bpwXVWOVpGrW+f1RfXbj/Wog9yzbJXdsMa6+2ERjiDMorozxUSa7YMh/vdQU
         udwsQTg+FdjlMbzjlrRIoTVOYY1Ymu8JplxbUFZrXIVavSIMFh+Pd/Py1wFI4KTW99dd
         vg9eZ3OxEAOriDONV2Iq+YR4B5WVxpSAOFJAv/NOqED+5XMdGobsALqyMVhLDwuw82BJ
         Vm0nl+1O/KxyNT9CLFc816uaBu55aU421f3g4zzlZYIGmUNLsehkUWE7T1Tdbu+N8LeR
         Pb9Gk3s/j0Wk5F2ju2J/QRt2s5LhCEMY0h2vLE9ER537EgjkE+Bn+kRikkeDlvzEatsg
         X4qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=j9s8MIAwgP2V8q4FHQD5j26d80Tql8W6mTALFA+V5ts=;
        b=J5f/2WtZ4Dxy5un4d0b+YEJszKS65mzI0xZIXMDr42SPD8HmXH0EKuYuiGROyzOBS6
         AtUV22Kq6Cd1Lf/TZAb+cTIlW58FdqlVGIo4Ya0bOTOVpqQWWLMjMEB5W/BsO8M2rGC2
         Iwwf3GWJ9JVC/K+dwGiVn06x0wz3N1CLHxzJpLStHfjcE5X5QHgMKgKvntEjwWxZw8ch
         aTIhfdhjWl4OWqAErqE32rsKT3+tRsXqAsU/kcmdu4YQe+QqrHRVC9StAyqk5BZVZghu
         U8yv2/n2Uy0HmMcOSwtc1Xq0gPsEMBOE8BFif7r2W3blbXx7zeu6bPZe2H89JcYqjtXZ
         GNjA==
X-Gm-Message-State: APjAAAWoGmZE6II3gRbBBirrJq1YVwy9KWHm7VnYR2GH4EkJf4MVvsik
        EFTDXGJyqa4om6PrAEBz+Z65kjFri3Q=
X-Google-Smtp-Source: APXvYqy19eAeu9WFKqDjUgFsOvtLoHhMQP6OQy0J1cPzLjB5cbVO8vT1B49WmBTieHyuyT8GMXYkiA==
X-Received: by 2002:a37:508b:: with SMTP id e133mr4687913qkb.21.1574867821283;
        Wed, 27 Nov 2019 07:17:01 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id u67sm6838534qkf.115.2019.11.27.07.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 07:17:00 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4663840D3E; Wed, 27 Nov 2019 12:16:57 -0300 (-03)
Date:   Wed, 27 Nov 2019 12:16:57 -0300
To:     Andi Kleen <andi@firstfloor.org>
Cc:     jolsa@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Optimize perf stat for large number of events/cpus
Message-ID: <20191127151657.GE22719@kernel.org>
References: <20191121001522.180827-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191121001522.180827-1-andi@firstfloor.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Nov 20, 2019 at 04:15:10PM -0800, Andi Kleen escreveu:
> [v8: Address review feedback. Only changes one patch.]
> 
> This patch kit optimizes perf stat for a large number of events 
> on systems with many CPUs and PMUs.
> 
> Some profiling shows that the most overhead is doing IPIs to
> all the target CPUs. We can optimize this by using sched_setaffinity
> to set the affinity to a target CPU once and then doing
> the perf operation for all events on that CPU. This requires
> some restructuring, but cuts the set up time quite a bit.
> 
> In theory we could go further by parallelizing these setups
> too, but that would be much more complicated and for now just batching it
> per CPU seems to be sufficient. At some point with many more cores 
> parallelization or a better bulk perf setup API might be needed though.
> 
> In addition perf does a lot of redundant /sys accesses with
> many PMUs, which can be also expensve. This is also optimized.
> 
> On a large test case (>700 events with many weak groups) on a 94 CPU
> system I go from
> 
> real	0m8.607s
> user	0m0.550s
> sys	0m8.041s
> 
> to 
> 
> real	0m3.269s
> user	0m0.760s
> sys	0m1.694s
> 
> so shaving ~6 seconds of system time, at slightly more cost
> in perf stat itself. On a 4 socket system the savings
> are more dramatic:
> 
> real	0m15.641s
> user	0m0.873s
> sys	0m14.729s
> 
> to 
> 
> real	0m4.493s
> user	0m1.578s
> sys	0m2.444s
> 
> so 11s difference in the user visible set up time.

Applied to my local perf/core branch, now undergoing test builds on all
the containers.

Thanks,

- Arnaldo
