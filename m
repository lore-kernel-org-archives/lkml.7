Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D28C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 09:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 597312075C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 09:00:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbfE1JAK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 05:00:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39802 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726492AbfE1JAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 05:00:09 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C1C5930833AF;
        Tue, 28 May 2019 09:00:09 +0000 (UTC)
Received: from krava (unknown [10.43.17.32])
        by smtp.corp.redhat.com (Postfix) with SMTP id 4EB2A611B1;
        Tue, 28 May 2019 09:00:08 +0000 (UTC)
Date:   Tue, 28 May 2019 11:00:07 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, jolsa@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        ak@linux.intel.com
Subject: Re: [PATCH 1/3] perf header: Add die information in CPU topology
Message-ID: <20190528090007.GE27906@krava>
References: <1558644081-17738-1-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1558644081-17738-1-git-send-email-kan.liang@linux.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Tue, 28 May 2019 09:00:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 01:41:19PM -0700, kan.liang@linux.intel.com wrote:

SNIP

>  	if (sret <= 0)
> -		goto try_threads;
> +		goto try_dies;
>  
>  	p = strchr(buf, '\n');
>  	if (p)
> @@ -57,6 +78,35 @@ static int build_cpu_topology(struct cpu_topology *tp, int cpu)
>  	}
>  	ret = 0;
>  
> +try_dies:
> +	if (has_die) {

less depth..

	if (!has_die())
		goto try_threads;


	scnprintf(filename, MAXPATHLEN, DIE_SIB_FMT,
		  sysfs__mountpoint(), cpu);
	...

> +		scnprintf(filename, MAXPATHLEN, DIE_SIB_FMT,
> +			  sysfs__mountpoint(), cpu);
> +		fp = fopen(filename, "r");
> +		if (!fp)
> +			goto try_threads;
> +
> +		sret = getline(&buf, &len, fp);
> +		fclose(fp);
> +		if (sret <= 0)
> +			goto try_threads;
> +
> +		p = strchr(buf, '\n');
> +		if (p)
> +			*p = '\0';
> +
> +		for (i = 0; i < tp->die_sib; i++) {
> +			if (!strcmp(buf, tp->die_siblings[i]))
> +				break;
> +		}
> +		if (i == tp->die_sib) {
> +			tp->die_siblings[i] = buf;
> +			tp->die_sib++;
> +			buf = NULL;
> +			len = 0;
> +		}
> +		ret = 0;
> +	}
>  try_threads:
>  	scnprintf(filename, MAXPATHLEN, THRD_SIB_FMT,

SNIP
