Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 978E0C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 12:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D1E32173B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 12:34:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ljflD3SN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbfGQMe4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 08:34:56 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41289 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbfGQMe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 08:34:56 -0400
Received: by mail-qt1-f196.google.com with SMTP id d17so23048916qtj.8
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 05:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZqYh4q54kojj7QiJfPRmhlfESpvMsxeKfpaJ0TM5c9g=;
        b=ljflD3SNDjjnDWAYDgUdP8KOBtTfYHumT1qFYTHZ9XtbeS9bRWK/9MC643KzSBB4W3
         YIDLpkr9yRhIBfTZY+udyhcKbOe0XwgMRoFeQMArdcpO/kaO1EhP4SleRqQyKeZLt8y8
         2KgGJyf8MDVRs/hCN4e7RvIQ45KBD22NqHiUJtUd480+8D7MjH36KEFVRMfccR75EZ66
         0vSLrohdrwZi++3wU95iDLIVSxbsD0VqT1jZ+ZCMw9+hvFem99iFDtZ87utMqzgQS2jn
         4ls+ygSP6JL+rnzVcmSxsJRvlw8RzY1u+CY2tbxXYyb2ZgWF+/kJ5vLFLCcUfvqYuzGg
         HzqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZqYh4q54kojj7QiJfPRmhlfESpvMsxeKfpaJ0TM5c9g=;
        b=DXdDyBjS/Y9xEO4hORncU7NqDYYYVsQ0Zzo9ICCJUWlBOK/jo+du5MDvmBGkiZRWRW
         x1+oZCP51VSiM6peW9icQs29VnsisH0bs/tgcUOB6R4gFEZWYF7AdtqSH65beEXlpmjG
         FdtRT41jzf5wJbYceLwbNggmBneIl5+45SgRz2Ro/gA2KtmqwvYyRnD2gjQDpEuR+PFw
         ixgM9rrSg3uH450bYCwxcJkAZLVB1QWHhgYOMGuLJlRg3FMfBe1ab+kP/f/JL0xNFDwm
         f+4v0P1iHsh0XGxZ8o8S0lJBZTB2egp9JvQCtWHP6xtpJCLHSbXmzGf4B+A0oPRsl6dx
         1LMQ==
X-Gm-Message-State: APjAAAUhPSmF473Zdo7YRHBCZXnascT+jFHkbzu6oigsks9KaduXO/EQ
        Fjh+qiSrQ5nGYDS+jI17KjuilFli
X-Google-Smtp-Source: APXvYqxFNY49p3IK4i2UabQHwsBBElxDPThX5abCXPkRJf36mGXmMdq0zECKA2/l2OjTDLRUF+z+mA==
X-Received: by 2002:ac8:3f55:: with SMTP id w21mr27686420qtk.217.1563366895281;
        Wed, 17 Jul 2019 05:34:55 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id g2sm9838275qkm.31.2019.07.17.05.34.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 17 Jul 2019 05:34:53 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D20A240340; Wed, 17 Jul 2019 09:34:50 -0300 (-03)
Date:   Wed, 17 Jul 2019 09:34:50 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] perf session: fix loading of compressed data split
 across adjacent records
Message-ID: <20190717123450.GA24063@kernel.org>
References: <4d839e1b-9c48-89c4-9702-a12217420611@linux.intel.com>
 <20190714154932.GC16802@krava>
 <389a8b98-1d53-6fe3-ff56-0789c0841292@linux.intel.com>
 <20190716184959.GG3624@kernel.org>
 <20190716205930.GF28722@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190716205930.GF28722@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jul 16, 2019 at 10:59:30PM +0200, Jiri Olsa escreveu:
> On Tue, Jul 16, 2019 at 03:49:59PM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Mon, Jul 15, 2019 at 03:30:24PM +0300, Alexey Budankov escreveu:
> > > On 14.07.2019 18:49, Jiri Olsa wrote:
> > > > On Tue, Jul 09, 2019 at 05:48:14PM +0300, Alexey Budankov wrote:
> > > > 
> > > > SNIP
> > > > 
> > > >>  	decomp->file_pos = file_offset;
> > > >> +	decomp->mmap_len = mmap_len;
> > > >>  	decomp->head = 0;
> > > >>  
> > > >> -	if (decomp_last) {
> > > >> -		decomp_last_rem = decomp_last->size - decomp_last->head;
> > > >> +	if (decomp_last_rem) {
> > > >>  		memcpy(decomp->data, &(decomp_last->data[decomp_last->head]), decomp_last_rem);
> > > >>  		decomp->size = decomp_last_rem;
> > > >>  	}
> > > >> @@ -61,7 +67,7 @@ static int perf_session__process_compressed_event(struct perf_session *session,
> > > >>  	decomp_size = zstd_decompress_stream(&(session->zstd_data), src, src_size,
> > > >>  				&(decomp->data[decomp_last_rem]), decomp_len - decomp_last_rem);
> > > >>  	if (!decomp_size) {
> > > >> -		munmap(decomp, sizeof(struct decomp) + decomp_len);
> > > >> +		munmap(decomp, mmap_len);
> > > >>  		pr_err("Couldn't decompress data\n");
> > > >>  		return -1;
> > > >>  	}
> > > >> @@ -255,15 +261,15 @@ static void perf_session__delete_threads(struct perf_session *session)
> > > >>  static void perf_session__release_decomp_events(struct perf_session *session)
> > > >>  {
> > > >>  	struct decomp *next, *decomp;
> > > >> -	size_t decomp_len;
> > > >> +	size_t mmap_len;
> > > >>  	next = session->decomp;
> > > >> -	decomp_len = session->header.env.comp_mmap_len;
> > > >>  	do {
> > > >>  		decomp = next;
> > > >>  		if (decomp == NULL)
> > > >>  			break;
> > > >>  		next = decomp->next;
> > > >> -		munmap(decomp, decomp_len + sizeof(struct decomp));
> > > >> +		mmap_len = decomp->mmap_len;
> > > >> +		munmap(decomp, mmap_len);
> > > > 
> > > > what's the need for extra mmap_len variable in here?
> > > > could you just use decomp->mmap_len directly?
> > > 
> > > To avoid reference to the object being deallocated.
> > > Plain munmap(), yes - :)
> 
> well it's passed as value, so should be ok,
> anyway I was just curious, if I'm not missing
> something else.. it's ok ;-)
> 
> > 
> > So, Jiri, Acked-by?
> 
> yep ;-)
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Thanks, applied.

- Arnaldo
