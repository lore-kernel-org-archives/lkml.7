Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F3ECC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 09:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D03622465E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 09:24:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OEHTT5qA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbfLSJY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 04:24:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20919 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726599AbfLSJY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 04:24:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576747467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yW871V/Rfnx6IVFLj4fHZJXpGz1yS41EFn/XzNPZO0Q=;
        b=OEHTT5qAckaxnIC1CTExNTR15EGr6zrVtmzA9R8ZWx/T42H59v8S0qJ+ew/MSbS/ediKeS
        gFoO6Kb5VSfUeyDoSR9qz/aTfSDDOurVoC7nOmHPpmtDMIyfzJp9oBfaXgzoT678hnXMkp
        jwYDn/jTF5taKa1hybH9hwcVkYIWkUg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-WruUOAN6PM-ADN1fLbCZrQ-1; Thu, 19 Dec 2019 04:24:20 -0500
X-MC-Unique: WruUOAN6PM-ADN1fLbCZrQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6E89D107ACC7;
        Thu, 19 Dec 2019 09:24:19 +0000 (UTC)
Received: from krava (unknown [10.43.17.106])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 35BB36888D;
        Thu, 19 Dec 2019 09:24:17 +0000 (UTC)
Date:   Thu, 19 Dec 2019 10:24:14 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 12/12] perf maps: Set maps pointer in the kmap area for
 kernel maps
Message-ID: <20191219092414.GC8141@krava>
References: <20191217144828.2460-1-acme@kernel.org>
 <20191217144828.2460-13-acme@kernel.org>
 <20191218090504.GE19062@krava>
 <20191218182254.GA13282@kernel.org>
 <20191218190120.GB13282@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191218190120.GB13282@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 04:01:20PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Wed, Dec 18, 2019 at 03:22:54PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Wed, Dec 18, 2019 at 10:05:04AM +0100, Jiri Olsa escreveu:
> > After looking at this some more, I retract this patch and instead the
> > two-liner at the end of this message seems enough.
> 
> So here is the full cset, I have not made changes to the other patches,
> 
> - Arnaldo
> 
> commit 178427a192bcbe3ad93dd0637c3dceaa3ccef31e
> Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> Date:   Wed Dec 18 15:23:14 2019 -0300
> 
>     perf map: Set kmap->kmaps backpointer for main kernel map chunks
>     
>     When a map is create to represent the main kernel area (vmlinux) with
>     map__new2() we allocate an extra area to store a pointer to the 'struct
>     maps' for the kernel maps, so that we can access that struct when
>     loading ELF files or kallsyms, as we will need to split it in multiple
>     maps, one per kernel module or ELF section (such as ".init.text").
>     
>     So when map->dso->kernel is non-zero, it is expected that
>     map__kmap(map)->kmaps to be set to the tree of kernel maps (modules,
>     chunks of the main kernel, bpf progs put in place via
>     PERF_RECORD_KSYMBOL, the main kernel).
>     
>     This was not the case when we were splitting the main kernel into chunks
>     for its ELF sections, which ended up making 'perf report --children'
>     processing a perf.data file with callchains to trip on
>     __map__is_kernel(), when we press ENTER to see the popup menu for main
>     histogram entries that starts at a symbol in the ".init.text" ELF
>     section, e.g.:
>     
>     -    8.83%     0.00%  swapper     [kernel.vmlinux].init.text  [k] start_kernel
>          start_kernel
>          cpu_startup_entry
>          do_idle
>          cpuidle_enter
>          cpuidle_enter_state
>          intel_idle
>     
>     Fix it.
>     
>     Cc: Adrian Hunter <adrian.hunter@intel.com>
>     Cc: Jiri Olsa <jolsa@kernel.org>
>     Cc: Namhyung Kim <namhyung@kernel.org>
>     Link: https://lkml.kernel.org/n/tip-vcokue57w4goyzweg2rr5i80@git.kernel.org
>     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> index 6658fbf196e6..1965aefccb02 100644
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
> @@ -920,6 +920,9 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
>  		if (curr_map == NULL)
>  			return -1;
>  
> +		if (curr_dso->kernel)
> +			map__kmap(curr_map)->kmaps = kmaps;
> +
>  		if (adjust_kernel_syms) {
>  			curr_map->start  = shdr->sh_addr + ref_reloc(kmap);
>  			curr_map->end	 = curr_map->start + shdr->sh_size;
> 

looks good ;-)

jirka

