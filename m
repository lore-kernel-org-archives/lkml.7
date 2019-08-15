Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DAE2C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 14:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FE36206C2
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 14:10:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732757AbfHOOKj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 10:10:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53668 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729918AbfHOOKj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 10:10:39 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7F621300146E;
        Thu, 15 Aug 2019 14:10:38 +0000 (UTC)
Received: from krava (unknown [10.43.17.33])
        by smtp.corp.redhat.com (Postfix) with SMTP id 69B1C43FCD;
        Thu, 15 Aug 2019 14:10:36 +0000 (UTC)
Date:   Thu, 15 Aug 2019 16:10:35 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     John Keeping <john@metanate.com>
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] perf unwind: fix libunwind when tid != pid
Message-ID: <20190815141035.GJ30356@krava>
References: <20190804124434.204da4ac.john@metanate.com>
 <20190815100146.28842-1-john@metanate.com>
 <20190815100146.28842-2-john@metanate.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815100146.28842-2-john@metanate.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Thu, 15 Aug 2019 14:10:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 11:01:45AM +0100, John Keeping wrote:
> Commit e5adfc3e7e77 ("perf map: Synthesize maps only for thread group
> leader") changed the recording side so that we no longer get mmap events
> for threads other than the thread group leader (when synthesising these
> events for threads which exist before perf is started).
> 
> When a file recorded after this change is loaded, the lack of mmap
> records mean that unwinding is not set up for any other threads.
> 
> This can be seen in a simple record/report scenario:
> 
> 	perf record --call-graph=dwarf -t $TID
> 	perf report
> 
> If $TID is a process ID then the report will show call graphs, but if
> $TID is a secondary thread the output is as if --call-graph=none was
> specified.

great, mucch clearler now

> 
> Following the rationale in that commit, move the libunwind fields into
> struct map_groups and update the libunwind functions to take this
> instead of the struct thread.  This is only required for
> unwind__finish_access which must now be called from map_groups__delete
> and the others are changed for symmetry.
> 
> Note that unwind__get_entries keeps the thread argument since it is
> required for symbol lookup and the libdw unwind provider uses the thread
> ID.
> 
> Fixes: e5adfc3e7e77 ("perf map: Synthesize maps only for thread group leader")

for all 3 patches

Reviewed-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka
