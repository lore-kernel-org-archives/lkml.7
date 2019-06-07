Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6915C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 18:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CF47208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 18:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IAyCC6Ja"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731725AbfFGSXd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 14:23:33 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34654 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730183AbfFGSXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 14:23:32 -0400
Received: by mail-qt1-f193.google.com with SMTP id m29so3414845qtu.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 11:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tsfr6umeVueoQ8nTR1ppqgNBP/xzgyeaPLGI8Cc6r4c=;
        b=IAyCC6JadIqgfiOmvLE9V8xO5/sx9mJqMG6DgPTXckUXLZRy3gHgtXfP8O6aQLALFw
         hdexS+aURjpiv+mkPe5u0MvcITH69tU1G4wAasJnXwzmoKvgvi+g6+HJfMT8asWe6rvZ
         n38YvzCiCIDEkhO5LtIf6Fj4MZoNR5W/U/350etOrb1PTA/G8QL6H0F0CstGdt+l41dO
         i0SGOnWBBAJ2bVTpOIXgd2N2vcsRCsolHAIwf6RcGtc3RIgbmfY1BpTdGgcyLNDazsPZ
         RXfM2K14D3+zzi3I2HRDlAkKSvr9daRplrlyIOkYrpNAxOqNN4e+2gRfENwsbt/x6EGM
         9T+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tsfr6umeVueoQ8nTR1ppqgNBP/xzgyeaPLGI8Cc6r4c=;
        b=HRM+TToG0HFFAvNjVsJCc5Lqg7OSpgtpX5cjeRQzlG4M0ad2kLBG7BORvhA5qJ0Ehm
         s3CX3qWuJdLvzlvUWKgKwjBof0OWMUByhkPJl54Gv6xAZA0642DmaqlsVrkjvcPUAUxs
         vcM+usumObNn0MNTi9XkA9uemn6qy8+I9VYwc0ly3XW7SVU+OhLLcV48HHRpd5SWT/jz
         BR0P2YWGjPzCfeZC/1+X94/+R0BR/imgfb0W9/67OJWaJ6fstz0b/74BtS5wbEmLjp0P
         9muqtzJ1bJg1NWz8TlkGQp34TJnfgmIG2rizL4VVQoTuEhTFu/S9esPnXI90/79b26Y4
         0RLw==
X-Gm-Message-State: APjAAAWuIz1c5FsTFExGmomuoV/cPhLzeyqJYH7g8ATStxcEyJRkjn4v
        FJBAWQXR3vW12xIycX7rq64=
X-Google-Smtp-Source: APXvYqxz5cT+z8QlIrBuNLPDYU8fejj53xwjPibMzgcVv7HvBk8ekoQFzmhy6xdomlXQmeGKyDrKgA==
X-Received: by 2002:aed:3824:: with SMTP id j33mr47027712qte.108.1559931810763;
        Fri, 07 Jun 2019 11:23:30 -0700 (PDT)
Received: from quaco.ghostprotocols.net (187-26-97-17.3g.claro.net.br. [187.26.97.17])
        by smtp.gmail.com with ESMTPSA id t197sm1673423qke.2.2019.06.07.11.23.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 07 Jun 2019 11:23:29 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B36CA41149; Fri,  7 Jun 2019 15:23:25 -0300 (-03)
Date:   Fri, 7 Jun 2019 15:23:25 -0300
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        suzuki.poulose@arm.com, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tools: Properly set the value of 'old' and 'head'
 in snapshot mode
Message-ID: <20190607182325.GL21245@kernel.org>
References: <20190605161633.12245-1-mathieu.poirier@linaro.org>
 <20190606201056.GJ21245@kernel.org>
 <20190607064425.GF5970@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607064425.GF5970@leoy-ThinkPad-X240s>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jun 07, 2019 at 02:44:25PM +0800, Leo Yan escreveu:
