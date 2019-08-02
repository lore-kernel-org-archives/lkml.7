Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BDD8C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AFB22087C
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:14:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390825AbfHBNOo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 09:14:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48120 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726997AbfHBNOn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 09:14:43 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5C58E307D97F;
        Fri,  2 Aug 2019 13:14:43 +0000 (UTC)
Received: from krava (ovpn-204-20.brq.redhat.com [10.40.204.20])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1F3575D704;
        Fri,  2 Aug 2019 13:14:40 +0000 (UTC)
Date:   Fri, 2 Aug 2019 15:14:40 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Vince Weaver <vincent.weaver@maine.edu>
Cc:     linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Chong Jiang <chongjiang@chromium.org>,
        Simon Que <sque@chromium.org>
Subject: Re: [patch] perf.data documentation clarify HEADER_SAMPLE_TOPOLOGY
 format
Message-ID: <20190802131440.GC27223@krava>
References: <alpine.DEB.2.21.1908011425240.14303@macbook-air>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1908011425240.14303@macbook-air>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Fri, 02 Aug 2019 13:14:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2019 at 02:30:43PM -0400, Vince Weaver wrote:
> 
> The perf.data file format documentation for HEADER_SAMPLE_TOPOLOGY 
> specifies the layout in a confusing manner that doesn't match the rest of 
> the document.  This patch attempts to describe things consistent with the 
> rest of the file.
> 
> Signed-off-by: Vince Weaver <vincent.weaver@maine.edu>
> 
> diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
> index 5f54feb19977..6a7dceaae709 100644
> --- a/tools/perf/Documentation/perf.data-file-format.txt
> +++ b/tools/perf/Documentation/perf.data-file-format.txt
> @@ -298,16 +298,21 @@ Physical memory map and its node assignments.
>  
>  The format of data in MEM_TOPOLOGY is as follows:
>  
> -   0 - version          | for future changes
> -   8 - block_size_bytes | /sys/devices/system/memory/block_size_bytes
> -  16 - count            | number of nodes
> -
> -For each node we store map of physical indexes:
> -
> -  32 - node id          | node index
> -  40 - size             | size of bitmap
> -  48 - bitmap           | bitmap of memory indexes that belongs to node
> -                        | /sys/devices/system/node/node<NODE>/memory<INDEX>
> +	u64 version;            // Currently 1
> +	u64 block_size_bytes;   // /sys/devices/system/memory/block_size_bytes
> +	u64 count;              // number of nodes
> +
> +struct memory_node {
> +        u64 node_id;            // node index
> +        u64 size;               // size of bitmap
> +        struct bitmap {
> +		/* size of bitmap again */
> +                u64 bitmapsize; 
> +		/* bitmap of memory indexes that belongs to node     */
> +		/* /sys/devices/system/node/node<NODE>/memory<INDEX> */
> +                u64 entries[(bitmapsize/64)+1];
> +        }
> +}[count];

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks for doing this,
jirka

>  
>  The MEM_TOPOLOGY can be displayed with following command:
>  
