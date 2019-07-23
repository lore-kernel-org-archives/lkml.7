Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB6C1C7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 11:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ECBF20838
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 11:42:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730868AbfGWLmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 07:42:54 -0400
Received: from outbound-smtp35.blacknight.com ([46.22.139.218]:45974 "EHLO
        outbound-smtp35.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726575AbfGWLmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 07:42:53 -0400
Received: from mail.blacknight.com (unknown [81.17.255.152])
        by outbound-smtp35.blacknight.com (Postfix) with ESMTPS id 1FBC2E69
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 12:42:51 +0100 (IST)
Received: (qmail 12414 invoked from network); 23 Jul 2019 11:42:50 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.21.36])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 23 Jul 2019 11:42:50 -0000
Date:   Tue, 23 Jul 2019 12:42:48 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Matt Fleming <matt@codeblueprint.co.uk>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v3] sched/topology: Improve load balancing on AMD EPYC
Message-ID: <20190723114248.GJ24383@techsingularity.net>
References: <20190723104830.26623-1-matt@codeblueprint.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20190723104830.26623-1-matt@codeblueprint.co.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 11:48:30AM +0100, Matt Fleming wrote:
> SD_BALANCE_{FORK,EXEC} and SD_WAKE_AFFINE are stripped in sd_init()
> for any sched domains with a NUMA distance greater than 2 hops
> (RECLAIM_DISTANCE). The idea being that it's expensive to balance
> across domains that far apart.
> 
> However, as is rather unfortunately explained in
> 
>   commit 32e45ff43eaf ("mm: increase RECLAIM_DISTANCE to 30")
> 
> the value for RECLAIM_DISTANCE is based on node distance tables from
> 2011-era hardware.
> 
> Current AMD EPYC machines have the following NUMA node distances:
> 
> node distances:
> node   0   1   2   3   4   5   6   7
>   0:  10  16  16  16  32  32  32  32
>   1:  16  10  16  16  32  32  32  32
>   2:  16  16  10  16  32  32  32  32
>   3:  16  16  16  10  32  32  32  32
>   4:  32  32  32  32  10  16  16  16
>   5:  32  32  32  32  16  10  16  16
>   6:  32  32  32  32  16  16  10  16
>   7:  32  32  32  32  16  16  16  10
> 
> where 2 hops is 32.
> 
> The result is that the scheduler fails to load balance properly across
> NUMA nodes on different sockets -- 2 hops apart.
> 
> For example, pinning 16 busy threads to NUMA nodes 0 (CPUs 0-7) and 4
> (CPUs 32-39) like so,
> 
>   $ numactl -C 0-7,32-39 ./spinner 16
> 
> causes all threads to fork and remain on node 0 until the active
> balancer kicks in after a few seconds and forcibly moves some threads
> to node 4.
> 
> Override node_reclaim_distance for AMD Zen.
> 
> Signed-off-by: Matt Fleming <matt@codeblueprint.co.uk>
> Cc: "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
> Cc: Borislav Petkov <bp@alien8.de>

Acked-by: Mel Gorman <mgorman@techsingularity.net>

The only caveat I can think of is that a future generation of Zen might
take a different magic number than 32 as their remote distance. If or
when this happens, it'll need additional smarts but lacking a crystal
ball, we can cross that bridge when we come to it.

-- 
Mel Gorman
SUSE Labs
