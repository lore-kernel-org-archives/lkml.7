Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DCA7C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 21:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECC732077B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 21:00:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pYneGwHg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbfCMVAh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 17:00:37 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41043 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbfCMVAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 17:00:36 -0400
Received: by mail-qt1-f196.google.com with SMTP id v10so3641281qtp.8;
        Wed, 13 Mar 2019 14:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ARUs5u00KYRy5wFwUnnBD6sJgFXzk/fe2aU81ESxAGg=;
        b=pYneGwHgaPM0b3DIUbmjCMlvQfxxtpzvgrmECsE7xewAo3JBR/JV8i/9LttBltm4DY
         YeeWmfOkZC+y4FeNgWoYjHi4KB/LHJZu3JkPSOoHqGqGtA17ccymWqgBz5HGuqgc7Weu
         6xe0xtXA++kpK1lvjaeZuBTGCpP6uNN86mS11QOGaWpI1E90kgejL7O6244qZ3bmqElN
         X8oIOaBWgXuTwZskTF0ZJbX/21FpuuYnvUizINOQ0a1yu5gvGl071dzI9yvIYszIN3bf
         OerlEzA2eTVT0ZLfdd4VqpKkm+wgOmX9/zQJr4hAGxnnUvYCnmychsHQXreZ52JunlA5
         EYUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ARUs5u00KYRy5wFwUnnBD6sJgFXzk/fe2aU81ESxAGg=;
        b=FaE1SLcBWNr7KggR4jyQRNnqGR405hR2UDcbtS7EV7jgIPF0yuVRwSg+nfr1gZusng
         vB49jtq3HrXw1cb5MukSbSc8Pt0tQV+KwQSHAUWeMWrUiL81NZnWBYIuA0phhK6JSaXW
         ENTh0yxz1Mhno7Aq2zrwz1dMuEW1rQJtXQG+39lGxO8pSIYEAY7jNP3cH566PIqWJtYR
         AMJ+cYRUts9H8SN82/9ODAlPeCrW3eAzC5ZacXwzYXt8KRuFztg4Ms/raskLj4DLuyin
         w6Mcz26RazSreC1gWyiFwz9g6dBJrZnB6qCvl+QZyvzcMj4rAsPuDo5DzEsxJuJssWxa
         7Jvw==
X-Gm-Message-State: APjAAAWkLyPcsJAdD2z7yn1ih1Gp3xzY7Nta35+5RyZGeYZuwsxj6t14
        mvHuelwkVIC5Pyl9fqaTgKY=
X-Google-Smtp-Source: APXvYqzwG883+So/zQdp5WjySf4zAgkoJ02AXetVb4+b3O6UirZy4/zZOBdleGxKNVyyJPwRckEC0Q==
X-Received: by 2002:ac8:180b:: with SMTP id q11mr12507960qtj.113.1552510834976;
        Wed, 13 Mar 2019 14:00:34 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id 76sm688369qkf.88.2019.03.13.14.00.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Mar 2019 14:00:33 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7AD744039C; Wed, 13 Mar 2019 18:00:30 -0300 (-03)
Date:   Wed, 13 Mar 2019 18:00:30 -0300
To:     Song Liu <songliubraving@fb.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, peterz@infradead.org, acme@redhat.com,
        jolsa@kernel.org, namhyung@kernel.org, sdf@fomichev.me
Subject: Re: [PATCH v9 perf,bpf 04/15] perf, bpf: synthesize bpf events with
 bpf_program__get_prog_info_linear()
Message-ID: <20190313210030.GA16304@kernel.org>
References: <20190312053051.2690567-1-songliubraving@fb.com>
 <20190312053051.2690567-5-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190312053051.2690567-5-songliubraving@fb.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Mar 11, 2019 at 10:30:40PM -0700, Song Liu escreveu:
