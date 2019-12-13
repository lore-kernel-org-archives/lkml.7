Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F295BC4BA2C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32AAF2470A
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:39:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbfLMQdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 11:33:36 -0500
Received: from smtprelay0038.hostedemail.com ([216.40.44.38]:39117 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727480AbfLMQdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 11:33:35 -0500
X-Greylist: delayed 367 seconds by postgrey-1.27 at vger.kernel.org; Fri, 13 Dec 2019 11:33:34 EST
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave03.hostedemail.com (Postfix) with ESMTP id 8CD3F180458E1;
        Fri, 13 Dec 2019 16:27:27 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 78640101297A2;
        Fri, 13 Dec 2019 16:27:26 +0000 (UTC)
X-Session-Marker: 6E657665747340676F6F646D69732E6F7267
X-HE-Tag: sand41_40a358540413f
X-Filterd-Recvd-Size: 3128
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (Authenticated sender: nevets@goodmis.org)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Fri, 13 Dec 2019 16:27:24 +0000 (UTC)
Date:   Fri, 13 Dec 2019 11:25:00 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
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
Message-ID: <20191213112438.773dff35@gandalf.local.home>
In-Reply-To: <20191213153553.GE20583@krava>
References: <20191213153553.GE20583@krava>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Dec 2019 16:35:53 +0100
Jiri Olsa <jolsa@redhat.com> wrote:

> I don't think dedup algorithm can handle this and I'm not sure if there's
> some way in pahole to detect/prevent this.
> 
> I only found that if I rename the ring_buffer objects to have distinct
> names, it will help:
> 
>   $ bpftool btf dump file /sys/kernel/btf/vmlinux | grep task_struct
>   [150] STRUCT 'task_struct' size=11008 vlen=205
> 
>   $ bpftool btf dump file /sys/kernel/btf/vmlinux | grep "STRUCT 'perf_event'"
>   [1665] STRUCT 'perf_event' size=1160 vlen=70
> 
> also the BTF data get smaller ;-) before:
> 
>   $ ll /sys/kernel/btf/vmlinux
>   -r--r--r--. 1 root root 2067432 Dec 13 22:56 /sys/kernel/btf/vmlinux
> 
> after:
>   $ ll /sys/kernel/btf/vmlinux
>   -r--r--r--. 1 root root 1984345 Dec 13 23:02 /sys/kernel/btf/vmlinux
> 
> 
> Peter, Steven,
> if above is correct and there's no other better solution, would it be possible
> to straighten up the namespace and user some distinct names for perf and ftrace
> ring buffers?

Now, the ring buffer that ftrace uses is not specific for ftrace or
even tracing for that matter. It is a stand alone ring buffer (oprofile
uses it), and can be used by anyone else.

As the perf ring buffer is very coupled with perf (or perf events), and
unless something changed, I was never able to pull the perf ring
buffer out as a stand alone ring buffer.

As the ring buffer in the tracing directory is more generic, and not to
mention around longer, if one is to change the name, I would suggest it
be the perf ring buffer.

-- Steve
