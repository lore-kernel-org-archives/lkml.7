Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC7BCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 10:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 911A82070B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 10:39:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394400AbfJYKjj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 06:39:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:51066 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730471AbfJYKjj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 06:39:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0CB61AD9C;
        Fri, 25 Oct 2019 10:39:37 +0000 (UTC)
From:   Thomas Renninger <trenn@suse.com>
To:     " Natarajan, Janakarajan " <Janakarajan.Natarajan@amd.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Pu Wen <puwen@hygon.com>, Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        Richard Fontana <rfontana@redhat.com>,
        Borislav Petkov <bp@suse.de>
Subject: Re: [PATCHv2 2/3] cpupower: mperf_monitor: Introduce per_cpu_schedule flag
Date:   Fri, 25 Oct 2019 12:39:36 +0200
Message-ID: <24194241.SRZ5kbjNg7@skinner.arch.suse.de>
In-Reply-To: <bb4b0e4137b62651b9d028925fa8f09ca5fbd989.1570819652.git.Janakarajan.Natarajan@amd.com>
References: <cover.1570819652.git.Janakarajan.Natarajan@amd.com> <bb4b0e4137b62651b9d028925fa8f09ca5fbd989.1570819652.git.Janakarajan.Natarajan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Natarajan,

sorry for answering that late.
I post on top as it doesn't fit to the patch context:

While I like the 2 other patches, especially the first preparing for
a generic "ensure to always run on the measured CPU at measure time" 
interface..., this patch does make use of it in a very static manner.

I then tried to get this more generic..., without any outcome for now.

If someone likes to play with this, my idea would be:

- the monitors need cpu_start() and cpu_stop() callbacks to register
- either start(), stop() and/or cpu_start(), cpu_stop() callbacks have to
  be provided by a monitor.
- current behavior is only start/stop which means the whole per_cpu logic
  resides inside the monitor
- if cpu_start/cpu_stop is provided, iterating over all cpus is done in
  fork_it and general start/stop functions are an optionally entry point
  before and after the per_cpu calls.

Then the cpu binding can be done from outside.
Another enhancement could be then to fork as many processes as there are CPUs
in case of per_cpu_schedule (or an extra param/flag) and then:

- Bind these forked processes to each cpu.
- Execute start measures via the forked processes on each cpu
- Execute test executable (which runs in yet another fork as done already)
- Execute stop measures via the forked processes on each cpu

This should be ideal environment to not interfere with the tested executable.
It would also allow a nicer program structure.

Just some ideas. But no time right now to look deeper into this.

I'll ack on the first summarizing commit message.


    Thomas


