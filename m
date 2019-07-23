Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B2EC76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 21:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70BEE2253D
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 21:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563918141;
	bh=nkoZ55sbX54lATlU5k6+5gQv7idYt2y+kI0DWXCfgoo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wRQRamvRkaUTRtbuN5a9xNfNOSL3l+cT3mdTU74Io/BuBhzg0oIRulUn1cHm3qrSU
	 fu/rRu9TFpt6iTTAUnHwm+/ljKYIeem/GuAGsarnojRD7ODUggd/Y4afKQVVWZ/rUY
	 2U4sndKx52PsYqxAEEEFoq2+gjl5fMTdmZAQERhQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392048AbfGWVmU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 17:42:20 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45503 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727025AbfGWVmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 17:42:19 -0400
Received: by mail-wr1-f67.google.com with SMTP id f9so44642089wre.12;
        Tue, 23 Jul 2019 14:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qcz0OfYIO4ioC82hjLq78BiRilKb/Li5v1zQcKQH6IU=;
        b=l+YWvXH9HvxwECZvS31VtkVTODjvuma1lO5CrgOrcJ+IYyv/nyTc79kokPi8rHD3EB
         Mp3n33epjGflEA6FRv8FgZFNEFpDfyLGt8HWvcepp4R9S8KUQGQHSq/zeTxJybaRFd5o
         RCYP7LAePcFYJltSMJ3AOq6CsZkUNzCJRQEGivG0b1b4a1NIex7aDGdNAtcC7hTFTCA0
         B49CwTKj85xyevwzNocA8/HWjn5gmrupAGyoG7xfJCgBI+05mno+eceMsElxLT7GSzeZ
         +q7RIToTC13oUvJnVrM2jN9uIYkXkGE6h7irdRaLkD1ZYfMYfQuQjIZZm+4p7rRj2BxW
         UYoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=qcz0OfYIO4ioC82hjLq78BiRilKb/Li5v1zQcKQH6IU=;
        b=Gi/dmYkyD+uLVlHshUaY4We6nZgd4Ju8v7580TvCgRLKofGg04iiVLBA8ZH23wX8dz
         i4j52pGFzSMX1djhiynu5RrOJ3z5Ze1ngODfAj8xqAULlwQAswtCbhiihuwf0I/pDZFm
         S6sji/asZQaI84yAp8IMI1HiU9jSZ6j4+AJM52OoA5OButYjNuwtyymYhWlEP+rZDVxF
         Met5voYfiLsTWe0wce5nfh/zAA7jACNN6Bu3uCPpC+NSBadiI/NB5xG8JXu/VptAX1am
         0fetvAWJozq8qRDUOQP4nN7Ospeln8rgMrkB7XbjPnRuxc8SEQ6EPFBwYn+xqZ0a+DS/
         Ro3w==
X-Gm-Message-State: APjAAAU4ygCxe3CD5WNKq6N7h9qvnh70WjZp/OMGSqrNSAtLOXCMJ9mx
        85OUaA2J0B3OTZ9UZyH+L8c=
X-Google-Smtp-Source: APXvYqwOaRtgXeC2WsnewGEx6gEhf5OnBZHnvV4DzlM4xZTE726JsQv3oLTAm83r1yO7ICoUXLtO1A==
X-Received: by 2002:adf:ec0f:: with SMTP id x15mr47977472wrn.165.1563918137324;
        Tue, 23 Jul 2019 14:42:17 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id p18sm43809626wrm.16.2019.07.23.14.42.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 14:42:16 -0700 (PDT)
Date:   Tue, 23 Jul 2019 23:42:14 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Denis Bakhvalov <denis.bakhvalov@intel.com>,
        Numfor Mbiziwo-Tiapo <nums@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL] perf/urgent fixes
Message-ID: <20190723214214.GA56614@gmail.com>
References: <20190723200530.14090-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190723200530.14090-1-acme@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo,
> 
> 	Please consider pulling,
> 
> Best regards,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit e0c5c5e308ee9b3548844f0d88da937782b895ef:
> 
>   Merge tag 'perf-core-for-mingo-5.3-20190715' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent (2019-07-18 00:32:52 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-5.3-20190723
> 
> for you to fetch changes up to 39e7317e37f7f0be366d1201c283f968c17268da:
> 
>   perf build: Do not use -Wshadow on gcc < 4.8 (2019-07-23 09:04:54 -0300)
> 
> ----------------------------------------------------------------
> perf/urgent fixes:
> 
> perf.data:
> 
>   Alexey Budankov:
> 
>   - Fix loading of compressed data split across adjacent records
> 
>   Jiri Olsa:
> 
>   - Fix buffer size setting for processing CPU topology perf.data header.
> 
> perf stat:
> 
>   Jiri Olsa:
> 
>   - Fix segfault for event group in repeat mode
> 
>   Cong Wang:
> 
>   - Always separate "stalled cycles per insn" line, it was being appended to
>     the "instructions" line.
> 
> perf script:
> 
>   Andi Kleen:
> 
>   - Fix --max-blocks man page description.
> 
>   - Improve man page description of metrics.
> 
>   - Fix off by one in brstackinsn IPC computation.
> 
> perf probe:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Avoid calling freeing routine multiple times for same pointer.
> 
> perf build:
> 
>   - Do not use -Wshadow on gcc < 4.8, avoiding too strict warnings
>     treated as errors, breaking the build.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Alexey Budankov (1):
>       perf session: Fix loading of compressed data split across adjacent records
> 
> Andi Kleen (3):
>       perf script: Fix --max-blocks man page description
>       perf script: Improve man page description of metrics
>       perf script: Fix off by one in brstackinsn IPC computation
> 
> Arnaldo Carvalho de Melo (3):
>       perf probe: Set pev->nargs to zero after freeing pev->args entries
>       perf probe: Avoid calling freeing routine multiple times for same pointer
>       perf build: Do not use -Wshadow on gcc < 4.8
> 
> Cong Wang (1):
>       perf stat: Always separate stalled cycles per insn
> 
> Jiri Olsa (2):
>       perf tools: Fix proper buffer size for feature processing
>       perf stat: Fix segfault for event group in repeat mode
> 
>  tools/perf/Documentation/perf-script.txt |  8 ++++----
>  tools/perf/builtin-probe.c               | 10 ++++++++++
>  tools/perf/builtin-script.c              |  2 +-
>  tools/perf/builtin-stat.c                |  9 ++++++++-
>  tools/perf/util/evsel.c                  |  2 ++
>  tools/perf/util/header.c                 |  2 +-
>  tools/perf/util/probe-event.c            |  1 +
>  tools/perf/util/session.c                | 22 ++++++++++++++--------
>  tools/perf/util/session.h                |  1 +
>  tools/perf/util/stat-shadow.c            |  3 ++-
>  tools/perf/util/zstd.c                   |  4 ++--
>  tools/scripts/Makefile.include           |  9 ++++++++-
>  12 files changed, 54 insertions(+), 19 deletions(-)

Pulled, thanks a lot Arnaldo!

	Ingo
