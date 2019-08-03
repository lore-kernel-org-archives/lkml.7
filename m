Return-Path: <SRS0=Iotr=V7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A03FEC31E40
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 08:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70D2D21783
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 08:45:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387757AbfHCIpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Aug 2019 04:45:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59030 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387692AbfHCIpX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 04:45:23 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EA437308C38B;
        Sat,  3 Aug 2019 08:45:22 +0000 (UTC)
Received: from krava (ovpn-204-59.brq.redhat.com [10.40.204.59])
        by smtp.corp.redhat.com (Postfix) with SMTP id DFB4D60922;
        Sat,  3 Aug 2019 08:45:21 +0000 (UTC)
Date:   Sat, 3 Aug 2019 10:45:20 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Stephane Eranian <eranian@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [BUG] perf report: segfault with --no-group in pipe mode
Message-ID: <20190803084520.GA1008@krava>
References: <CABPqkBQtnYM6E2F3JiZ2A5z8iR+MvxM5DH4L6KyAeSaBfnGEPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPqkBQtnYM6E2F3JiZ2A5z8iR+MvxM5DH4L6KyAeSaBfnGEPw@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Sat, 03 Aug 2019 08:45:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2019 at 09:38:49AM -0700, Stephane Eranian wrote:
> Hi,
> 
> When trying the following command line with perf from tip,git, I got:
> 
> $ perf record --group -c 100000 -e '{branch-misses,branches}' -a -o -
> sleep 1| perf report --no-group -F sample,cpu,period -i -
> # To display the perf.data header info, please use
> --header/--header-only options.
> #
> Segmentation fault (core dumped)
> 
> (gdb) r report --no-group -F sample,cpu,period -i - < tt
> Starting program: /export/hda3/perftest/perf.tip report --no-group -F
> sample,cpu,period -i - < tt
> # To display the perf.data header info, please use
> --header/--header-only options.
> #
> 
> Program received signal SIGSEGV, Segmentation fault.
> hlist_add_head (h=0xeb9ed8, n=0xebdfd0) at
> /usr/local/google/home/eranian/G/bnw.tip/tools/include/linux/list.h:644
> 644 /usr/local/google/home/eranian/G/bnw.tip/tools/include/linux/list.h:
> No such file or directory.
> (gdb)
> 
> Can you reproduce this?

hi,
looks like it's you might be hitting this one:
  79b2fe5e7561 perf tools: Fix proper buffer size for feature processing

please try Arnaldo's perf/urgent, it's in there

jirka
