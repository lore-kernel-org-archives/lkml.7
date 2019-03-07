Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C710C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 21:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA53720851
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 21:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551993162;
	bh=FEhu89AafxbwzLvnEuDQrJBmCNPs+nVqyr+Wh8s1G0g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hZHJt/JKP1lAgIb8djtW4ScjEf6/EwmMpXVlTKpkcKhjIEepgeB+LEJX4IPyLBZYY
	 t15n44C2C/ZpPxEf+gQgUdrIHFK2SuYao/J+DX/vstB+li0dWCpBrYTYVzE2VJyeVd
	 /rsrndgiZqSp3acgY9Ib+Lnhk7lAXwfkEHuk53MY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbfCGVMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 16:12:40 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:42321 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726399AbfCGVMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 16:12:38 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id A50033729;
        Thu,  7 Mar 2019 16:12:37 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 07 Mar 2019 16:12:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=sl0/N9C6zTew6r0AmJjt/i5bgUmqZ7m+uQgINZNciSE=; b=L30+ooeJ
        pE9KT/vzzsWOhcsWzWowiCBUAsejVKDL66Ra9APu79en9n8BTJdMRIrOnHJOwkiB
        iUHzbU4cNCldfe9myuFRNg0psH3jnboOQBtfym57MILqHJcUYFQ+Xk+//ufWszMK
        H6piIZwoBCHONMUDW/tVKlDAjqgT6HN77K0Z/1ez/Jn3EzajGnN1za4jrKsc3w97
        C/m5JeviK00dQEz+RsZjHn5AD0432EC8CRbQuA9ljq9fnkyLM0N/b3Qm3OOYe4Ep
        0mpmoDhVTRvq5fWCKdy0jFtA6qYv8B9xARyD/xM/gFH09bd1Snnki6qNrBQp7Gk7
        m6Szkb2m6eMZtA==
X-ME-Sender: <xms:RYmBXMWJlW0SKOnBGNIi9qjvrGUNyMaiEujUTvM80eULJotoVV4KmQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrfeekgdduhedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpedfvfhosghi
    nhcuvedrucfjrghrughinhhgfdcuoehtohgsihhnsehkvghrnhgvlhdrohhrgheqnecukf
    hppeduvdegrdduieelrdehrdduheeknecurfgrrhgrmhepmhgrihhlfhhrohhmpehtohgs
    ihhnsehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpeef
X-ME-Proxy: <xmx:RYmBXO0Zeo_Bts6kPfn3RNgxHXEyW_4GXAvBkIrPb87VprC_yMatIQ>
    <xmx:RYmBXKh7sD1MVvfdMktt83dLdT2oDgu-5QgpTD7sJJIHRK8rxtX_Ug>
    <xmx:RYmBXHvx_1EXKcHh5jYCjmX2k9YMaSqGJDqw0ah6UWKvuwlhVUtrSg>
    <xmx:RYmBXAGOcLgVu42qbSAGhlHNssezPDtqsgCXSQMiDKTEvWtIND_qRQ>
Received: from eros.localdomain (124-169-5-158.dyn.iinet.net.au [124.169.5.158])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0E6DC10336;
        Thu,  7 Mar 2019 16:12:34 -0500 (EST)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     "Tobin C. Harding" <tobin@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/9] docs: Use correct list markup character
Date:   Fri,  8 Mar 2019 08:11:50 +1100
Message-Id: <20190307211153.28400-7-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190307211153.28400-1-tobin@kernel.org>
References: <20190307211153.28400-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sphinx uses a star not a hyphen for lists.

Use correct list markup character.

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 Documentation/driver-api/gpio/board.rst |  5 +++--
 Documentation/laptops/lg-laptop.rst     | 12 ++++++------
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/Documentation/driver-api/gpio/board.rst b/Documentation/driver-api/gpio/board.rst
index a0f294e2e250..a5d5c22ab610 100644
--- a/Documentation/driver-api/gpio/board.rst
+++ b/Documentation/driver-api/gpio/board.rst
@@ -204,8 +204,9 @@ between a caller and a respective .get/set_multiple() callback of a GPIO chip.
 
 In order to qualify for fast bitmap processing, the array must meet the
 following requirements:
-- pin hardware number of array member 0 must also be 0,
-- pin hardware numbers of consecutive array members which belong to the same
+
+* pin hardware number of array member 0 must also be 0.
+* pin hardware numbers of consecutive array members which belong to the same
   chip as member 0 does must also match their array indexes.
 
 Otherwise fast bitmap processing path is not used in order to avoid consecutive
diff --git a/Documentation/laptops/lg-laptop.rst b/Documentation/laptops/lg-laptop.rst
index e486fe7ddc35..d9e560dfd045 100644
--- a/Documentation/laptops/lg-laptop.rst
+++ b/Documentation/laptops/lg-laptop.rst
@@ -9,12 +9,12 @@ Hotkeys
 -------
 
 The following FN keys are ignored by the kernel without this driver:
-- FN-F1 (LG control panel)   - Generates F15
-- FN-F5 (Touchpad toggle)    - Generates F13
-- FN-F6 (Airplane mode)      - Generates RFKILL
-- FN-F8 (Keyboard backlight) - Generates F16.
-  This key also changes keyboard backlight mode.
-- FN-F9 (Reader mode)        - Generates F14
+
+* FN-F1 (LG control panel)   - Generates F15
+* FN-F5 (Touchpad toggle)    - Generates F13
+* FN-F6 (Airplane mode)      - Generates RFKILL
+* FN-F8 (Keyboard backlight) - Generates F16 (This key also changes keyboard backlight mode)
+* FN-F9 (Reader mode)        - Generates F14
 
 The rest of the FN key work without a need for a special driver.
 
-- 
2.21.0

