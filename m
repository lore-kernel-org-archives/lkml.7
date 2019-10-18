Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31443CA9EA4
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 11:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 074A42070B
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 11:57:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codeblueprint-co-uk.20150623.gappssmtp.com header.i=@codeblueprint-co-uk.20150623.gappssmtp.com header.b="ztw7KsP+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633664AbfJRL5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 07:57:32 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46685 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729946AbfJRL5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 07:57:32 -0400
Received: by mail-wr1-f65.google.com with SMTP id o18so5925333wrv.13
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 04:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeblueprint-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cqKbTMZTAZ43lyW2LyE54ks+iYd/xqP3DegJ6aJ/pVg=;
        b=ztw7KsP+2FzSh1VwPckD1Lo4Y5c/65/19/DCxaTr9KW8Yy9cNkuNApvx1jAW5o9G7O
         PpSJ3q19KKK7gJ07qX1+S+s2gUSebIzk7tv6AsAOMy/RCg7pyLEub3QyFb6z+HXjkmGx
         4NfFHtr8YlzqqXAB7liZv89LXbkYhNVYiRKHqQNm5k9MCaEmtiU4fnC1eKzuCqr+OxcL
         OzevzNiVpCfwSEYPqS6NVGlPVR2fjb65eSn90W/NO2A1t98alUTi5hSFXrE7gyO2K4nZ
         SuuHnrCVC7SY7AzOPPkCaCPjehjQmEb5zwmhQFxz9q6n1aC7DVH61JNWxfO9c+SM8qF7
         xzEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cqKbTMZTAZ43lyW2LyE54ks+iYd/xqP3DegJ6aJ/pVg=;
        b=IiWpVy4G0Y+GCaVqpgFO+wAUMETwQSisW4Q+tbijtEdodDame7xnrQReYliIr9op+P
         SaOfzm8f5XF8jBG1IlENvt0c7IwUX9g3Jreq1zc8rKSbbuUCpkqlU28OXuXmARf75i5M
         tCBhcjtsCMuUzqAP7z2H6SjXbUX7VvUAn4NqQBNlDkahZiJps6sOAHGovJUx3KFRfDh/
         TkYxFsxbThza6b1WmUdpqhNSung1QBdO+knde7BVxhpNFSGQxsPsFvxhQZ4aDVqNPzga
         h2I8IZVMNYVbLyDzeDCzs10PtmZpLon1I1NB1cAfQBHJfA+eG42e/+lyxZmdD2liemZI
         SXPw==
X-Gm-Message-State: APjAAAVn1RfUpAOYhMS/+xqx+f0wwBqqLeXwNJ1Zie5xTIHoYD7C2I3+
        39poj4UFzE5ekbort/0XFzXCRw==
X-Google-Smtp-Source: APXvYqyfCAk9xfZZth58XrWVeHXKOKtT2xpuI6jIbyzjLNQWiTeU6pk2f+91nr8hZ/rq0fGTLdJwxw==
X-Received: by 2002:a5d:51d2:: with SMTP id n18mr7379562wrv.225.1571399849601;
        Fri, 18 Oct 2019 04:57:29 -0700 (PDT)
Received: from localhost (97e34ace.skybroadband.com. [151.227.74.206])
        by smtp.gmail.com with ESMTPSA id z9sm5211325wrp.26.2019.10.18.04.57.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Oct 2019 04:57:28 -0700 (PDT)
Date:   Fri, 18 Oct 2019 12:57:28 +0100
From:   Matt Fleming <matt@codeblueprint.co.uk>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] mm, meminit: Recalculate pcpu batch and high limits
 after init completes
Message-ID: <20191018115728.GF4065@codeblueprint.co.uk>
References: <20191018105606.3249-1-mgorman@techsingularity.net>
 <20191018105606.3249-3-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018105606.3249-3-mgorman@techsingularity.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Oct, at 11:56:05AM, Mel Gorman wrote:
> Deferred memory initialisation updates zone->managed_pages during
> the initialisation phase but before that finishes, the per-cpu page
> allocator (pcpu) calculates the number of pages allocated/freed in
> batches as well as the maximum number of pages allowed on a per-cpu list.
> As zone->managed_pages is not up to date yet, the pcpu initialisation
> calculates inappropriately low batch and high values.
> 
> This increases zone lock contention quite severely in some cases with the
> degree of severity depending on how many CPUs share a local zone and the
> size of the zone. A private report indicated that kernel build times were
> excessive with extremely high system CPU usage. A perf profile indicated
> that a large chunk of time was lost on zone->lock contention.
> 
> This patch recalculates the pcpu batch and high values after deferred
> initialisation completes on each node. It was tested on a 2-socket AMD
> EPYC 2 machine using a kernel compilation workload -- allmodconfig and
> all available CPUs.
> 
> mmtests configuration: config-workload-kernbench-max
> Configuration was modified to build on a fresh XFS partition.
> 
> kernbench
>                                 5.4.0-rc3              5.4.0-rc3
>                                   vanilla         resetpcpu-v1r1
> Amean     user-256    13249.50 (   0.00%)    15928.40 * -20.22%*
> Amean     syst-256    14760.30 (   0.00%)     4551.77 *  69.16%*
> Amean     elsp-256      162.42 (   0.00%)      118.46 *  27.06%*
> Stddev    user-256       42.97 (   0.00%)       50.83 ( -18.30%)
> Stddev    syst-256      336.87 (   0.00%)       33.70 (  90.00%)
> Stddev    elsp-256        2.46 (   0.00%)        0.81 (  67.01%)
> 
>                    5.4.0-rc3   5.4.0-rc3
>                      vanillaresetpcpu-v1r1
> Duration User       39766.24    47802.92
> Duration System     44298.10    13671.93
> Duration Elapsed      519.11      387.65
> 
> The patch reduces system CPU usage by 69.16% and total build time by
> 27.06%. The variance of system CPU usage is also much reduced.
> 
> Cc: stable@vger.kernel.org # v4.15+
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> ---
>  mm/page_alloc.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

Tested-by: Matt Fleming <matt@codeblueprint.co.uk>
