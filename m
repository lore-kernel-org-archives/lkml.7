Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F63C3A59E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 17:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A304A214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 17:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="u/h/8wag";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qHI9RYdR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730642AbfHTR6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 13:58:53 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:58267 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730006AbfHTR6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 13:58:52 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 4B0572306;
        Tue, 20 Aug 2019 13:58:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 20 Aug 2019 13:58:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        content-transfer-encoding:content-type:in-reply-to:date:cc
        :subject:from:to:message-id; s=fm1; bh=V4une9T0118s6OifTGsDx9LZN
        fb9kvaUaj3F5fzCd6s=; b=u/h/8wagkBqbj7O1gfNDI6T3iHd4N7OLnI4UqEIaO
        CcqaChfePnM4TAKcYL//5qqXszmzzEsA+oiRM7kih/BoozHdJubnyoHUqmH9F4fo
        kWO3B6508q5RHyk++s5InpcR4eEAvXsKCugSwDEcYmTgpMDZcQDsB9ymVnK32akF
        utXA3DwabE4rinHpUe5Su4gmNXKTN+Q/Ou9Kpho9WrVsar9WgQ29YidpyAf76lxu
        GqhczZ91RH3UrZ5N1G6Jhv+iImhaLUI4LIxHRqeiecU6ZOscwyQzMLm+vElDz9AA
        drRyTx9e+Gp4orejB5jIsRD2o+VWhM7EW4IexF8ilVclg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=V4une9
        T0118s6OifTGsDx9LZNfb9kvaUaj3F5fzCd6s=; b=qHI9RYdRSVkSETgw2uClzL
        70JdXB3P9BAa3CEUS0wdk44jOd+ooIGmy9pdHqKZvxBj+pg+XozH774egLl6SpYc
        rXObo+cAx30IBp+AdmqpBsYDLnwZjqfomOS2KbYMqzI5IDP3+8WVeVV9HcEMP+La
        623Ka39vuy6R2gjN75INol0b8XfJBMt+Go/O4Eoj2c8riiwi4R3IMz8Uu157dljC
        JyFhM37ydPj0CeXadQmqxW8gQz0KUD253yOqIYpIRRBQv8EojnpZiALFnrJY/w1z
        Cuh1lvdf8gompasWN3D6SpELAsuZmVyAKeg9z1pjplYPkgJVcNIPyZvoMiBXOIJQ
        ==
X-ME-Sender: <xms:2jRcXY0tSHpzzQ2t3htmFIe_pyUiNZppulxBYXprHCSYG65A_mL8xQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudeguddguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculdejtddmnecujfgurhepgfgtjgffuffhvffksehtqhertddttdej
    necuhfhrohhmpedfffgrnhhivghlucgiuhdfuceougiguhesugiguhhuuhdrgiihiieqne
    cukfhppeduleelrddvtddurdeigedrvdenucfrrghrrghmpehmrghilhhfrhhomhepugig
    uhesugiguhhuuhdrgiihiienucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:2jRcXXO1meebK_ta9rGPrtD3T0iu8CsRgvaNONnbHdWGNDhAMODckw>
    <xmx:2jRcXd5SwP6KaaGXrSdePp2iQFqEibZJwXYHVlNOd_GdF3VYLUOR5A>
    <xmx:2jRcXcZY4O3SKKp--7PW92EnyauRovtELeQ7S_-kxSj2gYapPfvxpQ>
    <xmx:2zRcXXk_Ou9T60hwIRMo9JfvF-GEyLe81MBZE6duPCAHL5sEK0Fq2w>
Received: from localhost (unknown [199.201.64.2])
        by mail.messagingengine.com (Postfix) with ESMTPA id 30C1280064;
        Tue, 20 Aug 2019 13:58:48 -0400 (EDT)
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20190820144503.GV2332@hirez.programming.kicks-ass.net>
Date:   Tue, 20 Aug 2019 10:58:47 -0700
Cc:     <bpf@vger.kernel.org>, <songliubraving@fb.com>, <yhs@fb.com>,
        <andriin@fb.com>, <mingo@redhat.com>, <acme@kernel.org>,
        <ast@fb.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>
Subject: Re: [PATCH v3 bpf-next 1/4] tracing/probe: Add
 PERF_EVENT_IOC_QUERY_PROBE ioctl
From:   "Daniel Xu" <dxu@dxuuu.xyz>
To:     "Peter Zijlstra" <peterz@infradead.org>
Message-Id: <BWENHQJIN885.216UOYEIWNGFU@dlxu-fedora-R90QNFJV>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Tue Aug 20, 2019 at 4:45 PM Peter Zijlstra wrote:
> On Fri, Aug 16, 2019 at 03:31:46PM -0700, Daniel Xu wrote:
> > It's useful to know [uk]probe's nmissed and nhit stats. For example wit=
h
> > tracing tools, it's important to know when events may have been lost.
> > debugfs currently exposes a control file to get this information, but
> > it is not compatible with probes registered with the perf API.
>=20
> What is this nmissed and nhit stuff?

nmissed is the number of times the probe's handler should have been run
but didn't. nhit is the number of times the probes handler has run. I've
documented this information in the uapi header. If you'd like, I can put
it in the commit message too.

Daniel
