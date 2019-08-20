Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC59AC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 21:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC64222DA7
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 21:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="n1cViQBo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M+KoGwTq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730999AbfHTVtP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 17:49:15 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:60659 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730866AbfHTVtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 17:49:04 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 2D6042CFE;
        Tue, 20 Aug 2019 17:49:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 20 Aug 2019 17:49:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=evbhp73Xk8bWT
        LyfS6KQIzihDp0fb6c/a4M3e31kJSI=; b=n1cViQBoOVXChiLULzrLRpsR3NBgV
        83aKYIeB/kwLMadT20lkAbu+XBIoYPHC0Rb13gaW/xwqukjZt5qDww6EtGRp6l+r
        AJGZSTmSK5x6TQqi1s4VmEpEgSNi1JMxUJl6Qzy/ujSzdbQiB9oKZ2FXhW7x6+7O
        s+d/fYhJ0xEtA6n3IalNqxtp35yQWIcX2YQytWNVqor+X6y9+iE3Z5NGyrtnm0kg
        Tys+uRkW/bWM7vkQjRq8jGEBl0KmqyEbUL3GwLD4aXl10LF7eB9XTfIUHMCugZxp
        8UaXhyiKs6dizauTR5Nb2tAEBIBZU4UNjA/7hBNtOSPJZsqpbdNRHUT/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=evbhp73Xk8bWTLyfS6KQIzihDp0fb6c/a4M3e31kJSI=; b=M+KoGwTq
        09BUUWEVKHN6Tm+IIB8BYRLmXtXq3vh8t854p12nUrb/xhrOt66zPYdQZTarIvBC
        YpFlMgnroFT5r9537ljQtYbc/uiw14i6M9u6kLWIDUAUsl9RtqdK0fEKXRZ6gJh5
        4EiDD/CcPWVQUpeFbZkJ7hOiuh5Gju/aZ9zGqXRPUd3ItJMa/SiiARUkjXSibMzw
        C+rHk0pQ8Sh6hAoAyfP58o2y4+AHfTOmqQfMa2KKaPGdiuHI6NVAvS1z+xk6Iae5
        xFFw11cR3y/TyrIrZegbWKIcf5mFQurnkcemU55pL4+KBBpYHLWfOjzA9KX7Bvp6
        9T/v4fisgsdXMQ==
X-ME-Sender: <xms:zmpcXZmWLcX75pXsuOnTUbymH9PdGNBvagt79o8gFhTE6MTzRN37Ew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudegvddgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfeehmdenucfjughrpefhvf
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegu
    gihusegugihuuhhurdighiiiqeenucfkphepudelledrvddtuddrieegrddvnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiiinecuvehluhhsthgvrhfu
    ihiivgepud
X-ME-Proxy: <xmx:zmpcXQnLUGk5Fx36LTpNr6aBOvPqpM7mxKxLk4Jp2fiRyCAAaiOEKA>
    <xmx:zmpcXSZaigdv9dhB94ZbZSh2W_ZfogNM11NLJe4znk146qFyhWaCPg>
    <xmx:zmpcXfmE1IEVmsj3CnrDNzJK-jr2V06z73jkQy3-EdT71qe_9Tm3GQ>
    <xmx:z2pcXQKJym_H99D_PTLjDzFz0iIYM4CzBiE-9ncXaONXCPjwAFI2Qg>
Received: from dlxu-fedora-R90QNFJV.thefacebook.com (unknown [199.201.64.2])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1299C80059;
        Tue, 20 Aug 2019 17:49:00 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     bpf@vger.kernel.org, songliubraving@fb.com, yhs@fb.com,
        andriin@fb.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org
Cc:     Daniel Xu <dxu@dxuuu.xyz>, ast@fb.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v4 bpf-next 2/4] libbpf: Add helpers to extract perf fd from bpf_link
Date:   Tue, 20 Aug 2019 14:48:17 -0700
Message-Id: <20190820214819.16154-3-dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190820214819.16154-1-dxu@dxuuu.xyz>
References: <20190820214819.16154-1-dxu@dxuuu.xyz>
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

