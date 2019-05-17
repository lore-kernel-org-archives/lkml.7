Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ABF4C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 15:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 093E321726
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 15:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fHZp23wT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729173AbfEQPBf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 11:01:35 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44502 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728968AbfEQPBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 11:01:35 -0400
Received: by mail-qt1-f194.google.com with SMTP id f24so8282278qtk.11
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 08:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bUdFP7F3fGjfbxXE0kGWWIZYeDIU2OfmfYIj21zDHME=;
        b=fHZp23wTNWhQ+ksm7+DGvxeHVRHnhf1RVIs9aLjVekZZOYyjaVZ4EuFQ8C2TSL6IYB
         OvtoK1ADfd7j+hIBZxwMhdn+Zo0Ywdb9+hn1gfyz7w6urX6HQwgVMjFYwB5vg2nDorBj
         wb17BrKsc/r3MOduCYctfAhraWD7M+RKTquzUElV+3vw8dPoTHlPKHuLQ49aHHPyS/Bj
         6rosL0n4gZTad2MWJUDdQgmelIzjxHs8kfNdAfFQ5hya+i5WnF06k6B7/Sl1LoZoMX8Y
         mAAFmC59EQ1Uda9gzRb46orL//aDREgr59plKkhThUyWpxdIEK9ECJWee7Cs9Ng/L6iZ
         9J4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bUdFP7F3fGjfbxXE0kGWWIZYeDIU2OfmfYIj21zDHME=;
        b=Ln2qJMAFPY6xoKCn2JrJDdVqkrTHUkMLhMPakJSEmVgxf9Ym69uX562MwSamxG80QV
         h6KBldiALfnzGIsXtXKjpRzmqkWTZwo2PLk0blU5BzAkxPGgPZXApn0IW50QaDPOnXxv
         NU/If3C/GhG8vNnkRfNjlNDUHuCHx3PLTxuXhb992zLjK6BvqaO5SQ3ClG/mVlUlk/4Q
         qK3+I54XlKhW4Lg7x8ZkdrFaFlFoPPn9OiEv2v9FlFJ43rBIxNZgv0BlVy5sMIwcbmli
         DAHjrYomJuLIlD6COAHzdGCtOBPL3/eTs4m8DJIg8MiuB/t26JtwB+RVWtFRR3ps3Pb7
         TBwg==
X-Gm-Message-State: APjAAAUeI5cyOHqxZwhI+4f09ElQsOyJMLmNmZUpzzBLQYXOgrmusjhq
        BSTiHiEX8+eHn5qEC5jbhLtN8C/L
X-Google-Smtp-Source: APXvYqyoM8v6RyZ/mPiZ2/UtdhLPh80K2zNlDibuXAlm6sHWHt9XuwubdRzw1jDFaCITcIZcZa9/sA==
X-Received: by 2002:ad4:5365:: with SMTP id e5mr45214898qvv.197.1558105293066;
        Fri, 17 May 2019 08:01:33 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([177.195.211.69])
        by smtp.gmail.com with ESMTPSA id v126sm4239216qkh.86.2019.05.17.08.01.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 17 May 2019 08:01:32 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 77BEA404A1; Fri, 17 May 2019 12:01:22 -0300 (-03)
Date:   Fri, 17 May 2019 12:01:22 -0300
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 09/12] perf record: implement
 -z,--compression_level[=<n>] option
Message-ID: <20190517150122.GF8945@kernel.org>
References: <20190515123802.GA23162@kernel.org>
 <175a0cd8-226f-dee4-8919-89f844a6dc8b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175a0cd8-226f-dee4-8919-89f844a6dc8b@linux.intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, May 15, 2019 at 06:44:29PM +0300, Alexey Budankov escreveu:
