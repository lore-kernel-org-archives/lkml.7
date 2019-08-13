Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3FC3C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 23:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4342206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 23:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="zhHNAd1H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WkqWfPS7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbfHMXHn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 19:07:43 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:60491 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727296AbfHMXHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 19:07:43 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 968163124;
        Tue, 13 Aug 2019 19:07:41 -0400 (EDT)
Received: from imap35 ([10.202.2.85])
  by compute4.internal (MEProxy); Tue, 13 Aug 2019 19:07:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm1; bh=0rrPGmIv2yZu9CW9MwraWkVFugqoPll
        lk+rySKOcBFM=; b=zhHNAd1HDshBQwbLA5HVP2YBTm+J0g26BlivO9trOPUhQjd
        /NHbPA7rbPOa5bfSW5hXGLYuNmgmJYZiXB+dg18UDesAfgo3FFgKuRzusriins+R
        5nTuNaIX4iaaZFzrX6e9vUJfuDmNno+3LxSDjtmLbbF7wdv0eS4wFhFnOQU6anie
        Hgl3RhvnlTKxRjYX8O11YO8WOW9ndiErldQZ+/8PK5ir1iaA8gujLznVH9+761hW
        dYVrNIggrMtHKC8TT9JxRvW1XSW6jvJ6GRsKwwwDzytJshTrmahghaNtM6KiRHqh
        8X4cJdPwr5747TgxksSjnpuAotjd5sQkKv3CDzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=0rrPGm
        Iv2yZu9CW9MwraWkVFugqoPlllk+rySKOcBFM=; b=WkqWfPS7l1daqaFNJ26uIe
        T3tWfnWM/zNPffRZvrhHK7PMSFE6e7qY5lDwdtIlcaqyQJ+0Q9P8kK8Muop24Je/
        DPpqp4vWVt56MDNTeMXZvb6uXN/yn9Z868xaSC9dW2JWPF+V4rlCgjDrLThbGZ8q
        IKfvR3XFq9+P3ZFodizrd7dKBUSXxSzdalcz4UIsv6gaVOveG32skpVp5S5CChJk
        OsQ60wDkqmcS3FFZNe+zbzzMcS8NjC0HtRTTkemxRBAuhsbWsw7IEakyyLFfn7SZ
        y4WXlXZLLvxxBCGNc92AI24PP65DPDeqnNZElTLkTgTqMAAtd2QJy5BDPSnox88w
        ==
X-ME-Sender: <xms:vEJTXe_bLfIgDT1eNgXmtTO4XP8V9IPrMVdS0p2wNUvMdrR7FZVrtw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddruddvjedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlfeehmdenucfjughrpefofgggkfgjfhffhffvufgtsehttdertder
    reejnecuhfhrohhmpedfffgrnhhivghlucgiuhdfuceougiguhesugiguhhuuhdrgiihii
    eqnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiiinecuvehl
    uhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:vUJTXSyM9LbYZiERRHcGZMTzRDTARp0KrSeJfPpdi9cIjMOrXCg6wQ>
    <xmx:vUJTXeuusRsCngPL-Ifhcb8a0jBUH5jLEZCJI3heurmEIN3oRKGrFA>
    <xmx:vUJTXVwy1SS2T-iuAi8I_oqE1CNkrn-RdL_ehzvhr9ikrvU6Mx8S-A>
    <xmx:vUJTXbCiaNp7yfZFTteNq_-zgS1MyMdAvBH4G2LL-JnBs2PbhybZpg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D0A6C14C0062; Tue, 13 Aug 2019 19:07:40 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.6-868-g07f9431-fmstable-20190813v2
Mime-Version: 1.0
Message-Id: <fcb7d142-1f18-4c1d-a9f9-c887b657fe4b@www.fastmail.com>
In-Reply-To: <CAPhsuW43rN1sb5sSShd1PYAQDVz1uHCiXF2nXVkMe8xj42xgpA@mail.gmail.com>
References: <20190809214642.12078-1-dxu@dxuuu.xyz>
 <20190809214642.12078-2-dxu@dxuuu.xyz>
 <CAPhsuW43rN1sb5sSShd1PYAQDVz1uHCiXF2nXVkMe8xj42xgpA@mail.gmail.com>
Date:   Tue, 13 Aug 2019 16:07:40 -0700
From:   "Daniel Xu" <dxu@dxuuu.xyz>
To:     "Song Liu" <liu.song.a23@gmail.com>
Cc:     "Song Liu" <songliubraving@fb.com>, "Yonghong Song" <yhs@fb.com>,
        "Andrii Nakryiko" <andriin@fb.com>, peterz@infraded.org,
        "Ingo Molnar" <mingo@redhat.com>,
        "Arnaldo Carvalho de Melo" <acme@kernel.org>,
        "Alexei Starovoitov" <ast@fb.com>,
        "Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
        "Jiri Olsa" <jolsa@redhat.com>,
        "Namhyung Kim" <namhyung@kernel.org>,
        "open list" <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?Q?Re:_[PATCH_v2_bpf-next_1/4]_tracing/probe:_Add_PERF=5FEVENT=5F?=
 =?UTF-8?Q?IOC=5FQUERY=5FPROBE_ioctl?=
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019, at 2:47 PM, Song Liu wrote:
> On Fri, Aug 9, 2019 at 2:48 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
> >
> > It's useful to know [uk]probe's nmissed and nhit stats. For example with
> > tracing tools, it's important to know when events may have been lost.
> > debugfs currently exposes a control file to get this information, but
> > it is not compatible with probes registered with the perf API.
> >
> > While bpf programs may be able to manually count nhit, there is no way
> > to gather nmissed. In other words, it is currently not possible to
> > retrieve information about FD-based probes.
> >
> > This patch adds a new ioctl that lets users query nmissed (as well as
> > nhit for completeness). We currently only add support for [uk]probes
> > but leave the possibility open for other probes like tracepoint.
> >
> > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> > ---
> [...]
> 
> > +int perf_uprobe_event_query(struct perf_event *event, void __user *info)
> > +{
> > +       struct perf_event_query_probe __user *uquery = info;
> > +       struct perf_event_query_probe query = {};
> > +       struct trace_event_call *call = event->tp_event;
> > +       struct trace_uprobe *tu = (struct trace_uprobe *)call->data;
> > +       u64 nmissed, nhit;
> > +
> > +       if (!capable(CAP_SYS_ADMIN))
> > +               return -EPERM;
> > +       if (copy_from_user(&query, uquery, sizeof(query)))
> > +               return -EFAULT;
> > +
> > +       nhit = tu->nhit;
> > +       nmissed = 0;
> 
> Blindly return 0 is a little weird. Maybe return 0xffffffffffffffff so
> that the user
> can tell this is not a valid 0. Or some other idea?
> 
> Thanks,
> Song
>

My (maybe flawed) understanding is that uprobes cannot really miss the same way
a kprobe can. From skimming the code a little, it seems the main reason kprobes
can miss is when the processing of one kprobe results in hitting another kprobe.
The latter cannot be handled for whatever reason. The same cannot really happen
for uprobes as kernel doesn't call into userspace. That's why I made it 0 (that and
the fact I didn't see any accounting for uprobe misses).

cc Srikar who authored the uprobe patches.

Srikar, do you mind clarifying if uprobes can miss?

Thanks,
Daniel
