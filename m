Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E30AAC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 20:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB86D2068E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 20:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfKZUTM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 15:19:12 -0500
Received: from mga17.intel.com ([192.55.52.151]:27752 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726049AbfKZUTM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 15:19:12 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Nov 2019 12:19:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,246,1571727600"; 
   d="scan'208";a="359273878"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by orsmga004.jf.intel.com with ESMTP; 26 Nov 2019 12:19:11 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 879BC300B64; Tue, 26 Nov 2019 12:19:11 -0800 (PST)
From:   Andi Kleen <ak@linux.intel.com>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/2] perf: add support for logging debug messages to file
References: <20191126143720.10333-1-changbin.du@gmail.com>
Date:   Tue, 26 Nov 2019 12:19:11 -0800
In-Reply-To: <20191126143720.10333-1-changbin.du@gmail.com> (Changbin Du's
        message of "Tue, 26 Nov 2019 22:37:18 +0800")
Message-ID: <87v9r6e6gw.fsf@linux.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changbin Du <changbin.du@gmail.com> writes:

> When in TUI mode, it is impossible to show all the debug messages to
> console. This make it hard to debug perf issues using debug messages.
> This patch adds support for logging debug messages to file to resolve
> this problem.

This was already solved in

commit f78eaef0e0493f6068777a246b9c4d9d5cf2b7aa
Author: Andi Kleen <ak@linux.intel.com>
Date:   Fri Nov 21 13:38:00 2014 -0800

    perf tools: Allow to force redirect pr_debug to stderr.

    When debugging the tui browser I find it useful to redirect the
    debug
        log into a file. Currently it's always forced to the message
    line.

    Add an option to force it to stderr. Then it can be easily
    redirected.
    
You can do

perf report --debug stderr 2> file ...

-Andi
