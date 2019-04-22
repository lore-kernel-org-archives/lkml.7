Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F7DC282E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 09:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D132206A3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 09:36:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbfDVJge (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 05:36:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44896 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726164AbfDVJge (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 05:36:34 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DB5B4C00735C;
        Mon, 22 Apr 2019 09:36:33 +0000 (UTC)
Received: from krava (ovpn-204-20.brq.redhat.com [10.40.204.20])
        by smtp.corp.redhat.com (Postfix) with SMTP id B7C3160139;
        Mon, 22 Apr 2019 09:36:30 +0000 (UTC)
Date:   Mon, 22 Apr 2019 11:36:29 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Bo YU <tsu.yubo@gmail.com>
Cc:     peterz@infradead.org, acme@kernel.org,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH] perf bpf: return value with unlocking in
 perf_env__find_btf()
Message-ID: <20190422093629.GA1730@krava>
References: <20190422080138.10088-1-tsu.yubo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190422080138.10088-1-tsu.yubo@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Mon, 22 Apr 2019 09:36:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2019 at 04:01:38AM -0400, Bo YU wrote:
> In perf_env__find_btf(), returning without unlocking
> "env->bpf_progs.lock". There may be cause lockdep issue.
> 
> DEtected by CoversityScan, CID# 1444762:(program hangs(LOCK))
> 
> Fixes: 2db7b1e0bd49d: (perf bpf: Return NULL when RB tree lookup fails in perf_env__find_btf())

ugh, sry about that

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> Signed-off-by: Bo YU <tsu.yubo@gmail.com>
> ---
>  tools/perf/util/env.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
> index 9494f9dc61ec..6a3eaf7d9353 100644
> --- a/tools/perf/util/env.c
> +++ b/tools/perf/util/env.c
> @@ -115,8 +115,8 @@ struct btf_node *perf_env__find_btf(struct perf_env *env, __u32 btf_id)
>  	}
>  	node = NULL;
>  
> -	up_read(&env->bpf_progs.lock);
>  out:
> +	up_read(&env->bpf_progs.lock);
>  	return node;
>  }
>  
> -- 
> 2.11.0
> 
