Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92368C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 18:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B2B821773
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 18:17:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYZ1/sDh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729541AbfEXSRY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 14:17:24 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36337 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbfEXSRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 14:17:23 -0400
Received: by mail-qk1-f193.google.com with SMTP id o2so8563250qkb.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 11:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mFvw6+J4k/FG3sZmJri0C6ZdtCcbtoQ4ExoHw2HJ7WU=;
        b=lYZ1/sDhk4nLWs+ifnxTW01WIoX6kvLO0RPTi28a+uXMCnFpFMSebZLZ2cHBnfVsr3
         ic/6K08WwW00KE5EEHkK1H9cHp0mkQhzKzq1qJSOkPt7YJgOa+BHJBbFV528+gHSbWea
         ElVtaJIw8ztnRfFcGireUvXSh2+0xWg3CGkf+NpeFd0aWwEm527I+RicRLcpmlV/s0+6
         us1qkJh+oV8FAfRwV5WCYr0oqM1V2HqvTY/wlREQTBafv+FVIJwbaPSAuhQPzrpXz1Dl
         jbtDOu8j4yoSec/MJq/6EVzefn4AECyxlWjnATQFOiEnVpIV/72crodB6z426wonKoSv
         fCDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mFvw6+J4k/FG3sZmJri0C6ZdtCcbtoQ4ExoHw2HJ7WU=;
        b=fwYZecFfT6yn9q7gjEsmJvIoiskNevTsCOnoNjog9+EYXx2XAqSbBNNilBsZIfJRII
         cKw585ISnY03SvLcW5muP6R+RuzwT9EIBEfD/tHJJixUa/LMs0vxIEwZe9M1wlJ2onGu
         XsFadrxtNtrtyzeptFyV5YsyF4gdzy7/81sciwDvOf1VfPzpjg1g3YJcM0wpWMUuuZt+
         H+sPrXUmXltkZn5EZyMIbpj0im8fOnKBV4B5mqesiBd2sHaU7B2I/3yJL+HeZA8SuMfR
         zQBAdD3/TXIzYGz0RmRQJc9oPKsEHw11kYkel+EJiyzez5QRPT0nMYkDh49xYViKlaj8
         3oIQ==
X-Gm-Message-State: APjAAAW4tQR8ItEHcgq4smZ6/8RnEev6Y5p/BzgAEQcnWhWlDk+YCp8b
        pnRGx9rSTRC2H1vo9ZDPbB8=
X-Google-Smtp-Source: APXvYqxa4BCI+j2yWyr3YwJtAhrLxCB+X6jw3TiSYhMYxfx2wE/9n6bkTCd5FNnE0lNWJKgWnVUZGw==
X-Received: by 2002:a37:7a47:: with SMTP id v68mr80791744qkc.56.1558721842522;
        Fri, 24 May 2019 11:17:22 -0700 (PDT)
Received: from quaco.ghostprotocols.net (177-58-252-77.3g.claro.net.br. [177.58.252.77])
        by smtp.gmail.com with ESMTPSA id t17sm1466515qte.66.2019.05.24.11.17.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 24 May 2019 11:17:21 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9464341149; Fri, 24 May 2019 15:17:17 -0300 (-03)
Date:   Fri, 24 May 2019 15:17:17 -0300
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Stanislav Fomichev <sdf@fomichev.me>,
        Song Liu <songliubraving@fb.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 05/12] perf tools: Read also the end of the kernel
Message-ID: <20190524181717.GF17479@kernel.org>
References: <20190508132010.14512-1-jolsa@kernel.org>
 <20190508132010.14512-6-jolsa@kernel.org>
 <20190524181506.GE17479@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524181506.GE17479@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, May 24, 2019 at 03:15:06PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, May 08, 2019 at 03:20:03PM +0200, Jiri Olsa escreveu:
> > We mark the end of kernel based on the first module,
> > but that could cover some bpf program maps. Reading
> > _etext symbol if it's present to get precise kernel
> > map end.
> 
> Investigating... Have you run 'perf test' before hitting the send
> button? :-)

<SNIP>

> [root@quaco c]# perf test -v 1
>  1: vmlinux symtab matches kallsyms                       :
<SNIP>
> --- start ---
> ERR : 0xffffffff8cc00e41: __indirect_thunk_end not on kallsyms
<SNIP>
> test child finished with -1
> ---- end ----
> vmlinux symtab matches kallsyms: FAILED!
> [root@quaco c]#

So...

[root@quaco c]# grep __indirect_thunk_end /proc/kallsyms
ffffffff8cc00e41 T __indirect_thunk_end
[root@quaco c]# grep -w _etext /proc/kallsyms
ffffffff8cc00e41 T _etext
[root@quaco c]#

[root@quaco c]# grep -w ffffffff8cc00e41 /proc/kallsyms
ffffffff8cc00e41 T _etext
ffffffff8cc00e41 T __indirect_thunk_end
[root@quaco c]#

Lemme try to fix this.

- Arnaldo
 
