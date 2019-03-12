Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE8CC4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 13:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54DFE214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 13:10:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbfCLNKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 09:10:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36278 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbfCLNK3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 09:10:29 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 66F18C04AC56;
        Tue, 12 Mar 2019 13:10:29 +0000 (UTC)
Received: from krava (unknown [10.43.17.124])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 08D5C5C280;
        Tue, 12 Mar 2019 13:10:23 +0000 (UTC)
Date:   Tue, 12 Mar 2019 14:10:23 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, peterz@infradead.org, acme@redhat.com,
        jolsa@kernel.org, namhyung@kernel.org, sdf@fomichev.me
Subject: Re: [PATCH v9 perf,bpf 07/15] perf, bpf: save bpf_prog_info
 information as headers to perf.data
Message-ID: <20190312131023.GA3034@krava>
References: <20190312053051.2690567-1-songliubraving@fb.com>
 <20190312053051.2690567-8-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190312053051.2690567-8-songliubraving@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 12 Mar 2019 13:10:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 10:30:43PM -0700, Song Liu wrote:

SNIP

> +static void print_bpf_prog_info(struct feat_fd *ff, FILE *fp)
> +{
> +	struct perf_env *env = &ff->ph->env;
> +	struct rb_root *root;
> +	struct rb_node *next;
> +
> +	down_read(&env->bpf_progs.lock);
> +
> +	root = &env->bpf_progs.infos;
> +	next = rb_first(root);
> +
> +	while (next) {
> +		struct bpf_prog_info_node *node;
> +
> +		node = rb_entry(next, struct bpf_prog_info_node, rb_node);
> +		next = rb_next(&node->rb_node);
> +		fprintf(fp, "# bpf_prog_info of id %u\n",
> +			node->info_linear->info.id);

so report displays bpf prog dso/name like:

   0.02%  ls           bpf_prog_c80ffe554aba1bec_syscall_enter_o  [k] bpf_prog_c80ffe554aba1bec_syscall_enter_o                                                                                       ▒

and 'perf report --header-only -I' shows:


	# bpf_prog_info of id 17
	# bpf_prog_info of id 18
	# bpf_prog_info of id 19
	# bpf_prog_info of id 20
	# bpf_prog_info of id 21
	# bpf_prog_info of id 22
	# bpf_prog_info of id 25
	# bpf_prog_info of id 26
	# bpf_prog_info of id 34
	# bpf_prog_info of id 35

could we have something more detailed like bpftool output:

	34: tracepoint  name syscall_enter_o  tag c80ffe554aba1bec  gpl
		loaded_at 2019-03-12T14:02:03+0100  uid 0
		xlated 360B  jited 232B  memlock 4096B  map_ids 30

	35: tracepoint  name syscall_enter_o  tag ada5ccbe5576399c  gpl
		loaded_at 2019-03-12T14:02:03+0100  uid 0
		xlated 352B  jited 228B  memlock 4096B  map_ids 30


could be on top of this patchset

jirka
