Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E93B4C2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 17:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBE532073A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 17:35:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b="B3/zrHRP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfLWRf5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 12:35:57 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37505 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbfLWRf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 12:35:56 -0500
Received: by mail-qk1-f193.google.com with SMTP id 21so14133619qky.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Dec 2019 09:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=uP8PckNbUaLSpRir2aIP/UhQzXL6a9QpbQ12gu/yjVg=;
        b=B3/zrHRP7wtOthBDwM0sYOPRE2oI98xZ2aLyGghHzTpBwe2jTL0Hmpn8P4Jlbfakyp
         LqHEFT/6hxUFH2xzUoNvlMG8pyHzeR7jz/E5pS0/h6KH3EAzmE+BlPMtF5waorgBLRzS
         thQl33ViMN27xPhj5wpyjHJT1plWFwsH3gGr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=uP8PckNbUaLSpRir2aIP/UhQzXL6a9QpbQ12gu/yjVg=;
        b=P1QTP/sYmd+OTQQqhR/iJLIT9K9x39bAlgYwkRaRr7+NdLzY1qM7ROwJkly70mc/3u
         CK5i40Ni9XBchyh9rkQXabT32bDyMsGfFkSC3C8F38BItnJr0O9k2dykMN/m6ba0uE8W
         J0TH6IQlTqc7NJbyddtHOPgTDoXClrdrB2VvGpu77gxDi1juaNhT5dhzQhs4r3VYRTaC
         kTMfWB8knfmE5MNzzV7TRY3V2A50LJvvNT2bJaCmB3JqydThTjlrxr+bCdluwGE60Q90
         35ryqSHCr5PjFNpb//rOId4PigAD4DtyeSe6nQYoyrheVWGzkMGb7/ZAs5y9jBqhKGsX
         AGYw==
X-Gm-Message-State: APjAAAVRI2BLn4WAVqPV2hgZk+nQc08oajVLwZ4TbcTTuvI6y/ZV+MOl
        4bMlu9feXAALrVpDj0wEHxh/PA==
X-Google-Smtp-Source: APXvYqwqLEJfWFPOoCAeB3BnQ5rF9tWqx7ltXx590WZ8Q+SfEkuyYyaeV3ughldw3zEa/3bRi4cAOg==
X-Received: by 2002:a05:620a:137a:: with SMTP id d26mr27277189qkl.173.1577122555565;
        Mon, 23 Dec 2019 09:35:55 -0800 (PST)
Received: from macbook-air (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id u57sm6485715qth.68.2019.12.23.09.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2019 09:35:54 -0800 (PST)
From:   Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date:   Mon, 23 Dec 2019 12:35:47 -0500 (EST)
X-X-Sender: vince@macbook-air
To:     Namhyung Kim <namhyung@kernel.org>
cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCHSET 0/9] perf: Improve cgroup profiling (v3)
In-Reply-To: <20191223060759.841176-1-namhyung@kernel.org>
Message-ID: <alpine.DEB.2.21.1912231235090.775@macbook-air>
References: <20191223060759.841176-1-namhyung@kernel.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Dec 2019, Namhyung Kim wrote:

> This work is to improve cgroup profiling in perf.  Currently it only
> supports profiling tasks in a specific cgroup and there's no way to
> identify which cgroup the current sample belongs to.  So I added
> PERF_SAMPLE_CGROUP to add cgroup id into each sample.  It's a 64-bit
> integer having file handle of the cgroup.  And kernel also generates
> PERF_RECORD_CGROUP event for new groups to correlate the cgroup id and
> cgroup name (path in the cgroup filesystem).  The cgroup id can be
> read from userspace by name_to_handle_at() system call so it can
> synthesize the CGROUP event for existing groups.

so is there a patch to the manpage that describes this new behavior in 
perf_event_open()?

Vince
