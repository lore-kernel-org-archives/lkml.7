Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C755CC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 14:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A14E1217D8
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 14:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbfEUOe4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 10:34:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52452 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726900AbfEUOe4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 10:34:56 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EA2627EBC1;
        Tue, 21 May 2019 14:34:50 +0000 (UTC)
Received: from Diego (unknown [10.43.2.54])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CAC371001F5B;
        Tue, 21 May 2019 14:34:48 +0000 (UTC)
Date:   Tue, 21 May 2019 16:34:47 +0200 (CEST)
From:   Michael Petlan <mpetlan@redhat.com>
X-X-Sender: Michael@Diego
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
cc:     Vitaly Chikunov <vt@altlinux.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Kim Phillips <kim.phillips@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: Re: [PATCH] perf arm64: Fix mksyscalltbl when system kernel headers
 are ahead of the kernel
In-Reply-To: <20190521132838.GB26253@kernel.org>
Message-ID: <alpine.LRH.2.20.1905211632300.4243@Diego>
References: <20190521030203.1447-1-vt@altlinux.org> <20190521132838.GB26253@kernel.org>
User-Agent: Alpine 2.20 (LRH 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 21 May 2019 14:34:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 May 2019, Arnaldo Carvalho de Melo wrote:
> Em Tue, May 21, 2019 at 06:02:03AM +0300, Vitaly Chikunov escreveu:
> > When a host system has kernel headers that are newer than a compiling
> > kernel, mksyscalltbl fails with errors such as:
> > 
> >   <stdin>: In function 'main':
> >   <stdin>:271:44: error: '__NR_kexec_file_load' undeclared (first use in this function)
> >   <stdin>:271:44: note: each undeclared identifier is reported only once for each function it appears in
> >   <stdin>:272:46: error: '__NR_pidfd_send_signal' undeclared (first use in this function)
> >   <stdin>:273:43: error: '__NR_io_uring_setup' undeclared (first use in this function)
> >   <stdin>:274:43: error: '__NR_io_uring_enter' undeclared (first use in this function)
> >   <stdin>:275:46: error: '__NR_io_uring_register' undeclared (first use in this function)
> >   tools/perf/arch/arm64/entry/syscalls//mksyscalltbl: line 48: /tmp/create-table-xvUQdD: Permission denied
> > 
> > mksyscalltbl is compiled with default host includes, but run with
> 
> It shouldn't :-\ So with this you're making it use the ones shipped in
> tools/include? Good, I'll test it, thanks!
> 
> - Arnaldo
> 

I've hit the issue too, this patch fixes it for me.
Tested.

Michael

> > compiling kernel tree includes, causing some syscall numbers being
> > undeclared.
> > 
> > Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> > Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> > Cc: Hendrik Brueckner <brueckner@linux.ibm.com>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Jiri Olsa <jolsa@redhat.com>
> > Cc: Kim Phillips <kim.phillips@arm.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
> > ---
> >  tools/perf/arch/arm64/entry/syscalls/mksyscalltbl | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl b/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl
> > index c88fd32563eb..459469b7222c 100755
> > --- a/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl
> > +++ b/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl
> > @@ -56,7 +56,7 @@ create_table()
> >  	echo "};"
> >  }
> >  
> > -$gcc -E -dM -x c  $input	       \
> > +$gcc -E -dM -x c -I $incpath/include/uapi $input \
> >  	|sed -ne 's/^#define __NR_//p' \
> >  	|sort -t' ' -k2 -nu	       \
> >  	|create_table
> > -- 
> > 2.11.0
> 
> -- 
> 
> - Arnaldo
> 
