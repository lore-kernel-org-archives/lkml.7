Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54428C4741C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9271724765
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:40:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728600AbfLMSnk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 13:43:40 -0500
Received: from smtprelay0166.hostedemail.com ([216.40.44.166]:35700 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728473AbfLMSnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 13:43:40 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 39AD7182CED28;
        Fri, 13 Dec 2019 18:43:38 +0000 (UTC)
X-Session-Marker: 6E657665747340676F6F646D69732E6F7267
X-HE-Tag: flame51_59855085f2047
X-Filterd-Recvd-Size: 2377
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (Authenticated sender: nevets@goodmis.org)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Fri, 13 Dec 2019 18:43:35 +0000 (UTC)
Date:   Fri, 13 Dec 2019 13:43:33 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNl?= =?UTF-8?B?bg==?= 
        <toke@redhat.com>, Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Quentin Monnet <quentin.monnet@netronome.com>
Subject: Re: [RFC] btf: Some structs are doubled because of struct
 ring_buffer
Message-ID: <20191213134333.19335555@gandalf.local.home>
In-Reply-To: <20191213183646.GB8994@krava>
References: <20191213153553.GE20583@krava>
        <20191213112438.773dff35@gandalf.local.home>
        <20191213165155.vimm27wo7brkh3yu@ast-mbp.dhcp.thefacebook.com>
        <20191213121118.236f55b8@gandalf.local.home>
        <20191213180223.GE2844@hirez.programming.kicks-ass.net>
        <20191213132941.6fa2d1bd@gandalf.local.home>
        <20191213183646.GB8994@krava>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Dec 2019 19:36:46 +0100
Jiri Olsa <jolsa@redhat.com> wrote:

> > Thinking about this, perhaps we should remove the word "ring" from
> > both. That is:
> > 
> >   perf_buffer and trace_buffer ?  
> 
> sounds good to me.. and too good to be true ;-)
> please let me know if I should send the perf change

Note, changing the other one is a lot more invasive. It's not as easy
as I thought. I forgot that even blktrace uses it. And a lot of the
trace event code is tied to the ring buffer code, as well as every
tracer.

-- Steve
