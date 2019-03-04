Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2358CC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 13:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E420D20823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 13:52:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbfCDNwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 08:52:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36276 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726350AbfCDNwU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 08:52:20 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 39D7E59450;
        Mon,  4 Mar 2019 13:52:20 +0000 (UTC)
Received: from krava (unknown [10.43.17.112])
        by smtp.corp.redhat.com (Postfix) with SMTP id 8C1C96013A;
        Mon,  4 Mar 2019 13:52:17 +0000 (UTC)
Date:   Mon, 4 Mar 2019 14:52:17 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        peterz@infradead.org, acme@redhat.com, jolsa@kernel.org,
        namhyung@kernel.org
Subject: Re: [PATCH v5 perf,bpf 09/15] perf, bpf: save btf information as
 headers to perf.data
Message-ID: <20190304135217.GC19809@krava>
References: <20190228050643.958685-1-songliubraving@fb.com>
 <20190228050643.958685-10-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190228050643.958685-10-songliubraving@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Mon, 04 Mar 2019 13:52:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 09:06:37PM -0800, Song Liu wrote:

SNIP

>  
> +static int process_bpf_btf(struct feat_fd *ff, void *data __maybe_unused)
> +{
> +	struct perf_env *env = &ff->ph->env;
> +	u32 count, i;
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
> +		/* endian mismatch, drop the btf, continue */
> +		if (ff->ph->needs_swap) {
> +			free(node);
> +			continue;
> +		}

again, we can check for needs_swap in the begining,
display warning and skip the loop in here

perhaps we should warn just once for all the bpf data
missed when needs_swap is set

jirka
