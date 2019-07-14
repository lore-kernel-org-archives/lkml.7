Return-Path: <SRS0=2uMJ=VL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94FE0C73C66
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 15:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66E4020820
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 15:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbfGNPtg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 11:49:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55994 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726799AbfGNPtf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 11:49:35 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5A8F4308FB93;
        Sun, 14 Jul 2019 15:49:35 +0000 (UTC)
Received: from krava (ovpn-204-80.brq.redhat.com [10.40.204.80])
        by smtp.corp.redhat.com (Postfix) with SMTP id 9033D5C231;
        Sun, 14 Jul 2019 15:49:33 +0000 (UTC)
Date:   Sun, 14 Jul 2019 17:49:32 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] perf session: fix loading of compressed data split
 across adjacent records
Message-ID: <20190714154932.GC16802@krava>
References: <4d839e1b-9c48-89c4-9702-a12217420611@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d839e1b-9c48-89c4-9702-a12217420611@linux.intel.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Sun, 14 Jul 2019 15:49:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 09, 2019 at 05:48:14PM +0300, Alexey Budankov wrote:

SNIP

>  	decomp->file_pos = file_offset;
> +	decomp->mmap_len = mmap_len;
>  	decomp->head = 0;
>  
> -	if (decomp_last) {
> -		decomp_last_rem = decomp_last->size - decomp_last->head;
> +	if (decomp_last_rem) {
>  		memcpy(decomp->data, &(decomp_last->data[decomp_last->head]), decomp_last_rem);
>  		decomp->size = decomp_last_rem;
>  	}
> @@ -61,7 +67,7 @@ static int perf_session__process_compressed_event(struct perf_session *session,
>  	decomp_size = zstd_decompress_stream(&(session->zstd_data), src, src_size,
>  				&(decomp->data[decomp_last_rem]), decomp_len - decomp_last_rem);
>  	if (!decomp_size) {
> -		munmap(decomp, sizeof(struct decomp) + decomp_len);
> +		munmap(decomp, mmap_len);
>  		pr_err("Couldn't decompress data\n");
>  		return -1;
>  	}
> @@ -255,15 +261,15 @@ static void perf_session__delete_threads(struct perf_session *session)
>  static void perf_session__release_decomp_events(struct perf_session *session)
>  {
>  	struct decomp *next, *decomp;
> -	size_t decomp_len;
> +	size_t mmap_len;
>  	next = session->decomp;
> -	decomp_len = session->header.env.comp_mmap_len;
>  	do {
>  		decomp = next;
>  		if (decomp == NULL)
>  			break;
>  		next = decomp->next;
> -		munmap(decomp, decomp_len + sizeof(struct decomp));
> +		mmap_len = decomp->mmap_len;
> +		munmap(decomp, mmap_len);

what's the need for extra mmap_len variable in here?
could you just use decomp->mmap_len directly?

otherwise it lookgs good to me

thanks,
jirka
