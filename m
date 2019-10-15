Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC00DC4CECE
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 03:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C084421835
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 03:20:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u6MRhQIW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbfJODUt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 23:20:49 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38169 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727195AbfJODUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 23:20:49 -0400
Received: by mail-qt1-f196.google.com with SMTP id j31so28518286qta.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 20:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+a62DdmduxnuPn8gfinhXIl/fI174vfUQzT+Rlsfq90=;
        b=u6MRhQIWLKqRNJUSQur+JB3dwFxavoa402DUjy/BWkWh5ofauj0kuzK+EGHte94+od
         NlGd/8HFOGL2MrO6Hm3Uby891BjI6UV5JhtYPQcV8/5IL9RFUky5euB400vJba244ucC
         +QBicP0y/IeHmdzPFgu5AfU4dGa3RIIYN8B+UwhZj5Yh/tE2LN/iREe1DvyoJ7mHoj5D
         swDdlB7pYjxHURvNDOFxozl5zQiV+ofC8obFbEltdsjKvfbwwJbQl7olZdYeoGbby2r3
         1Jim2+hIzPJVPl8/eFYs3vCHaLg2EWvXtEtKcVqQLkT+8VHRt6DCDLpp/T5Ec7GVpb/h
         6vrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+a62DdmduxnuPn8gfinhXIl/fI174vfUQzT+Rlsfq90=;
        b=Y2+aGFtjhTDiwrAR6kjarJ7XMa9w55aWDUIRQWeeq5GJRQMFeQKbDHJPoE45Qn5qCi
         lNEJ4YFhsFUR+H+CO69v/jdxu47W2BHHTEt/l/+CoAf50OjynDlAt+x7tjUoMHOTDNml
         1UZ1n+T7Ge/KYk9yNwyIAajlNVeOas/cgtcoZsISQQ9nW1RoLk6TfBaBZ7EHKHRgbj2k
         DvZ5wTqFqTUqpxz+oZt5EvYBO/fgn0UkZ3MBVHA24lnw0GQeNmaHdSgcPnGsIbXzPv78
         VZuMbnDNRtmjcTRv9k70nKt48QtsD/MR3EGpPUU1OZp0KM83F5NOGA7a7IVICxc7RTDi
         YiXw==
X-Gm-Message-State: APjAAAUytPPwioBUZGN6+a2AqnV0Caae2reWOLVcs3kNb3omlPpNJmD+
        z0+WZnwxPyialla9pHRUjLBz+A==
X-Google-Smtp-Source: APXvYqz1imHgeqaddA3di71uJl0NpcZoPv6YENI6GPW3vEFz0irmOXt9Qo3eu8CdPF0/qxjJOYLM6g==
X-Received: by 2002:aed:2796:: with SMTP id a22mr35631096qtd.324.1571109646445;
        Mon, 14 Oct 2019 20:20:46 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (li937-157.members.linode.com. [45.56.119.157])
        by smtp.gmail.com with ESMTPSA id d40sm11954014qtk.6.2019.10.14.20.20.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Oct 2019 20:20:45 -0700 (PDT)
Date:   Tue, 15 Oct 2019 11:20:38 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] perf test: Avoid infinite loop for task exit case
Message-ID: <20191015032038.GA6336@leoy-ThinkPad-X240s>
References: <20191011091942.29841-1-leo.yan@linaro.org>
 <20191011091942.29841-2-leo.yan@linaro.org>
 <20191014141136.GD19627@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014141136.GD19627@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 11:11:36AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Fri, Oct 11, 2019 at 05:19:42PM +0800, Leo Yan escreveu:
> > When execute task exit testing case, Perf tool stucks in this case and
> > doesn't return back on Arm64 Juno board.
> > 
> > After dig into this issue, since Juno board has Arm's big.LITTLE CPUs,
> > thus the PMUs are not compatible between the big CPUs and little CPUs.
> > This leads to PMU event cannot be enabled properly when the traced task
> > is migrated from one variant's CPU to another variant.  Finally, the
> > test case runs into infinite loop for cannot read out any event data
> > after return from polling.
> > 
> > Eventually, we need to work out formal solution to allow PMU events can
> > be freely migrated from one CPU variant to another, but this is a
> > difficult task and a different topic.  This patch tries to fix the Perf
> > test case to avoid infinite loop, when the testing detects 1000 times
> > retrying for reading empty events, it will directly bail out and return
> > failure.  This allows the Perf tool can continue its other test cases.
> 
> Thanks, applied.

Thanks a lot, Arnaldo.
