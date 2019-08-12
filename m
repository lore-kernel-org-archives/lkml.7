Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F26C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 07:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06FF42085A
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 07:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vlQDNy5Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbfHLHCq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 03:02:46 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44830 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbfHLHCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 03:02:46 -0400
Received: by mail-pg1-f195.google.com with SMTP id i18so49013510pgl.11
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 00:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EOl0XeLgAx0b65C6nSeSC9yGXCtzgtHSTtqGfuyIaA0=;
        b=vlQDNy5YJO6Rv2CTz4D+sFjXSVfdMSWzoGHyWrsVpDZq7JqD0mPF8/aws7RJXMFDqf
         6juF0WggXHGf25n28qssGrf1563DftaotS7eWUkqtIlIsjjkCug9pxhVm16NNtdJBK2l
         l5LIBGhsttPzj+EKXjcBjyY793e64nIv5iAKXKhXBy3BdxPIys2fff+ahuqNOYnPzSdO
         BuLYSLioVYPRnVR3mgesz3wn2Sjs8Vg+hNAxHnCqcgP+aAFnWtOfFjVk/Xfu7Ae408Sy
         YIVmRdP36FMhVzUTFEpRfpokYAKjW1tprGctep1TYZJ8oZPrR8IGHGBwUqKSL5USjYmd
         34pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EOl0XeLgAx0b65C6nSeSC9yGXCtzgtHSTtqGfuyIaA0=;
        b=FXyMEN2gyW+ZXUvMKLrIuanyAOgfXNGmJ+rD1fPwV8IF63+WRCLygqonqU1Xxmma0y
         B5ElfkjJdmGs1reDuO7BKoVxWNtTYjbpOGijLqDHxnP8t7sguDH8yHV75nwKHaU0gQtb
         my9lw44UIQgBNRFwKSAku2OqbJ8jSmlyz1azuXa0cJb3eJePC1jAAShZH80VK3NBtDqh
         AbtFiAJitRZjcaYvpzrApvWo0bWI+i4jY1fDjjUbuU00IXqcnoV8VsmeSkY9Alp1qp17
         FHVH1UhurXsWi54aZeLwN8pYRtZDljQX2s3HFIo79JbHKrl/OxY9g0eHb8WX5TEXuf8e
         sxCA==
X-Gm-Message-State: APjAAAXQmKlhr4M6NZ1vgvV/iXnO2G0vBR+EQ5KwYqRw7ZDrijtq+3Ii
        HV5LK1ngKX9LJtzvpiznt5Oj7A==
X-Google-Smtp-Source: APXvYqxAh3VkSFRalpNOfNOGfoKAYQbeiPPX2JQLAcPa5A4DmJPshw2KGdvQ+9cPGwzU07VXbkSYGA==
X-Received: by 2002:a63:f07:: with SMTP id e7mr30222661pgl.238.1565593365394;
        Mon, 12 Aug 2019 00:02:45 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (li456-16.members.linode.com. [50.116.10.16])
        by smtp.gmail.com with ESMTPSA id k5sm6182091pgo.45.2019.08.12.00.02.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Aug 2019 00:02:44 -0700 (PDT)
Date:   Mon, 12 Aug 2019 15:02:36 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        David Miller <davem@davemloft.net>,
        Milian Wolff <milian.wolff@kdab.com>,
        Donald Yandt <donald.yandt@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Wei Li <liwei391@huawei.com>, Mark Drayton <mbd@fb.com>,
        "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH v4 1/2] perf machine: Support arch's specific kernel
 start address
Message-ID: <20190812070236.GA8062@leoy-ThinkPad-X240s>
References: <20190810072135.27072-1-leo.yan@linaro.org>
 <20190810072135.27072-2-leo.yan@linaro.org>
 <c1818f6f-37df-6971-fddc-6663e5b6ff95@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1818f6f-37df-6971-fddc-6663e5b6ff95@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 09:37:33AM +0300, Adrian Hunter wrote:
