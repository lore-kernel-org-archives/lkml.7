Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84104C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 07:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 529622083E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 07:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbfDIHgK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 03:36:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:39446 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726001AbfDIHgJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 03:36:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 37874B02C;
        Tue,  9 Apr 2019 07:36:08 +0000 (UTC)
Date:   Tue, 9 Apr 2019 09:36:07 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Miroslav Benes <mbenes@suse.cz>, yamada.masahiro@socionext.com,
        michal.lkml@markovi.net, jikos@kernel.org, joe.lawrence@redhat.com,
        ggherdovich@suse.cz, linux-kbuild@vger.kernel.org,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kbuild: use -flive-patching when CONFIG_LIVEPATCH is
 enabled
Message-ID: <20190409073607.ms4amehc23quaio3@pathway.suse.cz>
References: <20190404184411.1392-1-mbenes@suse.cz>
 <20190404201855.xtvtgxaaomcmowrt@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190404201855.xtvtgxaaomcmowrt@treble>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2019-04-04 15:18:55, Josh Poimboeuf wrote:
> On Thu, Apr 04, 2019 at 08:44:11PM +0200, Miroslav Benes wrote:
> > GCC 9 introduces a new option, -flive-patching. It disables certain
> > optimizations which could make a compilation unsafe for later live
> > patching of the running kernel.
> > 
> > The option is used only if CONFIG_LIVEPATCH is enabled and $(CC)
> > supports it.
> > 
> > Performance impact of the option was measured on three different
> > Intel machines - two bigger NUMA boxes and one smaller UMA box. Kernel
> > intensive (IO, scheduling, networking) benchmarks were selected, plus a
> > set of HPC workloads from NAS Parallel Benchmark. The tests were done on
> > upstream kernel 5.0-rc8 with openSUSE Leap 15.0 userspace.
> > 
> > The majority of the tests is unaffected. The only significant exception
> > is the scheduler section which suffers 1-3% degradation.
> > 
> > Evaluated-by: Giovanni Gherdovich <ggherdovich@suse.cz>
> > Signed-off-by: Miroslav Benes <mbenes@suse.cz>
> > ---
> > The patch is based on master branch of the livepatching tree on
> > git.kernel.org.
> > 
> > Many thanks to Giovanni who ran the whole testing campaign and analyzed
> > the results. I archived the dashboard and detailed data. If anyone is
> > interested, we could probably set up a public website somewhere.
> 
> Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

I have committed the patch into the branch for-5.2/core.

Best Regards,
Petr
