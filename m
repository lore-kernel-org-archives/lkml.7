Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B942CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 11:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4380021852
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 11:58:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codeblueprint-co-uk.20150623.gappssmtp.com header.i=@codeblueprint-co-uk.20150623.gappssmtp.com header.b="HFD3g+Y6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404538AbfJRL6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 07:58:53 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45143 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392487AbfJRL6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 07:58:53 -0400
Received: by mail-wr1-f65.google.com with SMTP id q13so981798wrs.12
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 04:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeblueprint-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3DByddWkc5cdTXqfZ8p4x/nfiNubhnhdBlB/o+i+ezM=;
        b=HFD3g+Y6OPB8fRJSvhg77Uh3VrsobKCLs+qlqxAsDrwyyaIR1S28n2tEgpMGmME3N1
         eSC8Y5L4spPuKlYR8IDXqVqPNkE3wCI57nEpQix5fZ1YSbdbMHfNnJ2PpqBII60CfCEy
         Ok14KMQdXroVK9EVkaLhU/WnvCdAn0n9Yah3KkgBKAeK6jWnnL950i+rFk0vvprF+Kgl
         VqJvd/gOuFEwIWQMsWaydU/DXQuhWBkZ7YMJEinq57kTrYMMSQMVXzK9KiODoYDMp4BE
         FlsEC7VTKImLcUvhnKjXjyBaTk5xpaLL5zLi8eShGH+77khULSLWGpfm6eAmW0CvOW3c
         TUUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3DByddWkc5cdTXqfZ8p4x/nfiNubhnhdBlB/o+i+ezM=;
        b=ncbv3OG4r3lf4CPWhA34x/7VohemlUGM0LYmbvqPe9XL7U7goVkzq3/aHpov9ck8KK
         ViM0wv9H7TTbFLue4ucnSWGfnDnkGjpJJKlBAINjRl61dJS598Ubh4I9DmLWnlBf9Dgf
         EuISJW8MucH3Y9bgPfMCaaldhi8W4nQSFpmdVvNCO4Xzthnt2jifPagUo8m3HsA2+h4s
         TCHpt/vAM+enRjMtTixbh3SIfF2ajtzUenjAOkYlxmTede4BSPF32ZZxZj1+AKhQ3dMW
         JncjCVK8z02UQeOhVmsdWlHhFP1b3Cdafx26mT5/ILQ0sPfz6mH9pqV8OWAVs2j0+Gvy
         JR/Q==
X-Gm-Message-State: APjAAAVL0TvyBS4h9AMcQWVY/O4q4j5qESJLxgQ4/CLqS53SUi/6nAg9
        t7Ev/lo6xpXRVdZmvT6CNuwim83YrZ0=
X-Google-Smtp-Source: APXvYqzdh7H6730oJvDIxHy9u1G9t2x+96YrbWxez+zHkilicBfh+IJpTmhTpIA8Xbhv6dcEfu+6hg==
X-Received: by 2002:a5d:638b:: with SMTP id p11mr7031669wru.372.1571399931236;
        Fri, 18 Oct 2019 04:58:51 -0700 (PDT)
Received: from localhost (97e34ace.skybroadband.com. [151.227.74.206])
        by smtp.gmail.com with ESMTPSA id a204sm6947970wmh.21.2019.10.18.04.58.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Oct 2019 04:58:50 -0700 (PDT)
Date:   Fri, 18 Oct 2019 12:58:49 +0100
From:   Matt Fleming <matt@codeblueprint.co.uk>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] Recalculate per-cpu page allocator batch and high
 limits after deferred meminit
Message-ID: <20191018115849.GH4065@codeblueprint.co.uk>
References: <20191018105606.3249-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018105606.3249-1-mgorman@techsingularity.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Oct, at 11:56:03AM, Mel Gorman wrote:
> A private report stated that system CPU usage was excessive on an AMD
> EPYC 2 machine while building kernels with much longer build times than
> expected. The issue is partially explained by high zone lock contention
> due to the per-cpu page allocator batch and high limits being calculated
> incorrectly. This series addresses a large chunk of the problem. Patch 1
> is mostly cosmetic but prepares for patch 2 which is the real fix. Patch
> 3 is definiely cosmetic but was noticed while implementing the fix. Proper
> details are in the changelog for patch 2.
> 
>  include/linux/mm.h |  3 ---
>  mm/internal.h      |  3 +++
>  mm/page_alloc.c    | 33 ++++++++++++++++++++-------------
>  3 files changed, 23 insertions(+), 16 deletions(-)

Just to confirm, these patches don't fix the issue we're seeing on the
EPYC 2 machines, but they do return the batch sizes to sensible values.
