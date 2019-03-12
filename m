Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79BADC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 13:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52B7B214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 13:10:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbfCLNKh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 09:10:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47570 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbfCLNKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 09:10:36 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 67836307E044;
        Tue, 12 Mar 2019 13:10:36 +0000 (UTC)
Received: from krava (unknown [10.43.17.124])
        by smtp.corp.redhat.com (Postfix) with SMTP id C029260FC3;
        Tue, 12 Mar 2019 13:10:33 +0000 (UTC)
Date:   Tue, 12 Mar 2019 14:10:33 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, peterz@infradead.org, acme@redhat.com,
        jolsa@kernel.org, namhyung@kernel.org, sdf@fomichev.me
Subject: Re: [PATCH v9 perf,bpf 06/15] perf, bpf: save bpf_prog_info in a
 rbtree in perf_env
Message-ID: <20190312131033.GB3034@krava>
References: <20190312053051.2690567-1-songliubraving@fb.com>
 <20190312053051.2690567-7-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190312053051.2690567-7-songliubraving@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Tue, 12 Mar 2019 13:10:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 10:30:42PM -0700, Song Liu wrote:

SNIP

> +/* purge data in bpf_progs.infos tree */
> +static void perf_env__purge_bpf(struct perf_env *env)
> +{
> +	struct rb_root *root;
> +	struct rb_node *next;
> +
> +	down_write(&env->bpf_progs.lock);
> +
> +	root = &env->bpf_progs.infos;
> +	next = rb_first(root);
> +
> +	while (next) {
> +		struct bpf_prog_info_node *node;
> +
> +		node = rb_entry(next, struct bpf_prog_info_node, rb_node);
> +		next = rb_next(&node->rb_node);
> +		rb_erase(&node->rb_node, root);
> +		free(node);
> +	}

	env->bpf_progs.infos_cnt = 0;  ?

but it's probably not needed given the current usage

jirka

> +	up_write(&env->bpf_progs.lock);
> +}

SNIP
