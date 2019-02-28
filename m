Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56EBBC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 16:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 298E92133D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 16:12:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731725AbfB1QMe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 11:12:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53468 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726403AbfB1QMd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 11:12:33 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BD31F14D015;
        Thu, 28 Feb 2019 16:12:33 +0000 (UTC)
Received: from krava (unknown [10.43.17.18])
        by smtp.corp.redhat.com (Postfix) with SMTP id 168BF4384;
        Thu, 28 Feb 2019 16:12:31 +0000 (UTC)
Date:   Thu, 28 Feb 2019 17:12:31 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, eranian@google.com,
        linux-kernel@vger.kernel.org, tonyj@suse.com, nasastry@in.ibm.com
Subject: Re: [PATCH] perf c2c: Fix c2c report for empty numa node
Message-ID: <20190228161231.GB8674@krava>
References: <20190228153719.23411-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190228153719.23411-1-ravi.bangoria@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 28 Feb 2019 16:12:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 09:07:19PM +0530, Ravi Bangoria wrote:
> perf c2c report fails if system has empty numa node(0 cpus):
> 
>   $ lscpu
>   NUMA node0 CPU(s):   
>   NUMA node1 CPU(s):   0-4
> 
>   $ sudo ./perf c2c report 
>   node/cpu topology bugFailed setup nodes
> 
> Fix this.
> 
> Reported-by: Nageswara R Sastry <nasastry@in.ibm.com>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> ---
>  tools/perf/util/cpumap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
> index 383674f448fc..517c3f37c613 100644
> --- a/tools/perf/util/cpumap.c
> +++ b/tools/perf/util/cpumap.c
> @@ -261,7 +261,7 @@ struct cpu_map *cpu_map__dummy_new(void)
>  	struct cpu_map *cpus = malloc(sizeof(*cpus) + sizeof(int));
>  
>  	if (cpus != NULL) {
> -		cpus->nr = 1;
> +		cpus->nr = 0;

you can't do this, there's one item in the map, nr needs to
reflect that.. it breaks 'perf test' badly

so the node is empty.. we need to teach c2c to work with that
I'll check

jirka

>  		cpus->map[0] = -1;
>  		refcount_set(&cpus->refcnt, 1);
>  	}
> -- 
> 2.17.1
> 
