Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43ABC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 21:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DD5320675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 21:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551993153;
	bh=lWvqODGdP87wTZvAsqmzfS3PcmF6+NyDEQKCiFwZ5J4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2qUyYQSN94WjidAHvS9fv6/TZhXxzTTcfkqHXgMk1rPLjjJF+PAxx1ELML86Wpb2f
	 rVIUT3asktPuQTZc+sA1/NnU4eT3BEYGYiEw67Z9sDcfBff63Bq1bUeLGFsx41o9Lu
	 ImcQI9fDbuEufTsL8IL0zfcxyMmHn0kFiBiq9/eQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbfCGVMc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 16:12:32 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:44645 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726224AbfCGVM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 16:12:28 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 53DC33556;
        Thu,  7 Mar 2019 16:12:27 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 07 Mar 2019 16:12:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=yul0rYWeVhXSUyknp6WDYiMWC3yNoiMnSNHOntK0nOk=; b=oIuCYf/N
        ywjtUo/yYXybjx5Xck/KGBVQTB+RJbpZU7+TsLXDyaye9o1AiksThpw7dCeKkjr0
        jPsOm8PRNoJz5wwEPuZ1ZwND/afFKYHDqMhEE60kz2wMyGhfQJzenAYGD9cWh5Gt
        TUNO1jrL7i9GBr5DrUxQSauXuH0C8FoVVuue1Yp9Xf5hyxWqD9pT18HAAWfusjC7
        KylPw/F9YgBdAuQj2bfmh3S0doSkV/1iHnOqre3ZtBcwwaJUC2httorn7ajsfcCs
        sMO/fsY4YfwnEsnGPQO94Gzjc1S4V5Le4eaxVHJqDiqpmmbFJ11npSAfAmFSJ3D5
        v9P6m5DDmGVA1g==
X-ME-Sender: <xms:OomBXDTQ2vBlcDskgBgggoeqehhdGjdggCTOhz_JyjMPlbDCr-Ay7A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrfeekgdduhedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpedfvfhosghi
    nhcuvedrucfjrghrughinhhgfdcuoehtohgsihhnsehkvghrnhgvlhdrohhrgheqnecukf
    hppeduvdegrdduieelrdehrdduheeknecurfgrrhgrmhepmhgrihhlfhhrohhmpehtohgs
    ihhnsehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:OomBXF0V2hMk8rnK4kAvlvNFCpP3hCr_2ChwkoaxwZCZOzus3DEWiw>
    <xmx:OomBXLx7UPFB_X2Ysfhv75xwNvOL0-QrfWtkRprA18agbr-FSjehzg>
    <xmx:OomBXAvdmXqexAWzJTebQggklkbcwhBvvhW_B3-3XWNVrMs-qSABLQ>
    <xmx:OomBXObFgbgi7eMRHiXcjX5b2jFUS24CDTmxcJ9SfT5rrGoMlTY8TQ>
Received: from eros.localdomain (124-169-5-158.dyn.iinet.net.au [124.169.5.158])
        by mail.messagingengine.com (Postfix) with ESMTPA id E70BE10310;
        Thu,  7 Mar 2019 16:12:24 -0500 (EST)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     "Tobin C. Harding" <tobin@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/9] docs: Add colon clearing sphinx warning
Date:   Fri,  8 Mar 2019 08:11:46 +1100
Message-Id: <20190307211153.28400-3-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190307211153.28400-1-tobin@kernel.org>
References: <20190307211153.28400-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sphinx emits various warnings all caused by missing colons before code
blocks:

	WARNING: Inline emphasis start-string without end-string.
	WARNING: Block quote ends without a blank line; unexpected unindent.
	ERROR: Unexpected indentation.
	WARNING: Block quote ends without a blank line; unexpected unindent.

Add the colon, clearing sphinx warnings.

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 Documentation/vm/slub.rst | 2 +-
 include/linux/wait.h      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/vm/slub.rst b/Documentation/vm/slub.rst
index 195928808bac..610510d90c33 100644
--- a/Documentation/vm/slub.rst
+++ b/Documentation/vm/slub.rst
@@ -66,7 +66,7 @@ Trying to find an issue in the dentry cache? Try::
 to only enable debugging on the dentry cache.  You may use an asterisk at the
 end of the slab name, in order to cover all slabs with the same prefix.  For
 example, here's how you can poison the dentry cache as well as all kmalloc
-slabs:
+slabs::
 
 	slub_debug=P,kmalloc-*,dentry
 
diff --git a/include/linux/wait.h b/include/linux/wait.h
index ed7c122cb31f..deedfe2b9ffe 100644
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

