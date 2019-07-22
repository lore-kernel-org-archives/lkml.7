Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0406C76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6367021900
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WkrbLr7S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbfGVReL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 13:34:11 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34458 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbfGVReK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 13:34:10 -0400
Received: by mail-qt1-f196.google.com with SMTP id k10so39339876qtq.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 10:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lEIlcJe49wMKxZFV+jJCY8oOGx3kbgN7K/bmRsLc4x8=;
        b=WkrbLr7SmkFBzdJ5+H24d1k40YbUfYfLSwrlbRQq87Ut5vcgWHc4m3YzHFk608SvxZ
         fyIN1YPs4J8ZN0sLWy+TU4Zvy4WLFtk1mY/klO1OM8Be930QGzinQAA1T2ozzOgX1Kr/
         C0KWhtvbSrCJO3WT2h960AeejPjjSlURF+H8tlDu6PRIuyMGUCwOqaYnNxg0Bh2lDdwc
         XRcdzXAquVA6g8MMIeXQqyKIfYutrNMSVh99d9Q9j0pcs80/l/bBIESzNtP9Jn9o7o79
         nbQGjS+t8Y4tyKTLFtVUZffZoh/U2iX2nore9t+AtcBxGj9ud3dX+Bz9u2kzHSl+bE8R
         ByOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lEIlcJe49wMKxZFV+jJCY8oOGx3kbgN7K/bmRsLc4x8=;
        b=M9bnnuEkdGoclBPj6SkXaEIGd5RATj2ne2wgSJHxLs4KxE9pYZDai3WNsqBZNaMG+2
         3BSw1r0QbCvLX5T4UE8gqekrcmW8EzsZ70xkWPXremjv6ZthZsGgplVHJ7iAQa+VxBuH
         8tJd1/TcsLVIweE5d4OON7YR+hJ49Iuxf6dOd0IRs0IkAe/2EH2kLzPtSeu2Gj8cxJC8
         +QjpZ3kUwBuOfE7gbkb5lcWZjiwwsSuHSeMeahs7vahcZ8bJjAn2mV8Chsj1wJeiHrfN
         mWJ69OD9MdpLd63oMaas3+y4U9gix3l6OGaAOs+NtDJTbg1KKT5rMP8T1LLUyBfdt3v1
         rhkg==
X-Gm-Message-State: APjAAAXB5zJf22Yuq7Oix9pIn2J5S9/+loq/SINzA+sfLsZoHch7gYdE
        wOc448z0taYm25iEPRO3wAPTlFbp
X-Google-Smtp-Source: APXvYqwGo/dDX5jg3igN1+gDbrwRY6rrq/k3t3SpVVXRIrKya7MvtnN08LfJhsHa61nAcR55ppBnVw==
X-Received: by 2002:a0c:d4d0:: with SMTP id y16mr49989761qvh.191.1563816848942;
        Mon, 22 Jul 2019 10:34:08 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id y3sm20153221qtj.46.2019.07.22.10.34.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 10:34:07 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3878440340; Mon, 22 Jul 2019 14:34:00 -0300 (-03)
Date:   Mon, 22 Jul 2019 14:34:00 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH 23/79] libperf: Make libperf.a part of the build
Message-ID: <20190722173400.GS3624@kernel.org>
References: <20190721112506.12306-1-jolsa@kernel.org>
 <20190721112506.12306-24-jolsa@kernel.org>
 <20190722123924.GA28864@kernel.org>
 <20190722155417.GA2121@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722155417.GA2121@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jul 22, 2019 at 05:54:17PM +0200, Jiri Olsa escreveu:
> On Mon, Jul 22, 2019 at 09:39:24AM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Sun, Jul 21, 2019 at 01:24:10PM +0200, Jiri Olsa escreveu:
> > > Adding empty libperf.a under toos/perf/lib and
> > > linking it with perf.
> > 
> > So, I noticed you created a subdirectory under tools/perf/, while I
> > first thought you would have it in tools/lib/perf/, why not move it
> > there?
> 
> yea I started like this, and then there was only one reason
> I could think of ;-) I mentioned it in the cover letter:
>   - move under tools/lib after the interface is more stable-ish
> 
> if you insist to move it there now, would it be ok
> to make it under separate patch afterwards? it would
> safe me zillions of small changes ;-)

