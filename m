Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E3B1CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 12:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 429D321D7B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 12:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572006999;
	bh=1/5YHQsc66zmvjaX31kfgULr4Oo/gRl4TrpUnyLQbaw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Wa1fqiQGBmFbzTR+iBN6a2nxhJDWB0rkGCOyhF5e3KQHXqaYgx1sVXemk7qpvDuVx
	 T7k65uV61Dv6qPBPPr5HVtjxgL/eZ9+mI5JvjTazG4bTPpUx1o7mxBujiCvpZUAh23
	 e75Tyu1CwpHJY4enpv/iBx/OC37ZMeTdkJ5qcHQ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440271AbfJYMgi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 08:36:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:43066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726497AbfJYMgh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 08:36:37 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47B3621D71;
        Fri, 25 Oct 2019 12:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572006997;
        bh=1/5YHQsc66zmvjaX31kfgULr4Oo/gRl4TrpUnyLQbaw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=l41oh5ljOHQdCIQIKsWnO0H6yP+2lD8S9+YXMYs9lUKX5Rdxl0U0lH0QzZIZm0RLP
         Glg3J00eyn7XfcY9K8qDXGJN3bAfbVUCtpMyuYkAOxkwdJCsvgZ/q315UmDH7/pbbd
         ukcycuHQI8EUwdU/9EYgi+x29GfrVEnNSdtqfd80=
Date:   Fri, 25 Oct 2019 21:36:33 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [BUGFIX PATCH 1/6] perf/probe: Fix wrong address verification
Message-Id: <20191025213633.b1227d0721b97edc8e8f9335@kernel.org>
In-Reply-To: <20191025121448.GC23511@kernel.org>
References: <157199317547.8075.1010940983970397945.stgit@devnote2>
        <157199318513.8075.10463906803299647907.stgit@devnote2>
        <20191025121448.GC23511@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 25 Oct 2019 09:14:48 -0300
Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Em Fri, Oct 25, 2019 at 05:46:25PM +0900, Masami Hiramatsu escreveu:
> > Since there are some DIE which has only ranges instead of the
> > combination of entrypc/highpc, address verification must use
> > dwarf_haspc() instead of dwarf_entrypc/dwarf_highpc.
> > 
> > Also, the ranges only DIE will have a partial code in different
> > section (e.g. unlikely code will be in text.unlikely as "FUNC.cold"
> > symbol). In that case, we can not use dwarf_entrypc() or
> > die_entrypc(), because the offset from original DIE can be
> > a minus value.
> > 
> > Instead, this simply gets the symbol and offset from symtab.
> > 
> > Without this patch;
> >   # tools/perf/perf probe -D clear_tasks_mm_cpumask:1
> >   Failed to get entry address of clear_tasks_mm_cpumask
> >     Error: Failed to add events.
> > 
> > And with this patch
> >   # tools/perf/perf probe -D clear_tasks_mm_cpumask:1
> >   p:probe/clear_tasks_mm_cpumask clear_tasks_mm_cpumask+0
> >   p:probe/clear_tasks_mm_cpumask_1 clear_tasks_mm_cpumask+5
> >   p:probe/clear_tasks_mm_cpumask_2 clear_tasks_mm_cpumask+8
> >   p:probe/clear_tasks_mm_cpumask_3 clear_tasks_mm_cpumask+16
> >   p:probe/clear_tasks_mm_cpumask_4 clear_tasks_mm_cpumask+82
> 
> Ok, so this just asks for the definition, but doesn't try to actually
> _use_ it, which I did and it fails:
> 
> [root@quaco tracebuffer]# perf probe -D clear_tasks_mm_cpumask:1
> p:probe/clear_tasks_mm_cpumask _text+919968
> p:probe/clear_tasks_mm_cpumask_1 _text+919973
> p:probe/clear_tasks_mm_cpumask_2 _text+919976
> [root@quaco tracebuffer]#
> [root@quaco tracebuffer]# perf probe clear_tasks_mm_cpumask
> Probe point 'clear_tasks_mm_cpumask' not found.
>   Error: Failed to add events.
> [root@quaco tracebuffer]#
> 
> So I'll tentatively continue to apply the other patches in this series,
> maybe one of them will fix this.

Yes, it should be fixed by [2/6] :)

Actually, a probe point with offset line and no-offset are handled
a bit differently.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
