Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D893EC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 14:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B27352081B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 14:06:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbfCGOGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 09:06:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52192 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726375AbfCGOF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 09:05:59 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EF934C05B01E;
        Thu,  7 Mar 2019 14:05:58 +0000 (UTC)
Received: from krava (unknown [10.40.206.1])
        by smtp.corp.redhat.com (Postfix) with SMTP id AFFC45D783;
        Thu,  7 Mar 2019 14:05:56 +0000 (UTC)
Date:   Thu, 7 Mar 2019 15:05:55 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, peterz@infradead.org, acme@redhat.com,
        jolsa@kernel.org, namhyung@kernel.org
Subject: Re: [PATCH v6 perf,bpf 07/15] perf, bpf: save bpf_prog_info
 information as headers to perf.data
Message-ID: <20190307140555.GD7233@krava>
References: <20190306071359.2359896-1-songliubraving@fb.com>
 <20190306071359.2359896-8-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190306071359.2359896-8-songliubraving@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Thu, 07 Mar 2019 14:05:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2019 at 11:13:51PM -0800, Song Liu wrote:

SNIP

> +static int process_bpf_prog_info(struct feat_fd *ff,
> +				 void *data __maybe_unused)
> +{
> +	struct bpf_prog_info_linear *info_linear;
> +	struct bpf_prog_info_node *info_node;
> +	struct perf_env *env = &ff->ph->env;
> +	u32 count, i;
> +	int err = -1;
> +
> +	if (do_read_u32(ff, &count))
> +		return -1;
> +
> +	if (ff->ph->needs_swap)
> +		pr_warning("interpreting bpf_prog_info from systems with endianity is not yet supported\n");

		return 0; ?

what's here to process?

jirka

> +
> +	down_write(&env->bpf_progs.lock);
> +
> +	for (i = 0; i < count; ++i) {
> +		u32 info_len, data_len;
> +
> +		info_linear = NULL;
> +		info_node = NULL;
> +		if (do_read_u32(ff, &info_len))
> +			goto out;
> +		if (do_read_u32(ff, &data_len))
> +			goto out;
> +
> +		if (info_len > sizeof(struct bpf_prog_info)) {
> +			pr_warning("detected invalid bpf_prog_info\n");
> +			goto out;
> +		}
> +
> +		info_linear = malloc(sizeof(struct bpf_prog_info_linear) +
> +				     data_len);
> +		if (!info_linear)
> +			goto out;
> +		info_linear->info_len = sizeof(struct bpf_prog_info);
> +		info_linear->data_len = data_len;
> +		if (do_read_u64(ff, (u64 *)(&info_linear->arrays)))
> +			goto out;
> +		if (__do_read(ff, &info_linear->info, info_len))
> +			goto out;
> +		if (info_len < sizeof(struct bpf_prog_info))
> +			memset(((void *)(&info_linear->info)) + info_len, 0,
> +			       sizeof(struct bpf_prog_info) - info_len);
> +
> +		if (__do_read(ff, info_linear->data, data_len))
> +			goto out;
> +
> +		/* endian mismatch, drop the info, continue */
> +		if (ff->ph->needs_swap) {
> +			free(info_linear);
> +			continue;
> +		}
> +
> +		info_node = malloc(sizeof(struct bpf_prog_info_node));
> +		if (!info_node)
> +			goto out;
> +
> +		/* after reading from file, translate offset to address */
> +		bpf_program__bpil_offs_to_addr(info_linear);
> +		info_node->info_linear = info_linear;
> +		perf_env__insert_bpf_prog_info(env, info_node);
> +	}
> +
> +	return 0;
> +out:
> +	free(info_linear);
> +	free(info_node);
> +	up_write(&env->bpf_progs.lock);
> +	return err;
> +}

SNIP
