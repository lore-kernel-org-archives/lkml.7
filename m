Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE25C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 13:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A6C320652
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 13:53:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbfCDNxq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 08:53:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:21722 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726094AbfCDNxo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 08:53:44 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2201E85545;
        Mon,  4 Mar 2019 13:53:44 +0000 (UTC)
Received: from krava (unknown [10.43.17.112])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1E7B02CFD6;
        Mon,  4 Mar 2019 13:53:41 +0000 (UTC)
Date:   Mon, 4 Mar 2019 14:53:41 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        peterz@infradead.org, acme@redhat.com, jolsa@kernel.org,
        namhyung@kernel.org
Subject: Re: [PATCH v5 perf,bpf 08/15] perf, bpf: save btf in a rbtree in
 perf_env
Message-ID: <20190304135341.GK19809@krava>
References: <20190228050643.958685-1-songliubraving@fb.com>
 <20190228050643.958685-9-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190228050643.958685-9-songliubraving@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Mon, 04 Mar 2019 13:53:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 09:06:36PM -0800, Song Liu wrote:
> btf contains information necessary to annotate bpf programs. This patch
> saves btf for bpf programs loaded in the system.
> 
> Signed-off-by: Song Liu <songliubraving@fb.com>
> ---
>  tools/perf/util/bpf-event.c | 24 ++++++++++++++
>  tools/perf/util/bpf-event.h |  7 ++++
>  tools/perf/util/env.c       | 65 +++++++++++++++++++++++++++++++++++++
>  tools/perf/util/env.h       |  4 +++
>  4 files changed, 100 insertions(+)
> 
> diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
> index ce81b2c43a51..370b830f2433 100644
> --- a/tools/perf/util/bpf-event.c
> +++ b/tools/perf/util/bpf-event.c
> @@ -34,6 +34,29 @@ int machine__process_bpf_event(struct machine *machine __maybe_unused,
>  	return 0;
>  }
>  
> +static int perf_env__fetch_btf(struct perf_env *env,
> +			       u32 btf_id,
> +			       struct btf *btf)
> +{
> +	struct btf_node *node;
> +	u32 data_size;
> +	const void *data;
> +
> +	data = btf__get_raw_data(btf, &data_size);
> +
> +	node = malloc(data_size + sizeof(struct btf_node));
> +

extra new line

> +	if (!node)
> +		return -1;
> +
> +	node->id = btf_id;
> +	node->data_size = data_size;
> +	memcpy(node->data, data, data_size);
> +
> +	perf_env__insert_btf(env, node);
> +	return 0;
> +}

SNIP
