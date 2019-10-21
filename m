Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92DBACA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 14:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A48B20640
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 14:36:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gtNLqNtF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728696AbfJUOga (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 10:36:30 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43149 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbfJUOg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 10:36:29 -0400
Received: by mail-qt1-f195.google.com with SMTP id t20so21319106qtr.10
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 07:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=WIDjAnIY5s6GGL5NpDYApt8A4XYw3zE0FBnQP5Op4Lg=;
        b=gtNLqNtFn7ocCZza7xUwONieovazjOLwL7Voqe9RJ8xO4Nu81MPdkKvdoDE2XjG1LM
         Ynd+EVSK0GtsBv2t8vo+BGy6Yv/ingOzNVyTjIFjWsatYejFjTwURRQ7XXgBgNb4siSp
         gfp4htmGSRZZLDDseVlJZ5Srrde9XHqTaNQxtxGoHDOM3a1aoYK6D/bCtTQKXMmPkOis
         w55gy5XkrJRtG69Hn4Y74weZEA6BSpea/nSfjs8+3JLjCeShZSUPKRrjW+fSGuhlCQba
         78PbmyUObx53yDVphg++vLIbcvbmA2f3K0stVNjSvFYGc4J9qkRz9SvvBZxY/MxEKo05
         iCrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=WIDjAnIY5s6GGL5NpDYApt8A4XYw3zE0FBnQP5Op4Lg=;
        b=QrqzGouSGfjXebLEmefkfsL5wZPlU2qZHerOO8EPEMMtOrTyh0wh0Q9zP6jd6YrQL2
         DC860RjaUuxqex1vzyHAOBYrnMG46vlxAjE/KO5lxSMEYTfIMj12dK2M1lKy3+Gs6PQW
         nj4pcry/2G2e7gFr7ouFoU6OyqL5GDh/ebnZkNjkWxN2ecQQNW9IYdUK9sjRMbihJEqK
         SxesLfRYjGOC4ouaFTL3zgcj9SC+XgK0G1Fmv8JHoM8mxWywiUse3nzRb1yyR8faPt4J
         vItRoGvr87sokX13rtaXv6EPapoueyVgoV15TT5H6fvBaTS3b/fXDYxTeMh1bTc2k9I/
         eGVw==
X-Gm-Message-State: APjAAAVJDm3aQ1sWoZwFPTBkq6Ol0Q3zvOUTQhM76MCrHEotD1/jfJB1
        rv1qgKWxAkqPgoK/pOsBHKpTOQvs
X-Google-Smtp-Source: APXvYqyoDoivzWtUPZD1hDs9feHGYlRaDGAnrshDSBRfjZfGhS3gT1W254fBrFp6R8//cb1fRtTieA==
X-Received: by 2002:ac8:fda:: with SMTP id f26mr25071096qtk.34.1571668588283;
        Mon, 21 Oct 2019 07:36:28 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id p5sm3410850qtq.2.2019.10.21.07.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 07:36:27 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8EBE74035B; Mon, 21 Oct 2019 11:36:25 -0300 (-03)
Date:   Mon, 21 Oct 2019 11:36:25 -0300
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] perf record: Put a copy of kcore into the perf.data
 directory
Message-ID: <20191021143625.GD10039@kernel.org>
References: <20191004083121.12182-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191004083121.12182-1-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Oct 04, 2019 at 11:31:16AM +0300, Adrian Hunter escreveu:
> Hi
> 
> Here are patches to add a new 'perf record' option '--kcore' which will put
> a copy of /proc/kcore, kallsyms and modules into a perf.data directory.
> Note, that without the --kcore option, output goes to a file as previously.
> The tools' -o and -i options work with either a file name or directory
> name.

Its great that you two got in agreement about adding the new feature
using the infrastructure that is being put in place for perf.data as a
directory, great team work.

Applied, thanks a lot,

- Arnaldo
 
> Example:
> 
>  $ sudo perf record --kcore uname
> 
>  $ sudo tree perf.data
>  perf.data
>  ├── kcore_dir
>  │   ├── kallsyms
>  │   ├── kcore
>  │   └── modules
>  └── data
> 
>  $ sudo perf script -v
>  build id event received for vmlinux: 1eaa285996affce2d74d8e66dcea09a80c9941de
>  build id event received for [vdso]: 8bbaf5dc62a9b644b4d4e4539737e104e4a84541
>  Samples for 'cycles' event do not have CPU attribute set. Skipping 'cpu' field.
>  Using CPUID GenuineIntel-6-8E-A
>  Using perf.data/kcore_dir/kcore for kernel data
>  Using perf.data/kcore_dir/kallsyms for symbols
>              perf 19058 506778.423729:          1 cycles:  ffffffffa2caa548 native_write_msr+0x8 (vmlinux)
>              perf 19058 506778.423733:          1 cycles:  ffffffffa2caa548 native_write_msr+0x8 (vmlinux)
>              perf 19058 506778.423734:          7 cycles:  ffffffffa2caa548 native_write_msr+0x8 (vmlinux)
>              perf 19058 506778.423736:        117 cycles:  ffffffffa2caa54a native_write_msr+0xa (vmlinux)
>              perf 19058 506778.423738:       2092 cycles:  ffffffffa2c9b7b0 native_apic_msr_write+0x0 (vmlinux)
>              perf 19058 506778.423740:      37380 cycles:  ffffffffa2f121d0 perf_event_addr_filters_exec+0x0 (vmlinux)
>             uname 19058 506778.423751:     582673 cycles:  ffffffffa303a407 propagate_protected_usage+0x147 (vmlinux)
>             uname 19058 506778.423892:    2241841 cycles:  ffffffffa2cae0c9 unwind_next_frame.part.5+0x79 (vmlinux)
>             uname 19058 506778.424430:    2457397 cycles:  ffffffffa3019232 check_memory_region+0x52 (vmlinux)
> 
> 
> Adrian Hunter (5):
>       perf data: Correctly identify directory data files
>       perf data: Move perf_dir_version into data.h
>       perf data: Rename directory "header" file to "data"
>       perf tools: Support single perf.data file directory
>       perf record: Put a copy of kcore into the perf.data directory
> 
>  tools/perf/Documentation/perf-record.txt           |  3 ++
>  .../Documentation/perf.data-directory-format.txt   | 63 ++++++++++++++++++++++
>  tools/perf/builtin-record.c                        | 54 ++++++++++++++++++-
>  tools/perf/util/data.c                             | 46 ++++++++++++++--
>  tools/perf/util/data.h                             | 12 +++++
>  tools/perf/util/header.h                           |  4 --
>  tools/perf/util/record.h                           |  1 +
>  tools/perf/util/session.c                          |  4 ++
>  tools/perf/util/util.c                             | 19 ++++++-
>  9 files changed, 197 insertions(+), 9 deletions(-)
>  create mode 100644 tools/perf/Documentation/perf.data-directory-format.txt
> 
> 
> Regards
> Adrian

-- 

- Arnaldo
