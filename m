Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E22C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 21:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51E2F20B7C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 21:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="GvjdEwV3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yEXkWiFl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbfHIVux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 17:50:53 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:55411 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726022AbfHIVux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 17:50:53 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 0FBA6217F;
        Fri,  9 Aug 2019 17:50:52 -0400 (EDT)
Received: from imap36 ([10.202.2.86])
  by compute4.internal (MEProxy); Fri, 09 Aug 2019 17:50:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm1; bh=FDGxDXPN2SUWSByp360DMt/uwwjigIP
        j7nZHao0b4BQ=; b=GvjdEwV3qRM4CESVG0xWRLWI+29GB62ehpRrK+x3nuOIi5a
        mHPCzGYWfwN9TkAsQZ4XvUZTaStNK1mv36vHvcjITLHY0LlsZAZeVDUjok8o/oQq
        y0rH4YITtaQ/mrv8oLnsqUIRKb3k8YkCjsxsG8WolCtNo08JfH0XUE+OeT9mZz4j
        R8eqbSyrUG1uIbJ5tY/kZC7wtOwGZZJ//Eplln7vVIOLKK2H8q2V6zesXW0NbYRI
        dlbfRjM7CJEdnhEeom2oqjZKAmplN+TzBfvqQ5pOcfmNz9SykzWEeDhlG3ksvroG
        gMn917unXh3lkwxOyWsu7lvZScEp9eQr7D1kQAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=FDGxDX
        PN2SUWSByp360DMt/uwwjigIPj7nZHao0b4BQ=; b=yEXkWiFliuHufd+e/NWJ+C
        Kq+eZ7OyUsY+ojUw77LB/IztX4BmPuyQcTpILsfqoGEIxhm+sk6o/F/Tl1mzkkoh
        +FwcV0KLTwWY2Pq1o2oQJg1myRpD2wJJ4SRgJI8InfpoX2yKLwFXYbH9PnYAaX6f
        AOMlPq3LmQYN/6M5k3IbUZ7tcl5Toao71ahIat/ZawnoTyMUI5Q/Q1bjGJnyc44a
        B+hl5u2aTXTVdb/NRBFvdsHBs15EDzYHW9JxMt9+o/srORGBb2ARlKoMt3Ec09Rt
        8Yt5Y7UBL3hHmo/Y0BLyxrrLLwYAhKXfkF66u6QH7/8boKblqXH6ZSD6575/ZDvg
        ==
X-ME-Sender: <xms:uepNXUBa663m5lMWIokKDpec0gV4YYlA9CMZSojoFMunsI1dUEm-rw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddruddukedgtdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlfeehmdenucfjughrpefofgggkfgjfhffhffvufgtsehttdertder
    reejnecuhfhrohhmpedfffgrnhhivghlucgiuhdfuceougiguhesugiguhhuuhdrgiihii
    eqnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiiinecuvehl
    uhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:uepNXWPC0mlX1bW0ZGEYU8i0AFWf58ThG1pB7G1JlZpZjxHRdxr-hg>
    <xmx:uepNXSb8f8nO-pgfI8mr3vPoAoqoWkKdYbFd4JPEPdxNKuL_xvthdg>
    <xmx:uepNXdM7YU35B3D3M5qQ3ek6f6kU8Uh9quxLTwTAdbVMhrSxdpj8Nw>
    <xmx:vOpNXeFCwkHBQIthWTWG25US4NNj6wnIApLqLX81bLvGrnQGSE-BkA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 0446B12200A2; Fri,  9 Aug 2019 17:50:48 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.6-809-g8e5c451-fmstable-20190809v1
Mime-Version: 1.0
Message-Id: <3429be0c-1a10-452e-a566-bf02db72f5ba@www.fastmail.com>
In-Reply-To: <20190809214642.12078-1-dxu@dxuuu.xyz>
References: <20190809214642.12078-1-dxu@dxuuu.xyz>
Date:   Fri, 09 Aug 2019 14:50:47 -0700
From:   "Daniel Xu" <dxu@dxuuu.xyz>
To:     "Song Liu" <songliubraving@fb.com>, "Yonghong Song" <yhs@fb.com>,
        "Andrii Nakryiko" <andriin@fb.com>, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org
Cc:     ast@fb.com, alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org
Subject: =?UTF-8?Q?Re:_[PATCH_v2_bpf-next_0/4]_tracing/probe:_Add_PERF=5FEVENT=5F?=
 =?UTF-8?Q?IOC=5FQUERY=5FPROBE?=
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 9, 2019, at 2:47 PM, Daniel Xu wrote:
> It's useful to know [uk]probe's nmissed and nhit stats. For example with
> tracing tools, it's important to know when events may have been lost.
> debugfs currently exposes a control file to get this information, but
> it is not compatible with probes registered with the perf API.
> 
> While bpf programs may be able to manually count nhit, there is no way
> to gather nmissed. In other words, it is currently not possible to
> retrieve information about FD-based probes.
> 
> This patch adds a new ioctl that lets users query nmissed (as well as
> nhit for completeness). We currently only add support for [uk]probes
> but leave the possibility open for other probes like tracepoint.
> 
> v1 -> v2:
> - More descriptive cover letter
> - Make API more generic and support uprobes as well
> - Use casters/getters for libbpf instead of single getter
> - Fix typos
> - Remove size field from ioctl struct
> - Split out libbpf.h sync to tools dir to separate commit
> 
> Daniel Xu (4):
>   tracing/probe: Add PERF_EVENT_IOC_QUERY_PROBE ioctl
>   libbpf: Add helpers to extract perf fd from bpf_link
>   tracing/probe: Sync perf_event.h to tools
>   tracing/probe: Add self test for PERF_EVENT_IOC_QUERY_PROBE
> 
>  include/linux/trace_events.h                  |  12 +++
>  include/uapi/linux/perf_event.h               |  19 ++++
>  kernel/events/core.c                          |  20 ++++
>  kernel/trace/trace_kprobe.c                   |  23 ++++
>  kernel/trace/trace_uprobe.c                   |  23 ++++
>  tools/include/uapi/linux/perf_event.h         |  19 ++++
>  tools/lib/bpf/libbpf.c                        |  19 ++++
>  tools/lib/bpf/libbpf.h                        |   8 ++
>  tools/lib/bpf/libbpf.map                      |   6 ++
>  .../selftests/bpf/prog_tests/attach_probe.c   | 102 ++++++++++++++++++
>  10 files changed, 251 insertions(+)
> 
> -- 
> 2.20.1
> 
>

CC PeterZ, whose email I misspelled. Apologies.

Daniel
