Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0AFFC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 16:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE31B20850
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 16:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732397AbfHZQ6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 12:58:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44248 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727815AbfHZQ6z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 12:58:55 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 205EC307D915;
        Mon, 26 Aug 2019 16:58:55 +0000 (UTC)
Received: from krava (ovpn-204-96.brq.redhat.com [10.40.204.96])
        by smtp.corp.redhat.com (Postfix) with SMTP id 092C860BEC;
        Mon, 26 Aug 2019 16:58:52 +0000 (UTC)
Date:   Mon, 26 Aug 2019 18:58:52 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH 00/12] libperf: Add events to perf/event.h
Message-ID: <20190826165852.GC8926@krava>
References: <20190825181752.722-1-jolsa@kernel.org>
 <20190826160627.GE24801@kernel.org>
 <20190826161849.GF24801@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826161849.GF24801@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Mon, 26 Aug 2019 16:58:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2019 at 01:18:49PM -0300, Arnaldo Carvalho de Melo wrote:

SNIP

> [perfbuilder@490c2c7bdaab ~]$ grep 'printf("lost' /tmp/build/perf/builtin-sched.i
>  printf("lost %" "l" "ll""u" " events on cpu %d\n", event->lost.lost, sample->cpu);
> [perfbuilder@490c2c7bdaab ~]$
> 
> And if we do this on a fedora:30 x86_64:
> 
> $ make -C tools/perf O=/tmp/build/perf /tmp/build/perf/builtin-sched.i
> [acme@quaco perf]$ grep -A4 'printf("lost' /tmp/build/perf/builtin-sched.i
>  printf("lost %" "l" 
> # 2646 "builtin-sched.c" 3 4
>                 "l" "u" 
> # 2646 "builtin-sched.c"
>                          " events on cpu %d\n", event->lost.lost, sample->cpu);
> [acme@quaco perf]$
> 
> I.e. on 32-bit arches we shouldn't add that extra "l", right?

hum, I guess we could #ifdef it 64/32 bits

> 
> I bet the build for the mips/mipsel will fail too, lemme see... Yeah,
> both failed:
> 
> 
> [root@quaco ~]# grep -m1 -A6 -- -Werror=format=  dm.log/debian\:experimental-x-mips
> builtin-sched.c:2646:9: error: unknown conversion type character 'l' in format [-Werror=format=]
>   printf("lost %" PRI_lu64 " events on cpu %d\n", event->lost.lost, sample->cpu);
>          ^~~~~~~~
> In file included from builtin-sched.c:31:
> /usr/mips-linux-gnu/include/inttypes.h:47:28: note: format string is defined here
>  #  define __PRI64_PREFIX "ll"
>                             ^
> [root@quaco ~]#
> 
> [root@quaco ~]# grep -m1 -A6 -- -Werror=format=  dm.log/debian\:experimental-x-mipsel
> builtin-sched.c:2646:9: error: unknown conversion type character 'l' in format [-Werror=format=]
>   printf("lost %" PRI_lu64 " events on cpu %d\n", event->lost.lost, sample->cpu);
>          ^~~~~~~~
> In file included from builtin-sched.c:31:
> /usr/mipsel-linux-gnu/include/inttypes.h:47:28: note: format string is defined here
>  #  define __PRI64_PREFIX "ll"
>                             ^
> [root@quaco ~]#
> 
> And also on a uclibc ARC arch container:
> 
> [root@quaco ~]# grep -m1 -A6 -- -Werror=format=  dm.log/fedora\:24-x-ARC-uClibc
> builtin-sched.c:2646:9: error: unknown conversion type character 'l' in format [-Werror=format=]
>   printf("lost %" PRI_lu64 " events on cpu %d\n", event->lost.lost, sample->cpu);
>          ^~~~~~~~
> In file included from builtin-sched.c:31:0:
> /arc_gnu_2017.09-rc2_prebuilt_uclibc_le_arc700_linux_install/arc-snps-linux-uclibc/sysroot/usr/include/inttypes.h:47:28: note: format string is defined here
>  #  define __PRI64_PREFIX "ll"
>                             ^
> [root@quaco ~]#
> 
> The _fix_ will come after lunch :)

thanks ;-)

jirka
