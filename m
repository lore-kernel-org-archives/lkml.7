Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E31FC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 13:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 353B1206F4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 13:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kHR9fqvV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbfKNN5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 08:57:39 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52004 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbfKNN5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 08:57:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lDnN/9X9Cy3nGKIfPbPORD6eLqZBeoY8DYM75RP+PVA=; b=kHR9fqvVMMIwGa9wpqf7cu3Q9
        7kstGQluaRrCyA9Nk0Rs+bxKnYA6OOxUrQU39domY8IwIZHeq6E/guxbO2tPG3GFbx77kEjl7Cj2x
        FdjPWQZF3sifgHo71u7s+tXjENYmETxBFm3KcTssuiJFHZIZlsleVBc66SOkPiH7jKd9FYeapv/4p
        Joir6dQNRlvri62gmaMEvPIdHJVX97mZcEFbD1Umc9P1qTeiGGGc1e6JylZXmNxqx8w+oEo5F0/XL
        ybmYoCqypXb1xT0+Q3ArYgPGEzgKsqwJcwkPJpC5QcPacaJdNS4SfznyyaDqKk2Wod4QZ4y4WknBD
        MPt+p1UgQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iVFce-00062A-W8; Thu, 14 Nov 2019 13:57:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E37A6304637;
        Thu, 14 Nov 2019 14:56:10 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 63585203A589D; Thu, 14 Nov 2019 14:57:18 +0100 (CET)
Date:   Thu, 14 Nov 2019 14:57:18 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Petr Mladek <pmladek@suse.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Qian Cai <cai@lca.pw>, Joe Lawrence <joe.lawrence@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Sri Krishna chowdary <schowdary@nvidia.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Changbin Du <changbin.du@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Gary Hook <Gary.Hook@amd.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v3 10/10] perf/cgroup: Do not switch system-wide events
 in cgroup switch
Message-ID: <20191114135718.GX4131@hirez.programming.kicks-ass.net>
References: <20191114003042.85252-1-irogers@google.com>
 <20191114003042.85252-11-irogers@google.com>
 <20191114104340.GT4131@hirez.programming.kicks-ass.net>
 <710edaf6-2562-0f53-15d6-dc50885b8e08@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <710edaf6-2562-0f53-15d6-dc50885b8e08@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2019 at 08:46:51AM -0500, Liang, Kan wrote:
> 
> 
> On 11/14/2019 5:43 AM, Peter Zijlstra wrote:
> > On Wed, Nov 13, 2019 at 04:30:42PM -0800, Ian Rogers wrote:
> > > From: Kan Liang <kan.liang@linux.intel.com>
> > > 
> > > When counting system-wide events and cgroup events simultaneously, the
> > > system-wide events are always scheduled out then back in during cgroup
> > > switches, bringing extra overhead and possibly missing events. Switching
> > > out system wide flexible events may be necessary if the scheduled in
> > > task's cgroups have pinned events that need to be scheduled in at a higher
> > > priority than the system wide flexible events.
> > 
> > I'm thinking this patch is actively broken. groups->index 'group' wide
> > and therefore across cpu/cgroup boundaries.
> > 
> > There is no !cgroup to cgroup hierarchy as this patch seems to assume,
> > specifically look at how the merge sort in visit_groups_merge() allows
> > cgroup events to be picked before !cgroup events.
> 
> 
> No, the patch intends to avoid switch !cgroup during cgroup context switch.

Which is wrong.
