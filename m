Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3ABAC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 15:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4DD2205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 15:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GXqZz+1V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733222AbfJOPCR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 11:02:17 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34581 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbfJOPCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 11:02:17 -0400
Received: by mail-qk1-f193.google.com with SMTP id q203so19468940qke.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 08:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NLR93Dy9IGF0JBebgrOJmcCmgJkDv562sXNHQrNC0S8=;
        b=GXqZz+1VVKZu7nfPgW/5iUtNqZZD7zhPcAdww2nnnhdOhY4VFPqOQCKjlVLd1HkFKS
         1w1hgnxMIEeOD2ncQ4v2XwIRotLFaDbxWienMfbsyzkhENtn62GsHJhItSakQlK/zAU8
         C6U3d8Be0UE2wB+SOGesDSqadcAsrcMP7VR2K2+2ke8Qr8LDdw+fZyFdOi8NIhF4vA7R
         Xdbi/2BDfty0q+PKPz/loL8/kDE7TZGVPYue1nQIlG6b8GyGcDZJ2MLd3ylx5Xn7XQ3F
         S2+L4QbNFl9+ExtCAZES6nzAprWAohDlZbk/DtKWrv4J+b3y9F5DLX7Fk7XoRff1bid8
         gSfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NLR93Dy9IGF0JBebgrOJmcCmgJkDv562sXNHQrNC0S8=;
        b=bJL3OHnDIxxxK+WJro4HdlFlglWh/QBZGz+iVATfEYsJdMfUKqLnK0puuRSHNnefF4
         l6vVrmFPT4iyEdJ1l8/3ANrGIINhb6iTguqezREBwVgLXcpaqRLRjo0OnFA6dYE8D4AQ
         Azj7F/1UvnsDfrilSEDlxqfkXN2WPtOD20anPlvlJ265XeSOOTzHWMRlha0bcyWqW1Vu
         cU2Mn5gvkLxi/ucCP4nRDHP2Rb14nobclIRYnETS0jIEpmxtSYfCh2THUXigRs6XgR0e
         er0C5B0g31kueFbh9fJXxI+YU9XD3hwg4Rmx02OFmQMj4tyO984YkRKPkG3Wmz9vDyyv
         qPTQ==
X-Gm-Message-State: APjAAAXbrdrDx0KWn+zzt2mvQCfnidP6KWFcOC7jEN7B9OgJb/JqcbgV
        TsF+zn8QkvofQiIjb+PcgT65RUkDS4s=
X-Google-Smtp-Source: APXvYqwR4ig3MELSEKkYdN0rPa0Gd7rROBc/HU1fVsawNHJxzSYaufMilDlGMmI/hfMAh9FVSuWorQ==
X-Received: by 2002:ae9:c00f:: with SMTP id u15mr34751821qkk.281.1571151734851;
        Tue, 15 Oct 2019 08:02:14 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id 44sm11800616qtu.45.2019.10.15.08.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 08:02:13 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 133394DD66; Tue, 15 Oct 2019 12:02:11 -0300 (-03)
Date:   Tue, 15 Oct 2019 12:02:11 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf annotate: Fix multiple memory and file descriptor
 leaks
Message-ID: <20191015150211.GA25820@kernel.org>
References: <20191014171047.GA30850@embeddedor>
 <20191015084632.GC10951@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015084632.GC10951@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Oct 15, 2019 at 10:46:32AM +0200, Jiri Olsa escreveu:
> On Mon, Oct 14, 2019 at 12:10:47PM -0500, Gustavo A. R. Silva wrote:
> > Store SYMBOL_ANNOTATE_ERRNO__BPF_MISSING_BTF in variable *ret*, instead
> > of returning in the middle of the function and leaking multiple
> > resources: prog_linfo, btf, s and bfdf.
> > 
> > Addresses-Coverity-ID: 1454832 ("Structurally dead code")
> > Fixes: 11aad897f6d1 ("perf annotate: Don't return -1 for error when doing BPF disassembly")
> > Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> 
> thanks,
> jirka
> 
> > ---
> >  tools/perf/util/annotate.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> > index 4036c7f7b0fb..e42bf572358c 100644
> > --- a/tools/perf/util/annotate.c
> > +++ b/tools/perf/util/annotate.c
> > @@ -1758,7 +1758,7 @@ static int symbol__disassemble_bpf(struct symbol *sym,
> >  	info_node = perf_env__find_bpf_prog_info(dso->bpf_prog.env,
> >  						 dso->bpf_prog.id);
> >  	if (!info_node) {
> > -		return SYMBOL_ANNOTATE_ERRNO__BPF_MISSING_BTF;
> > +		ret = SYMBOL_ANNOTATE_ERRNO__BPF_MISSING_BTF;
> >  		goto out;

Ouch, unreachable goto, /me ducks

- Arnaldo

> >  	}
> >  	info_linear = info_node->info_linear;
> > -- 
> > 2.23.0
> > 

-- 

- Arnaldo
