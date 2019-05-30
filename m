Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68605C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 19:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D8D726105
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 19:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lo8rE098"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfE3TlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 15:41:17 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33961 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbfE3TlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 15:41:16 -0400
Received: by mail-qt1-f196.google.com with SMTP id h1so8520056qtp.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 12:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ic51GBoC4HGzJmq/ZGRelBKGtxO/dhaAnZB7vp+Kvbc=;
        b=lo8rE098x9VZr7UrCPPE7b1jql2yxvP2r29kQRVB8iLqGV3MwN0nJ0OfCxctKit1xi
         kHn3t6dohUWXYS9FkwON9VT6sFbllRjIELv80C2v7efL37wpIytLyU1RCU55UttIVCms
         TpnnbHNlix7LkHIo2jcW0BYxrjmYmg/tg6jGxsKCFBrEDsoNx0jS3mzQub2TA0QPhwWM
         LRJ5vg879aD72ySObj/kyT0IK/f/uadTZp8jxKYWO6SDgZ23ogjHvVArrhTPdMEOSrGT
         2IzunaW2lACwqfRNChKHNYGKTfJhqkf9+dyruA6iWGf0xyH4zgeLUucVj3ulGjiRFR3U
         JKTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ic51GBoC4HGzJmq/ZGRelBKGtxO/dhaAnZB7vp+Kvbc=;
        b=BUSZaXgjIVQ4RIcKMMTmCX8g3+7s/mHYpZSjzYEzTqvv0ScgG87XuLZFxrXbh6H0PN
         0lz8/rYLBrrX4127+PIZBMSD5U/ho5xHFkR8lNSn6Rs5RNfP+yVe6H5EhPGpnPjoIG38
         qgpdoB2y/Gm0u+tGRGvsT6X+1SxDtxuKrHA0dqHg2apyPipKwYJC9tTzE/oBd6Vj+dP4
         /C3gBvDqYsQ/TBYuwbPVurv9YrRe9yCDjhHc+MN1dIF6M5zWUJibGCBzMMnBxfZtsM4a
         f7lBJMahPoWu3CrBExhq56CLglZuB78Oi+E+RVMXTuwQ5gzJ0Y0UB7EmBfQxAqOTtDgw
         nd5A==
X-Gm-Message-State: APjAAAUb+/R4y+RK0TP/zUCzGO8mz758eyunaSgQ0sZC/HfIemhLxfAo
        ihzwRGG68G75TkMJ8aEiJ8U=
X-Google-Smtp-Source: APXvYqx7EsbltOe8G9/33FVPMD6MaF1OVn8nCAYGMe8hf/pFDMvmvtK8XtjiWKlufSw1ftMPNnSyWg==
X-Received: by 2002:aed:2383:: with SMTP id j3mr5126926qtc.313.1559245275350;
        Thu, 30 May 2019 12:41:15 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id k65sm1811261qkf.46.2019.05.30.12.41.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 30 May 2019 12:41:14 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DD95F41149; Thu, 30 May 2019 16:41:11 -0300 (-03)
Date:   Thu, 30 May 2019 16:41:11 -0300
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5] perf record: collect user registers set jointly with
 dwarf stacks
Message-ID: <20190530194111.GA6540@kernel.org>
References: <e7fd37b1-af22-0d94-a0dc-5895e803bbfe@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7fd37b1-af22-0d94-a0dc-5895e803bbfe@linux.intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, May 30, 2019 at 10:03:36PM +0300, Alexey Budankov escreveu:
> 
> When dwarf stacks are collected jointly with user specified register
> set using --user-regs option like below the full register context is
> captured on a sample:
> 
>   $ perf record -g --call-graph dwarf,1024 --user-regs=IP,SP,BP -- stack_test2.g.O3
> 
>   188143843893585 0x6b48 [0x4f8]: PERF_RECORD_SAMPLE(IP, 0x4002): 23828/23828: 0x401236 period: 1363819 addr: 0x7ffedbdd51ac
>   ... FP chain: nr:0
>   ... user regs: mask 0xff0fff ABI 64-bit
>   .... AX    0x53b
>   .... BX    0x7ffedbdd3cc0
>   .... CX    0xffffffff
>   .... DX    0x33d3a
>   .... SI    0x7f09b74c38d0
>   .... DI    0x0
>   .... BP    0x401260
>   .... SP    0x7ffedbdd3cc0
>   .... IP    0x401236
>   .... FLAGS 0x20a
>   .... CS    0x33
>   .... SS    0x2b
>   .... R8    0x7f09b74c3800
>   .... R9    0x7f09b74c2da0
>   .... R10   0xfffffffffffff3ce
>   .... R11   0x246
>   .... R12   0x401070
>   .... R13   0x7ffedbdd5db0
>   .... R14   0x0
>   .... R15   0x0
>   ... ustack: size 1024, offset 0xe0
>    . data_src: 0x5080021
>    ... thread: stack_test2.g.O:23828
>    ...... dso: /root/abudanko/stacks/stack_test2.g.O3
> 
> After applying the change suggested in the patch the sample data contain
> only user specified register values. IP and SP registers (DWARF_MINIMAL_REGS)
> are collected anyways regardless of the --user-regs value provided from
> the command line:

Applied, changed the subject and description to:

perf record: Allow mixing --user-regs with --call-graph=dwarf

When DWARF stacks were requested and at the same time that the user
specifies a register set using the --user-regs option the full register
context was being captured on samples:

  $ perf record -g --call-graph dwarf,1024 --user-regs=IP,SP,BP -- stack_test2.g.O3

  188143843893585 0x6b48 [0x4f8]: PERF_RECORD_SAMPLE(IP, 0x4002): 23828/23828: 0x401236 period: 1363819 addr: 0x7ffedbdd51ac
  ... FP chain: nr:0
  ... user regs: mask 0xff0fff ABI 64-bit
  .... AX    0x53b
  .... BX    0x7ffedbdd3cc0
  .... CX    0xffffffff
  .... DX    0x33d3a
  .... SI    0x7f09b74c38d0
  .... DI    0x0
  .... BP    0x401260
  .... SP    0x7ffedbdd3cc0
  .... IP    0x401236
  .... FLAGS 0x20a
  .... CS    0x33
  .... SS    0x2b
  .... R8    0x7f09b74c3800
  .... R9    0x7f09b74c2da0
  .... R10   0xfffffffffffff3ce
  .... R11   0x246
  .... R12   0x401070
  .... R13   0x7ffedbdd5db0
  .... R14   0x0
  .... R15   0x0
  ... ustack: size 1024, offset 0xe0
   . data_src: 0x5080021
   ... thread: stack_test2.g.O:23828
   ...... dso: /root/abudanko/stacks/stack_test2.g.O3

I.e. the --user-regs=IP,SP,BP was being ignored, being overridden by the
needs of --call-graph=dwarf.

After applying the change in this patch the sample data contains the
user specified register, but making sure that at least the minimal set
of register needed for DWARF unwinding (DWARF_MINIMAL_REGS) is
requested.

The user is warned that DWARF unwinding may not work if extra registers
end up being needed.

  -g call-graph dwarf,K                         full_regs
  --user-regs=user_regs                         user_regs
  -g call-graph dwarf,K --user-regs=user_regs   user_regs + DWARF_MINIMAL_REGS
<REST remains the same>
