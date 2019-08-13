Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D98FC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 00:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DB13206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 00:39:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="hJdh3IZm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fe/dmV2d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfHMAjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 20:39:08 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:50657 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726200AbfHMAjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 20:39:07 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 64B9D2A08;
        Mon, 12 Aug 2019 20:39:06 -0400 (EDT)
Received: from imap35 ([10.202.2.85])
  by compute4.internal (MEProxy); Mon, 12 Aug 2019 20:39:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm1; bh=3jfb2lEVv1sOcUFflmmOQX9A1r3ygEe
        TfYqbBLcpo8Y=; b=hJdh3IZmHwbjm2BdLjBVz1K5WYlciI8xqMSY6NRPqQ8WCx8
        TsMpZIcSP7c8Qzl5F6dZAa4/0R0v8x+lw+HwqG0Uka2/bGLXQiJdRa6w3VY104Qd
        BNE40Qe9M779kssLjnmCV2vvMdqhnbuS6jZQMVyOb4zoYOMvR7VxgQB8rZr4TNPq
        z+pkOnV469CJ8H3LA/CpvafIlcDg24C3I4+XESDXAL6e469wci4OPLDZdueba7z8
        NGh8IrbRT4Loz8VdXKG+mEZuEEUG8lzSpAtbp+7Itx2T0gGCYMAPQRmLTIJmCf6o
        VlhvBVtAbeCT/o3Z9SMxau5MwtPP0D3BbFe8VYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=3jfb2l
        EVv1sOcUFflmmOQX9A1r3ygEeTfYqbBLcpo8Y=; b=fe/dmV2dO6a3mOK2iJGV7A
        N+/JtWc4eBv/0iiW8FY3IuLyM82GD4XCrAhiKa8Te9loPhugzVoa1MR9IS06zkHh
        7XoYggMu7g2TpHjM81fH6+Lc1eZyyAZ7N8IXJhX/pKN69YEKgaG7Q1mFRMOVSqgD
        PF4EpeNT+5Ef5JmVb6fNwTo5iQND2eSxX8p3ycUaew2oFl/4p+k6mNV2s27jtyFm
        YBhjIWrp36sVesRVUjDyJt05gnQXEAvAyUp6IdpcWPIgR6VekydxOPRPpHtHLYbR
        HvIVoLPdaZ0V11gA3YImIT4VqnSaG/mq/umE1GBgD08rHNmoj9f+LLL4csrELLgQ
        ==
X-ME-Sender: <xms:qQZSXZl3VU0BFbHf8AOLrGdAt9e-e8IduBaO365x3bjgmdEXUpW3Eg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddruddvhedgfeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlfeehmdenucfjughrpefofgggkfgjfhffhffvufgtsehttdertder
    reejnecuhfhrohhmpedfffgrnhhivghlucgiuhdfuceougiguhesugiguhhuuhdrgiihii
    eqnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiiinecuvehl
    uhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:qQZSXStouB65Wt9IPoixasDbIfd-WWU-ogxO3VU2zmJqPFzkczXRnQ>
    <xmx:qQZSXYtwlL9Qh31SzEEGdYyNrbfVxeS6QxzImSK6vOSvToV_PWfC1Q>
    <xmx:qQZSXa0qh9T44Uz5JRXPG2VFsNr27HYIJBAVfB4idLYISMk0l9os3w>
    <xmx:qgZSXY-z2CnGVv4ww4ACyPqCJ7DKUPpo3qYtAQwCZAe7CAsz7WtDhw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id A44CD14C0062; Mon, 12 Aug 2019 20:39:05 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.6-809-g8e5c451-fmstable-20190809v1
Mime-Version: 1.0
Message-Id: <7232f649-78f8-4a2d-a3df-0ce9293f9de8@www.fastmail.com>
In-Reply-To: <CAEf4Bzb0jBmsdeKZ_vN4w-z1tM8M2Ygz_CoBoO_2iV55tgL1Bg@mail.gmail.com>
References: <20190809214642.12078-1-dxu@dxuuu.xyz>
 <20190809214642.12078-2-dxu@dxuuu.xyz>
 <CAEf4Bzb0jBmsdeKZ_vN4w-z1tM8M2Ygz_CoBoO_2iV55tgL1Bg@mail.gmail.com>
Date:   Mon, 12 Aug 2019 17:38:53 -0700
From:   "Daniel Xu" <dxu@dxuuu.xyz>
To:     "Andrii Nakryiko" <andrii.nakryiko@gmail.com>
Cc:     "Song Liu" <songliubraving@fb.com>, "Yonghong Song" <yhs@fb.com>,
        "Andrii Nakryiko" <andriin@fb.com>, peterz@infraded.org,
        "Ingo Molnar" <mingo@redhat.com>,
        "Arnaldo Carvalho de Melo" <acme@kernel.org>,
        "Alexei Starovoitov" <ast@fb.com>,
        alexander.shishkin@linux.intel.com, "Jiri Olsa" <jolsa@redhat.com>,
        "Namhyung Kim" <namhyung@kernel.org>,
        "open list" <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?Q?Re:_[PATCH_v2_bpf-next_1/4]_tracing/probe:_Add_PERF=5FEVENT=5F?=
 =?UTF-8?Q?IOC=5FQUERY=5FPROBE_ioctl?=
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019, at 8:57 AM, Andrii Nakryiko wrote:
> On Fri, Aug 9, 2019 at 2:47 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
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
> >  include/linux/trace_events.h    | 12 ++++++++++++
> >  include/uapi/linux/perf_event.h | 19 +++++++++++++++++++
> >  kernel/events/core.c            | 20 ++++++++++++++++++++
> >  kernel/trace/trace_kprobe.c     | 23 +++++++++++++++++++++++
> >  kernel/trace/trace_uprobe.c     | 23 +++++++++++++++++++++++
> >  5 files changed, 97 insertions(+)
> >
[...]
> > +       struct trace_kprobe *tk = (struct trace_kprobe *)call->data;
> > +       u64 nmissed, nhit;
> > +
> > +       if (!capable(CAP_SYS_ADMIN))
> > +               return -EPERM;
> > +       if (copy_from_user(&query, uquery, sizeof(query)))
> 
> what about forward/backward compatibility? Didn't you have a size
> field for perf_event_query_probe?

I initially did, yes. But after thinking about it more, I'm not convinced it
is necessary. It seems the last change to the debugfs counterpart was in
the initial comit cd7e7bd5e4, ~10 years ago. I cannot think of any other
information that would be useful off the top of my head, so I figured it'd
be best if we didn't make more complicated something that doesn't seem
likely to change. If we really needed something else, I figured adding
another ioctl is pretty cheap.

If you (or anyone) feels strongly about adding it back, I can make it a
u64 so there's no holes.

> 
> > +               return -EFAULT;
> > +
> > +       nhit = trace_kprobe_nhit(tk);
> > +       nmissed = tk->rp.kp.nmissed;
> > +
> > +       if (put_user(nmissed, &uquery->nmissed) ||
> > +           put_user(nhit, &uquery->nhit))
> 
> Wouldn't it be nicer to just do one user put for entire struct (or at
> least relevant part of it with backward/forward compatibility?).

Not sure how that didn't occur to me. Thanks.