> On 15.05.2019 15:59, Arnaldo Carvalho de Melo wrote:
> > Em Wed, May 15, 2019 at 11:43:30AM +0300, Alexey Budankov escreveu:
> >> On 15.05.2019 0:46, Arnaldo Carvalho de Melo wrote:
> >>> Em Tue, May 14, 2019 at 05:20:41PM -0300, Arnaldo Carvalho de Melo escreveu:
> >>>> Em Mon, Mar 18, 2019 at 08:44:42PM +0300, Alexey Budankov escreveu:
> > 
> >>>>> Implemented -z,--compression_level[=<n>] option that enables compression
> >>>>> of mmaped kernel data buffers content in runtime during perf record
> >>>>> mode collection. Default option value is 1 (fastest compression).
> > 
> >>> <SNIP>
> > 
> >>>> [root@quaco ~]# perf record -z2
> >>>> ^C[ perf record: Woken up 1 times to write data ]
> >>>> 0x1746e0 [0x76]: failed to process type: 81 [Invalid argument]
> >>>> [ perf record: Captured and wrote 1.568 MB perf.data, compressed (original 0.452 MB, ratio is 3.995) ]
> > 
> >>>> [root@quaco ~]#
> > 
> >>> So, its the buildid processing at the end, so we can't do build-id
> >>> processing when using PERF_RECORD_COMPRESSED, otherwise we'd have to
> >>> uncompress at the end to find the PERF_RECORD_FORK/PERF_RECORD_MMAP,
> >>> etc.
> > 
> >>> [root@quaco ~]# perf record -z2  --no-buildid sleep 1
> >>> [ perf record: Woken up 1 times to write data ]
> >>> [ perf record: Captured and wrote 0.020 MB perf.data, compressed (original 0.001 MB, ratio is 2.153) ]
> >>> [root@quaco ~]# perf report -D | grep PERF_RECORD_COMP
> >>> 0x4f40 [0x195]: failed to process type: 81 [Invalid argument]
> >>> Error:
> >>> failed to process sample
> >>> 0 0x4f40 [0x195]: PERF_RECORD_COMPRESSED
> >>> [root@quaco ~]#
> > 
> >>> I'll play with it tomorrow.
> > 
> >> Applied the whole patch set on top of the current perf/core 
> >> and the whole thing functions as expected.
> > 
> > It doesn't, see the reported error above, these three lines, that
> > shouldn't be there:
> > 
> > 0x4f40 [0x195]: failed to process type: 81 [Invalid argument]
> > Error:
> > failed to process sample
> > 
> > That is because at this point in the patch series a record was
> > introduced that is not being handled by the build id processing done, by
> > default, at the end of the 'perf record' session, and, as explained
> > above, needs fixing so that when we do 'git bisect' looking for a non
> > expected "failed to process type: 81" kind of error, this doesn't
> > appear.
> > 
> > I added the changes below to this cset and will continue from there:
> > 
> > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > index d84a4885e341..f8d21991f94c 100644
> > --- a/tools/perf/builtin-record.c
> > +++ b/tools/perf/builtin-record.c
> > @@ -2284,6 +2284,12 @@ int cmd_record(int argc, const char **argv)
> >  			"cgroup monitoring only available in system-wide mode");
> >  
> >  	}
> > +
> > +	if (rec->opts.comp_level != 0) {
> > +		pr_debug("Compression enabled, disabling build id collection at the end of the session\n");
> > +		rec->no_buildid = true;
> > +	}
> > +
> >  	if (rec->opts.record_switch_events &&
> >  	    !perf_can_record_switch_events()) {
> >  		ui__error("kernel does not support recording context switch events\n");
> > 
> > ---------------------------------------------------------------------------
> > 
> > [acme@quaco perf]$ perf record -z2 sleep 1
> > [ perf record: Woken up 1 times to write data ]
> > [ perf record: Captured and wrote 0.001 MB perf.data, compressed (original 0.001 MB, ratio is 2.292) ]
> > [acme@quaco perf]$ perf record -v -z2 sleep 1
> > Compression enabled, disabling build id collection at the end of the session
> > Using CPUID GenuineIntel-6-8E-A
> > nr_cblocks: 0
> > affinity: SYS
> > mmap flush: 1
> > comp level: 2
> > mmap size 528384B
> > Couldn't start the BPF side band thread:
> > BPF programs starting from now on won't be annotatable
> > perf_event__synthesize_bpf_events: can't get next program: Operation not permitted
> > [ perf record: Woken up 1 times to write data ]
> > [ perf record: Captured and wrote 0.001 MB perf.data, compressed (original 0.001 MB, ratio is 2.305) ]
> > [acme@quaco perf]$
> > 
> > Will check if its possible to get rid of the following in this patch, to
> > keep bisection working for this case as well:
> > 
> > [acme@quaco perf]$ perf report -D | grep COMPRESS
> > 0x1b8 [0x169]: failed to process type: 81 [Invalid argument]
> > Error:
> > failed to process sample
> > 0 0x1b8 [0x169]: PERF_RECORD_COMPRESSED
> > [acme@quaco perf]$
> 
> Makes sense. Thanks.

I did it yesterday, all is in my acme/perf/core branch, now testing it
together with the large pile of patches there accumulated while I was in
LSF/MM + vacations :-)

All have already passed through most of my test build containers, with
most of the distros that have libzstd being updated to include it, and
the make_minimal test build target was updated to build explicitely
disabling zstd, i.e. with NO_LIBZSTD=1, so that we test with/without it
in systems where it is installed and also in systems where zstd is not
even available.

- Arnaldo
