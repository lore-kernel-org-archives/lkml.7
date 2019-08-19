Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A6FAC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 21:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ADC5206C1
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 21:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="xUtn4j1G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ry0547q5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728595AbfHSVaL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 17:30:11 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:47571 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728387AbfHSVaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 17:30:10 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id BBCA32E7F;
        Mon, 19 Aug 2019 17:30:08 -0400 (EDT)
Received: from imap35 ([10.202.2.85])
  by compute4.internal (MEProxy); Mon, 19 Aug 2019 17:30:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm1; bh=Q5JhGTN+fjSJxso/aLaWEsyqO9JCUhO
        T7ziS9ZnAOsA=; b=xUtn4j1G34ZT3y2T5IEdd5A2VDsgDEVzXW6Pjsx8JMHzTRK
        8+qj+li6IoE0Unogyksn2fTbvKy5Nhzd9jiqGmGUK0V9NfJ5BTE5fnMrXgWBTFkT
        mqkfky6XZsWnVjBopBNHHhTyafKYye8S0aEF5oVPyWXcBy1nHmwUtbUt5ZUS7GSw
        SzkXSr9/3KAIEOmyRR5bQTfKyF/YSKHWUXkwouEs6q4qIRZwfZ49dJzRz4Hu+P1a
        2mzP4fSAMLeD4qTbvf5LnPZIQ4k8QvR8V0tByP68lUZ2jT9xOoO65NWY5FHykU6D
        G+bysEnfWHYGEsypANvxwWZv1KctKojA/1bgj1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=Q5JhGT
        N+fjSJxso/aLaWEsyqO9JCUhOT7ziS9ZnAOsA=; b=ry0547q56oTH2j7WD50GWt
        XupBQm20OFhLRN/3HuCo0W9MYrJ+dee1hun0MAH083ZiRI9hJPNQenkeHoOfh08p
        FlV2pP4DMwVqZpqg4kSIKaFz6NZ466GB+CQ0Ta4ubOJEqBH0zsuBfTmZdA78Z9ew
        sBfN08+RjqHWJ5Yewk1+avKDGPz2RkQvGR3SchevaSKgji1onmpbRbcsDerZi9CS
        RkHM9X1PEK0BVXHbM7HO+t6k9MMcFo/U/PRRMoRDSGVsUVuggOFCNLiOiSJQNhp8
        u95LZTpDKVM2lTorphVVcNgf0ry+8UCns5So4i9zEaKbN4KOSGv8rSmBM8BCeEJQ
        ==
X-ME-Sender: <xms:3xRbXTtD2Kd1Vh4LbPdobYV9vL-Reffwx06OdMVNejirngyp92DwvQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudegtddgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlfeehmdenucfjughrpefofgggkfgjfhffhffvufgtsehttdertder
    reejnecuhfhrohhmpedfffgrnhhivghlucgiuhdfuceougiguhesugiguhhuuhdrgiihii
    eqnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiiinecuvehl
    uhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:3xRbXfJ6hQpkIf2K3Lt08Ggg6IKBWXa6iKwbbi5mIKrlb2RT_Y-H9w>
    <xmx:3xRbXdZ3Iqdsp5PizLUl6pWo7J6q7aCRovUO326tyZySaIyVpUHo-A>
    <xmx:3xRbXdLlx8sT3Rh6KY9TpVPVLjyS3WLhurdTZIYearTcuL_1MwiEDg>
    <xmx:4BRbXePAsusUAd0M_S8bjowWXd0JiFtf1TAPX8gPuqUYGE27LwX0kQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B0F1114C0062; Mon, 19 Aug 2019 17:30:07 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.6-877-g11309a8-fmstable-20190819v1
Mime-Version: 1.0
Message-Id: <bf85e622-afa9-4f9e-a41b-ba67be24a9e3@www.fastmail.com>
In-Reply-To: <CAEf4BzYbckCr2mxgsAn0z-fi-jxjvL5RGF4vdCLdfWgOzQfb-A@mail.gmail.com>
References: <20190816223149.5714-1-dxu@dxuuu.xyz>
 <20190816223149.5714-3-dxu@dxuuu.xyz>
 <CAEf4BzYbckCr2mxgsAn0z-fi-jxjvL5RGF4vdCLdfWgOzQfb-A@mail.gmail.com>
Date:   Mon, 19 Aug 2019 14:30:06 -0700
From:   "Daniel Xu" <dxu@dxuuu.xyz>
To:     "Andrii Nakryiko" <andrii.nakryiko@gmail.com>
Cc:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "Song Liu" <songliubraving@fb.com>, "Yonghong Song" <yhs@fb.com>,
        "Andrii Nakryiko" <andriin@fb.com>,
        "Peter Ziljstra" <peterz@infradead.org>,
        "Ingo Molnar" <mingo@redhat.com>,
        "Arnaldo Carvalho de Melo" <acme@kernel.org>,
        "Alexei Starovoitov" <ast@fb.com>,
        alexander.shishkin@linux.intel.com, "Jiri Olsa" <jolsa@redhat.com>,
        "Namhyung Kim" <namhyung@kernel.org>,
        "open list" <linux-kernel@vger.kernel.org>,
        "Kernel Team" <kernel-team@fb.com>
Subject: =?UTF-8?Q?Re:_[PATCH_v3_bpf-next_2/4]_libbpf:_Add_helpers_to_extract_per?=
 =?UTF-8?Q?f_fd_from_bpf=5Flink?=
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019, at 10:45 AM, Andrii Nakryiko wrote:
> On Fri, Aug 16, 2019 at 3:32 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
> >
> > It is sometimes necessary to perform ioctl's on the underlying perf fd.
> > There is not currently a way to extract the fd given a bpf_link, so add a
> > a pair of casting and getting helpers.
> >
> > The casting and getting helpers are nice because they let us define
> > broad categories of links that makes it clear to users what they can
> > expect to extract from what type of link.
> >
> > Acked-by: Song Liu <songliubraving@fb.com>
> > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> > ---
> 
> This looks great, thanks a lot!
> 
> I think you might have a conflict with dadb81d0afe7 ("libbpf: make
> libbpf.map source of truth for libbpf version") in libbpf.map, so you
> might need to pull, rebase and re-post rebased version. But in any
> case:
> 

The patchset is already rebased on top :). Thanks for the tip.

Daniel
