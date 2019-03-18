Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE4D6C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 18:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE4492133D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 18:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552933281;
	bh=fX0KR8uWAFr+SR4MMFN9LrN+iYXYOiPwLx9CXdTkI7k=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=ikiO5eN+iTOWLBlv4FFLVgRHaxPdOm6anadb7CqRu0QWC6JCmPiAoqip+Qw/Kfdte
	 EoFdAnapV4KE+5N4MG2YWsNmhtCvgY3ohuhNi+R01NyZT7YYbjAJmIwkcbiMhLtse1
	 yN5Pq2xMrumL0Q2sNumfFQFyCClh1QKnxoHbyKX4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbfCRSVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 14:21:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55274 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726897AbfCRSVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 14:21:20 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5A23B309264A;
        Mon, 18 Mar 2019 18:21:19 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.124])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B16AB600D4;
        Mon, 18 Mar 2019 18:21:16 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Andy Lutomirski <luto@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [RFC 0/8] perf/x86: Add msr probe interface
Date:   Mon, 18 Mar 2019 19:21:08 +0100
Message-Id: <20190318182116.17388-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Mon, 18 Mar 2019 18:21:19 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
following up on [1], this patchset factors out the MSR
probe code and use it in msr,cstate* and rapl PMUs.

The functionality stays the same with one exception:
the event is not exported if the rdmsr return zero
on event's msr.

I still need to run tests on other models and verify
rapl model table properly, but I'd like to ask it
something like this would be acceptable.

Also available in:
  git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
  perf/msr

thanks,
jirka


[1] https://lore.kernel.org/lkml/20190301114250.GA23459@krava/
---
Jiri Olsa (8):
      perf/x86: Add msr probe interface
      perf/x86/msr: Use new probe function
      perf/x86/cstate: Use new probe function
      perf/x86/rapl: Use new msr detection interface
      perf/x86/rapl: Get rapl_cntr_mask from new probe framework
      perf/x86/rapl: Get msr values from new probe framework
      perf/x86/rapl: Get attributes from new probe framework
      perf/x86/rapl: Get quirk state from new probe framework

 arch/x86/events/Makefile       |   2 +-
 arch/x86/events/intel/cstate.c |  92 +++++++++++++++++++++++------------------------
 arch/x86/events/intel/rapl.c   | 341 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------------------------------------------------------------------------------------------------------
 arch/x86/events/msr.c          |  76 ++++++++++++++++++---------------------
 arch/x86/events/probe.c        |  36 +++++++++++++++++++
 arch/x86/events/probe.h        |  22 ++++++++++++
 6 files changed, 272 insertions(+), 297 deletions(-)
 create mode 100644 arch/x86/events/probe.c
 create mode 100644 arch/x86/events/probe.h
