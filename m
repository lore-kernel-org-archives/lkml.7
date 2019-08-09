Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A04C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 21:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C08D208C4
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 21:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="ABYFek7G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qW1zj6Bf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729307AbfHIVrl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 17:47:41 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:55693 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728600AbfHIVri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 17:47:38 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 9A16E20D6;
        Fri,  9 Aug 2019 17:47:37 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 09 Aug 2019 17:47:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=3HfArrsUapD2G
        uEhrlUoGsXRI0BRydCBwu27R8/WFUM=; b=ABYFek7GmunD3FEuSEnC4/edWdATL
        095uTTEJdY5H0IPUQQgFHvMNuyExqM4B5/R43ubmVutBnxvRB1BeV0FRkoItZPTc
        kR0TZq+Zh/eR6HE22c6yTXw4FXHbJ452ZohNxUCWYflFyTJLFeqxzA8gUIg8EHVB
        dSyBkYuN8jI2pNz85DRZ0ToE8SD9Cr1F1Yt+wDhjUA9ulotHtGb653MGEWxpxWK4
        zZ0YZlbB6bLOovvFqZS/aoi6O0uOSiNkaVqGtQGhTLWfZXspeCvo8mBI4UJlDWni
        2YmR0b/4CPme3Z+RucBjabHTQ4O7Fex9ooT0+bdsw0CJyafFIzM084wbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=3HfArrsUapD2GuEhrlUoGsXRI0BRydCBwu27R8/WFUM=; b=qW1zj6Bf
        +CFxTp+Pz38bdyxa+AWqOA3B0ITLmKvxXFRNeXBM8sOnuCHtm69YiSBcul6jKJ7Y
        0GI1TDJ6ryd3gjrRzo3CVSvZZCWfXzDN0kPeodT7R1XS6KsO8rWqzevqsB3Lmh3C
        6atkh5wT3eVnSLZpQLvsnkzkBJO70fkRNWE7KSZFcfWrEVfztEAaEh0A8TaDSyaF
        LYpzfJf6gds5eP7KwrKWzOVYY4AyofmOyQ5uuZ1TH0bW9zonqrcoUeBhBpqGHsPz
        uNKUcaNip1steZnOGj1KcBahY1l3nYHcjl/8Bgh2PZtGBp+X4mT0Vty8+aODw4MD
        kM4bt0D7svO/lw==
X-ME-Sender: <xms:-elNXXNMg94NORAWplz2iOyfF2HcfKXc_O3dnAfARkT2HBJ2UVkDeQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddruddukedgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegu
    gihusegugihuuhhurdighiiiqeenucfkphepudelledrvddtuddrieegrddufeeknecurf
    grrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiiinecuvehluhhsthgv
    rhfuihiivgepud
X-ME-Proxy: <xmx:-elNXVc3gTEk4PMp8UJnhjIbKp_o9-h3i4unTK6nBujuK73hQEC6lg>
    <xmx:-elNXZGxvNepTLz1yqg5nL-yu_EvpV4gbM0mxXUAB5dIFPVx6Iw1gw>
    <xmx:-elNXZQEJE1BPU-2DxK8uqQBYH0fInMOSCNm-E_Ys3_s6SDv8snx7w>
    <xmx:-elNXYAtmb6cU0ULiUl3b3UVj758o6F-huIxa0_0DbKLA5v0bvEliQ>
Received: from dlxu-fedora-R90QNFJV.thefacebook.com (unknown [199.201.64.138])
        by mail.messagingengine.com (Postfix) with ESMTPA id D54B6380075;
        Fri,  9 Aug 2019 17:47:35 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     songliubraving@fb.com, yhs@fb.com, andriin@fb.com,
        peterz@infraded.org, mingo@redhat.com, acme@kernel.org
