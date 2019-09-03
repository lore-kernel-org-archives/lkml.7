Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A63FC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09C6622CF8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:05:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729935AbfICQFv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 12:05:51 -0400
Received: from foss.arm.com ([217.140.110.172]:39712 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729709AbfICQFu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 12:05:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5FC3E360;
        Tue,  3 Sep 2019 09:05:50 -0700 (PDT)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AAC203F246;
        Tue,  3 Sep 2019 09:05:48 -0700 (PDT)
Subject: Re: [PATCH 2/2] sched/debug: add sched_update_nr_running tracepoint
To:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        =?UTF-8?Q?Jirka_Hladk=c3=bd?= <jhladky@redhat.com>,
        =?UTF-8?B?SmnFmcOtIFZvesOhcg==?= <jvozar@redhat.com>,
        x86@kernel.org, Qais Yousef <qais.yousef@arm.com>
References: <20190903154340.860299-1-rkrcmar@redhat.com>
 <20190903154340.860299-3-rkrcmar@redhat.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <a2924d91-df68-42de-0709-af53649346d5@arm.com>
Date:   Tue, 3 Sep 2019 17:05:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190903154340.860299-3-rkrcmar@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/09/2019 16:43, Radim Krčmář wrote:
> The paper "The Linux Scheduler: a Decade of Wasted Cores" used several
> custom data gathering points to better understand what was going on in
> the scheduler.
> Red Hat adapted one of them for the tracepoint framework and created a
> tool to plot a heatmap of nr_running, where the sched_update_nr_running
> tracepoint is being used for fine grained monitoring of scheduling
> imbalance.
> The tool is available from https://github.com/jirvoz/plot-nr-running.
> 
> The best place for the tracepoints is inside the add/sub_nr_running,
> which requires some shenanigans to make it work as they are defined
> inside sched.h.
> The tracepoints have to be included from sched.h, which means that
> CREATE_TRACE_POINTS has to be defined for the whole header and this
> might cause problems if tree-wide headers expose tracepoints in sched.h
> dependencies, but I'd argue it's the other side's misuse of tracepoints.
> 
> Moving the import sched.h line lower would require fixes in s390 and ppc
> headers, because they don't include dependecies properly and expect
> sched.h to do it, so it is simpler to keep sched.h there and
> preventively undefine CREATE_TRACE_POINTS right after.
> 
> Exports of the pelt tracepoints remain because they don't need to be
> protected by CREATE_TRACE_POINTS and moving them closer would be
> unsightly.
> 

Pure trace events are frowned upon in scheduler world, try going with
trace points. Qais did something very similar recently:

https://lore.kernel.org/lkml/20190604111459.2862-1-qais.yousef@arm.com/

You'll have to implement the associated trace events in a module, which
lets you define your own event format and doesn't form an ABI :).
