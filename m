Return-Path: <SRS0=Y9JJ=T2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD65C282E3
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 13:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB7572075E
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 13:11:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbfEZNJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 May 2019 09:09:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56648 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727708AbfEZNJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 09:09:58 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1AE852DD43;
        Sun, 26 May 2019 13:09:58 +0000 (UTC)
Received: from krava (ovpn-204-45.brq.redhat.com [10.40.204.45])
        by smtp.corp.redhat.com (Postfix) with SMTP id 68F435C221;
        Sun, 26 May 2019 13:09:55 +0000 (UTC)
Date:   Sun, 26 May 2019 15:09:54 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Stanislav Fomichev <sdf@fomichev.me>,
        Song Liu <songliubraving@fb.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 05/12] perf tools: Read also the end of the kernel
Message-ID: <20190526130954.GA16567@krava>
References: <20190508132010.14512-1-jolsa@kernel.org>
 <20190508132010.14512-6-jolsa@kernel.org>
 <20190524181506.GE17479@kernel.org>
 <20190524181717.GF17479@kernel.org>
 <20190524184607.GG17479@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524184607.GG17479@kernel.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Sun, 26 May 2019 13:09:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 03:46:07PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Fri, May 24, 2019 at 03:17:17PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Fri, May 24, 2019 at 03:15:06PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > Em Wed, May 08, 2019 at 03:20:03PM +0200, Jiri Olsa escreveu:
> > > > We mark the end of kernel based on the first module,
> > > > but that could cover some bpf program maps. Reading
> > > > _etext symbol if it's present to get precise kernel
> > > > map end.
> > > 
> > > Investigating... Have you run 'perf test' before hitting the send
> > > button? :-)
> > 
> > <SNIP>
> > 
> > > [root@quaco c]# perf test -v 1
> > >  1: vmlinux symtab matches kallsyms                       :
> > <SNIP>
> > > --- start ---
> > > ERR : 0xffffffff8cc00e41: __indirect_thunk_end not on kallsyms
> > <SNIP>
> > > test child finished with -1
> > > ---- end ----
> > > vmlinux symtab matches kallsyms: FAILED!
> > > [root@quaco c]#
> > 
> > So...
> > 
> > [root@quaco c]# grep __indirect_thunk_end /proc/kallsyms
> > ffffffff8cc00e41 T __indirect_thunk_end
> > [root@quaco c]# grep -w _etext /proc/kallsyms
> > ffffffff8cc00e41 T _etext
> > [root@quaco c]#
> > 
> > [root@quaco c]# grep -w ffffffff8cc00e41 /proc/kallsyms
> > ffffffff8cc00e41 T _etext
> > ffffffff8cc00e41 T __indirect_thunk_end
> > [root@quaco c]#
> > 
> > Lemme try to fix this.
> 
> So, I got this right before your patch:
> 
> commit 1d1c54c5bbf55256e691bedb47b0d14745043e80
> Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> Date:   Fri May 24 15:39:00 2019 -0300
> 
>     perf test vmlinux-kallsyms: Ignore aliases to _etext when searching on kallsyms
>     
>     No need to search for aliases for the symbol that marks the end of the
>     kernel text segment, the following patch will make such symbols not to
>     be found when searching in the kallsyms maps causing this test to fail.
>     
>     So as a prep patch to avoid breaking bisection, ignore such symbols.
>     
>     Cc: Adrian Hunter <adrian.hunter@intel.com>
>     Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>     Cc: Andi Kleen <ak@linux.intel.com>
>     Cc: Jiri Olsa <jolsa@kernel.org>
>     Cc: Namhyung Kim <namhyung@kernel.org>
>     Cc: Peter Zijlstra <peterz@infradead.org>
>     Cc: Song Liu <songliubraving@fb.com>
>     Cc: Stanislav Fomichev <sdf@google.com>
>     Cc: Thomas Richter <tmricht@linux.ibm.com>
>     Link: https://lkml.kernel.org/n/tip-qfwuih8cvmk9doh7k5k244eq@git.kernel.org
>     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

works for me

Tested-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka
