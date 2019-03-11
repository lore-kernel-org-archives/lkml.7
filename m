Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9EFBC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C86AD2075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:56:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbfCKR4x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 13:56:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50494 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726675AbfCKR4w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 13:56:52 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 75E62882F5;
        Mon, 11 Mar 2019 17:56:51 +0000 (UTC)
Received: from krava (ovpn-204-107.brq.redhat.com [10.40.204.107])
        by smtp.corp.redhat.com (Postfix) with SMTP id C88435C26D;
        Mon, 11 Mar 2019 17:56:48 +0000 (UTC)
Date:   Mon, 11 Mar 2019 18:56:47 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, peterz@infradead.org, acme@redhat.com,
        jolsa@kernel.org, namhyung@kernel.org
Subject: Re: [PATCH v7 perf,bpf 09/15] perf, bpf: save btf information as
 headers to perf.data
Message-ID: <20190311175647.GB19721@krava>
References: <20190307175810.249857-1-songliubraving@fb.com>
 <20190307175810.249857-10-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307175810.249857-10-songliubraving@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Mon, 11 Mar 2019 17:56:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 09:58:04AM -0800, Song Liu wrote:
> This patch enables perf-record to save btf information as headers to
> perf.data A new header type HEADER_BPF_BTF is introduced for this data.
> 
> Signed-off-by: Song Liu <songliubraving@fb.com>
> ---
>  tools/perf/util/header.c | 107 ++++++++++++++++++++++++++++++++++++++-
>  tools/perf/util/header.h |   1 +
>  2 files changed, 107 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index f0708188211e..e31344de20c4 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -1124,6 +1124,45 @@ static int write_bpf_prog_info(struct feat_fd *ff,
>  	return ret;
>  }
>  
> +static int write_bpf_btf(struct feat_fd *ff,
> +			 struct perf_evlist *evlist __maybe_unused)
> +{
> +	struct perf_env *env = &ff->ph->env;
> +	struct rb_root *root;
> +	struct rb_node *next;
> +	u32 count = 0;
> +	int ret;
> +
> +	down_read(&env->bpf_progs.lock);
> +
> +	root = &env->bpf_progs.btfs;
> +	next = rb_first(root);
> +	while (next) {
> +		++count;
> +		next = rb_next(next);
> +	}

same here.. why you don't keep btf count in perf_env::bpf_progs::btfs_cnt ?

jirka

> +
> +	ret = do_write(ff, &count, sizeof(count));
> +
> +	if (ret < 0)
> +		goto out;
> +
> +	next = rb_first(root);
> +	while (next) {
> +		struct btf_node *node;
> +
> +		node = rb_entry(next, struct btf_node, rb_node);
> +		next = rb_next(&node->rb_node);
> +		ret = do_write(ff, &node->id,
> +			       sizeof(u32) * 2 + node->data_size);
> +		if (ret < 0)
> +			goto out;
> +	}
> +out:
> +	up_read(&env->bpf_progs.lock);
> +	return ret;
> +}
> +
>  static int cpu_cache_level__sort(const void *a, const void *b)
>  {
>  	struct cpu_cache_level *cache_a = (struct cpu_cache_level *)a;
> @@ -1627,6 +1666,28 @@ static void print_bpf_prog_info(struct feat_fd *ff, FILE *fp)
>  	up_read(&env->bpf_progs.lock);
>  }
>  
> +static void print_bpf_btf(struct feat_fd *ff, FILE *fp)
> +{
> +	struct perf_env *env = &ff->ph->env;
> +	struct rb_root *root;
> +	struct rb_node *next;
> +
> +	down_read(&env->bpf_progs.lock);
> +
> +	root = &env->bpf_progs.btfs;
> +	next = rb_first(root);
> +
> +	while (next) {
> +		struct btf_node *node;
> +
> +		node = rb_entry(next, struct btf_node, rb_node);
> +		next = rb_next(&node->rb_node);
> +		fprintf(fp, "# btf info of id %u\n", node->id);
> +	}
> +
> +	up_read(&env->bpf_progs.lock);
> +}
> +
>  static void free_event_desc(struct perf_evsel *events)
>  {
>  	struct perf_evsel *evsel;
> @@ -2728,6 +2789,49 @@ static int process_bpf_prog_info(struct feat_fd *ff,
>  	return err;
>  }
>  
> +static int process_bpf_btf(struct feat_fd *ff, void *data __maybe_unused)
> +{
> +	struct perf_env *env = &ff->ph->env;
> +	u32 count, i;
> +
> +	if (ff->ph->needs_swap) {
> +		pr_warning("interpreting btf from systems with endianity is not yet supported\n");
> +		return 0;
> +	}
> +
> +	if (do_read_u32(ff, &count))
> +		return -1;
> +
> +	down_write(&env->bpf_progs.lock);
> +
> +	for (i = 0; i < count; ++i) {
> +		struct btf_node *node;
> +		u32 id, data_size;
> +
> +		if (do_read_u32(ff, &id))
> +			return -1;
> +		if (do_read_u32(ff, &data_size))
> +			return -1;
> +
> +		node = malloc(sizeof(struct btf_node) + data_size);
> +		if (!node)
> +			return -1;
> +
> +		node->id = id;
> +		node->data_size = data_size;
> +
> +		if (__do_read(ff, node->data, data_size)) {
> +			free(node);
> +			return -1;
> +		}
> +
> +		perf_env__insert_btf(env, node);
> +	}
> +
> +	up_write(&env->bpf_progs.lock);
> +	return 0;
> +}
> +
>  struct feature_ops {
>  	int (*write)(struct feat_fd *ff, struct perf_evlist *evlist);
>  	void (*print)(struct feat_fd *ff, FILE *fp);
> @@ -2788,7 +2892,8 @@ static const struct feature_ops feat_ops[HEADER_LAST_FEATURE] = {
>  	FEAT_OPR(SAMPLE_TIME,	sample_time,	false),
>  	FEAT_OPR(MEM_TOPOLOGY,	mem_topology,	true),
>  	FEAT_OPR(CLOCKID,       clockid,        false),
> -	FEAT_OPR(BPF_PROG_INFO, bpf_prog_info,  false)
> +	FEAT_OPR(BPF_PROG_INFO, bpf_prog_info,  false),
> +	FEAT_OPR(BPF_BTF,       bpf_btf,        false)
>  };
>  
>  struct header_print_data {
> diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
> index 0785c91b4c3a..9e7d931f7c0d 100644
> --- a/tools/perf/util/header.h
> +++ b/tools/perf/util/header.h
> @@ -40,6 +40,7 @@ enum {
>  	HEADER_MEM_TOPOLOGY,
>  	HEADER_CLOCKID,
>  	HEADER_BPF_PROG_INFO,
> +	HEADER_BPF_BTF,
>  	HEADER_LAST_FEATURE,
>  	HEADER_FEAT_BITS	= 256,
>  };
> -- 
> 2.17.1
> 
