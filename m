Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48211C3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 10:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1768B2053B
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 10:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733156AbfHVKK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 06:10:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38098 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726422AbfHVKK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 06:10:28 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F29758D5BAB;
        Thu, 22 Aug 2019 10:10:27 +0000 (UTC)
Received: from krava (unknown [10.43.17.33])
        by smtp.corp.redhat.com (Postfix) with SMTP id 042C160E1C;
        Thu, 22 Aug 2019 10:10:26 +0000 (UTC)
Date:   Thu, 22 Aug 2019 12:10:26 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     acme@kernel.org, linux-kernel@vger.kernel.org,
        Nageswara R Sastry <nasastry@in.ibm.com>
Subject: Re: [PATCH] perf c2c: Fix report with offline cpus
Message-ID: <20190822101026.GE28439@krava>
References: <20190822085045.25108-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822085045.25108-1-ravi.bangoria@linux.ibm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.69]); Thu, 22 Aug 2019 10:10:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2019 at 02:20:45PM +0530, Ravi Bangoria wrote:
> If c2c is recorded on a machine where any cpus are offline,
> 'perf c2c report' throws an error "node/cpu topology bugFailed
> setup nodes". It fails because while preparing node-cpu mapping
> we don't consider offline cpus.
> 
> Fixes: 1e181b92a2da ("perf c2c report: Add 'node' sort key")
> Reported-by: Nageswara R Sastry <nasastry@in.ibm.com>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> ---
>  tools/perf/builtin-c2c.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> index 9e6cc86..fc68a94 100644
> --- a/tools/perf/builtin-c2c.c
> +++ b/tools/perf/builtin-c2c.c
> @@ -2027,7 +2027,7 @@ static int setup_nodes(struct perf_session *session)
>  		c2c.node_info = 2;
>  
>  	c2c.nodes_cnt = session->header.env.nr_numa_nodes;
> -	c2c.cpus_cnt  = session->header.env.nr_cpus_online;
> +	c2c.cpus_cnt  = session->header.env.nr_cpus_avail;
>  
>  	n = session->header.env.numa_nodes;
>  	if (!n)
> -- 
> 1.8.3.1
> 
