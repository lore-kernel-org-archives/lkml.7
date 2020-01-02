Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64DF2C2D0C2
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 18:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3533A21655
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 18:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b="fGyQZIUO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbgABSz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 13:55:58 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40192 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727951AbgABSz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 13:55:58 -0500
Received: by mail-qk1-f196.google.com with SMTP id c17so32072369qkg.7
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jan 2020 10:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google;
        h=from:date:to:cc:subject:message-id:user-agent:mime-version;
        bh=SVhqJNc9KZvv3EKUfF1sirEUq6RG4WOzhSxBPIcUwS8=;
        b=fGyQZIUOE1EwKvzSQHfBo9D3ndHkj15jXCmb5aymGBAJQfOtBwHVCRboNJoRoIcuGy
         KneQgA1RZQFkATPeiB9vPaiszLvna07HrPQkzMpne4sSlSGbKu0kc8WBF6XnL8ZvaQOi
         G7rByV+7OuPjDQmfQHsZwZTOGeYvxOViiRS58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=SVhqJNc9KZvv3EKUfF1sirEUq6RG4WOzhSxBPIcUwS8=;
        b=pHlyfeiCAWEM0ZrOt9UhrFzdC5DUC5VrFhrbdP6W7scuLeNhepOKr8xbu8VQ66WLy+
         /y6vH3rBCeiyDECnqd0oQRZje9yQYXTGOgk2IS72R6Py3P0rY0LFiQmc5kQEmd7nn+Zs
         q0UDJ+D/WWxuq44zCNB6srkSfo2APJmeGOIgXwugI2eEl2yDaMCbEoBam5RJafVvPJQ9
         egDU63wJYX+3pPpcmr2xp+1ew5RLd+huGxlRHxDFIqLzcdnxPINtSminpPUhqsC6EyRY
         taM3zq2kJuZCxv1HvbxzWn0GiNu9Df5keSpxA/1kOcoSz9hmmqTiJbHO6bVdNLAro9N0
         VA3A==
X-Gm-Message-State: APjAAAU/I3Hw+2KC1/iPY98aLU/kEGP4+Iy5QSPAk+jNMhvf1O9gixkh
        rlHFLu0smnthOZ5RN53/3zykPH0Kix8=
X-Google-Smtp-Source: APXvYqx6atPtouviklmhlnmFklzEranEIF2Jip5ea8rQYQBjG9DwH0ytDunhIrUtXJh3ZFm3gCr/8w==
X-Received: by 2002:a05:620a:16c6:: with SMTP id a6mr69034478qkn.140.1577991356527;
        Thu, 02 Jan 2020 10:55:56 -0800 (PST)
Received: from macbook-air (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id v5sm17210024qth.70.2020.01.02.10.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 10:55:55 -0800 (PST)
From:   Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date:   Thu, 2 Jan 2020 13:55:47 -0500 (EST)
X-X-Sender: vince@macbook-air
To:     linux-kernel@vger.kernel.org
cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [perf] perf_event_open() sometimes returning 0
Message-ID: <alpine.DEB.2.21.2001021349390.11372@macbook-air>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

so I was tracking down some odd behavior in the perf_fuzzer which turns 
out to be because perf_even_open() sometimes returns 0 (indicating a file 
descriptor of 0) even though as far as I can tell stdin is still open.

Before I waste too much time trying to track this down, is this a known 
issue?

Some sample strace output:

perf_event_open({type=PERF_TYPE_RAW, size=0x78 /* PERF_ATTR_SIZE_??? */, config=0x1313, ...}, 0, 3, -1, PERF_FLAG_FD_NO_GROUP) = 0
perf_event_open({type=PERF_TYPE_SOFTWARE, size=0x78 /* PERF_ATTR_SIZE_??? */, config=PERF_COUNT_SW_DUMMY, ...}, -1, 3, -1, PERF_FLAG_FD_NO_GROUP|PERF_FLAG_FD_OUTPUT) = 0
perf_event_open({type=PERF_TYPE_SOFTWARE, size=0x78 /* PERF_ATTR_SIZE_??? */, config=PERF_COUNT_SW_PAGE_FAULTS_MIN, ...}, 158266, 2, -1, PERF_FLAG_FD_CLOEXEC) = 0
perf_event_open({type=PERF_TYPE_HW_CACHE, size=0x78 /* PERF_ATTR_SIZE_??? */, config=PERF_COUNT_HW_CACHE_DTLB|PERF_COUNT_HW_CACHE_OP_READ<<8|PERF_COUNT_HW_CACHE_RESULT_MISS<<16, ...}, 0, 4, -1, PERF_FLAG_FD_NO_GROUP|PERF_FLAG_FD_CLOEXEC) = 0
perf_event_open({type=PERF_TYPE_RAW, size=0x78 /* PERF_ATTR_SIZE_??? */, config=0, ...}, -1, 0, -1, PERF_FLAG_FD_OUTPUT|PERF_FLAG_FD_CLOEXEC) = 0

On my Haswell system (running current git) I can reproduce things with a 
single call:

	memset(&pe[0],0,sizeof(struct perf_event_attr));
	pe[0].type=PERF_TYPE_RAW;
	pe[0].size=120;
	pe[0].config=0x0ULL;
	pe[0].sample_period=0x4777c3ULL;
	pe[0].sample_type=PERF_SAMPLE_STREAM_ID; /* 200 */
	pe[0].read_format=PERF_FORMAT_TOTAL_TIME_RUNNING|PERF_FORMAT_ID|PERF_FORMAT_GROUP; /* e */
	pe[0].inherit=1;
	pe[0].exclude_hv=1;
	pe[0].exclude_idle=1;
	pe[0].enable_on_exec=1;
	pe[0].watermark=1;
	pe[0].precise_ip=0; /* arbitrary skid */
	pe[0].mmap_data=1;
	pe[0].exclude_guest=1;
	pe[0].exclude_callchain_kernel=1;
	pe[0].mmap2=1;
	pe[0].comm_exec=1;
	pe[0].context_switch=1;
	pe[0].bpf_event=1;
	pe[0].wakeup_watermark=47545;
	pe[0].bp_type=HW_BREAKPOINT_EMPTY;
	pe[0].branch_sample_type=PERF_SAMPLE_BRANCH_KERNEL|PERF_SAMPLE_BRANCH_ANY_RETURN|PERF_SAMPLE_BRANCH_COND|0x800ULL;
	pe[0].sample_regs_user=42ULL;
	pe[0].sample_stack_user=0xfffffffd;
	pe[0].aux_watermark=25443;
	pe[0].aux_sample_size=8192;

	fd[0]=perf_event_open(&pe[0],
				-1, /* current thread */
				0, /* Only cpu 0 */
				-1, /* New Group Leader */
				PERF_FLAG_FD_OUTPUT|PERF_FLAG_FD_CLOEXEC /*a*/ );