Cc:     Daniel Xu <dxu@dxuuu.xyz>, ast@fb.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 bpf-next 4/4] tracing/probe: Add self test for PERF_EVENT_IOC_QUERY_PROBE
Date:   Fri,  9 Aug 2019 14:46:42 -0700
Message-Id: <20190809214642.12078-5-dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190809214642.12078-1-dxu@dxuuu.xyz>
References: <20190809214642.12078-1-dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 .../selftests/bpf/prog_tests/attach_probe.c   | 102 ++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/attach_probe.c b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
index 5ecc267d98b0..bb53103ddb66 100644
--- a/tools/testing/selftests/bpf/prog_tests/attach_probe.c
+++ b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
@@ -27,17 +27,27 @@ void test_attach_probe(void)
 	const char *kretprobe_name = "kretprobe/sys_nanosleep";
 	const char *uprobe_name = "uprobe/trigger_func";
 	const char *uretprobe_name = "uretprobe/trigger_func";
+	struct perf_event_query_probe kprobe_query = {};
+	struct perf_event_query_probe kretprobe_query = {};
+	struct perf_event_query_probe uprobe_query = {};
+	struct perf_event_query_probe uretprobe_query = {};
 	const int kprobe_idx = 0, kretprobe_idx = 1;
 	const int uprobe_idx = 2, uretprobe_idx = 3;
 	const char *file = "./test_attach_probe.o";
 	struct bpf_program *kprobe_prog, *kretprobe_prog;
 	struct bpf_program *uprobe_prog, *uretprobe_prog;
 	struct bpf_object *obj;
+	const struct bpf_link_fd *kprobe_fd_link;
+	const struct bpf_link_fd *kretprobe_fd_link;
+	const struct bpf_link_fd *uprobe_fd_link;
+	const struct bpf_link_fd *uretprobe_fd_link;
 	int err, prog_fd, duration = 0, res;
 	struct bpf_link *kprobe_link = NULL;
 	struct bpf_link *kretprobe_link = NULL;
 	struct bpf_link *uprobe_link = NULL;
 	struct bpf_link *uretprobe_link = NULL;
+	int kprobe_fd, kretprobe_fd;
+	int uprobe_fd, uretprobe_fd;
 	int results_map_fd;
 	size_t uprobe_offset;
 	ssize_t base_addr;
@@ -116,6 +126,52 @@ void test_attach_probe(void)
 	/* trigger & validate kprobe && kretprobe */
 	usleep(1);
 
+	kprobe_fd_link = bpf_link__as_fd(kprobe_link);
+	if (CHECK(!kprobe_fd_link, "kprobe_link_as_fd",
+		  "failed to cast link to fd link\n"))
+		goto cleanup;
+
+	kprobe_fd = bpf_link_fd__fd(kprobe_fd_link);
+	if (CHECK(kprobe_fd < 0, "kprobe_get_perf_fd",
+	    "failed to get perf fd from kprobe link\n"))
+		goto cleanup;
+
+	kretprobe_fd_link = bpf_link__as_fd(kretprobe_link);
+	if (CHECK(!kretprobe_fd_link, "kretprobe_link_as_fd",
+		  "failed to cast link to fd link\n"))
+		goto cleanup;
+
+	kretprobe_fd = bpf_link_fd__fd(kretprobe_fd_link);
+	if (CHECK(kretprobe_fd < 0, "kretprobe_get_perf_fd",
+	    "failed to get perf fd from kretprobe link\n"))
+		goto cleanup;
+
+	err = ioctl(kprobe_fd, PERF_EVENT_IOC_QUERY_PROBE, &kprobe_query);
+	if (CHECK(err, "get_kprobe_ioctl",
+		  "failed to issue kprobe query ioctl\n"))
+		goto cleanup;
+	if (CHECK(kprobe_query.nmissed > 0, "get_kprobe_ioctl",
+		  "read incorect nmissed from kprobe_ioctl: %llu\n",
+		  kprobe_query.nmissed))
+		goto cleanup;
+	if (CHECK(kprobe_query.nhit == 0, "get_kprobe_ioctl",
+		  "read incorect nhit from kprobe_ioctl: %llu\n",
+		  kprobe_query.nhit))
+		goto cleanup;
+
+	err = ioctl(kretprobe_fd, PERF_EVENT_IOC_QUERY_PROBE, &kretprobe_query);
+	if (CHECK(err, "get_kretprobe_ioctl",
+		  "failed to issue kretprobe query ioctl\n"))
+		goto cleanup;
+	if (CHECK(kretprobe_query.nmissed > 0, "get_kretprobe_ioctl",
+		  "read incorect nmissed from kretprobe_ioctl: %llu\n",
+		  kretprobe_query.nmissed))
+		goto cleanup;
+	if (CHECK(kretprobe_query.nhit <= 0, "get_kretprobe_ioctl",
+		  "read incorect nhit from kretprobe_ioctl: %llu\n",
+		  kretprobe_query.nhit))
+		goto cleanup;
+
 	err = bpf_map_lookup_elem(results_map_fd, &kprobe_idx, &res);
 	if (CHECK(err, "get_kprobe_res",
 		  "failed to get kprobe res: %d\n", err))