> With bpf_program__get_prog_info_linear, we can simplify the logic that
> synthesizes bpf events.
> 
> This patch doesn't change the behavior of the code.
> 
> Signed-off-by: Song Liu <songliubraving@fb.com>
> ---
>  tools/perf/util/bpf-event.c | 118 ++++++++++++------------------------
>  1 file changed, 40 insertions(+), 78 deletions(-)
> 
> diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
> index ea012b735a37..e9d9854be506 100644
> --- a/tools/perf/util/bpf-event.c
> +++ b/tools/perf/util/bpf-event.c
> @@ -3,7 +3,9 @@
>  #include <stdlib.h>
>  #include <bpf/bpf.h>
>  #include <bpf/btf.h>
> +#include <bpf/libbpf.h>
>  #include <linux/btf.h>
> +#include <linux/err.h>
>  #include "bpf-event.h"
>  #include "debug.h"
>  #include "symbol.h"
> @@ -49,99 +51,62 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_tool *tool,
>  {
>  	struct ksymbol_event *ksymbol_event = &event->ksymbol_event;
>  	struct bpf_event *bpf_event = &event->bpf_event;
> -	u32 sub_prog_cnt, i, func_info_rec_size = 0;
> -	u8 (*prog_tags)[BPF_TAG_SIZE] = NULL;
> -	struct bpf_prog_info info = { .type = 0, };
> -	u32 info_len = sizeof(info);
> -	void *func_infos = NULL;
> -	u64 *prog_addrs = NULL;
> +	struct bpf_prog_info_linear *info_linear;
> +	struct bpf_prog_info *info;
>  	struct btf *btf = NULL;
> -	u32 *prog_lens = NULL;
>  	bool has_btf = false;
> -	char errbuf[512];
> +	u32 sub_prog_cnt, i;
>  	int err = 0;
> +	u64 arrays;
>  
> -	/* Call bpf_obj_get_info_by_fd() to get sizes of arrays */
> -	err = bpf_obj_get_info_by_fd(fd, &info, &info_len);
> +	arrays = 1UL << BPF_PROG_INFO_JITED_KSYMS;
> +	arrays |= 1UL << BPF_PROG_INFO_JITED_FUNC_LENS;
> +	arrays |= 1UL << BPF_PROG_INFO_FUNC_INFO;
> +	arrays |= 1UL << BPF_PROG_INFO_PROG_TAGS;
>  
> -	if (err) {
> -		pr_debug("%s: failed to get BPF program info: %s, aborting\n",
> -			 __func__, str_error_r(errno, errbuf, sizeof(errbuf)));
> +	info_linear = bpf_program__get_prog_info_linear(fd, arrays);
> +	if (IS_ERR_OR_NULL(info_linear)) {
> +		info_linear = NULL;
> +		pr_debug("%s: failed to get BPF program info. aborting\n", __func__);
>  		return -1;
>  	}
> -	if (info_len < offsetof(struct bpf_prog_info, prog_tags)) {
> +
> +	if (info_linear->info_len < offsetof(struct bpf_prog_info, prog_tags)) {
>  		pr_debug("%s: the kernel is too old, aborting\n", __func__);
>  		return -2;
>  	}
>  
> +	info = &info_linear->info;
> +
>  	/* number of ksyms, func_lengths, and tags should match */
> -	sub_prog_cnt = info.nr_jited_ksyms;
> -	if (sub_prog_cnt != info.nr_prog_tags ||
> -	    sub_prog_cnt != info.nr_jited_func_lens)
> +	sub_prog_cnt = info->nr_jited_ksyms;
> +	if (sub_prog_cnt != info->nr_prog_tags ||
> +	    sub_prog_cnt != info->nr_jited_func_lens)
>  		return -1;
>  
>  	/* check BTF func info support */
> -	if (info.btf_id && info.nr_func_info && info.func_info_rec_size) {
> +	if (info->btf_id && info->nr_func_info && info->func_info_rec_size) {
>  		/* btf func info number should be same as sub_prog_cnt */
> -		if (sub_prog_cnt != info.nr_func_info) {
> +		if (sub_prog_cnt != info->nr_func_info) {
>  			pr_debug("%s: mismatch in BPF sub program count and BTF function info count, aborting\n", __func__);
> -			return -1;
> -		}
> -		if (btf__get_from_id(info.btf_id, &btf)) {
> -			pr_debug("%s: failed to get BTF of id %u, aborting\n", __func__, info.btf_id);
> -			return -1;
> +			err = -1;
> +			goto out;
>  		}
> -		func_info_rec_size = info.func_info_rec_size;
> -		func_infos = calloc(sub_prog_cnt, func_info_rec_size);
> -		if (!func_infos) {
> -			pr_debug("%s: failed to allocate memory for func_infos, aborting\n", __func__);
> -			return -1;
> +		if (btf__get_from_id(info->btf_id, &btf)) {
> +			pr_debug("%s: failed to get BTF of id %u, aborting\n", __func__, info->btf_id);
> +			err = -1;
> +			btf = NULL;
> +			goto out;
>  		}
>  		has_btf = true;
>  	}
>  
> -	/*
> -	 * We need address, length, and tag for each sub program.
> -	 * Allocate memory and call bpf_obj_get_info_by_fd() again
> -	 */
> -	prog_addrs = calloc(sub_prog_cnt, sizeof(u64));
> -	if (!prog_addrs) {
> -		pr_debug("%s: failed to allocate memory for prog_addrs, aborting\n", __func__);
> -		goto out;
> -	}
> -	prog_lens = calloc(sub_prog_cnt, sizeof(u32));
> -	if (!prog_lens) {
> -		pr_debug("%s: failed to allocate memory for prog_lens, aborting\n", __func__);
> -		goto out;
> -	}
> -	prog_tags = calloc(sub_prog_cnt, BPF_TAG_SIZE);
> -	if (!prog_tags) {
> -		pr_debug("%s: failed to allocate memory for prog_tags, aborting\n", __func__);
> -		goto out;
> -	}
> -
> -	memset(&info, 0, sizeof(info));
> -	info.nr_jited_ksyms = sub_prog_cnt;
> -	info.nr_jited_func_lens = sub_prog_cnt;
> -	info.nr_prog_tags = sub_prog_cnt;
> -	info.jited_ksyms = ptr_to_u64(prog_addrs);
> -	info.jited_func_lens = ptr_to_u64(prog_lens);
> -	info.prog_tags = ptr_to_u64(prog_tags);
> -	info_len = sizeof(info);
> -	if (has_btf) {
> -		info.nr_func_info = sub_prog_cnt;
> -		info.func_info_rec_size = func_info_rec_size;
> -		info.func_info = ptr_to_u64(func_infos);
> -	}
> -
> -	err = bpf_obj_get_info_by_fd(fd, &info, &info_len);
> -	if (err) {
> -		pr_debug("%s: failed to get BPF program info, aborting\n", __func__);
> -		goto out;
> -	}
> -
>  	/* Synthesize PERF_RECORD_KSYMBOL */
>  	for (i = 0; i < sub_prog_cnt; i++) {
> +		u8 (*prog_tags)[BPF_TAG_SIZE] = (void *)(info->prog_tags);

Need this:

-               u8 (*prog_tags)[BPF_TAG_SIZE] = (void *)(info->prog_tags);
+               u8 (*prog_tags)[BPF_TAG_SIZE] = (u8 *)(info->prog_tags);


To overcome this on debian:experimental-x-mips, i.e. Debian Experimental
cross building to MIPS 32-bit:

util/bpf-event.c: In function 'perf_event__synthesize_one_bpf_prog':
util/bpf-event.c:143:35: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
   u8 (*prog_tags)[BPF_TAG_SIZE] = (void *)(info->prog_tags);
                                   ^
util/bpf-event.c:144:22: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
   __u32 *prog_lens = (__u32 *)(info->jited_func_lens);
                      ^
util/bpf-event.c:145:23: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
   __u64 *prog_addrs = (__u64 *)(info->jited_ksyms);
                       ^
util/bpf-event.c:146:22: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
   void *func_infos = (void *)(info->func_info);
                      ^
  CC       /tmp/build/perf/util/pmu.o
  CC       /tmp/build/perf/util/pmu-flex.o
cc1: all warnings being treated as errors


> +		__u32 *prog_lens = (__u32 *)(info->jited_func_lens);
> +		__u64 *prog_addrs = (__u64 *)(info->jited_ksyms);
> +		void *func_infos = (void *)(info->func_info);
>  		const struct bpf_func_info *finfo;
>  		const char *short_name = NULL;
>  		const struct btf_type *t;
> @@ -163,13 +128,13 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_tool *tool,
>  					 KSYM_NAME_LEN - name_len,
>  					 prog_tags[i], BPF_TAG_SIZE);
>  		if (has_btf) {
> -			finfo = func_infos + i * info.func_info_rec_size;
> +			finfo = func_infos + i * info->func_info_rec_size;
>  			t = btf__type_by_id(btf, finfo->type_id);
>  			short_name = btf__name_by_offset(btf, t->name_off);
>  		} else if (i == 0 && sub_prog_cnt == 1) {
>  			/* no subprog */
> -			if (info.name[0])
> -				short_name = info.name;
> +			if (info->name[0])
> +				short_name = info->name;
>  		} else
>  			short_name = "F";
>  		if (short_name)
> @@ -195,9 +160,9 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_tool *tool,
>  			},
>  			.type = PERF_BPF_EVENT_PROG_LOAD,
>  			.flags = 0,
> -			.id = info.id,
> +			.id = info->id,
>  		};
> -		memcpy(bpf_event->tag, prog_tags[i], BPF_TAG_SIZE);
> +		memcpy(bpf_event->tag, info->tag, BPF_TAG_SIZE);
>  		memset((void *)event + event->header.size, 0, machine->id_hdr_size);
>  		event->header.size += machine->id_hdr_size;
>  		err = perf_tool__process_synth_event(tool, event,
> @@ -205,10 +170,7 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_tool *tool,
>  	}
>  
>  out:
> -	free(prog_tags);
> -	free(prog_lens);
> -	free(prog_addrs);
> -	free(func_infos);
> +	free(info_linear);
>  	free(btf);
>  	return err ? -1 : 0;
>  }
> -- 
> 2.17.1

-- 

- Arnaldo
