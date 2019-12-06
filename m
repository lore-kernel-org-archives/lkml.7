Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6193C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 15:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ED632466E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 15:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QC44qwu9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbfLFPd6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 10:33:58 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:42845 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbfLFPd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 10:33:57 -0500
Received: by mail-vs1-f66.google.com with SMTP id b79so235883vsd.9
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 07:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0OHOVZg0M3wZ6LII4t+2QI8E/HL/58zvlQjyYHOlNf0=;
        b=QC44qwu9rwf9c3IiEwo4KfYvh8uXLgJM1nsLvI0dpnxRc9Gkgyjs5xZdDX8nYRwByZ
         +uk/dPBwUQjkJTmL+CtvJXieh2VAzA5f9Dlw6oj1QowCGIHtQIUdSqYtuzXDIZtGVkc+
         KsjgQsOYsswa65GUpNj8VCOvZmBKU/9TEE7GatfNe311foI+iCYQHCx4HWq9eQm6z/e/
         cPYwMBNZqrO4p4mdPmnyDiR6JUrXKieHEF1bK7W4XWUAa9KxyTDdAoDrKSOPc6XenXv+
         3mV/JOATY3e+W1vMELvf8e+ZF5qO7TnzHSrDcaRQJPRx72x2tWcsByd3BzbNoQH9NbKQ
         FlFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0OHOVZg0M3wZ6LII4t+2QI8E/HL/58zvlQjyYHOlNf0=;
        b=CI/qcN3XadTNXqhePsvgztQZhkwBsQP4+lPdutL07PayRbjcykp/OfhxTXmguuxKaj
         +/1O3vS7sVUwMxCCoyWbJifoGFqlh8VkVBZdoBlR5ofxTI3z4Wga6jOvqW323d/msYh/
         N716YeTzsoAtcBT6NZPME73XrYjgXAY+j6ZVbhAHufMtcFbC0cTMKUgnZ+DEP9oYLt8b
         +IJ3UtnWLTmG/s1SPZM5ABTUwwqo4NKy+CZlFkERsrxq9asiu7iJC3xeV9dMG4BAmhlO
         RasvqQDMrhHeB2ARYPFubDaFwRUsBlJPxyjLvM6wEdjKCiv80vyfE61zWo9fpT6mf722
         Et7A==
X-Gm-Message-State: APjAAAWhgmXxI5IaYjtIC8P3bOGczPISjcoqTp6ijHJgBkAr+vu7SHx2
        X1IuFjdJw1Igx8oulprYqKw=
X-Google-Smtp-Source: APXvYqxN/w1Iwwu73mHFuSHQH5aMB+OY9kI+89CFG8O+zeUx+ftuaRRH1oh5Ihl+soA7SaKVNyIYzA==
X-Received: by 2002:a67:c598:: with SMTP id h24mr10077998vsk.210.1575646436203;
        Fri, 06 Dec 2019 07:33:56 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id j26sm4504970ual.7.2019.12.06.07.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 07:33:55 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0165240352; Fri,  6 Dec 2019 12:33:51 -0300 (-03)
Date:   Fri, 6 Dec 2019 12:33:51 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH 1/3] libperf: Move libperf under tools/lib/perf
Message-ID: <20191206153351.GA13965@kernel.org>
References: <20191206135513.31586-1-jolsa@kernel.org>
 <20191206135513.31586-2-jolsa@kernel.org>
 <20191206142754.GC30698@kernel.org>
 <20191206150706.GD31721@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191206150706.GD31721@krava>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Dec 06, 2019 at 04:07:06PM +0100, Jiri Olsa escreveu:
> On Fri, Dec 06, 2019 at 11:27:54AM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Fri, Dec 06, 2019 at 02:55:11PM +0100, Jiri Olsa escreveu:
> > > Moving libperf from its current location under perf
> > > to separate directory under tools/lib.
> > 
> > Breaks the build/bisection:
> 
> yes, I noted that in the cover email, the 2nd patch repairs paths,
> but those changes would get lost in the move.. I can squash it
> if you want, but I thought this is more transparent despite the
> one-commit-long broken bisect ;-)

It may well be, but bisection for me is of primary importance, so please
avoid breaking it,

Thanks,

- Arnaldo
 
