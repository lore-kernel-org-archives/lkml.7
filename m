Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C036C76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 14:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E477721993
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 14:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563806314;
	bh=nI4H02Rs1Krn9fT6Xdh4P8gDKFBNE1yuNf5PosxFUOY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=cXN4easbyAOg8m+OqOHiEloFlRUUK5LIUd/FkyPwUgQ1aArHk98lTe7uwaFfg1yTS
	 PavCijrs38zAvt37KVd3oWBnhskR1vms2dMJb8b/AWFUwUGWhLJc8cvgdASrzMnGzA
	 vxiD+fLeO2mckMIdt7rbTUIpPcW08kzz3SpDN9y8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730910AbfGVOid (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 10:38:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:59418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728189AbfGVOic (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 10:38:32 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2EF621951;
        Mon, 22 Jul 2019 14:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563806311;
        bh=nI4H02Rs1Krn9fT6Xdh4P8gDKFBNE1yuNf5PosxFUOY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RKftx4fgX4wm2P05Sd2ay5mLZCSMLaRLeUuRjV8+CiggE+5MTLRVJkAVHZ8No/j1E
         23Z+Dd6LRmnmkYW+PgWu/iKTyYNIdVJt/2bACs/dTyFcnWFzRNZZyKJapFz6k55gx+
         CqqCw5m0yMLwW/6/2PrGZEuHZDCKlktv9nu6+fow=
Date:   Mon, 22 Jul 2019 23:38:26 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Rob Herring <robh+dt@kernel.org>, Tim Bird <Tim.Bird@sony.com>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [RFC PATCH v2 00/15] tracing: of: Boot time tracing using
 devicetree
Message-Id: <20190722233826.bafd7aeaad3b821157f2d2ff@kernel.org>
In-Reply-To: <20190717000235.9ab100f0dac4af797a0fb76a@kernel.org>
References: <156316746861.23477.5815110570539190650.stgit@devnote2>
        <488a65e6-1d80-0acb-5092-80c18b7ff447@gmail.com>
        <20190717000235.9ab100f0dac4af797a0fb76a@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I discussed with Frank and other kernel developers last week at OSSJ 2019.
Eventually, I decided to leave from devicetree, because it can unstabilize
current devicetree desgin and policy. Instead, aim to introduce a new
generic structured kernel cmdline, something like "configtree".

I thought JSON or other generic data format, but they look a bit bloated
for my purpose. I just need something like "extended hierarchical kernel
cmdline". For example,

ftrace {
  options = "sym-addr"
  events = "initcall:*"
  tp-printk
  event.0 {
    name = "tasl:task_newtask"
    filter = "pid < 128"
  } 
}

Which can be written as

ftrace.options="sym-addr" ftrace.events="initcall:*" ftrace.tp-printk ftrace.event.0.name="tasl:task_newtask" ftrace.event.0.filter="pid < 128"

on current kernel cmdline.

So, the parameters are linearly extended from current kernel cmdline.
Kernel internal APIs must be able to handle both of current cmdline
key-values and configtree key-values.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