Acked-by: Song Liu <songliubraving@fb.com>
Acked-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 tools/lib/bpf/libbpf.c   | 21 +++++++++++++++++++++
 tools/lib/bpf/libbpf.h   | 13 +++++++++++++
 tools/lib/bpf/libbpf.map |  3 +++
 3 files changed, 37 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 2233f919dd88..41588e13be2b 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -4876,6 +4876,7 @@ int bpf_prog_load_xattr(const struct bpf_prog_load_attr *attr,
 
 struct bpf_link {
 	int (*destroy)(struct bpf_link *link);
+	enum bpf_link_type type;
 };
 
 int bpf_link__destroy(struct bpf_link *link)
@@ -4909,6 +4910,24 @@ static int bpf_link__destroy_perf_event(struct bpf_link *link)
 	return err;
 }
 
+const struct bpf_link_fd *bpf_link__as_fd(const struct bpf_link *link)
+{
+	if (link->type != LIBBPF_LINK_FD)
+		return NULL;
+
+	return (struct bpf_link_fd *)link;
+}
+
+enum bpf_link_type bpf_link__type(const struct bpf_link *link)
+{
+	return link->type;
+}
+
+int bpf_link_fd__fd(const struct bpf_link_fd *link)
+{
+	return link->fd;
+}
+
 struct bpf_link *bpf_program__attach_perf_event(struct bpf_program *prog,
 						int pfd)
 {
@@ -4932,6 +4951,7 @@ struct bpf_link *bpf_program__attach_perf_event(struct bpf_program *prog,
 	if (!link)
 		return ERR_PTR(-ENOMEM);
 	link->link.destroy = &bpf_link__destroy_perf_event;
+	link->link.type = LIBBPF_LINK_FD;
 	link->fd = pfd;
 
 	if (ioctl(pfd, PERF_EVENT_IOC_SET_BPF, prog_fd) < 0) {
@@ -5225,6 +5245,7 @@ struct bpf_link *bpf_program__attach_raw_tracepoint(struct bpf_program *prog,
 	link = malloc(sizeof(*link));
 	if (!link)
 		return ERR_PTR(-ENOMEM);
+	link->link.type = LIBBPF_LINK_FD;
 	link->link.destroy = &bpf_link__destroy_fd;
 
 	pfd = bpf_raw_tracepoint_open(tp_name, prog_fd);
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index e8f70977d137..2ddef5315ff9 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -166,7 +166,20 @@ LIBBPF_API int bpf_program__pin(struct bpf_program *prog, const char *path);
 LIBBPF_API int bpf_program__unpin(struct bpf_program *prog, const char *path);
 LIBBPF_API void bpf_program__unload(struct bpf_program *prog);
 
+enum bpf_link_type {
+	LIBBPF_LINK_FD,
+};
+
 struct bpf_link;
+struct bpf_link_fd;
+
+/* casting APIs */
+LIBBPF_API const struct bpf_link_fd *
+bpf_link__as_fd(const struct bpf_link *link);
+
+/* getters APIs */
+LIBBPF_API enum bpf_link_type bpf_link__type(const struct bpf_link *link);
+LIBBPF_API int bpf_link_fd__fd(const struct bpf_link_fd *link);
 
 LIBBPF_API int bpf_link__destroy(struct bpf_link *link);
 
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 664ce8e7a60e..ed169579896f 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -188,4 +188,7 @@ LIBBPF_0.0.4 {
 LIBBPF_0.0.5 {
 	global:
 		bpf_btf_get_next_id;
+		bpf_link__type;
+		bpf_link__as_fd;
+		bpf_link_fd__fd;
 } LIBBPF_0.0.4;
-- 
2.21.0

