Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD0EC76192
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 18:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C0AC2064B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 18:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tQVTe9x8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388532AbfGPSuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 14:50:07 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36636 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388432AbfGPSuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 14:50:07 -0400
Received: by mail-qt1-f194.google.com with SMTP id z4so20716882qtc.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 11:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=I3eRYibeoQehmMKtTdehZx5shEh6xz2X8+qA77bSphY=;
        b=tQVTe9x86Mh+zED3O2osHru75jkgx3tW0LvGAKXT5kFmAzrkF4A/ZQRpK2Qf2v4YRM
         KqxA73e6Dklm4xOehNmekawW6aXvPU6JAKdKWVIjslixy6zmZ54kIFC4MAm+1nSGcH/8
         mdeCK5yz/VSzRgY19RDZuGMXLqe+/7eAFw9wM4AUOCjQkzj85WUIjH+4ZSmF3TeN2vGD
         Pp8mEi0IAv28uU108mkGpoP4B1j3z5A0+SNm8IgPR9xtFl3cEQV+raMEk7irrjXqDy/U
         YExXR0xm5sAyhYxLFS1634VHFiaPSP9E0DS/rA1a6G2giEF7iNAXncAGRc9OtnTCGQ/8
         2TbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=I3eRYibeoQehmMKtTdehZx5shEh6xz2X8+qA77bSphY=;
        b=Oh+MBQC/ZtnskIqYLuTTgTyZmgw1OBzkfogINdlH30WVDUKeky4plVnn3dErez9fRv
         mCK5TA26l5mf+6708J0qbBkvIYxQwlxANiBfnxziH7nGlDDEhj4k8mWB9qE2MI2CiTny
         p4LtKjRtR3/6ZMukC2cB+Hlw4iYuDRKOl6bbbVxLCAGfT1wALONo3xsSmAWUZ9hnBx2U
         uG/5CXaviCBlvhDHvzdqa5lrwIa1FOrHshSTDgaDEPn6cVr8ggkv58xsZil5xOrDDzE/
         HOl7HkHkvrU0VqZ5xVwlRVZTwlmQJPg+E8ehEN35n5wbifHpGXu6PdSHxWODs57Mt9Cv
         8vjg==
X-Gm-Message-State: APjAAAUyyKMYIbncBiEAsi7oFl5esPB/F0oUAlXUWtxl2WHiG/9k4SC6
        PfEtZgbP3RpzplX910ZVYzcJLSlp
X-Google-Smtp-Source: APXvYqxZz/ZeVjEJGaKCK1pOJFJCAx4vqTOyA3B98fcafLavE6BBQQ1vjx7fKmDb7B3klOYf1Hl1IQ==
X-Received: by 2002:ac8:5297:: with SMTP id s23mr24649595qtn.230.1563303006084;
        Tue, 16 Jul 2019 11:50:06 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id c74sm10313485qke.128.2019.07.16.11.50.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 11:50:05 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 79EA440340; Tue, 16 Jul 2019 15:49:59 -0300 (-03)
Date:   Tue, 16 Jul 2019 15:49:59 -0300
To:     Alexey Budankov <alexey.budankov@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] perf session: fix loading of compressed data split
 across adjacent records
Message-ID: <20190716184959.GG3624@kernel.org>
References: <4d839e1b-9c48-89c4-9702-a12217420611@linux.intel.com>
 <20190714154932.GC16802@krava>
 <389a8b98-1d53-6fe3-ff56-0789c0841292@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <389a8b98-1d53-6fe3-ff56-0789c0841292@linux.intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jul 15, 2019 at 03:30:24PM +0300, Alexey Budankov escreveu:
> On 14.07.2019 18:49, Jiri Olsa wrote:
> > On Tue, Jul 09, 2019 at 05:48:14PM +0300, Alexey Budankov wrote:
> > 
> > SNIP
> > 
> >>  	decomp->file_pos = file_offset;
> >> +	decomp->mmap_len = mmap_len;
> >>  	decomp->head = 0;
> >>  
> >> -	if (decomp_last) {
> >> -		decomp_last_rem = decomp_last->size - decomp_last->head;
> >> +	if (decomp_last_rem) {
> >>  		memcpy(decomp->data, &(decomp_last->data[decomp_last->head]), decomp_last_rem);
> >>  		decomp->size = decomp_last_rem;
> >>  	}
> >> @@ -61,7 +67,7 @@ static int perf_session__process_compressed_event(struct perf_session *session,
> >>  	decomp_size = zstd_decompress_stream(&(session->zstd_data), src, src_size,
> >>  				&(decomp->data[decomp_last_rem]), decomp_len - decomp_last_rem);
> >>  	if (!decomp_size) {
> >> -		munmap(decomp, sizeof(struct decomp) + decomp_len);
> >> +		munmap(decomp, mmap_len);
> >>  		pr_err("Couldn't decompress data\n");
> >>  		return -1;
> >>  	}
> >> @@ -255,15 +261,15 @@ static void perf_session__delete_threads(struct perf_session *session)
> >>  static void perf_session__release_decomp_events(struct perf_session *session)
> >>  {
> >>  	struct decomp *next, *decomp;
> >> -	size_t decomp_len;
> >> +	size_t mmap_len;
> >>  	next = session->decomp;
> >> -	decomp_len = session->header.env.comp_mmap_len;
> >>  	do {
> >>  		decomp = next;
> >>  		if (decomp == NULL)
> >>  			break;
> >>  		next = decomp->next;
> >> -		munmap(decomp, decomp_len + sizeof(struct decomp));
> >> +		mmap_len = decomp->mmap_len;
> >> +		munmap(decomp, mmap_len);
> > 
> > what's the need for extra mmap_len variable in here?
> > could you just use decomp->mmap_len directly?
> 
> To avoid reference to the object being deallocated.
> Plain munmap(), yes - :)

So, Jiri, Acked-by?

- Arnaldo
