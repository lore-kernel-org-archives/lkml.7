Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C71BC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 15:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D1D12067D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 15:03:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b="XukWqnN+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387774AbfG2PDg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 11:03:36 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37222 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728494AbfG2PDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 11:03:36 -0400
Received: by mail-qk1-f196.google.com with SMTP id d15so44325432qkl.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 08:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=GGm6OI70suTpFjV7qqNRDI5ovSLydBxQ6ymCIyOGOuM=;
        b=XukWqnN+f7ASzP5xRS7xN7QmRS+fXyMi9aH+eIpObdFSFmM2Gwij6HW9xnCcGW2VFJ
         0YVbOT+7tMf7rh/VIU4tRsqaFhkPC087YYO46peiQmEZm7rEYjEsOKMMguuBrnskL2zs
         97Nu8ezE53m/foi6CrL4xGRPzJXyMEJvZD3aw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=GGm6OI70suTpFjV7qqNRDI5ovSLydBxQ6ymCIyOGOuM=;
        b=ghIlV9ycyC32mLFPTVhtMCYnt5s9MVUMzPqSb6a46MH4dum3IjYXQb7EN0Kv4Sp9OZ
         FMMsxQihwOfmwwP7n4pbqYwgD/PJd6TpAMkbGgBMXoEhYM/v1gvyWrTZSJDvaVtzDY8a
         HZ3qxxns1JZjfh2CMK3fWm4C9kpTvohXNCuyHOiu0LGQX0I7AP0p6T4DB1kAMv1eZh0z
         0i0xLpktg/kM1ywAc/I4YNFMKEL4b4YZcr7Y1D976eux3kezRSZerb7PoSdIEK9Kck5p
         4fYMjH9aA+wxX7fb9zcMk8gxqplJ8e2KR53i+E+UXRUlMPm0sqy2Q8N05sjrW+iel2Wf
         coQw==
X-Gm-Message-State: APjAAAWyyZUJ3PLEGVsMZ6Iikk2qT2AT2Q6x1ZsXMW2MHcyVrlkRz4cj
        Pj8brsGGFwimf456fEhqkUyPRseQfwc=
X-Google-Smtp-Source: APXvYqzUFRaqL/T3JR8xJ5iKiBBlmGvkH1xB3cm3TfaXnPHjOK6x5UFBJP8eP/q4e8U2SNn6vsoWzw==
X-Received: by 2002:a37:9d1:: with SMTP id 200mr71450094qkj.306.1564412615532;
        Mon, 29 Jul 2019 08:03:35 -0700 (PDT)
Received: from macbook-air (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id u1sm34198651qth.21.2019.07.29.08.03.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 08:03:34 -0700 (PDT)
From:   Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date:   Mon, 29 Jul 2019 11:03:26 -0400 (EDT)
X-X-Sender: vince@macbook-air
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: perf: perf report stuck in an infinite loop
In-Reply-To: <20190726211415.GE24867@kernel.org>
Message-ID: <alpine.DEB.2.21.1907291102500.31029@macbook-air>
References: <alpine.DEB.2.21.1907261640590.27043@macbook-air> <20190726211415.GE24867@kernel.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Jul 2019, Arnaldo Carvalho de Melo wrote:

> Em Fri, Jul 26, 2019 at 04:46:51PM -0400, Vince Weaver escreveu:
> > 
> > Currently the perf_data_fuzzer causes perf report to get stuck in an 
> > infinite loop.
> > 
> > >From what I can tell, the issue happens in reader__process_events()
> > when an event is mapped using mmap(), but when it goes to process the
> > event finds out the internal event header has the size (invalidly) set to 
> > something much larger than the mmap buffer size.  This means 
> > fetch_mmaped_event() fails, which gotos remap: which tries again with
> > the exact same mmap size, and this will loop forever.
> > 
> > I haven't been able to puzzle out how to fix this, but maybe you have a 
> > better feel for what's going on here.
> 
> Perhaps the patch below?

yes, with the patch you provided I can no longer trigger the infinite 
loop.

Tested-by: Vince Weaver <vincent.weaver@maine.edu>
