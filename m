Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B1E8C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 08:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B04F2075C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 08:59:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfE1I7v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 04:59:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46154 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726576AbfE1I7u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 04:59:50 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D0F648830C;
        Tue, 28 May 2019 08:59:50 +0000 (UTC)
Received: from krava (unknown [10.43.17.32])
        by smtp.corp.redhat.com (Postfix) with SMTP id 62A805D6A9;
        Tue, 28 May 2019 08:59:49 +0000 (UTC)
Date:   Tue, 28 May 2019 10:59:48 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, jolsa@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        ak@linux.intel.com
Subject: Re: [PATCH 1/3] perf header: Add die information in CPU topology
Message-ID: <20190528085948.GB27906@krava>
References: <1558644081-17738-1-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1558644081-17738-1-git-send-email-kan.liang@linux.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Tue, 28 May 2019 08:59:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 01:41:19PM -0700, kan.liang@linux.intel.com wrote:

SNIP

> @@ -88,7 +138,7 @@ static int build_cpu_topology(struct cpu_topology *tp, int cpu)
>  	return ret;
>  }
>  
> -void cpu_topology__delete(struct cpu_topology *tp)
> +void cpu_topology__delete(struct cpu_topology *tp, bool has_die)
>  {
>  	u32 i;
>  
> @@ -98,17 +148,22 @@ void cpu_topology__delete(struct cpu_topology *tp)
>  	for (i = 0 ; i < tp->core_sib; i++)
>  		zfree(&tp->core_siblings[i]);
>  
> +	if (has_die) {

I think there's no need for has_die check in here,
tp->die_sib will be zero, and also will tp->die_siblings[i]

jirka

> +		for (i = 0 ; i < tp->die_sib; i++)
> +			zfree(&tp->die_siblings[i]);
> +	}
> +
>  	for (i = 0 ; i < tp->thread_sib; i++)
>  		zfree(&tp->thread_siblings[i]);
>  
>  	free(tp);
>  }

SNIP
