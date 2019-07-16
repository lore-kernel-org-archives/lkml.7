Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B379FC7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 20:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9109F2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 20:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388843AbfGPU7f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 16:59:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42676 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728781AbfGPU7e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 16:59:34 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7BD16308424C;
        Tue, 16 Jul 2019 20:59:34 +0000 (UTC)
Received: from krava (ovpn-204-33.brq.redhat.com [10.40.204.33])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5E5D060A9F;
        Tue, 16 Jul 2019 20:59:31 +0000 (UTC)
Date:   Tue, 16 Jul 2019 22:59:30 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Alexey Budankov <alexey.budankov@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] perf session: fix loading of compressed data split
 across adjacent records
Message-ID: <20190716205930.GF28722@krava>
References: <4d839e1b-9c48-89c4-9702-a12217420611@linux.intel.com>
 <20190714154932.GC16802@krava>
 <389a8b98-1d53-6fe3-ff56-0789c0841292@linux.intel.com>
 <20190716184959.GG3624@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190716184959.GG3624@kernel.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Tue, 16 Jul 2019 20:59:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2019 at 03:49:59PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Mon, Jul 15, 2019 at 03:30:24PM +0300, Alexey Budankov escreveu:
> > On 14.07.2019 18:49, Jiri Olsa wrote:
> > > On Tue, Jul 09, 2019 at 05:48:14PM +0300, Alexey Budankov wrote:
> > > 
> > > SNIP
> > > 
> > >>  	decomp->file_pos = file_offset;
> > >> +	decomp->mmap_len = mmap_len;
> > >>  	decomp->head = 0;
> > >>  
> > >> -	if (decomp_last) {
> > >> -		decomp_last_rem = decomp_last->size - decomp_last->head;
> > >> +	if (decomp_last_rem) {
> > >>  		memcpy(decomp->data, &(decomp_last->data[decomp_last->head]), decomp_last_rem);
> > >>  		decomp->size = decomp_last_rem;
> > >>  	}
> > >> @@ -61,7 +67,7 @@ static int perf_session__process_compressed_event(struct perf_session *session,
> > >>  	decomp_size = zstd_decompress_stream(&(session->zstd_data), src, src_size,
> > >>  				&(decomp->data[decomp_last_rem]), decomp_len - decomp_last_rem);
> > >>  	if (!decomp_size) {
> > >> -		munmap(decomp, sizeof(struct decomp) + decomp_len);
> > >> +		munmap(decomp, mmap_len);
> > >>  		pr_err("Couldn't decompress data\n");
> > >>  		return -1;
> > >>  	}
> > >> @@ -255,15 +261,15 @@ static void perf_session__delete_threads(struct perf_session *session)
> > >>  static void perf_session__release_decomp_events(struct perf_session *session)
> > >>  {
> > >>  	struct decomp *next, *decomp;
> > >> -	size_t decomp_len;
> > >> +	size_t mmap_len;
> > >>  	next = session->decomp;
> > >> -	decomp_len = session->header.env.comp_mmap_len;
> > >>  	do {
> > >>  		decomp = next;
> > >>  		if (decomp == NULL)
> > >>  			break;
> > >>  		next = decomp->next;
> > >> -		munmap(decomp, decomp_len + sizeof(struct decomp));
> > >> +		mmap_len = decomp->mmap_len;
> > >> +		munmap(decomp, mmap_len);
> > > 
> > > what's the need for extra mmap_len variable in here?
> > > could you just use decomp->mmap_len directly?
> > 
> > To avoid reference to the object being deallocated.
> > Plain munmap(), yes - :)

well it's passed as value, so should be ok,
anyway I was just curious, if I'm not missing
something else.. it's ok ;-)

> 
> So, Jiri, Acked-by?

yep ;-)

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> 
> - Arnaldo
