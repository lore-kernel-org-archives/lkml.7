Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D98C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE417206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:35:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rkyT7KHP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732562AbfDQOfr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 10:35:47 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40938 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730463AbfDQOfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 10:35:47 -0400
Received: by mail-qt1-f194.google.com with SMTP id x12so27563888qts.7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 07:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=C+dXDxKP2DfUadMk0J/h5v57BizP6fDRP8FUg+wPT8w=;
        b=rkyT7KHPlS3K67drfHukAWHQAfv2X4zlW1yk92lTbiGS/P4u9/L1hR+VyDJC1Mjtmc
         wt975s9Ee04lfkImktYw90laUlEhI4u3ROUqEbfrEimJjtnt+LJAjDB9IUIP+gWlGwoO
         YtTvo0vny+EFD1LK9myLn6PHxWL9egeTW8BgYRSHu1dVTumCzmcZTPVpSCaFvetQWdsk
         zLdcXn4jWTmWwTwOL2P2olzdjFeoPBbjfULUfUC2sd3m4Chv/XSqiJZNjrAZO64i23k3
         Xuwj27O4HM9SsOcrnbvwzYm1Gu59NzGTcHun1v66grnZnKBimKHEx8E3MWygUU7ua0s2
         dgwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C+dXDxKP2DfUadMk0J/h5v57BizP6fDRP8FUg+wPT8w=;
        b=Mdj5Tkzd8SGqsbgXjJEwCHfWJlXuU7Rzv8js2Yfn+K5HZs0LSZTL0/aOcj0RW8+GT8
         a3FcY1GL9H86QOEl3c5BG9W0G9x/rqqlr110vAkgs52/Sl3TXBeC0i6SC0RrGkKXWnUa
         yKsqNHfLkbEUjR3cD5DOBVQAHN8TtuFlrqWFYlavgsazK2YdxVSLOVYbwpnMbmzWrrSy
         57smMheiIeyRM+lr0iEKzKbfTx6QEzYq94Mbd270wSLutrzh0hCyM6Qpm3U/5CyWV3DH
         NNNTk41NeWJLRv6qzviOzyJQdZpwGDUUKoRrAM0FjJp5QHSxAQbpev+aKrse1JtHx+Tl
         71gw==
X-Gm-Message-State: APjAAAXpS2PLbTrYe9RrceQeUYNG33cg1K5WGWKh+1eJI4FhlCcKkghK
        9Mi0FpRtbmBui7LvvA801MI=
X-Google-Smtp-Source: APXvYqwXXPZx1I/Fbl92EOa8nLcMy8dR1zL2v/5IAPchcN+RLhsIrZuXOAl1i9V97kPpvmWxhHjnzg==
X-Received: by 2002:a0c:a362:: with SMTP id u89mr167692qvu.148.1555511745859;
        Wed, 17 Apr 2019 07:35:45 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([2804:14d:1283:9770::1002])
        by smtp.gmail.com with ESMTPSA id f14sm797036qkk.32.2019.04.17.07.35.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 07:35:44 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4905C40521; Wed, 17 Apr 2019 11:35:42 -0300 (-03)
Date:   Wed, 17 Apr 2019 11:35:42 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Alexey Budankov <alexey.budankov@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] perf record: collect user registers set jointly with
 dwarf stacks
Message-ID: <20190417143542.GA5246@kernel.org>
References: <a83183c0-21f4-02af-1443-1a3fdb5d89c3@linux.intel.com>
 <20190417073952.GF17024@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417073952.GF17024@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Apr 17, 2019 at 09:39:52AM +0200, Jiri Olsa escreveu:
> On Mon, Apr 15, 2019 at 06:36:13PM +0300, Alexey Budankov wrote:
> > 
> > When dwarf stacks are collected jointly with user specified register
> > set using --user-regs option like below the full register context is
> > still captured on a sample:
> > 
> >   $ perf record -g --call-graph dwarf,1024 --user-regs=IP,SP,BP -- matrix.gcc.g.O3
> > 
> >   188143843893585 0x6b48 [0x4f8]: PERF_RECORD_SAMPLE(IP, 0x4002): 23828/23828: 0x401236 period: 1363819 addr: 0x7ffedbdd51ac
> >   ... FP chain: nr:0
> >   ... user regs: mask 0xff0fff ABI 64-bit
> >   .... AX    0x53b
> >   .... BX    0x7ffedbdd3cc0
> >   .... CX    0xffffffff
> >   .... DX    0x33d3a
> >   .... SI    0x7f09b74c38d0
> >   .... DI    0x0
> >   .... BP    0x401260
> >   .... SP    0x7ffedbdd3cc0
> >   .... IP    0x401236
> >   .... FLAGS 0x20a
> >   .... CS    0x33
> >   .... SS    0x2b
> >   .... R8    0x7f09b74c3800
> >   .... R9    0x7f09b74c2da0
> >   .... R10   0xfffffffffffff3ce
> >   .... R11   0x246
> >   .... R12   0x401070
> >   .... R13   0x7ffedbdd5db0
> >   .... R14   0x0
> >   .... R15   0x0
> >   ... ustack: size 1024, offset 0xe0
> >    . data_src: 0x5080021
> >    ... thread: stack_test2.g.O:23828
> >    ...... dso: /root/abudanko/stacks/stack_test2.g.O3
> > 
> > After applying the change suggested in the patch the sample data contain
> > only user specified register values:
> > 
> >   $ perf record -g --call-graph dwarf,1024 --user-regs=IP,SP,BP -- matrix.gcc.g.03
> > 
> >   188368474305373 0x5e40 [0x470]: PERF_RECORD_SAMPLE(IP, 0x4002): 23839/23839: 0x401236 period: 1260507 addr: 0x7ffd3d85e96c
> >   ... FP chain: nr:0
> >   ... user regs: mask 0x1c0 ABI 64-bit
> >   .... BP    0x401260
> >   .... SP    0x7ffd3d85cc20
> >   .... IP    0x401236
> >   ... ustack: size 1024, offset 0x58
> >    . data_src: 0x5080021
> >    ... thread: stack_test2.g.O:23839
> >    ...... dso: /root/abudanko/stacks/stack_test2.g.O3
> > 
> > Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

So, there are registers that are needed to do the DWARF unwinding,
right? But at the same time, if the user says only some are needed, he
better know what they're doing and ask for at least the registers needed
for the unwinding process to be successfull, right?

- Arnaldo
 
> thanks,
> jirka
> 
> > ---
> >  tools/perf/util/evsel.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > index 84cfb9fe2fc6..29a223b4c699 100644
> > --- a/tools/perf/util/evsel.c
> > +++ b/tools/perf/util/evsel.c
> > @@ -702,7 +702,8 @@ static void __perf_evsel__config_callchain(struct perf_evsel *evsel,
> >  		if (!function) {
> >  			perf_evsel__set_sample_bit(evsel, REGS_USER);
> >  			perf_evsel__set_sample_bit(evsel, STACK_USER);
> > -			attr->sample_regs_user |= PERF_REGS_MASK;
> > +			if (!opts->sample_user_regs)
> > +				attr->sample_regs_user |= PERF_REGS_MASK;
> >  			attr->sample_stack_user = param->dump_size;
> >  			attr->exclude_callchain_user = 1;
> >  		} else {
> > -- 
> > 2.20.1
> > 

-- 

- Arnaldo