> On Thu, Jun 06, 2019 at 05:10:56PM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Wed, Jun 05, 2019 at 10:16:33AM -0600, Mathieu Poirier escreveu:
> > > This patch adds the necessay intelligence to properly compute the value
> > > of 'old' and 'head' when operating in snapshot mode.  That way we can get
> > > the latest information in the AUX buffer and be compatible with the
> > > generic AUX ring buffer mechanic.
> > 
> > Leo, have you had the chance to test/review this one? Suzuki?
> 
> Sure.  I applied this patch on the perf/core branch (with latest
> commit 3e4fbf36c1e3 'perf augmented_raw_syscalls: Move reading
> filename to the loop') and passed testing with below steps:
> 
> # perf record -e cs_etm/@tmc_etr0/ -S -m,64 --per-thread ./sort &
> [1] 19097
> Bubble sorting array of 30000 elements
> 
> # kill -USR2 19097
> # kill -USR2 19097
> # kill -USR2 19097
> [ perf record: Woken up 4 times to write data ]
> [ perf record: Captured and wrote 0.753 MB perf.data ]
> 
> FWIW:
> 
> Tested-by: Leo Yan <leo.yan@linaro.org>

Thanks a lot, I've added your "Tester notes:" and also your Tested-by:.

As I don't have hardware (yet) to test these patches, tests by people
who can test on real hardware is always super appreciated.

Any suggestions for a SBC that I could buy to be able to do so?

Regards,

- Arnaldo
 
> > I also changed the subject to:
> > 
> >   [PATCH] perf cs-etm: Properly set the value of 'old' and 'head' in snapshot mode
> > 
> > So that when looking at a 'git log --oneline' one can have the proper
> > context and know that its about cs-etm.
> > 
> > - Arnaldo
> >  
> > > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > > ---
> > >  tools/perf/arch/arm/util/cs-etm.c | 127 +++++++++++++++++++++++++++++-
> > >  1 file changed, 123 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
> > > index 911426721170..0a278bbcaba6 100644
> > > --- a/tools/perf/arch/arm/util/cs-etm.c
> > > +++ b/tools/perf/arch/arm/util/cs-etm.c
> > > @@ -31,6 +31,8 @@ struct cs_etm_recording {
> > >  	struct auxtrace_record	itr;
> > >  	struct perf_pmu		*cs_etm_pmu;
> > >  	struct perf_evlist	*evlist;
> > > +	int			wrapped_cnt;
> > > +	bool			*wrapped;
> > >  	bool			snapshot_mode;
> > >  	size_t			snapshot_size;
> > >  };
> > > @@ -536,16 +538,131 @@ static int cs_etm_info_fill(struct auxtrace_record *itr,
> > >  	return 0;
> > >  }
> > >  
> > > -static int cs_etm_find_snapshot(struct auxtrace_record *itr __maybe_unused,
> > > +static int cs_etm_alloc_wrapped_array(struct cs_etm_recording *ptr, int idx)
> > > +{
> > > +	bool *wrapped;
> > > +	int cnt = ptr->wrapped_cnt;
> > > +
> > > +	/* Make @ptr->wrapped as big as @idx */
> > > +	while (cnt <= idx)
> > > +		cnt++;
> > > +
> > > +	/*
> > > +	 * Free'ed in cs_etm_recording_free().  Using realloc() to avoid
> > > +	 * cross compilation problems where the host's system supports
> > > +	 * reallocarray() but not the target.
> > > +	 */
> > > +	wrapped = realloc(ptr->wrapped, cnt * sizeof(bool));
> > > +	if (!wrapped)
> > > +		return -ENOMEM;
> > > +
> > > +	wrapped[cnt - 1] = false;
> > > +	ptr->wrapped_cnt = cnt;
> > > +	ptr->wrapped = wrapped;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static bool cs_etm_buffer_has_wrapped(unsigned char *buffer,
> > > +				      size_t buffer_size, u64 head)
> > > +{
> > > +	u64 i, watermark;
> > > +	u64 *buf = (u64 *)buffer;
> > > +	size_t buf_size = buffer_size;
> > > +
> > > +	/*
> > > +	 * We want to look the very last 512 byte (chosen arbitrarily) in
> > > +	 * the ring buffer.
> > > +	 */
> > > +	watermark = buf_size - 512;
> > > +
> > > +	/*
> > > +	 * @head is continuously increasing - if its value is equal or greater
> > > +	 * than the size of the ring buffer, it has wrapped around.
> > > +	 */
> > > +	if (head >= buffer_size)
> > > +		return true;
> > > +
> > > +	/*
> > > +	 * The value of @head is somewhere within the size of the ring buffer.
> > > +	 * This can be that there hasn't been enough data to fill the ring
> > > +	 * buffer yet or the trace time was so long that @head has numerically
> > > +	 * wrapped around.  To find we need to check if we have data at the very
> > > +	 * end of the ring buffer.  We can reliably do this because mmap'ed
> > > +	 * pages are zeroed out and there is a fresh mapping with every new
> > > +	 * session.
> > > +	 */
> > > +
> > > +	/* @head is less than 512 byte from the end of the ring buffer */
> > > +	if (head > watermark)
> > > +		watermark = head;
> > > +
> > > +	/*
> > > +	 * Speed things up by using 64 bit transactions (see "u64 *buf" above)
> > > +	 */
> > > +	watermark >>= 3;
> > > +	buf_size >>= 3;
> > > +
> > > +	/*
> > > +	 * If we find trace data at the end of the ring buffer, @head has
> > > +	 * been there and has numerically wrapped around at least once.
> > > +	 */
> > > +	for (i = watermark; i < buf_size; i++)
> > > +		if (buf[i])
> > > +			return true;
> > > +
> > > +	return false;
> > > +}
> > > +
> > > +static int cs_etm_find_snapshot(struct auxtrace_record *itr,
> > >  				int idx, struct auxtrace_mmap *mm,
> > > -				unsigned char *data __maybe_unused,
> > > +				unsigned char *data,
> > >  				u64 *head, u64 *old)
> > >  {
> > > +	int err;
> > > +	bool wrapped;
> > > +	struct cs_etm_recording *ptr =
> > > +			container_of(itr, struct cs_etm_recording, itr);
> > > +
> > > +	/*
> > > +	 * Allocate memory to keep track of wrapping if this is the first
> > > +	 * time we deal with this *mm.
> > > +	 */
> > > +	if (idx >= ptr->wrapped_cnt) {
> > > +		err = cs_etm_alloc_wrapped_array(ptr, idx);
> > > +		if (err)
> > > +			return err;
> > > +	}
> > > +
> > > +	/*
> > > +	 * Check to see if *head has wrapped around.  If it hasn't only the
> > > +	 * amount of data between *head and *old is snapshot'ed to avoid
> > > +	 * bloating the perf.data file with zeros.  But as soon as *head has
> > > +	 * wrapped around the entire size of the AUX ring buffer it taken.
> > > +	 */
> > > +	wrapped = ptr->wrapped[idx];
> > > +	if (!wrapped && cs_etm_buffer_has_wrapped(data, mm->len, *head)) {
> > > +		wrapped = true;
> > > +		ptr->wrapped[idx] = true;
> > > +	}
> > > +
> > >  	pr_debug3("%s: mmap index %d old head %zu new head %zu size %zu\n",
> > >  		  __func__, idx, (size_t)*old, (size_t)*head, mm->len);
> > >  
> > > -	*old = *head;
> > > -	*head += mm->len;
> > > +	/* No wrap has occurred, we can just use *head and *old. */
> > > +	if (!wrapped)
> > > +		return 0;
> > > +
> > > +	/*
> > > +	 * *head has wrapped around - adjust *head and *old to pickup the
> > > +	 * entire content of the AUX buffer.
> > > +	 */
> > > +	if (*head >= mm->len) {
> > > +		*old = *head - mm->len;
> > > +	} else {
> > > +		*head += mm->len;
> > > +		*old = *head - mm->len;
> > > +	}
> > >  
> > >  	return 0;
> > >  }
> > > @@ -586,6 +703,8 @@ static void cs_etm_recording_free(struct auxtrace_record *itr)
> > >  {
> > >  	struct cs_etm_recording *ptr =
> > >  			container_of(itr, struct cs_etm_recording, itr);
> > > +
> > > +	zfree(&ptr->wrapped);
> > >  	free(ptr);
> > >  }
> > >  
> > > -- 
> > > 2.17.1
> > 
> > -- 
> > 
> > - Arnaldo

-- 

- Arnaldo