Humm, moving it after will be just a git rename, its ok.

- Arnaldo
 
> thanks,
> jirka
> 
> > 
> > - Arnaldo
> >  
> > > It can also be built separately with:
> > > 
> > >   $ cd tools/perf/lib && make
> > >     CC       core.o
> > >     LD       libperf-in.o
> > >     AR       libperf.a
> > >     LINK     libperf.so
> > > 
> > > Link: http://lkml.kernel.org/n/tip-lzrlfu3hutepbeqyntjks3za@git.kernel.org
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > ---
> > >  tools/perf/Makefile.config |  1 +
> > >  tools/perf/Makefile.perf   | 30 ++++++++--------
> > >  tools/perf/lib/Build       |  1 +
> > >  tools/perf/lib/Makefile    | 74 ++++++++++++++++++++++++++++++++++++++
> > >  tools/perf/lib/core.c      |  0
> > >  5 files changed, 92 insertions(+), 14 deletions(-)
> > >  create mode 100644 tools/perf/lib/Build
> > >  create mode 100644 tools/perf/lib/Makefile
> > >  create mode 100644 tools/perf/lib/core.c
> > > 
> > > diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> > > index 89ac5a1f1550..e4988f49ea79 100644
> > > --- a/tools/perf/Makefile.config
> > > +++ b/tools/perf/Makefile.config
> > > @@ -277,6 +277,7 @@ ifeq ($(DEBUG),0)
> > >    endif
> > >  endif
> > >  
> > > +INC_FLAGS += -I$(src-perf)/lib/include
> > >  INC_FLAGS += -I$(src-perf)/util/include
> > >  INC_FLAGS += -I$(src-perf)/arch/$(SRCARCH)/include
> > >  INC_FLAGS += -I$(srctree)/tools/include/uapi
> > > diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> > > index 0fffd2bb6cd9..6e7e7d44ffac 100644
> > > --- a/tools/perf/Makefile.perf
> > > +++ b/tools/perf/Makefile.perf
> > > @@ -224,6 +224,7 @@ LIB_DIR         = $(srctree)/tools/lib/api/
> > >  TRACE_EVENT_DIR = $(srctree)/tools/lib/traceevent/
> > >  BPF_DIR         = $(srctree)/tools/lib/bpf/
> > >  SUBCMD_DIR      = $(srctree)/tools/lib/subcmd/
> > > +LIBPERF_DIR     = $(srctree)/tools/perf/lib/
> > >  
> > >  # Set FEATURE_TESTS to 'all' so all possible feature checkers are executed.
> > >  # Without this setting the output feature dump file misses some features, for
> > > @@ -272,6 +273,7 @@ ifneq ($(OUTPUT),)
> > >    TE_PATH=$(OUTPUT)
> > >    BPF_PATH=$(OUTPUT)
> > >    SUBCMD_PATH=$(OUTPUT)
> > > +  LIBPERF_PATH=$(OUTPUT)
> > >  ifneq ($(subdir),)
> > >    API_PATH=$(OUTPUT)/../lib/api/
> > >  else
> > > @@ -282,6 +284,7 @@ else
> > >    API_PATH=$(LIB_DIR)
> > >    BPF_PATH=$(BPF_DIR)
> > >    SUBCMD_PATH=$(SUBCMD_DIR)
> > > +  LIBPERF_PATH=$(LIBPERF_DIR)
> > >  endif
> > >  
> > >  LIBTRACEEVENT = $(TE_PATH)libtraceevent.a
> > > @@ -303,6 +306,8 @@ LIBBPF = $(BPF_PATH)libbpf.a
> > >  
> > >  LIBSUBCMD = $(SUBCMD_PATH)libsubcmd.a
> > >  
> > > +LIBPERF = $(LIBPERF_PATH)libperf.a
> > > +
> > >  # python extension build directories
> > >  PYTHON_EXTBUILD     := $(OUTPUT)python_ext_build/
> > >  PYTHON_EXTBUILD_LIB := $(PYTHON_EXTBUILD)lib/
> > > @@ -348,9 +353,7 @@ endif
> > >  
> > >  export PERL_PATH
> > >  
> > > -LIBPERF_A=$(OUTPUT)libperf.a
> > > -
> > > -PERFLIBS = $(LIBAPI) $(LIBTRACEEVENT) $(LIBSUBCMD)
> > > +PERFLIBS = $(LIBAPI) $(LIBTRACEEVENT) $(LIBSUBCMD) $(LIBPERF)
> > >  ifndef NO_LIBBPF
> > >    PERFLIBS += $(LIBBPF)
> > >  endif
> > > @@ -583,8 +586,6 @@ JEVENTS_IN    := $(OUTPUT)pmu-events/jevents-in.o
> > >  
> > >  PMU_EVENTS_IN := $(OUTPUT)pmu-events/pmu-events-in.o
> > >  
> > > -LIBPERF_IN := $(OUTPUT)libperf-in.o
> > > -
> > >  export JEVENTS
> > >  
> > >  build := -f $(srctree)/tools/build/Makefile.build dir=. obj
> > > @@ -601,12 +602,9 @@ $(JEVENTS): $(JEVENTS_IN)
> > >  $(PMU_EVENTS_IN): $(JEVENTS) FORCE
> > >  	$(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=pmu-events obj=pmu-events
> > >  
> > > -$(LIBPERF_IN): prepare FORCE
> > > -	$(Q)$(MAKE) $(build)=libperf
> > > -
> > > -$(OUTPUT)perf: $(PERFLIBS) $(PERF_IN) $(PMU_EVENTS_IN) $(LIBPERF_IN) $(LIBTRACEEVENT_DYNAMIC_LIST)
> > > +$(OUTPUT)perf: $(PERFLIBS) $(PERF_IN) $(PMU_EVENTS_IN) $(LIBTRACEEVENT_DYNAMIC_LIST)
> > >  	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) $(LIBTRACEEVENT_DYNAMIC_LIST_LDFLAGS) \
> > > -		$(PERF_IN) $(PMU_EVENTS_IN) $(LIBPERF_IN) $(LIBS) -o $@
> > > +		$(PERF_IN) $(PMU_EVENTS_IN) $(LIBS) -o $@
> > >  
> > >  $(GTK_IN): FORCE
> > >  	$(Q)$(MAKE) $(build)=gtk
> > > @@ -727,9 +725,6 @@ endif
> > >  
> > >  $(patsubst perf-%,%.o,$(PROGRAMS)): $(wildcard */*.h)
> > >  
> > > -$(LIBPERF_A): $(LIBPERF_IN)
> > > -	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $(LIBPERF_IN) $(LIB_OBJS)
> > > -
> > >  LIBTRACEEVENT_FLAGS += plugin_dir=$(plugindir_SQ) 'EXTRA_CFLAGS=$(EXTRA_CFLAGS)' 'LDFLAGS=$(LDFLAGS)'
> > >  
> > >  $(LIBTRACEEVENT): FORCE
> > > @@ -762,6 +757,13 @@ $(LIBBPF)-clean:
> > >  	$(call QUIET_CLEAN, libbpf)
> > >  	$(Q)$(MAKE) -C $(BPF_DIR) O=$(OUTPUT) clean >/dev/null
> > >  
> > > +$(LIBPERF): FORCE
> > > +	$(Q)$(MAKE) -C $(LIBPERF_DIR) O=$(OUTPUT) $(OUTPUT)libperf.a
> > > +
> > > +$(LIBPERF)-clean:
> > > +	$(call QUIET_CLEAN, libperf)
> > > +	$(Q)$(MAKE) -C $(LIBPERF_DIR) O=$(OUTPUT) clean >/dev/null
> > > +
> > >  $(LIBSUBCMD): FORCE
> > >  	$(Q)$(MAKE) -C $(SUBCMD_DIR) O=$(OUTPUT) $(OUTPUT)libsubcmd.a
> > >  
> > > @@ -948,7 +950,7 @@ config-clean:
> > >  python-clean:
> > >  	$(python-clean)
> > >  
> > > -clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean config-clean fixdep-clean python-clean
> > > +clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBPERF)-clean config-clean fixdep-clean python-clean
> > >  	$(call QUIET_CLEAN, core-objs)  $(RM) $(LIBPERF_A) $(OUTPUT)perf-archive $(OUTPUT)perf-with-kcore $(LANG_BINDINGS)
> > >  	$(Q)find $(if $(OUTPUT),$(OUTPUT),.) -name '*.o' -delete -o -name '\.*.cmd' -delete -o -name '\.*.d' -delete
> > >  	$(Q)$(RM) $(OUTPUT).config-detected
> > > diff --git a/tools/perf/lib/Build b/tools/perf/lib/Build
> > > new file mode 100644
> > > index 000000000000..5196958cec01
> > > --- /dev/null
> > > +++ b/tools/perf/lib/Build
> > > @@ -0,0 +1 @@
> > > +libperf-y += core.o
> > > diff --git a/tools/perf/lib/Makefile b/tools/perf/lib/Makefile
> > > new file mode 100644
> > > index 000000000000..e6f2eb702aaa
> > > --- /dev/null
> > > +++ b/tools/perf/lib/Makefile
> > > @@ -0,0 +1,74 @@
> > > +# SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> > > +# Most of this file is copied from tools/lib/bpf/Makefile
> > > +
> > > +MAKEFLAGS += --no-print-directory
> > > +
> > > +ifeq ($(srctree),)
> > > +srctree := $(patsubst %/,%,$(dir $(CURDIR)))
> > > +srctree := $(patsubst %/,%,$(dir $(srctree)))
> > > +srctree := $(patsubst %/,%,$(dir $(srctree)))
> > > +#$(info Determined 'srctree' to be $(srctree))
> > > +endif
> > > +
> > > +include $(srctree)/tools/scripts/Makefile.include
> > > +include $(srctree)/tools/scripts/Makefile.arch
> > > +
> > > +ifeq ("$(origin V)", "command line")
> > > +  VERBOSE = $(V)
> > > +endif
> > > +ifndef VERBOSE
> > > +  VERBOSE = 0
> > > +endif
> > > +
> > > +ifeq ($(VERBOSE),1)
> > > +  Q =
> > > +else
> > > +  Q = @
> > > +endif
> > > +
> > > +# Set compile option CFLAGS
> > > +ifdef EXTRA_CFLAGS
> > > +  CFLAGS := $(EXTRA_CFLAGS)
> > > +else
> > > +  CFLAGS := -g -Wall
> > > +endif
> > > +
> > > +INCLUDES = -I. -Iinclude -I$(srctree)/tools/include -I$(srctree)/tools/arch/$(ARCH)/include/
> > > +
> > > +# Append required CFLAGS
> > > +override CFLAGS += $(EXTRA_WARNINGS)
> > > +override CFLAGS += -Werror -Wall
> > > +override CFLAGS += -fPIC
> > > +override CFLAGS += $(INCLUDES)
> > > +override CFLAGS += -fvisibility=hidden
> > > +
> > > +all:
> > > +
> > > +export srctree OUTPUT CC LD CFLAGS V
> > > +include $(srctree)/tools/build/Makefile.include
> > > +
> > > +LIBPERF_SO := $(OUTPUT)libperf.so
> > > +LIBPERF_A  := $(OUTPUT)libperf.a
> > > +LIBPERF_IN := $(OUTPUT)libperf-in.o
> > > +
> > > +$(LIBPERF_IN): FORCE
> > > +	$(Q)$(MAKE) $(build)=libperf
> > > +
> > > +$(LIBPERF_A): $(LIBPERF_IN)
> > > +	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $(LIBPERF_IN)
> > > +
> > > +$(LIBPERF_SO): $(LIBPERF_IN)
> > > +	$(QUIET_LINK)$(CC) --shared -Wl,-soname,libperf.so $^ -o $@
> > > +
> > > +libs: $(LIBPERF_A) $(LIBPERF_SO)
> > > +
> > > +all: fixdep
> > > +	$(Q)$(MAKE) libs
> > > +
> > > +clean:
> > > +	$(call QUIET_CLEAN, libperf) $(RM) $(LIBPERF_A) \
> > > +                *.o *~ *.a *.so .*.d .*.cmd LIBPERF-CFLAGS
> > > +
> > > +FORCE:
> > > +
> > > +.PHONY: all install clean FORCE
> > > diff --git a/tools/perf/lib/core.c b/tools/perf/lib/core.c
> > > new file mode 100644
> > > index 000000000000..e69de29bb2d1
> > > -- 
> > > 2.21.0
> > 
> > -- 
> > 
> > - Arnaldo

-- 

- Arnaldo
