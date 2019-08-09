Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A560DC31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 21:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73B66208C4
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 21:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="xUmDdGfe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zW+mVe8/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfHIVrY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 17:47:24 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:57881 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726137AbfHIVrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 17:47:24 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 31FE41D61;
        Fri,  9 Aug 2019 17:47:21 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 09 Aug 2019 17:47:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=yGeBq9ujYMy5OrupH6vu4uLdzj
        Pfu57B+u/DV1vUVqk=; b=xUmDdGfenI75/1nKloyeICaIK8bstAo6ZMAqCWSX2H
        izeFsNw7HikLoqfZJxW0nJ0WeHSiDvyQMkf/IEMK62OZEQg7RhvegS3EvYj4X7gt
        Yj9CdyonpPRMI84YQMM6VV2Ajo3hHaSKAjyHJvpbl5pDXTh5jHGIA8FlSH227Xof
        Tqu7f5gTqeTQ1Irn8Ok3sEUjkuGjkvvxBHsCVs1l3woTesjl2hexD3PqaXs+dvIV
        oCVHYD20m8OvIgPJJBac0iVPfJTvBbN2GcUveW7h5l9+SbpvzGAiVmUsHnbISMP7
        6/bHmHuUS+ws0oL/1WGzGq64hPf6qpFx4XLEs8j3A3Cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=yGeBq9ujYMy5OrupH
        6vu4uLdzjPfu57B+u/DV1vUVqk=; b=zW+mVe8/eg1Ymyd6sEot8a4fRUq6K0+oP
        ZVnnkkRkufSJYqOr13Uo7D7z9lb0iKozICML5tQU4h3tHfSssrPQ62npb6spq2dE
        CSMhCImtqLi8HcIkMBJpvf8rxTLanCEX7iAHfsA+xYPH6jGqksJ2gLeOIu/N8gbr
        xPSt1JIsn9GVNkB/0imwIZuOGlbwnj9OXPJbB+MNLfBBOWtXJ1RciJSWrpbd2XxR
        w0ae83qSqYgXA4h5Zn3m1Igt7OgkNALXQIeda0lDljltR+dnWmzDwYfRgCXcJPlp
        PWt9sYbVj7ne5NUkKJAPAXP2Od2OTOlUd80bkRjPl8iphGZ3Wmoyg==
X-ME-Sender: <xms:5-lNXQEkWqrG9c5bCcT4_K_EmR3bmJFl_fTnotKFlDicIYvq09P03w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddruddukedgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    fufffkofgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihu
    segugihuuhhurdighiiiqeenucfkphepudelledrvddtuddrieegrddufeeknecurfgrrh
    grmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiiinecuvehluhhsthgvrhfu
    ihiivgeptd
X-ME-Proxy: <xmx:5-lNXRmuINF53eGEluCp6OWkjR3gqPTURNo_bcAD2Yc9PY2SGKFRCA>
    <xmx:5-lNXeEbAUoOLtRPZDWt8RrT9tCT92gGy7n9pZDgeFNnR_vbSluRGQ>
    <xmx:5-lNXZapuvmCBOYRqgmXDxbhCS3w1KDiwR5Iq9puhsFE_WN7zbEYNw>
    <xmx:6elNXdEPaXMMS2sGuq8Kah4EHS6uxc6pF9q2_inzx0U7Kh0JDNNIjQ>
Received: from dlxu-fedora-R90QNFJV.thefacebook.com (unknown [199.201.64.138])
        by mail.messagingengine.com (Postfix) with ESMTPA id 76D2E380075;
        Fri,  9 Aug 2019 17:47:18 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     songliubraving@fb.com, yhs@fb.com, andriin@fb.com,
        peterz@infraded.org, mingo@redhat.com, acme@kernel.org
Cc:     Daniel Xu <dxu@dxuuu.xyz>, ast@fb.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 bpf-next 0/4] tracing/probe: Add PERF_EVENT_IOC_QUERY_PROBE
Date:   Fri,  9 Aug 2019 14:46:38 -0700
Message-Id: <20190809214642.12078-1-dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's useful to know [uk]probe's nmissed and nhit stats. For example with
tracing tools, it's important to know when events may have been lost.
debugfs currently exposes a control file to get this information, but
it is not compatible with probes registered with the perf API.

While bpf programs may be able to manually count nhit, there is no way
to gather nmissed. In other words, it is currently not possible to
retrieve information about FD-based probes.

This patch adds a new ioctl that lets users query nmissed (as well as
nhit for completeness). We currently only add support for [uk]probes
but leave the possibility open for other probes like tracepoint.

v1 -> v2:
- More descriptive cover letter
- Make API more generic and support uprobes as well
- Use casters/getters for libbpf instead of single getter
- Fix typos
- Remove size field from ioctl struct
- Split out libbpf.h sync to tools dir to separate commit

Daniel Xu (4):
  tracing/probe: Add PERF_EVENT_IOC_QUERY_PROBE ioctl
  libbpf: Add helpers to extract perf fd from bpf_link
  tracing/probe: Sync perf_event.h to tools
  tracing/probe: Add self test for PERF_EVENT_IOC_QUERY_PROBE

 include/linux/trace_events.h                  |  12 +++
 include/uapi/linux/perf_event.h               |  19 ++++
 kernel/events/core.c                          |  20 ++++
 kernel/trace/trace_kprobe.c                   |  23 ++++
 kernel/trace/trace_uprobe.c                   |  23 ++++
 tools/include/uapi/linux/perf_event.h         |  19 ++++
 tools/lib/bpf/libbpf.c                        |  19 ++++
 tools/lib/bpf/libbpf.h                        |   8 ++
 tools/lib/bpf/libbpf.map                      |   6 ++
 .../selftests/bpf/prog_tests/attach_probe.c   | 102 ++++++++++++++++++
 10 files changed, 251 insertions(+)

-- 
2.20.1

