Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E53C79DC7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BE15246B3
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbfLMRLY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 12:11:24 -0500
Received: from smtprelay0083.hostedemail.com ([216.40.44.83]:39806 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728402AbfLMRLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 12:11:24 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 4089818028E83;
        Fri, 13 Dec 2019 17:11:22 +0000 (UTC)
X-Session-Marker: 6E657665747340676F6F646D69732E6F7267
X-HE-Tag: day62_ba205330f24c
X-Filterd-Recvd-Size: 2291
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (Authenticated sender: nevets@goodmis.org)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Fri, 13 Dec 2019 17:11:19 +0000 (UTC)
Date:   Fri, 13 Dec 2019 12:11:18 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
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
Message-ID: <20191213121118.236f55b8@gandalf.local.home>
In-Reply-To: <20191213165155.vimm27wo7brkh3yu@ast-mbp.dhcp.thefacebook.com>
References: <20191213153553.GE20583@krava>
        <20191213112438.773dff35@gandalf.local.home>
        <20191213165155.vimm27wo7brkh3yu@ast-mbp.dhcp.thefacebook.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Dec 2019 08:51:57 -0800
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> It had two choices. Both valid. I don't know why gdb picked this one.
> So yeah I think renaming 'ring_buffer' either in ftrace or in perf would be
> good. I think renaming ftrace one would be better, since gdb picked perf one
> for whatever reason.

Because of the sort algorithm. But from a technical perspective, the
ring buffer that ftrace uses is generic, where the perf ring buffer can
only be used for perf. Call it "event_ring_buffer" or whatever, but
it's not generic and should not have a generic name.

-- Steve
