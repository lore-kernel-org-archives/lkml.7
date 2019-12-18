Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B9CC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 19:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D99C72082E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 19:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZyiAFIJm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbfLRTBY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 14:01:24 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43468 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbfLRTBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 14:01:24 -0500
Received: by mail-pf1-f196.google.com with SMTP id x6so634553pfo.10;
        Wed, 18 Dec 2019 11:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6WdwKS5JVC4M3j3bnAu7sePfl7KGaVURBL4LQ+xkW/U=;
        b=ZyiAFIJmTRtFpMrV8l/2UeAp3PD0SIwzseCpJPoVGKuXqx4QL4FQ7kyXWxQxwka5Yy
         yPbvde4NK8LDPnNEfRyNHAYIMuR4/t6pacMBlT3c7rZre7eXcNdXYS6jKws8d1abcF2V
         Zcb5f2+ckYyFxdFXXH5eRKxpsgt4UUTBLrU0NbkCZ/o9Aqbrt4ZT5+U2DNbflOv8jqxX
         yiYpGuOF9rZwDgaaREpbx7QxgV+E0vGhZ1bnzMCBUEUVsuWNckc55+72+vHtZAetMYdz
         HnGYAkLGsp3xr3DD9PIXtF/aedux+NwoZ3FSoYu6Jm8AUlznG2HfSURNRiXSeYCguq9i
         oncQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6WdwKS5JVC4M3j3bnAu7sePfl7KGaVURBL4LQ+xkW/U=;
        b=RJkWuA9pb+B+Vyzv2vf/Q/g+uoIjgg9OuddZd3DaRV6afWh8erLqfM6hUtooGMKGgn
         kplNFckGHzWo1Ah9MVK/mb3dqq3h8boZyO4dZluOOfjqbNXiV7u6005s7D62kw3/nOWW
         9zwc1hWLIZ3PIz4wthmbdJndRyrEifKRqxVIqFpdaTfU8jpYe2ftYKY1O6Ssjl+nLUFE
         HsIyH495sjaxumOfkJIoh8L/oCQlN+EihmXf6EIWrM/ESjOEtD01n/qDcLbrvFuyCIuK
         VKSzPFBfWOWHNBojSnFVgxmfWvx2VeczhO30g2K0LZS7RAZgAUq0ZElhZjcRGjAkcyTE
         UDeQ==
X-Gm-Message-State: APjAAAXeHDb0XREdPMXWuGBjy+gcpSG3VQu7gmVhTVr1N/o4B2Aq9my2
        9rliYuZoAP8MAdzJhZiO2bg=
X-Google-Smtp-Source: APXvYqz4O1QWESBMGURUBn+YN804Yfsnzv1kvGBaxOdwV4S51iqyihDMgnA5nZboMzZKV2lt0CEoDg==
X-Received: by 2002:a63:e84d:: with SMTP id a13mr4916981pgk.274.1576695683541;
        Wed, 18 Dec 2019 11:01:23 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id r6sm4359804pfh.91.2019.12.18.11.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 11:01:22 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id AE7DA40CB9; Wed, 18 Dec 2019 16:01:20 -0300 (-03)
Date:   Wed, 18 Dec 2019 16:01:20 -0300
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
Message-ID: <20191218190120.GB13282@kernel.org>
References: <20191217144828.2460-1-acme@kernel.org>
 <20191217144828.2460-13-acme@kernel.org>
 <20191218090504.GE19062@krava>
 <20191218182254.GA13282@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191218182254.GA13282@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Dec 18, 2019 at 03:22:54PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Dec 18, 2019 at 10:05:04AM +0100, Jiri Olsa escreveu:
> After looking at this some more, I retract this patch and instead the
> two-liner at the end of this message seems enough.

So here is the full cset, I have not made changes to the other patches,

- Arnaldo

commit 178427a192bcbe3ad93dd0637c3dceaa3ccef31e
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Wed Dec 18 15:23:14 2019 -0300

    perf map: Set kmap->kmaps backpointer for main kernel map chunks
    
    When a map is create to represent the main kernel area (vmlinux) with
    map__new2() we allocate an extra area to store a pointer to the 'struct
    maps' for the kernel maps, so that we can access that struct when
    loading ELF files or kallsyms, as we will need to split it in multiple
    maps, one per kernel module or ELF section (such as ".init.text").
    
    So when map->dso->kernel is non-zero, it is expected that
    map__kmap(map)->kmaps to be set to the tree of kernel maps (modules,
    chunks of the main kernel, bpf progs put in place via
    PERF_RECORD_KSYMBOL, the main kernel).
    
    This was not the case when we were splitting the main kernel into chunks
    for its ELF sections, which ended up making 'perf report --children'
    processing a perf.data file with callchains to trip on
    __map__is_kernel(), when we press ENTER to see the popup menu for main
    histogram entries that starts at a symbol in the ".init.text" ELF
    section, e.g.:
    
    -    8.83%     0.00%  swapper     [kernel.vmlinux].init.text  [k] start_kernel
         start_kernel
         cpu_startup_entry
         do_idle
         cpuidle_enter
         cpuidle_enter_state
         intel_idle
    
    Fix it.
    
    Cc: Adrian Hunter <adrian.hunter@intel.com>
    Cc: Jiri Olsa <jolsa@kernel.org>
    Cc: Namhyung Kim <namhyung@kernel.org>
    Link: https://lkml.kernel.org/n/tip-vcokue57w4goyzweg2rr5i80@git.kernel.org
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

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
