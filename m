Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 370E6C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 00:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05FEA218D2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 00:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554770683;
	bh=jXjbj24UKC076N6AfrysWFnBFfyMtEZB4zOnoUvyc7g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=A3Pgz6NgdCM12NLqpTvaM2F1lcp7IKvp5zHTF4tM9/8t0PnSMwz6CS+LnWJ7w+y1W
	 QIgUJ59sA9Pd1vJ9/x2H+PNoDaeThykOQMZmGtmMf330NS0H/CpFkkxVkyDuFE2BjL
	 aI8Vl3APS1MaQoEkud2iB6j5B+ZICjJQsNIrRHGM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbfDIAol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 20:44:41 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:42003 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726387AbfDIAoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 20:44:38 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 26C652358E;
        Mon,  8 Apr 2019 20:44:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 08 Apr 2019 20:44:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=IoSsJ4sUh4VfoBFuUrfdasLe2/8nhzRQoUZ6TSY0e4o=; b=jITBR7Cy
        VtP8B0f9UZfYj2VoIB/Wq63pB4SiM0fPUGyy0RuTh60BmDW0yb2gJUoER8XfuOyr
        1RL1gbycUG1vNg38HUxox5G4ryqbFitbajwhalKAMgWoYhLFzHh7cAPK9zmUX5j1
        oRqurLy3ic6OGkbJEE22BQck/P0CUFgy2r5Swp4wqSEvDd1j/rtxWIOSMr7akUE+
        3hbYtK3E4venWlbnfP7Dgf+zc/t0ZeZ2z4Dc/Ytx1ho6m8NlZvF6dQF6XZuhACIs
        Dp6TieXAiaOpM4vn26DchNrPBm3PPmFDs8SKkANJRe4zRIvTAvoVoP5FEQQrWW0Y
        sXMNeFmOy4eTPQ==
X-ME-Sender: <xms:9uqrXAAGO9eMcBc6nxJ9FJYP0ybdfccPmABFwPd3P8433E4VRDmLJg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrudeggdefiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhn
    ucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkph
    epuddvuddrgeegrddvudejrdehtdenucfrrghrrghmpehmrghilhhfrhhomhepthhosghi
    nheskhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:9uqrXH6Q6IQx4C5xSBtjpcmXlbjkeCt90o-jI_6Yghq1c2DfegQJQg>
    <xmx:9uqrXGpRSaAJnPqKkvW4EJbsdFte2yxhm67hLVEpA1lYLhsj116DuA>
    <xmx:9uqrXLbZ5q3WHD6Cj_02_nSnaRxIw12o8eeepuq-gOxu4DMIKD7Blg>
    <xmx:9uqrXIEH90bOpXnofVpOMkOz2Eq06KGSfH5_uflDnREDWbXqKFRtig>
Received: from eros.localdomain (ppp121-44-217-50.bras1.syd2.internode.on.net [121.44.217.50])
        by mail.messagingengine.com (Postfix) with ESMTPA id 12E6EE42C9;
        Mon,  8 Apr 2019 20:44:35 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     "Tobin C. Harding" <tobin@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] docs: Add colon clearing sphinx warning
Date:   Tue,  9 Apr 2019 10:43:57 +1000
Message-Id: <20190409004359.29668-3-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190409004359.29668-1-tobin@kernel.org>
References: <20190409004359.29668-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sphinx emits various warnings all caused by a missing colon before code
block:

	WARNING: Block quote ends without a blank line; unexpected unindent.
	ERROR: Unexpected indentation.
	WARNING: Block quote ends without a blank line; unexpected unindent.

Add the colon, clearing sphinx warnings.

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 include/linux/wait.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/wait.h b/include/linux/wait.h
index 5f3efabc36f4..b6f77cf60dd7 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -101,7 +101,7 @@ init_waitqueue_func_entry(struct wait_queue_entry *wq_entry, wait_queue_func_t f
  * lead to sporadic and non-obvious failure.
  *
  * Use either while holding wait_queue_head::lock or when used for wakeups
- * with an extra smp_mb() like:
+ * with an extra smp_mb() like::
  *
  *      CPU0 - waker                    CPU1 - waiter
  *
-- 
2.21.0

