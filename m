Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE207C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 21:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB64720854
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 21:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551993160;
	bh=hkwv/dazw2A/Cv6aivCdBAnBwyoSSJV4aZ0w/QhY4kA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Lx0L68RKA8ZMpth+vQ3oHm7tw6LEMv1sQ3KEFsLM5dtdO1GxnbQAbqdrNIkyaiVXu
	 HYH81tuiI3onpHKwyN8eapixGovm145DOv6XEycjmiNscQfdVaO5+eTxbOPku6d1aD
	 LrTN+jpdNaoJrmXPKETGS6OGcQSHIgrNYERMCLDg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbfCGVMj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 16:12:39 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:46891 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726380AbfCGVMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 16:12:35 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id A459E3540;
        Thu,  7 Mar 2019 16:12:34 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 07 Mar 2019 16:12:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=w6DnkOJdeCd08m/4a4WGsB39s0VMdxxDOkNHYP72TR8=; b=rSe+ZWxN
        TJBdt0GtTxchF/IYxpnEqnpUCTAA3NGeZMP5+UAStGs3CTQXyjkCw+Ui+uhgc+f6
        U9AqiJYXKh58OJBetVxzU4bTCyLVAxdxVi7ePTrvCrH9vuU9g3tDPP8EcUKsPVdF
        XWWubhvcUzKwTZbPq2on1zXwKSm+Ox3CquusZY1uopbytZCZ3Th/lEbRsXKNzmns
        N5/aLb4Adfsi0oTcL82jFN0Oi7Pob87feGrMgYrbeQTiBrkngHCDVGA9OGqGqguq
        gSVYlrdHhVSIKrthFl9Jfd4VvbFlsSv8Z5aykIW5xOQaS01V/H5OUnCjkGn1yBCj
        UmhuLO9ayPkm2w==
X-ME-Sender: <xms:QomBXJ-Ofx2_E9-1UQ6GeOe8M6X8yMb31Z4A2sFOK6fet6MMPPtK2Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrfeekgdduhedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpedfvfhosghi
    nhcuvedrucfjrghrughinhhgfdcuoehtohgsihhnsehkvghrnhgvlhdrohhrgheqnecukf
    hppeduvdegrdduieelrdehrdduheeknecurfgrrhgrmhepmhgrihhlfhhrohhmpehtohgs
    ihhnsehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpeef
X-ME-Proxy: <xmx:QomBXIM7wjCxkawoIYlxLtAyDPZnDncXbJaYwZUKHRoJJ_PyHxslng>
    <xmx:QomBXD-mFAHmjewsiqT85RImXsrlzo5ZP1re78Pfct2kQbfFPoQZEw>
    <xmx:QomBXAIqqAKOqME0jz__6CQd-68jk4MAl2-U0QIWR5sK6TN9XvcfpQ>
    <xmx:QomBXKwX2WewgJIiWaWRxJ6M4jbgYTlonbp36mhnxXKuDNjJRXo6Bg>
Received: from eros.localdomain (124-169-5-158.dyn.iinet.net.au [124.169.5.158])
        by mail.messagingengine.com (Postfix) with ESMTPA id 445FC10310;
        Thu,  7 Mar 2019 16:12:31 -0500 (EST)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     "Tobin C. Harding" <tobin@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/9] docs: Replace backtick with apostrophe.
Date:   Fri,  8 Mar 2019 08:11:49 +1100
Message-Id: <20190307211153.28400-6-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190307211153.28400-1-tobin@kernel.org>
References: <20190307211153.28400-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sphinx emits:

	WARNING: Inline interpreted text or phrase reference
	start-string without end-string.

This is caused by a spurious backtick.

Replace backtick with apostrophe.

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 include/linux/kernel.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 8f0e68e250a7..59c16c763086 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -134,7 +134,7 @@
  * Rounds @x up to next multiple of @y. If @y will always be a power
  * of 2, consider using the faster round_up().
  *
- * The `const' here prevents gcc-3.3 from calling __divdi3
+ * The 'const' here prevents gcc-3.3 from calling __divdi3
  */
 #define roundup(x, y) (					\
 {							\
-- 
2.21.0

