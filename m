Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B56CC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 09:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 193E920815
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 09:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557911319;
	bh=93+hwjR+w10zrRciL6qS4A51sEOe7GwHd9c0pmdYCQE=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=1NcmcWUipHa8AjJb0vtIrbnVHoSfqW2ZB3U18o6zd4Hjcn+Txb0u6ECuiFBko0Erj
	 PzCBmxp4xt+i9JNd2fRjgkGhtdDdHNDwU0fhaclfHgxGpF91DUiVt/lzHfY3oNPGaz
	 tJs/AbO96IZZ6PvvvSAtgmOhwge+CgcoefTLcWJE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbfEOJIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 05:08:38 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:38179 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726084AbfEOJIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 05:08:37 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id BC9412585C;
        Wed, 15 May 2019 05:08:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 15 May 2019 05:08:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=QzKWRK6NBMbQhyE5i
        rhebHpSXfQiq/oIHcfVwvxA9Y4=; b=X4g8GcvpmrFXvz4Gj+kjjbvd4BPxDWmlu
        mNe90vPHAMVXSibDmqRNLZb64qEOgU228oZwvNPD74T9V6CdAUsZ6J55nusBzdhC
        4vFb40XprJhib+5m3b0NFw65vVO1G0ZCPv+n+1STYqckkhDn+rNNvdhk1/PnIXng
        3B1bBP8iZhS+0AdcJ1Ih54UKFoX152+nrRB2/2lrqICOFdKpfzo6o5OLm0ScRsGN
        fqBu+46x5v7yePLyzOWBN7Xw48SwYG9nrUAAxAJc9zUiCLxDL9xm2zQQEFW7AcPb
        h2ju5oVCv1bJFlQqq6owvWKHsWkrIK0iT0cqgRml0610dGsw4qK4Q==
X-ME-Sender: <xms:E9fbXGVMGEptq4lh2RslL3ArPI-x-CuE5CUGVOIO_Dq_ox8-7U9b2g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrleekgddufecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhnucev
    rdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkphepud
    dvuddrgeegrddvvdefrddvuddunecurfgrrhgrmhepmhgrihhlfhhrohhmpehtohgsihhn
    sehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:E9fbXM7rxPa7ECgArhApF1fvOBPthKBeUL1zvWMDd9vcXBhU5uN0TQ>
    <xmx:E9fbXB5rLkY5YhKlE8JSgRqNgSDwtoWviUMDDS6UM_kNrDtIYRFbiQ>
    <xmx:E9fbXMHEWC3oc2unyDvSJsVOOO16s5StNp-bUos_MySsDuvlPtK1RA>
    <xmx:FNfbXA5U7c8WkVrzs-DrEv-MfDHDi9NwbMb_B6uBsxgtr_pM0CH8Eg>
Received: from eros.localdomain (ppp121-44-223-211.bras1.syd2.internode.on.net [121.44.223.211])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1E8C81037C;
        Wed, 15 May 2019 05:08:32 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: Remove double free
Date:   Wed, 15 May 2019 19:07:50 +1000
Message-Id: <20190515090750.30647-1-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kfree() after kobject_put().  Who ever wrote this was on crack.

Fixes: 7e8039795a80 ("powerpc/cacheinfo: Fix kobject memleak")
Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---

FTR

git log --pretty=format:"%h%x09%an%x09%ad%x09%s" | grep 7e8039795a80
7e8039795a80	Tobin C. Harding	Tue Apr 30 11:09:23 2019 +1000	powerpc/cacheinfo: Fix kobject memleak

 arch/powerpc/kernel/cacheinfo.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/kernel/cacheinfo.c b/arch/powerpc/kernel/cacheinfo.c
index f2ed3ef4b129..862e2890bd3d 100644
--- a/arch/powerpc/kernel/cacheinfo.c
+++ b/arch/powerpc/kernel/cacheinfo.c
@@ -767,7 +767,6 @@ static void cacheinfo_create_index_dir(struct cache *cache, int index,
 				  cache_dir->kobj, "index%d", index);
 	if (rc) {
 		kobject_put(&index_dir->kobj);
-		kfree(index_dir);
 		return;
 	}
 
-- 
2.21.0