> jirka
> 
> > 
> > [acme@quaco perf]$ rm -rf /tmp/build/perf ; mkdir -p /tmp/build/perf ; make O=/tmp/build/perf  -C tools/perf install-bin
> > make: Entering directory '/home/acme/git/perf/tools/perf'
> >   BUILD:   Doing 'make -j8' parallel build
> >   HOSTCC   /tmp/build/perf/fixdep.o
> >   HOSTLD   /tmp/build/perf/fixdep-in.o
> >   LINK     /tmp/build/perf/fixdep
> > 
> > Auto-detecting system features:
> > ...                         dwarf: [ on  ]
> > ...            dwarf_getlocations: [ on  ]
> > ...                         glibc: [ on  ]
> > ...                          gtk2: [ on  ]
> > ...                      libaudit: [ on  ]
> > ...                        libbfd: [ on  ]
> > ...                        libcap: [ on  ]
> > ...                        libelf: [ on  ]
> > ...                       libnuma: [ on  ]
> > ...        numa_num_possible_cpus: [ on  ]
> > ...                       libperl: [ on  ]
> > ...                     libpython: [ on  ]
> > ...                     libcrypto: [ on  ]
> > ...                     libunwind: [ on  ]
> > ...            libdw-dwarf-unwind: [ on  ]
> > ...                          zlib: [ on  ]
> > ...                          lzma: [ on  ]
> > ...                     get_cpuid: [ on  ]
> > ...                           bpf: [ on  ]
> > ...                        libaio: [ on  ]
> > ...                       libzstd: [ on  ]
> > ...        disassembler-four-args: [ on  ]
> > 
> >   GEN      /tmp/build/perf/common-cmds.h
> > make[3]: *** /home/acme/git/perf/tools/perf/lib/: No such file or directory.  Stop.
> > make[2]: *** [Makefile.perf:785: /tmp/build/perf/libperf.a] Error 2
> > make[2]: *** Waiting for unfinished jobs....
> >   MKDIR    /tmp/build/perf/fd/
> >   MKDIR    /tmp/build/perf/fs/
> >   CC       /tmp/build/perf/exec-cmd.o
> >   CC       /tmp/build/perf/fd/array.o
> >   CC       /tmp/build/perf/fs/fs.o
> >   CC       /tmp/build/perf/cpu.o
> >   CC       /tmp/build/perf/help.o
> >   LD       /tmp/build/perf/fd/libapi-in.o
> >   CC       /tmp/build/perf/event-parse.o
> >   CC       /tmp/build/perf/event-plugin.o
> >   CC       /tmp/build/perf/pager.o
> >   CC       /tmp/build/perf/debug.o
> >   CC       /tmp/build/perf/str_error_r.o
> >   CC       /tmp/build/perf/trace-seq.o
> >   MKDIR    /tmp/build/perf/fs/
> >   CC       /tmp/build/perf/parse-filter.o
> >   CC       /tmp/build/perf/parse-options.o
> >   MKDIR    /tmp/build/perf/staticobjs/
> >   CC       /tmp/build/perf/fs/tracing_path.o
> >   CC       /tmp/build/perf/run-command.o
> >   CC       /tmp/build/perf/staticobjs/libbpf.o
> >   CC       /tmp/build/perf/parse-utils.o
> >   CC       /tmp/build/perf/kbuffer-parse.o
> >   MKDIR    /tmp/build/perf/staticobjs/
> >   CC       /tmp/build/perf/sigchain.o
> >   LD       /tmp/build/perf/fs/libapi-in.o
> >   CC       /tmp/build/perf/staticobjs/bpf.o
> >   CC       /tmp/build/perf/subcmd-config.o
> >   CC       /tmp/build/perf/staticobjs/nlattr.o
> >   CC       /tmp/build/perf/tep_strerror.o
> >   CC       /tmp/build/perf/event-parse-api.o
> >   CC       /tmp/build/perf/staticobjs/btf.o
> >   LD       /tmp/build/perf/libapi-in.o
> >   LD       /tmp/build/perf/libsubcmd-in.o
> >   CC       /tmp/build/perf/staticobjs/libbpf_errno.o
> >   CC       /tmp/build/perf/staticobjs/str_error.o
> >   CC       /tmp/build/perf/staticobjs/netlink.o
> >   CC       /tmp/build/perf/staticobjs/bpf_prog_linfo.o
> >   AR       /tmp/build/perf/libapi.a
> >   LD       /tmp/build/perf/libtraceevent-in.o
> >   CC       /tmp/build/perf/staticobjs/libbpf_probes.o
> >   CC       /tmp/build/perf/staticobjs/xsk.o
> >   AR       /tmp/build/perf/libsubcmd.a
> >   CC       /tmp/build/perf/staticobjs/btf_dump.o
> >   CC       /tmp/build/perf/staticobjs/hashmap.o
> >   LINK     /tmp/build/perf/libtraceevent.a
> >   LD       /tmp/build/perf/staticobjs/libbpf-in.o
> >   LINK     /tmp/build/perf/libbpf.a
> >   PERF_VERSION = 5.4.ge59599b355da
> > make[1]: *** [Makefile.perf:225: sub-make] Error 2
> > make: *** [Makefile:110: install-bin] Error 2
> > make: Leaving directory '/home/acme/git/perf/tools/perf'
> > [acme@quaco perf]$
> > 

-- 

- Arnaldo
