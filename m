Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B92C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 13:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8940F20652
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 13:53:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfCDNxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 08:53:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38810 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725997AbfCDNxB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 08:53:01 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 23485308424E;
        Mon,  4 Mar 2019 13:53:01 +0000 (UTC)
Received: from krava (unknown [10.43.17.112])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1CC025D71D;
        Mon,  4 Mar 2019 13:52:58 +0000 (UTC)
Date:   Mon, 4 Mar 2019 14:52:58 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        peterz@infradead.org, acme@redhat.com, jolsa@kernel.org,
        namhyung@kernel.org
Subject: Re: [PATCH v5 perf,bpf 07/15] perf, bpf: save bpf_prog_info
 information as headers to perf.data
Message-ID: <20190304135258.GH19809@krava>
References: <20190228050643.958685-1-songliubraving@fb.com>
 <20190228050643.958685-8-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190228050643.958685-8-songliubraving@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Mon, 04 Mar 2019 13:53:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 09:06:35PM -0800, Song Liu wrote:
> This patch enables perf-record to save bpf_prog_info information as
> headers to perf.data. A new header type HEADER_BPF_PROG_INFO is
> introduced for this data.
> 
> Signed-off-by: Song Liu <songliubraving@fb.com>
> ---
>  tools/perf/util/header.c | 143 ++++++++++++++++++++++++++++++++++++++-
>  tools/perf/util/header.h |   1 +
>  2 files changed, 143 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index 4b88de5e9192..16f5bedb0b7d 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -18,6 +18,7 @@
>  #include <sys/utsname.h>
>  #include <linux/time64.h>
>  #include <dirent.h>
> +#include <bpf/libbpf.h>
>  
>  #include "evlist.h"
>  #include "evsel.h"
> @@ -39,6 +40,7 @@
>  #include "tool.h"
>  #include "time-utils.h"
>  #include "units.h"
> +#include "bpf-event.h"
>  
>  #include "sane_ctype.h"
>  
> @@ -1074,6 +1076,51 @@ static int write_clockid(struct feat_fd *ff,
>  			sizeof(ff->ph->env.clockid_res_ns));
>  }
>  
> +static int write_bpf_prog_info(struct feat_fd *ff,
> +			       struct perf_evlist *evlist __maybe_unused)
> +{
> +	struct perf_env *env = &ff->ph->env;
> +	struct rb_root *root;
> +	struct rb_node *next;
> +	u32 count = 0;
> +	int ret;
> +
> +	down_read(&env->bpf_progs.lock);
> +
> +	root = &env->bpf_progs.infos;
> +	next = rb_first(root);
> +	while (next) {
> +		++count;
> +		next = rb_next(next);
> +	}
> +
> +	ret = do_write(ff, &count, sizeof(count));
> +

extra new line

> +	if (ret < 0)
> +		goto out;
> +
> +	next = rb_first(root);
> +	while (next) {
> +		struct bpf_prog_info_node *node;
> +		size_t len;
> +
> +		node = rb_entry(next, struct bpf_prog_info_node, rb_node);
> +		next = rb_next(&node->rb_node);
> +		len = sizeof(struct bpf_prog_info_linear) +
> +			node->info_linear->data_len;
> +
> +		/* before writing to file, translate address to offset */
> +		bpf_program__bpil_addr_to_offs(node->info_linear);
> +		ret = do_write(ff, node->info_linear, len);
> +		bpf_program__bpil_offs_to_addr(node->info_linear);
> +		if (ret < 0)
> +			goto out;
> +	}
> +out:
> +	up_read(&env->bpf_progs.lock);
> +	return ret;
> +}

SNIP
