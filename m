Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01931C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D466A20578
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:09:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392964AbfHBNJb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 09:09:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48538 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389781AbfHBNJa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 09:09:30 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 33C6F3082E20;
        Fri,  2 Aug 2019 13:09:30 +0000 (UTC)
Received: from krava (ovpn-204-20.brq.redhat.com [10.40.204.20])
        by smtp.corp.redhat.com (Postfix) with SMTP id B3F02600C8;
        Fri,  2 Aug 2019 13:09:27 +0000 (UTC)
Date:   Fri, 2 Aug 2019 15:09:26 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Tan Xiaojun <tanxiaojun@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        songliubraving@fb.com, rostedt@goodmis.org,
        kan.liang@linux.intel.com, tz.stoyanov@gmail.com,
        alexey.budankov@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf record: Support aarch64 random socket_id assignment
Message-ID: <20190802130926.GB27223@krava>
References: <1564717737-21602-1-git-send-email-tanxiaojun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1564717737-21602-1-git-send-email-tanxiaojun@huawei.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Fri, 02 Aug 2019 13:09:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2019 at 11:48:57AM +0800, Tan Xiaojun wrote:
> Same as the commit 01766229533f ("perf record: Support s390 random
> socket_id assignment"), aarch64 also have this problem.
> 
> Without this fix:
>   [root@localhost perf]# ./perf report --header -I -v
>   ...
>   socket_id number is too big.You may need to upgrade the perf tool.
> 
>   # ========
>   # captured on    : Thu Aug  1 22:58:38 2019
>   # header version : 1
>   ...
>   # Core ID and Socket ID information is not available
>   ...
> 
> With this fix:
>   [root@localhost perf]# ./perf report --header -I -v
>   ...
>   cpumask list: 0-31
>   cpumask list: 32-63
>   cpumask list: 64-95
>   cpumask list: 96-127
> 
>   # ========
>   # captured on    : Thu Aug  1 22:58:38 2019
>   # header version : 1
>   ...
>   # CPU 0: Core ID 0, Socket ID 36
>   # CPU 1: Core ID 1, Socket ID 36
>   ...
>   # CPU 126: Core ID 126, Socket ID 8442
>   # CPU 127: Core ID 127, Socket ID 8442
>   ...
> 
> Signed-off-by: Tan Xiaojun <tanxiaojun@huawei.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> ---
>  tools/perf/util/header.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index 20111f8..d57fb74 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -2251,8 +2251,10 @@ static int process_cpu_topology(struct feat_fd *ff, void *data __maybe_unused)
>  	/* On s390 the socket_id number is not related to the numbers of cpus.
>  	 * The socket_id number might be higher than the numbers of cpus.
>  	 * This depends on the configuration.
> +	 * AArch64 is the same.
>  	 */
> -	if (ph->env.arch && !strncmp(ph->env.arch, "s390", 4))
> +	if (ph->env.arch && (!strncmp(ph->env.arch, "s390", 4)
> +			  || !strncmp(ph->env.arch, "aarch64", 7)))
>  		do_core_id_test = false;
>  
>  	for (i = 0; i < (u32)cpu_nr; i++) {
> -- 
> 2.7.4
> 