@@ -135,6 +191,52 @@ void test_attach_probe(void)
 	/* trigger & validate uprobe & uretprobe */
 	get_base_addr();
 
+	uprobe_fd_link = bpf_link__as_fd(uprobe_link);
+	if (CHECK(!uprobe_fd_link, "uprobe_link_as_fd",
+		  "failed to cast link to fd link\n"))
+		goto cleanup;
+
+	uprobe_fd = bpf_link_fd__fd(uprobe_fd_link);
+	if (CHECK(uprobe_fd < 0, "uprobe_get_perf_fd",
+	    "failed to get perf fd from uprobe link\n"))
+		goto cleanup;
+
+	uretprobe_fd_link = bpf_link__as_fd(uretprobe_link);
+	if (CHECK(!uretprobe_fd_link, "uretprobe_link_as_fd",
+		  "failed to cast link to fd link\n"))
+		goto cleanup;
+
+	uretprobe_fd = bpf_link_fd__fd(uretprobe_fd_link);
+	if (CHECK(uretprobe_fd < 0, "uretprobe_get_perf_fd",
+	    "failed to get perf fd from uretprobe link\n"))
+		goto cleanup;
+
+	err = ioctl(uprobe_fd, PERF_EVENT_IOC_QUERY_PROBE, &uprobe_query);
+	if (CHECK(err, "get_uprobe_ioctl",
+		  "failed to issue uprobe query ioctl\n"))
+		goto cleanup;
+	if (CHECK(uprobe_query.nmissed > 0, "get_uprobe_ioctl",
+		  "read incorect nmissed from uprobe_ioctl: %llu\n",
+		  uprobe_query.nmissed))
+		goto cleanup;
+	if (CHECK(uprobe_query.nhit == 0, "get_uprobe_ioctl",
+		  "read incorect nhit from uprobe_ioctl: %llu\n",
+		  uprobe_query.nhit))
+		goto cleanup;
+
+	err = ioctl(uretprobe_fd, PERF_EVENT_IOC_QUERY_PROBE, &uretprobe_query);
+	if (CHECK(err, "get_uretprobe_ioctl",
+		  "failed to issue uretprobe query ioctl\n"))
+		goto cleanup;
+	if (CHECK(uretprobe_query.nmissed > 0, "get_uretprobe_ioctl",
+		  "read incorect nmissed from uretprobe_ioctl: %llu\n",
+		  uretprobe_query.nmissed))
+		goto cleanup;
+	if (CHECK(uretprobe_query.nhit <= 0, "get_uretprobe_ioctl",
+		  "read incorect nhit from uretprobe_ioctl: %llu\n",
+		  uretprobe_query.nhit))
+		goto cleanup;
+
 	err = bpf_map_lookup_elem(results_map_fd, &uprobe_idx, &res);
 	if (CHECK(err, "get_uprobe_res",
 		  "failed to get uprobe res: %d\n", err))
-- 
2.20.1

