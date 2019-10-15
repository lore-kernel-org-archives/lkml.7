Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F86EECE58E
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 08:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C4ED2089C
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 08:46:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbfJOIqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 04:46:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57182 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726430AbfJOIqe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 04:46:34 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9B82B4E83E;
        Tue, 15 Oct 2019 08:46:34 +0000 (UTC)
Received: from krava (unknown [10.43.17.61])
        by smtp.corp.redhat.com (Postfix) with SMTP id 035D260127;
        Tue, 15 Oct 2019 08:46:32 +0000 (UTC)
Date:   Tue, 15 Oct 2019 10:46:32 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf annotate: Fix multiple memory and file descriptor
 leaks
Message-ID: <20191015084632.GC10951@krava>
References: <20191014171047.GA30850@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014171047.GA30850@embeddedor>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Tue, 15 Oct 2019 08:46:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 12:10:47PM -0500, Gustavo A. R. Silva wrote:
> Store SYMBOL_ANNOTATE_ERRNO__BPF_MISSING_BTF in variable *ret*, instead
> of returning in the middle of the function and leaking multiple
> resources: prog_linfo, btf, s and bfdf.
> 
> Addresses-Coverity-ID: 1454832 ("Structurally dead code")
> Fixes: 11aad897f6d1 ("perf annotate: Don't return -1 for error when doing BPF disassembly")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> ---
>  tools/perf/util/annotate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index 4036c7f7b0fb..e42bf572358c 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -1758,7 +1758,7 @@ static int symbol__disassemble_bpf(struct symbol *sym,
>  	info_node = perf_env__find_bpf_prog_info(dso->bpf_prog.env,
>  						 dso->bpf_prog.id);
>  	if (!info_node) {
> -		return SYMBOL_ANNOTATE_ERRNO__BPF_MISSING_BTF;
> +		ret = SYMBOL_ANNOTATE_ERRNO__BPF_MISSING_BTF;
>  		goto out;
>  	}
>  	info_linear = info_node->info_linear;
> -- 
> 2.23.0
> 
