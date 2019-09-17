Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D74CC4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 13:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0073E21852
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 13:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="ENVCxXQk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lnPWJyZh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbfIQNb6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 09:31:58 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:57951 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726131AbfIQNbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 09:31:34 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 828C01282;
        Tue, 17 Sep 2019 09:31:32 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 17 Sep 2019 09:31:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=pIV+W4mI1mhQp
        QNrmXn//XRASWzx2LWV3Ls02jzraw0=; b=ENVCxXQkFfhNjUfhdYmzVlcevTVgd
        EPhnebAPkQLgkbGp25kVPo7g6CsstQBvv7ytxBt5QNV/GiPKpUPYLumPsxcGmfTR
        vjk9oHYjgnvW2PLSc0F3CmS+TTJUH73D8HebLybm8UN45z7/x7HDygqkAFsiITg6
        0EmgXohZMoeWFL/ecb639JA/QoiW4K93vL5xxUGNh0QPWOH8oQxaZBE+VSVPfoVO
        RwRgjHgtbZhPkaFsU97pzYAEioDLNLjgNP2grbVy7ScRgqugD/LItgMb9JLsp7LE
        eAi7pdgVb0bFNeUmn+h+sYOJjB4JOLNo9pr49isnoWNwig2EJInr0yxMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=pIV+W4mI1mhQpQNrmXn//XRASWzx2LWV3Ls02jzraw0=; b=lnPWJyZh
        4aP3xY877eQFYxlVN3g7kuQqZSuUBLM4MFOU3DMtxkZsj9Kom8JhaFpbNydXxLVh
        NdQ0AUDVXD7CLApslf8MR5oswUJGT0ILrKUCNjuyHSMD68tmkwIl8fuHkFWHPXqo
        ZfBoSjX2qIXFqntKhlA+6urMnuEmhrvVx9CnuAQQZF3kKLzre5qlmnqIH1Ipm5kn
        EOCOho+zNhGByEvM4FTH5+Zi2/7y7n4e+m1LI3OO6MNgczTxUdAiPY/KT3SHUy8P
        Xxa5XzXvMExy7lGjAk1XYms0VeHWlWsvEjCA5NbHxLuKdVroHmJu8HvF56qVxktY
        PxHGsqVrgsplLw==
X-ME-Sender: <xms:NOCAXZhUMvKvKvjCrFETRbTgv_NUJYdSuDiwSEZYo5rnpWSzrohAVg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudeigdefkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhephffvuf
    ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceougig
    uhesugiguhhuuhdrgiihiieqnecukfhppeduleelrddvtddurdeiiedrtdenucfrrghrrg
    hmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihiienucevlhhushhtvghrufhi
    iigvpedu
X-ME-Proxy: <xmx:NOCAXZ7jkf_b-gnQKanjZbNhjyMjsRttDYexPjhZn54LFVQWmHTnpA>
    <xmx:NOCAXUnFWcbTRVaD4DiJkpz02nDPx7bMKKL6zkyhaUYEl8TRJuWeKw>
    <xmx:NOCAXSOAN5yxQ6cZBGXMPC28xpnQmghX-YP-4yGfY2eLHdnhDpFd7g>
    <xmx:NOCAXVYbcgnVjmR9hly5dGau9Dyv4kvNISQBMmU5EelGWxh6vmhqk0CUUvQ>
Received: from dlxu-fedora-R90QNFJV.thefacebook.com (unknown [199.201.66.0])
        by mail.messagingengine.com (Postfix) with ESMTPA id 15032D6005A;
        Tue, 17 Sep 2019 09:31:31 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     bpf@vger.kernel.org, songliubraving@fb.com, yhs@fb.com,
        andriin@fb.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org
Cc:     Daniel Xu <dxu@dxuuu.xyz>, ast@fb.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH bpf-next 2/5] perf/core: Sync perf_event.h to tools
Date:   Tue, 17 Sep 2019 06:30:53 -0700
Message-Id: <20190917133056.5545-3-dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190917133056.5545-1-dxu@dxuuu.xyz>
References: <20190917133056.5545-1-dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 tools/include/uapi/linux/perf_event.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 7198ddd0c6b1..bd874c7257f0 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -273,6 +273,7 @@ enum {
  *	  { u64		time_enabled; } && PERF_FORMAT_TOTAL_TIME_ENABLED
  *	  { u64		time_running; } && PERF_FORMAT_TOTAL_TIME_RUNNING
  *	  { u64		id;           } && PERF_FORMAT_ID
+ *	  { u64		missed;       } && PERF_FORMAT_LOST
  *	} && !PERF_FORMAT_GROUP
  *
  *	{ u64		nr;
@@ -280,6 +281,7 @@ enum {
  *	  { u64		time_running; } && PERF_FORMAT_TOTAL_TIME_RUNNING
  *	  { u64		value;
  *	    { u64	id;           } && PERF_FORMAT_ID
+ *	    { u64	missed;       } && PERF_FORMAT_LOST
  *	  }		cntr[nr];
  *	} && PERF_FORMAT_GROUP
  * };
@@ -289,8 +291,9 @@ enum perf_event_read_format {
 	PERF_FORMAT_TOTAL_TIME_RUNNING		= 1U << 1,
 	PERF_FORMAT_ID				= 1U << 2,
 	PERF_FORMAT_GROUP			= 1U << 3,
+	PERF_FORMAT_LOST			= 1U << 4,
 
-	PERF_FORMAT_MAX = 1U << 4,		/* non-ABI */
+	PERF_FORMAT_MAX = 1U << 5,		/* non-ABI */
 };
 
 #define PERF_ATTR_SIZE_VER0	64	/* sizeof first published struct */
-- 
2.21.0