> [acme@quaco perf]$ git bisect good
> 7d98e1a73bd7dae6cb321ec8b0b97b9fed7c0e1b is the first bad commit
> commit 7d98e1a73bd7dae6cb321ec8b0b97b9fed7c0e1b
> Author: Jiri Olsa <jolsa@kernel.org>
> Date:   Wed May 8 15:20:03 2019 +0200
> 
>     perf machine: Read also the end of the kernel
> 
>     We mark the end of kernel based on the first module, but that could
>     cover some bpf program maps. Reading _etext symbol if it's present to
>     get precise kernel map end.
> 
>     Signed-off-by: Jiri Olsa <jolsa@kernel.org>
>     Acked-by: Song Liu <songliubraving@fb.com>
>     Cc: Adrian Hunter <adrian.hunter@intel.com>
>     Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>     Cc: Andi Kleen <ak@linux.intel.com>
>     Cc: Namhyung Kim <namhyung@kernel.org>
>     Cc: Peter Zijlstra <peterz@infradead.org>
>     Cc: Stanislav Fomichev <sdf@google.com>
>     Cc: Thomas Richter <tmricht@linux.ibm.com>
>     Link: http://lkml.kernel.org/r/20190508132010.14512-6-jolsa@kernel.org
>     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> :040000 040000 4ca5fa4c6f15fd8cf9a0eee870efbd01e9fe309d 8311b30f94e9cf9a863dc9619b0499863f64960e M	tools
> [acme@quaco perf]$
>  
> > Link: http://lkml.kernel.org/n/tip-ynut991ttyyhvo1sbhlm4c42@git.kernel.org
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/perf/util/machine.c | 27 ++++++++++++++++++---------
> >  1 file changed, 18 insertions(+), 9 deletions(-)
> > 
> > diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> > index 3c520baa198c..ad0205fbb506 100644
> > --- a/tools/perf/util/machine.c
> > +++ b/tools/perf/util/machine.c
> > @@ -924,7 +924,8 @@ const char *ref_reloc_sym_names[] = {"_text", "_stext", NULL};
> >   * symbol_name if it's not that important.
> >   */
> >  static int machine__get_running_kernel_start(struct machine *machine,
> > -					     const char **symbol_name, u64 *start)
> > +					     const char **symbol_name,
> > +					     u64 *start, u64 *end)
> >  {
> >  	char filename[PATH_MAX];
> >  	int i, err = -1;
> > @@ -949,6 +950,11 @@ static int machine__get_running_kernel_start(struct machine *machine,
> >  		*symbol_name = name;
> >  
> >  	*start = addr;
> > +
> > +	err = kallsyms__get_function_start(filename, "_etext", &addr);
> > +	if (!err)
> > +		*end = addr;
> > +
> >  	return 0;
> >  }
> >  
> > @@ -1440,7 +1446,7 @@ int machine__create_kernel_maps(struct machine *machine)
> >  	struct dso *kernel = machine__get_kernel(machine);
> >  	const char *name = NULL;
> >  	struct map *map;
> > -	u64 addr = 0;
> > +	u64 start = 0, end = ~0ULL;
> >  	int ret;
> >  
> >  	if (kernel == NULL)
> > @@ -1459,9 +1465,9 @@ int machine__create_kernel_maps(struct machine *machine)
> >  				 "continuing anyway...\n", machine->pid);
> >  	}
> >  
> > -	if (!machine__get_running_kernel_start(machine, &name, &addr)) {
> > +	if (!machine__get_running_kernel_start(machine, &name, &start, &end)) {
> >  		if (name &&
> > -		    map__set_kallsyms_ref_reloc_sym(machine->vmlinux_map, name, addr)) {
> > +		    map__set_kallsyms_ref_reloc_sym(machine->vmlinux_map, name, start)) {
> >  			machine__destroy_kernel_maps(machine);
> >  			ret = -1;
> >  			goto out_put;
> > @@ -1471,16 +1477,19 @@ int machine__create_kernel_maps(struct machine *machine)
> >  		 * we have a real start address now, so re-order the kmaps
> >  		 * assume it's the last in the kmaps
> >  		 */
> > -		machine__update_kernel_mmap(machine, addr, ~0ULL);
> > +		machine__update_kernel_mmap(machine, start, end);
> >  	}
> >  
> >  	if (machine__create_extra_kernel_maps(machine, kernel))
> >  		pr_debug("Problems creating extra kernel maps, continuing anyway...\n");
> >  
> > -	/* update end address of the kernel map using adjacent module address */
> > -	map = map__next(machine__kernel_map(machine));
> > -	if (map)
> > -		machine__set_kernel_mmap(machine, addr, map->start);
> > +	if (end == ~0ULL) {
> > +		/* update end address of the kernel map using adjacent module address */
> > +		map = map__next(machine__kernel_map(machine));
> > +		if (map)
> > +			machine__set_kernel_mmap(machine, start, map->start);
> > +	}
> > +
> >  out_put:
> >  	dso__put(kernel);
> >  	return ret;
> > -- 
> > 2.20.1
> 
> -- 
> 
> - Arnaldo

-- 

- Arnaldo
