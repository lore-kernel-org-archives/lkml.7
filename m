Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F00C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2520C2147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nx94K2O0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbfCLPON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 11:14:13 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41546 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbfCLPON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 11:14:13 -0400
Received: by mail-qk1-f194.google.com with SMTP id o129so1638888qke.8;
        Tue, 12 Mar 2019 08:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=miPBdVFDY1yx1gay7VkCn4TYDon3mT5T9G5gshzkRAQ=;
        b=nx94K2O08ryjTLo7LmpBNjRbTHJbVv6bswgX4+vf5i4BKaJP0jWAUrZZGrLyU+/I6b
         hsCKX7ltUOFcSpE2GCSQA9YvJEdrRNywsmZOHVW089WEORq7yIZecW8oJ49TjtDZLsY4
         Ap8y2J6EPMMzIBfahyIPiOovaXVBxqNgJF+DB/XNuWmVGAPVcUXSN+0GcIfOMLvzlfyz
         B1m9V0pcIPGqnxlfz3Pz9p0EHaazCQrTCKLend/YfM+A81TwsBfCtRCdsxNp/SW+pb9y
         trrmeOcOzR7t8Z/PM6D8La8ymdkY62MBwa46U7Ff05dPo1hm2hB35dGnGABU3+Vs93jO
         UxYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=miPBdVFDY1yx1gay7VkCn4TYDon3mT5T9G5gshzkRAQ=;
        b=V03k9hCdI7Na/X2RohA3RE5yGpE64+jC7JJ9+/zKGhiCv61AgMO0LXHGpC9KdpulzX
         rZlP4hXKs5VicEnfYk9Tr7sdcYjWR7lLKB7r51OjNiEwZdyryB4ZB3p/GH7x1ZqYIa/n
         GzQNdOj6htbKslb41BaeFiWIsrd0yBl6inlki1+iR0GN6JzPCuz4Xf/eND8Um+OB0hde
         ZDqoIMXlc/zDwHvA3T+abRBAJRXN3Ju4S8trLgF0il072L9VodPPQtswe/b/1yusOxWL
         pwx+Km1MHKkwGfWj5E9eHgLNu4FPLt9VGTSPNePfsQgPYNc0O/4vUQqhWEmOvNGmoWON
         /kgQ==
X-Gm-Message-State: APjAAAWDWZqwN9+Co0wDfQezsVmyJyPzxr0gtVL6Q/cBqaebcVPVJddh
        wF7KxXDK0MonZPYK/Iv4yHI=
X-Google-Smtp-Source: APXvYqww2mhVz5aTUAxaS+KmbqiFz1c2ICmfSqJv/aLSsqAMecU2a0KglMGqQ7zApM0ZaEjPb11TMQ==
X-Received: by 2002:a37:e212:: with SMTP id g18mr17414012qki.152.1552403651614;
        Tue, 12 Mar 2019 08:14:11 -0700 (PDT)
Received: from quaco.ghostprotocols.net (177-59-123-113.3g.claro.net.br. [177.59.123.113])
        by smtp.gmail.com with ESMTPSA id 24sm5816423qtu.17.2019.03.12.08.14.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 08:14:10 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 093D84039C; Tue, 12 Mar 2019 12:14:06 -0300 (-03)
Date:   Tue, 12 Mar 2019 12:14:05 -0300
To:     Song Liu <songliubraving@fb.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, peterz@infradead.org, acme@redhat.com,
        jolsa@kernel.org, namhyung@kernel.org, sdf@fomichev.me
Subject: Re: [PATCH v9 perf,bpf 09/15] perf, bpf: save btf information as
 headers to perf.data
Message-ID: <20190312151405.GG4939@kernel.org>
References: <20190312053051.2690567-1-songliubraving@fb.com>
 <20190312053051.2690567-10-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190312053051.2690567-10-songliubraving@fb.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Mar 11, 2019 at 10:30:45PM -0700, Song Liu escreveu:
> This patch enables perf-record to save btf information as headers to
> perf.data A new header type HEADER_BPF_BTF is introduced for this data.
> 
> Signed-off-by: Song Liu <songliubraving@fb.com>
> ---
>  tools/perf/util/header.c | 101 ++++++++++++++++++++++++++++++++++++++-
>  tools/perf/util/header.h |   1 +
>  2 files changed, 101 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index a4ef8f657ad0..7decd2d1dbda 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -905,6 +905,39 @@ static int write_bpf_prog_info(struct feat_fd *ff,
>  	return ret;
>  }
>  
> +static int write_bpf_btf(struct feat_fd *ff,
> +			 struct perf_evlist *evlist __maybe_unused)
> +{
> +	struct perf_env *env = &ff->ph->env;
> +	struct rb_root *root;
> +	struct rb_node *next;
> +	int ret;
> +
> +	down_read(&env->bpf_progs.lock);
> +
> +	ret = do_write(ff, &env->bpf_progs.btfs_cnt,
> +		       sizeof(env->bpf_progs.btfs_cnt));
> +
> +	if (ret < 0)
> +		goto out;
> +
> +	root = &env->bpf_progs.btfs;
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
> @@ -1408,6 +1441,28 @@ static void print_bpf_prog_info(struct feat_fd *ff, FILE *fp)
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

So, I couldn't get this to work right now, and I have BPF programs that
are loaded and that have BTF info:

[root@quaco ~]# bpftool prog | tail -6
208: tracepoint  name sys_enter  tag 819967866022f1e1  gpl
	loaded_at 2019-03-12T11:16:55-0300  uid 0
	xlated 528B  jited 381B  memlock 4096B  map_ids 107,106,105
209: tracepoint  name sys_exit  tag c1bd85c092d6e4aa  gpl
	loaded_at 2019-03-12T11:16:55-0300  uid 0
	xlated 256B  jited 191B  memlock 4096B  map_ids 107,106
[root@quaco ~]#


[root@quaco ~]# bpftool map  | tail -6
105: perf_event_array  name __augmented_sys  flags 0x0
	key 4B  value 4B  max_entries 8  memlock 4096B
106: array  name syscalls  flags 0x0
	key 4B  value 1B  max_entries 512  memlock 8192B
107: hash  name pids_filtered  flags 0x0
	key 4B  value 1B  max_entries 64  memlock 8192B
[root@quaco ~]#

[root@quaco ~]# bpftool map dump id 107
[{
        "key": 8104,
        "value": true
    },{
        "key": 18868,
        "value": true
    }
]
[root@quaco ~]# ps ax|egrep 8104\|18868 | grep -v grep
 8104 pts/8    S+     0:07 trace -e recvmmsg
18868 ?        Ssl   21:21 /usr/libexec/gnome-terminal-server
[root@quaco ~]#

So I was expecting to see those btf lines there :-\

All the patches up to this point I have already merged and tested in my
local branch.

Will continue right after lunch to try to figure out why this BTF info
isn't landing on this new header feature...

- Arnaldo



> +	}
> +
> +	up_read(&env->bpf_progs.lock);
> +}
> +
>  static void free_event_desc(struct perf_evsel *events)
>  {
>  	struct perf_evsel *evsel;
> @@ -2509,6 +2564,49 @@ static int process_bpf_prog_info(struct feat_fd *ff,
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
> @@ -2569,7 +2667,8 @@ static const struct feature_ops feat_ops[HEADER_LAST_FEATURE] = {
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

-- 

- Arnaldo
