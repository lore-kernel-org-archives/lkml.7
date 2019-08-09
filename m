Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F758C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 21:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EEF2208C4
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 21:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="zyeWSpM1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yvf9ucN5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729043AbfHIVrg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 17:47:36 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:38663 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726137AbfHIVrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 17:47:36 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 9A38D1D5F;
        Fri,  9 Aug 2019 17:47:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 09 Aug 2019 17:47:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=ZgLj+e4X7MDRK
        6SM7/arel7PF4jkctUY0AARU+B4fj4=; b=zyeWSpM1MKhfw7iatIvgVkIO6zdkK
        rOytYdiL90VfA/k00XzpVcp3WW/YfE8K6nNp1iaYSn63E2N7FKof5HBQbPR3xvPN
        d75E10YNQ0yK41tg16HB9CoGAukLFMKOEIj8+CG74nmGP5rZeX0q7On3HjBVVUAy
        SkKtCOAr2TVlcUG+RpwTxHdKS7BnGF1diebpjq7AyRJ/5QQqrDT5YuN4PDSJKkzj
        7LE/9fH5G7NL9O3wsuieCW9qpUsVk0B8UoPoQk0ydkGxTo9ZR11jGEF7Kdmd2ZAM
        2vURoBvCzEA2pjZljQv1UIpWQdq5DsqnnTdfMefP7KPJzPrY5G5mktYQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=ZgLj+e4X7MDRK6SM7/arel7PF4jkctUY0AARU+B4fj4=; b=yvf9ucN5
        eXGOfdPkwl0v+SqaPocO3rDycuj4yrdJwGj0rZ0u3S0g9dydrpKqs3CComcYMStF
        9dFUMzKlKz8vOJsjarOTpYOgBwQ5OOHJ7NN5uz9qtIZuCDDZUXDe+dGMNecTJE/9
        iiZrQBaTpbqloI9sBW8HUZ9KQ9Z/6JLYGb2MNgq1fEMjpaoTgXE4u9i5EHfuAU8l
        PEkVu7YAwA+qpdib+PJ1bldBPsjEtdPdfN6TTTYP2uXP0oAOWl8sUPgkQ3EGlEDC
        6R/ADdQ98X75WSXxEtbamBgjr0FQtY5uzmbvxvwGLPJjw2amlQgnoADnyaELAgwr
        c7IetGQKt5s6GA==
X-ME-Sender: <xms:9ulNXUzV1wxm6rCnuXmUJKZMGrpEnAk69JpdsbmYnhToOhnq9EG1vA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddruddukedgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegu
    gihusegugihuuhhurdighiiiqeenucfkphepudelledrvddtuddrieegrddufeeknecurf
    grrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiiinecuvehluhhsthgv
    rhfuihiivgepud
X-ME-Proxy: <xmx:9ulNXZtD6MwjaNYQhHZd3cWSgtXpI695XnZ-bN5z4riR-DMEXohWtw>
    <xmx:9ulNXRVS-XdmNPJVQ-yAfK-NOmiAAf2PglDTjLVyINaIjU-orq2mSA>
    <xmx:9ulNXXAW7sn7PAjJQ27Nx3JZ9YgsZT6vMNP0kEpJV_p-FTtObR3evw>
    <xmx:9ulNXZ3MjviaL4YZ2lMa1Wnw4oREUk_r-vx2SjEtYTgfuJbNA1l1aA>
Received: from dlxu-fedora-R90QNFJV.thefacebook.com (unknown [199.201.64.138])
        by mail.messagingengine.com (Postfix) with ESMTPA id E8984380075;
        Fri,  9 Aug 2019 17:47:32 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     songliubraving@fb.com, yhs@fb.com, andriin@fb.com,
        peterz@infraded.org, mingo@redhat.com, acme@kernel.org
Cc:     Daniel Xu <dxu@dxuuu.xyz>, ast@fb.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 bpf-next 2/4] libbpf: Add helpers to extract perf fd from bpf_link
Date:   Fri,  9 Aug 2019 14:46:40 -0700
Message-Id: <20190809214642.12078-3-dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190809214642.12078-1-dxu@dxuuu.xyz>
References: <20190809214642.12078-1-dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is sometimes necessary to perform ioctl's on the underlying perf fd.
There is not currently a way to extract the fd given a bpf_link, so add a
a pair of casting and getting helpers.

The casting and getting helpers are nice because they let us define
broad categories of links that makes it clear to users what they can
expect to extract from what type of link.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 tools/lib/bpf/libbpf.c   | 19 +++++++++++++++++++
 tools/lib/bpf/libbpf.h   |  8 ++++++++
 tools/lib/bpf/libbpf.map |  6 ++++++
 3 files changed, 33 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index ead915aec349..f4d750863abd 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -4004,6 +4004,25 @@ static int bpf_link__destroy_perf_event(struct bpf_link *link)
 	return err;
 }
 
+const struct bpf_link_fd *bpf_link__as_fd(const struct bpf_link *link)
+{
+	if (!link)
+		return NULL;
+
+	if (link->destroy != &bpf_link__destroy_perf_event)
+		return NULL;
+
+	return (struct bpf_link_fd *)link;
+}
+
+int bpf_link_fd__fd(const struct bpf_link_fd *link)
+{
+	if (!link)
+		return -1;
+
+	return link->fd;
+}
+
 struct bpf_link *bpf_program__attach_perf_event(struct bpf_program *prog,
 						int pfd)
 {
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 8a9d462a6f6d..4498b6ae459a 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -166,6 +166,14 @@ LIBBPF_API int bpf_program__unpin(struct bpf_program *prog, const char *path);
 LIBBPF_API void bpf_program__unload(struct bpf_program *prog);
 
 struct bpf_link;
+struct bpf_link_fd;
+
+/* casting APIs */
+LIBBPF_API const struct bpf_link_fd *
+bpf_link__as_fd(const struct bpf_link *link);
+
+/* getters APIs */
+LIBBPF_API int bpf_link_fd__fd(const struct bpf_link_fd *link);
 
 LIBBPF_API int bpf_link__destroy(struct bpf_link *link);
 
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index f9d316e873d8..b58dd0f0259c 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -184,3 +184,9 @@ LIBBPF_0.0.4 {
 		perf_buffer__new_raw;
 		perf_buffer__poll;
 } LIBBPF_0.0.3;
+
+LIBBPF_0.0.5 {
+	global:
+		bpf_link__as_fd;
+		bpf_link_fd__fd;
+} LIBBPF_0.0.4;
-- 
2.20.1

