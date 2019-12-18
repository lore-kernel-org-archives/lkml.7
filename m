Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D09B3C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 18:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4AE620716
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 18:22:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNiTLEM+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbfLRSW6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 13:22:58 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39193 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbfLRSW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 13:22:58 -0500
Received: by mail-pf1-f193.google.com with SMTP id q10so1661195pfs.6;
        Wed, 18 Dec 2019 10:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=V951NgCoHrM+Jd5DUWKVXkF2yjsIreg9nmdt04tr6Iw=;
        b=kNiTLEM+7vxDPyk9JBh58nFlsjQRDd5nLtjXmidnl4S2wR4MC66l6FUEQBin/SVOG7
         xwSMDF1d4ozk1WxHNoynKX/uywXPTlrdJAtre7tNTGEHnwPP5ZxwVkTnJ33xaoPAfdxO
         9n2/Tqi+g3T6Cx7PcwEXohQt95Ps2YtrFVyb8OTCDqWJYz8rYSS9oaldhOkt84ipfjvi
         c5Qyn0IKHXCgPqvlQtKJ1uauZYz+7BYFR0KPzo6bzHGrQPU85/4ybBQuvwz5Rt7aVUoV
         RcUjkSyhMmt1K90ztMikH7TQvP4ZZbRgcFAf6YM3HVhJcsfKmlBtLaG32pw67zEf9FTR
         GIjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V951NgCoHrM+Jd5DUWKVXkF2yjsIreg9nmdt04tr6Iw=;
        b=SKavXf/+Ibu4I0Xd6Mz2qAnQovJh1zr0cC/0a4vJXD9lVen4WbA8P8SYhwCXKeSzxV
         RiSf/rXU1giThnEyB7Qma2dwfZa09tIl3PHqP6kfBC57Zmyh5F3MFGTivkJ4HT/Tr37d
         U/z0z9CjaOgdJTEDi/cCdWbHRZdmbDFVCCgXVF7MnjxeBTU0YJPAJQdx1YGyt2IJL79H
         ku163l7khv/PZViN++HlYME9RUjVmmKejCFcPL6hrWsatzchauymkAYqttUDEqZJlN/t
         cbsEvt8yAJDS+WQtNOBR0bPLxSmPwTUxeSxYX/OMtum1H9QuTs4JaUU+vtvgir0mm3o1
         +pyg==
X-Gm-Message-State: APjAAAXko6Mr3caJnnUhnl73XuYAuYrEEXyn8xtXHToHUZMl2zt9xTT9
        jqDj5ag20vdLk4OnXJemOvs=
X-Google-Smtp-Source: APXvYqxa+P08JXo+9vQ3ZnZLay9lhw6NknWPfP0LI2ggypf6YCTTPkwDG0pNIRXYBlzrRAuK8VE5ZQ==
X-Received: by 2002:a63:454a:: with SMTP id u10mr3088718pgk.248.1576693377160;
        Wed, 18 Dec 2019 10:22:57 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id t65sm4336051pfd.178.2019.12.18.10.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 10:22:56 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5F43240CB9; Wed, 18 Dec 2019 15:22:54 -0300 (-03)
Date:   Wed, 18 Dec 2019 15:22:54 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 12/12] perf maps: Set maps pointer in the kmap area for
 kernel maps
Message-ID: <20191218182254.GA13282@kernel.org>
References: <20191217144828.2460-1-acme@kernel.org>
 <20191217144828.2460-13-acme@kernel.org>
 <20191218090504.GE19062@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191218090504.GE19062@krava>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Dec 18, 2019 at 10:05:04AM +0100, Jiri Olsa escreveu:
> On Tue, Dec 17, 2019 at 11:48:28AM -0300, Arnaldo Carvalho de Melo wrote:
> 
> SNIP
> 
> > +	machine->vmlinux_map = map__new2(0, kernel, &machine->kmaps);
> >  	if (machine->vmlinux_map == NULL)
> >  		return -1;
> >  
> > @@ -1098,7 +1097,6 @@ __machine__create_kernel_maps(struct machine *machine, struct dso *kernel)
> >  	if (!kmap)
> >  		return -1;
> >  
> > -	kmap->kmaps = &machine->kmaps;
> >  	maps__insert(&machine->kmaps, map);
> >  
> >  	return 0;
> > diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
> > index fdd5bddb3075..a2cdfe62df94 100644
> > --- a/tools/perf/util/map.c
> > +++ b/tools/perf/util/map.c
> > @@ -223,7 +223,7 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
> >   * they are loaded) and for vmlinux, where only after we load all the
> >   * symbols we'll know where it starts and ends.
> >   */
> > -struct map *map__new2(u64 start, struct dso *dso)
> > +struct map *map__new2(u64 start, struct dso *dso, struct maps *kmaps)
> >  {
> >  	struct map *map = calloc(1, (sizeof(*map) +
> >  				     (dso->kernel ? sizeof(struct kmap) : 0)));
> > @@ -232,6 +232,19 @@ struct map *map__new2(u64 start, struct dso *dso)
> >  		 * ->end will be filled after we load all the symbols
> >  		 */
> >  		map__init(map, start, 0, 0, dso);
> 
> we are passing NULL for kmaps in some cases,
> should we check it in here and warn?
> 
> 		if (!WARN_ON_ONCE(!kmaps, "too bad..") && dso->kernel)

After looking at this some more, I retract this patch and instead the
two-liner at the end of this message seems enough.

I forgot the dso->kernel is just set for the main kernel map, and what
dso__process_kernel_symbol is doing is to split that map into chunks for
the ELF sections for the main kernel map, as an extra tidbit of
information, i.e. that symbol is in a specific main kernel section, so
its dso->kernel continues being set and thus it expects the kmap area to
be in place.

There is space for simplification in this old code, but for now the
safest is just the patch below, agreed?

- Arnaldo

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 6658fbf196e6..1965aefccb02 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -920,6 +920,9 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
 		if (curr_map == NULL)
 			return -1;
 
+		if (curr_dso->kernel)
+			map__kmap(curr_map)->kmaps = kmaps;
+
 		if (adjust_kernel_syms) {
 			curr_map->start  = shdr->sh_addr + ref_reloc(kmap);
 			curr_map->end	 = curr_map->start + shdr->sh_size;
