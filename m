Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 282CDECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 13:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03E7020640
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 13:13:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394357AbfJQNNb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 09:13:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60994 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726898AbfJQNNb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 09:13:31 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ECED13082E72;
        Thu, 17 Oct 2019 13:13:30 +0000 (UTC)
Received: from sandy.ghostprotocols.net (ovpn-112-30.phx2.redhat.com [10.3.112.30])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 339C95D6C8;
        Thu, 17 Oct 2019 13:13:28 +0000 (UTC)
Received: by sandy.ghostprotocols.net (Postfix, from userid 1000)
        id 8697D11E4; Thu, 17 Oct 2019 10:13:25 -0300 (BRT)
Date:   Thu, 17 Oct 2019 10:13:25 -0300
From:   Arnaldo Carvalho de Melo <acme@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-tip-commits@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Luis =?iso-8859-1?Q?Cl=E1udio_Gon=E7alves?= <lclaudio@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [tip: perf/core] perf trace: Introduce --filter for tracepoint
 events
Message-ID: <20191017131325.GB3437@redhat.com>
References: <tip-95bfe5d4tzy5f66bx49d05rj@git.kernel.org>
 <157111750352.12254.17113253973879925388.tip-bot2@tip-bot2>
 <20191017071205.GA14441@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017071205.GA14441@zn.tnic>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Thu, 17 Oct 2019 13:13:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Oct 17, 2019 at 09:12:05AM +0200, Borislav Petkov escreveu:
> On Tue, Oct 15, 2019 at 05:31:43AM -0000, tip-bot2 for Arnaldo Carvalho de Melo wrote:
> > The following commit has been merged into the perf/core branch of tip:

> > Commit-ID:     d4097f1937f2242d0aa0a7c654d2159a6895e5c8
> > Gitweb:        https://git.kernel.org/tip/d4097f1937f2242d0aa0a7c654d2159a6895e5c8
> > Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
> > AuthorDate:    Tue, 08 Oct 2019 07:33:08 -03:00
> > Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
> > CommitterDate: Wed, 09 Oct 2019 11:23:52 -03:00

> > perf trace: Introduce --filter for tracepoint events

> > Similar to what is in 'perf record', works just like there:

> >   # perf trace -e msr:*
> >    328.297 :0/0 msr:write_msr(msr: FS_BASE, val: 140240388381888)
> >    328.302 :0/0 msr:write_msr(msr: FS_BASE, val: 140240388381888)
> >    328.306 :0/0 msr:write_msr(msr: FS_BASE, val: 140240388381888)
> >    328.317 :0/0 msr:write_msr(msr: FS_BASE, val: 140240388381888)
> >    328.322 :0/0 msr:write_msr(msr: FS_BASE, val: 140240388381888)
> >    328.327 :0/0 msr:write_msr(msr: FS_BASE, val: 140240388381888)
> >    328.331 :0/0 msr:write_msr(msr: FS_BASE, val: 140240388381888)
> >    328.336 :0/0 msr:write_msr(msr: FS_BASE, val: 140240388381888)
> >    328.340 :0/0 ^Cmsr:write_msr(msr: FS_BASE, val: 140240388381888)
 
> I wonder if you guys can force this val:'s format to be always hex?
> Because MSR values are a lot more "natural" in hex...

Sure, I'll get there, for now its just setting scnprintf/strtoul helpers
based on tracepoint argument name and/or type.

But just like for syscalls, we'll get to have a way to specify that
'val', specifically for msr:write_msr, or sometimes, for the tracepoint
system part ('msr' in this case) should be formatted in some way.

For syscalls there is even provision for some args to be formmated based
on the value present in another arg, think ioctls, all this is being
refitted to support tracepoints other than the syscall ones.

The 'msr' one was the super low hanging fruit, we look just at its name,
no checks on what tracepoint it is, and we were investigating some stuff
at Red Hat and Marcelo said it was a PITA to be doing the lookups in
msr-index.h everytime he needed for look for those in traces, so came
first. :-)

- Arnaldo
