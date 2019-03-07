Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3789C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 14:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87CB72081B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 14:05:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbfCGOFo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 09:05:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:18744 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726127AbfCGOFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 09:05:43 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4FD1A307D90E;
        Thu,  7 Mar 2019 14:05:43 +0000 (UTC)
Received: from krava (unknown [10.40.206.1])
        by smtp.corp.redhat.com (Postfix) with SMTP id 193A01001E60;
        Thu,  7 Mar 2019 14:05:40 +0000 (UTC)
Date:   Thu, 7 Mar 2019 15:05:40 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, peterz@infradead.org, acme@redhat.com,
        jolsa@kernel.org, namhyung@kernel.org
Subject: Re: [PATCH v6 perf,bpf 08/15] perf, bpf: save btf in a rbtree in
 perf_env
Message-ID: <20190307140540.GB7233@krava>
References: <20190306071359.2359896-1-songliubraving@fb.com>
 <20190306071359.2359896-9-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190306071359.2359896-9-songliubraving@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Thu, 07 Mar 2019 14:05:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2019 at 11:13:52PM -0800, Song Liu wrote:

SNIP

>  /* purge data in bpf_progs.infos tree */
>  static void perf_env__purge_bpf(struct perf_env *env)
>  {
> @@ -82,6 +133,19 @@ static void perf_env__purge_bpf(struct perf_env *env)
>  		rb_erase_init(&node->rb_node, root);
>  		free(node);
>  	}
> +
> +	root = &env->bpf_progs.btfs;
> +	next = rb_first(root);
> +
> +	while (next) {
> +		struct btf_node *node;
> +
> +		node = rb_entry(next, struct btf_node, rb_node);
> +		next = rb_next(&node->rb_node);
> +		rb_erase_init(&node->rb_node, root);

hum rb_erase should be enough when we are removingfreeing the node right
after.. also for the struct bpf_prog_info_node up

jirka

> +		free(node);
> +	}

SNIP