> On 10/08/19 10:21 AM, Leo Yan wrote:
> > machine__get_kernel_start() gives out the kernel start address; some
> > architectures need to tweak the start address so that can reflect the
> > kernel start address correctly.  This is not only for x86_64 arch, but
> > it is also required by other architectures, e.g. arm/arm64 needs to
> > tweak the kernel start address so can include the kernel memory regions
> > which are used before the '_stext' symbol.
> > 
> > This patch refactors machine__get_kernel_start() by adding a weak
> > arch__fix_kernel_text_start(), any architecture can implement it to
> > tweak its specific start address; this also allows the arch specific
> > code to be placed into 'arch' folder.
> > 
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  tools/perf/arch/x86/util/machine.c | 10 ++++++++++
> >  tools/perf/util/machine.c          | 13 +++++++------
> >  tools/perf/util/machine.h          |  2 ++
> >  3 files changed, 19 insertions(+), 6 deletions(-)
> > 
> > diff --git a/tools/perf/arch/x86/util/machine.c b/tools/perf/arch/x86/util/machine.c
> > index 1e9ec783b9a1..9f012131534a 100644
> > --- a/tools/perf/arch/x86/util/machine.c
> > +++ b/tools/perf/arch/x86/util/machine.c
> > @@ -101,4 +101,14 @@ int machine__create_extra_kernel_maps(struct machine *machine,
> >  	return ret;
> >  }
> >  
> > +void arch__fix_kernel_text_start(u64 *start)
> > +{
> > +	/*
> > +	 * On x86_64, PTI entry trampolines are less than the
> > +	 * start of kernel text, but still above 2^63. So leave
> > +	 * kernel_start = 1ULL << 63 for x86_64.
> > +	 */
> > +	*start = 1ULL << 63;
> > +}
> 
> That is needed for reporting x86 data on any arch i.e. it is not specific to
> the compile-time architecture, it is specific to the perf.data file
> architecture, which is what machine__is() compares. So, this looks wrong.

Thanks for reviewing, Adrian.

If so, I think we should extend the function machine__get_kernel_start()
as below; for building successfully, will always define the macro
ARM_PRE_START_SIZE in Makefile.config.

@Arnaldo, @Adrian, Please let me know if this works for you?

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index f6ee7fbad3e4..30a0ff627263 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2687,13 +2687,26 @@ int machine__get_kernel_start(struct machine *machine)
        machine->kernel_start = 1ULL << 63;
        if (map) {
                err = map__load(map);
+               if (err)
+                       return err;
+
                /*
                 * On x86_64, PTI entry trampolines are less than the
                 * start of kernel text, but still above 2^63. So leave
                 * kernel_start = 1ULL << 63 for x86_64.
                 */
-               if (!err && !machine__is(machine, "x86_64"))
+               if (!machine__is(machine, "x86_64"))
                        machine->kernel_start = map->start;
+
+               /*
+                * On arm/arm64, some memory regions are prior to '_stext'
+                * symbol; to reflect the complete kernel address space,
+                * compensate these pre-defined regions for kernel start
+                * address.
+                */
+               if (machine__is(machine, "arm64") ||
+                   machine__is(machine, "arm"))
+                       machine->kernel_start -= ARM_PRE_START_SIZE;
        }
        return err;
 }

Thanks,
Leo Yan

> > +
> >  #endif
> > diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> > index f6ee7fbad3e4..603518835692 100644
> > --- a/tools/perf/util/machine.c
> > +++ b/tools/perf/util/machine.c
> > @@ -2671,6 +2671,10 @@ int machine__nr_cpus_avail(struct machine *machine)
> >  	return machine ? perf_env__nr_cpus_avail(machine->env) : 0;
> >  }
> >  
> > +void __weak arch__fix_kernel_text_start(u64 *start __maybe_unused)
> > +{
> > +}
> > +
> >  int machine__get_kernel_start(struct machine *machine)
> >  {
> >  	struct map *map = machine__kernel_map(machine);
> > @@ -2687,14 +2691,11 @@ int machine__get_kernel_start(struct machine *machine)
> >  	machine->kernel_start = 1ULL << 63;
> >  	if (map) {
> >  		err = map__load(map);
> > -		/*
> > -		 * On x86_64, PTI entry trampolines are less than the
> > -		 * start of kernel text, but still above 2^63. So leave
> > -		 * kernel_start = 1ULL << 63 for x86_64.
> > -		 */
> > -		if (!err && !machine__is(machine, "x86_64"))
> > +		if (!err)
> >  			machine->kernel_start = map->start;
> >  	}
> > +
> > +	arch__fix_kernel_text_start(&machine->kernel_start);
> >  	return err;
> >  }
> >  
> > diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
> > index ef803f08ae12..9cb459f4bfbc 100644
> > --- a/tools/perf/util/machine.h
> > +++ b/tools/perf/util/machine.h
> > @@ -278,6 +278,8 @@ void machine__get_kallsyms_filename(struct machine *machine, char *buf,
> >  int machine__create_extra_kernel_maps(struct machine *machine,
> >  				      struct dso *kernel);
> >  
> > +void arch__fix_kernel_text_start(u64 *start);
> > +
> >  /* Kernel-space maps for symbols that are outside the main kernel map and module maps */
> >  struct extra_kernel_map {
> >  	u64 start;
> > 
> 
