Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1906C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 11:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5A7120854
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 11:46:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbfCRLqW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 07:46:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42458 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726704AbfCRLqV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 07:46:21 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A418A308219C;
        Mon, 18 Mar 2019 11:46:21 +0000 (UTC)
Received: from krava (unknown [10.43.17.124])
        by smtp.corp.redhat.com (Postfix) with SMTP id 028AA1001DFE;
        Mon, 18 Mar 2019 11:46:19 +0000 (UTC)
Date:   Mon, 18 Mar 2019 12:46:19 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 10/12] perf report: implement record trace
 decompression
Message-ID: <20190318114619.GA7900@krava>
References: <c1423198-e474-1739-e800-4615cce501ce@linux.intel.com>
 <f688ddcd-99cf-ee59-06d7-205fa0dd2f3f@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f688ddcd-99cf-ee59-06d7-205fa0dd2f3f@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Mon, 18 Mar 2019 11:46:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 16, 2019 at 05:17:06PM +0300, Alexey Budankov wrote:

SNIP

>  static int perf_session__deliver_event(struct perf_session *session,
>  				       union perf_event *event,
>  				       struct perf_tool *tool,
> @@ -198,12 +259,23 @@ static void perf_session__delete_threads(struct perf_session *session)
>  
>  void perf_session__delete(struct perf_session *session)
>  {
> +	struct decomp *next, *decomp;
> +	size_t decomp_len;
>  	if (session == NULL)
>  		return;
>  	auxtrace__free(session);
>  	auxtrace_index__free(&session->auxtrace_index);
>  	perf_session__destroy_kernel_maps(session);
>  	perf_session__delete_threads(session);
> +	next = session->decomp;
> +	decomp_len = session->header.env.comp_mmap_len;
> +	do {
> +		decomp = next;
> +		if (decomp == NULL)
> +			break;
> +		next = decomp->next;
> +		munmap(decomp, decomp_len + sizeof(struct decomp));
> +	} while (1);

please put this to separate function

thanks,
jirka
