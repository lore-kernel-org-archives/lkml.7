Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE75C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 20:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F2DB206B7
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 20:19:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730754AbfDDUTD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 16:19:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:29839 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729184AbfDDUTD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 16:19:03 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A26D130EBB5A;
        Thu,  4 Apr 2019 20:19:02 +0000 (UTC)
Received: from treble (ovpn-125-158.rdu2.redhat.com [10.10.125.158])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E03D119C4F;
        Thu,  4 Apr 2019 20:18:57 +0000 (UTC)
Date:   Thu, 4 Apr 2019 15:18:55 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     yamada.masahiro@socionext.com, michal.lkml@markovi.net,
        pmladek@suse.com, jikos@kernel.org, joe.lawrence@redhat.com,
        ggherdovich@suse.cz, linux-kbuild@vger.kernel.org,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kbuild: use -flive-patching when CONFIG_LIVEPATCH is
 enabled
Message-ID: <20190404201855.xtvtgxaaomcmowrt@treble>
References: <20190404184411.1392-1-mbenes@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190404184411.1392-1-mbenes@suse.cz>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Thu, 04 Apr 2019 20:19:02 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2019 at 08:44:11PM +0200, Miroslav Benes wrote:
> GCC 9 introduces a new option, -flive-patching. It disables certain
> optimizations which could make a compilation unsafe for later live
> patching of the running kernel.
> 
> The option is used only if CONFIG_LIVEPATCH is enabled and $(CC)
> supports it.
> 
> Performance impact of the option was measured on three different
> Intel machines - two bigger NUMA boxes and one smaller UMA box. Kernel
> intensive (IO, scheduling, networking) benchmarks were selected, plus a
> set of HPC workloads from NAS Parallel Benchmark. The tests were done on
> upstream kernel 5.0-rc8 with openSUSE Leap 15.0 userspace.
> 
> The majority of the tests is unaffected. The only significant exception
> is the scheduler section which suffers 1-3% degradation.
> 
> Evaluated-by: Giovanni Gherdovich <ggherdovich@suse.cz>
> Signed-off-by: Miroslav Benes <mbenes@suse.cz>
> ---
> The patch is based on master branch of the livepatching tree on
> git.kernel.org.
> 
> Many thanks to Giovanni who ran the whole testing campaign and analyzed
> the results. I archived the dashboard and detailed data. If anyone is
> interested, we could probably set up a public website somewhere.

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

While we're on the subject, I'm glad to see ongoing activity on
klp-convert (though I haven't had a chance to follow the discussions).
What's the status of the rest of the needed bits?

- kgraft-analysis-tool - will this also be submitted for inclusion in
  the kernel tree?

- Documentation about how to create a patch

- The other bits I think Nicolai has been working on to eliminate all
  the manual steps

-- 
Josh
