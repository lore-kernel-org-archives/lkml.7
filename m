Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F09C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 18:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B52F2080F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 18:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405451AbfITSoj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 14:44:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53498 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404617AbfITSoi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 14:44:38 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BE87C307CDFC;
        Fri, 20 Sep 2019 18:44:38 +0000 (UTC)
Received: from krava (ovpn-204-62.brq.redhat.com [10.40.204.62])
        by smtp.corp.redhat.com (Postfix) with SMTP id DD0B060606;
        Fri, 20 Sep 2019 18:44:35 +0000 (UTC)
Date:   Fri, 20 Sep 2019 20:44:33 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH] perf tools: Fix segfault in cpu_cache_level__read
Message-ID: <20190920184433.GB26850@krava>
References: <20190912105235.10689-1-jolsa@kernel.org>
 <20190920182026.GA4865@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190920182026.GA4865@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Fri, 20 Sep 2019 18:44:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 03:20:26PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, Sep 12, 2019 at 12:52:35PM +0200, Jiri Olsa escreveu:
> > We release wrong pointer on error path in
> > cpu_cache_level__read function, leading to
> > segfault:
> > 
> >   (gdb) r record ls
> >   Starting program: /root/perf/tools/perf/perf record ls
> >   ...
> >   [ perf record: Woken up 1 times to write data ]
> >   double free or corruption (out)
> > 
> >   Thread 1 "perf" received signal SIGABRT, Aborted.
> >   0x00007ffff7463798 in raise () from /lib64/power9/libc.so.6
> >   (gdb) bt
> >   #0  0x00007ffff7463798 in raise () from /lib64/power9/libc.so.6
> >   #1  0x00007ffff7443bac in abort () from /lib64/power9/libc.so.6
> >   #2  0x00007ffff74af8bc in __libc_message () from /lib64/power9/libc.so.6
> >   #3  0x00007ffff74b92b8 in malloc_printerr () from /lib64/power9/libc.so.6
> >   #4  0x00007ffff74bb874 in _int_free () from /lib64/power9/libc.so.6
> >   #5  0x0000000010271260 in __zfree (ptr=0x7fffffffa0b0) at ../../lib/zalloc..
> >   #6  0x0000000010139340 in cpu_cache_level__read (cache=0x7fffffffa090, cac..
> >   #7  0x0000000010143c90 in build_caches (cntp=0x7fffffffa118, size=<optimiz..
> >   ...
> > 
> > Releasing the proper pointer.
> 
> You forgot to add:
> 
> Fixes: 720e98b5faf1 ("perf tools: Add perf data cache feature")
> Cc: stable@vger.kernel.org: # v4.6+
> 
> I did it, please consider doing it next time,

will do, sry

jirka
