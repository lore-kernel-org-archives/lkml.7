Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 737E6C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 19:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BB2121897
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 19:31:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbfH3TbP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 15:31:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48090 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727304AbfH3TbN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 15:31:13 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9139C308218D;
        Fri, 30 Aug 2019 19:31:13 +0000 (UTC)
Received: from treble (ovpn-123-26.rdu2.redhat.com [10.10.123.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 068A15C1D4;
        Fri, 30 Aug 2019 19:31:10 +0000 (UTC)
Date:   Fri, 30 Aug 2019 14:31:09 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 0/4] objtool,perf: Use shared x86 insn decoder
Message-ID: <20190830193109.p7jagidsrahoa4pn@treble>
References: <cover.1567118001.git.jpoimboe@redhat.com>
 <20190830184020.GG28011@kernel.org>
 <20190830190058.GH28011@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190830190058.GH28011@kernel.org>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Fri, 30 Aug 2019 19:31:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 04:00:58PM -0300, Arnaldo Carvalho de Melo wrote:
> I.e. we need to make sure that it always gets the x86 stuff, not
> something that is tied to the host arch, with the patch below we get it
> to work, please take a look.
> 
> Probably this should go to the master copy, i.e. to the kernel sources,
> no?
> 
> That or we'll have to ask the check-headers.sh and objtool sync-check
> (hey, this should be unified, each project could provide just the list
> of things it uses, but I digress) to ignore those lines...
> 
> I.e. we want to decode intel_PT traces on other arches, ditto for
> CoreSight (not affected here, but similar concept).
> 
> will kick the full container build process now.

Interesting, I didn't realize other arches would be using it.  The patch
looks good to me.

Ideally there wouldn't be any differences between the headers, but if
that's unavoidable then I guess we can just use the same 'diff -I' trick
we were using before in the check script(s).

-- 
Josh
