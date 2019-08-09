Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F42CC31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 21:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6AAD208C4
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 21:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="UArCW82d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MIe7e5rN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729203AbfHIVri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 17:47:38 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:37625 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729089AbfHIVrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 17:47:37 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 1D6EF20D4;
        Fri,  9 Aug 2019 17:47:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 09 Aug 2019 17:47:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=M+Jh0rXI0nh88
        AZ6KuRStyi951WXDkzY3rdW8qCW/Rg=; b=UArCW82dFWjv6htofCoBSGWmZryiV
        vQPSimVMCBLKKJjw2W7gcRDBsNqyVxa982v7yOWSBn5R2ZDCarcaVhO5hc9pchWe
        x474jnkUGhsUjt00fwHG7juabwwBnLNhy6YnAc5RAxXwkQhd16/OVxPKoBqtk1G8
        GS6HLfAW+sadLw6TbXS+0ZhmMBzToycqy7oj9WORQbA2d+6kuwe+VxvRRtpGpLGz
        qW4TPPmSRQjxdAjlznuK140Xhd7bnfoFDIhxAFC5CHbYa1aKfEipYONPebl4KjGh
        ahUb19Guvtzw8DUPejdqkbAJC7ycR5JJfNTrn29pxuIoYbHFFYOydaRgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=M+Jh0rXI0nh88AZ6KuRStyi951WXDkzY3rdW8qCW/Rg=; b=MIe7e5rN
        Pnaxkrj/ceTijCpVpmVeq2+YwxVXCxMcysuMPq+dpZxy+3dLlE+uL+Z6bnt6Uwh4
        QaOMXeK5AUp8DnboldyhyXwVJ5BQX+lF/SlS3xVfOIAHAloHnoasfoUemrHZC9Rs
        yQwsqncDJZGd0Y8yAs9wA5E9uyrJpKwI4vkJwABcghpReHh1i/5kcTx3ZVjhLSsy
        qU5dyehZGScGrJbImCCe1PQaVHSuWzm/4zehUPhuPBoGMm41VMDhbWe94tgFrE3Z
        9YpUZjKNoIx1hVnbrzQJejWHt4rXEGeKuB58ejBPKnnvy7rLdunEFIogOnqVvO8f
        Sg1ghJg6bPROTg==
X-ME-Sender: <xms:9-lNXYeG8SZPM1HHdexAUNFAgvIAlEp3YrlcAihyNaZCiLe7XuNuQQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddruddukedgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegu
    gihusegugihuuhhurdighiiiqeenucfkphepudelledrvddtuddrieegrddufeeknecurf
    grrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiiinecuvehluhhsthgv
    rhfuihiivgepud
X-ME-Proxy: <xmx:9-lNXe4U2Mm3O8nk23V7SSsWTSGc_jVFTixdsWNY5gYrLpEkcW8LAg>
    <xmx:9-lNXZwlJSb6m_E627a1JJZ1cg1x5NAf-4hrJFv_bip5K32YABuXUg>
    <xmx:9-lNXSFoK5wqCThSJoj74B1ikbrUuCcx1UYcSpaxFWtrerHxb4YPOA>
    <xmx:-OlNXTw4-yxnCNsIFYSMYHRaJ7dhl-tcqODy3UBVwlQulCnlV7-Nvw>
Received: from dlxu-fedora-R90QNFJV.thefacebook.com (unknown [199.201.64.138])
        by mail.messagingengine.com (Postfix) with ESMTPA id 65EB8380083;
        Fri,  9 Aug 2019 17:47:34 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     songliubraving@fb.com, yhs@fb.com, andriin@fb.com,
        peterz@infraded.org, mingo@redhat.com, acme@kernel.org
Cc:     Daniel Xu <dxu@dxuuu.xyz>, ast@fb.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 bpf-next 3/4] tracing/probe: Sync perf_event.h to tools
Date:   Fri,  9 Aug 2019 14:46:41 -0700
Message-Id: <20190809214642.12078-4-dxu@dxuuu.xyz>
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
 tools/include/uapi/linux/perf_event.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 7198ddd0c6b1..65faa9b2a3b4 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -447,6 +447,24 @@ struct perf_event_query_bpf {
 	__u32	ids[0];
 };
 
+/*
+ * Structure used by below PERF_EVENT_IOC_QUERY_PROBE command
+ * to query information about the probe attached to the perf
+ * event. Currently only supports [uk]probes.
+ */
+struct perf_event_query_probe {
+	/*
+	 * Set by the kernel to indicate number of times this probe
+	 * was temporarily disabled
+	 */
+	__u64	nmissed;
+	/*
+	 * Set by the kernel to indicate number of times this probe
+	 * was hit
+	 */
+	__u64	nhit;
+};
+
 /*
  * Ioctls that can be done on a perf event fd:
  */
@@ -462,6 +480,7 @@ struct perf_event_query_bpf {
 #define PERF_EVENT_IOC_PAUSE_OUTPUT		_IOW('$', 9, __u32)
 #define PERF_EVENT_IOC_QUERY_BPF		_IOWR('$', 10, struct perf_event_query_bpf *)
 #define PERF_EVENT_IOC_MODIFY_ATTRIBUTES	_IOW('$', 11, struct perf_event_attr *)
+#define PERF_EVENT_IOC_QUERY_PROBE		_IOR('$', 12, struct perf_event_query_probe *)
 
 enum perf_event_ioc_flags {
 	PERF_IOC_FLAG_GROUP		= 1U << 0,
-- 
2.20.1

