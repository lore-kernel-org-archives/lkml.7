Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F0DCC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 23:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DCF82064C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 23:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552950942;
	bh=txmzL9qyDgmrOy5l5Czsl5Q9wJBEjZAI/vVV5E/taJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BkrAH+YRLD+kISrL+z4FXYS0JrctAXIwmuPU9zS3mJqPUOeFtCqK+3vbybdNNIsY2
	 et7vaPAUpnWe8fe0Jdd8hHlJROWfZaKxYGMe9+aBwgjar8hinOBT+T6Kvdpum3t0Op
	 KoHQuu9PB7b+dGp2BmnJ6DT+2sG4miRtJp83PeJ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbfCRXPk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 19:15:40 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:37337 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727693AbfCRXPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 19:15:36 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 4D5A721EAE;
        Mon, 18 Mar 2019 19:15:35 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 18 Mar 2019 19:15:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=ooOKa/ZqqBINC0OX8j3RPnzyNMPjMfRf5UkgG248/x4=; b=Qah7eJzP
        l3i1z9Ws6s/h6BAk9+qNH7OkKO/tVL/zbpFXZR7JblGunHuSAq6JMnoU4mbdhIaF
        NpGQGHihn1ApJenhkDpGCXSagOSUuqWV1MNL6OftaR+5DfWo/NSC3mx59Xsi3qhp
        DybedDwvRLSI3QPbGKM2qwjPEA+efebCOJ6UcGdjzA2+1Ll1kEN9UqHIza1VqzaA
        2/86Z1g4k2y6VPizG8xyBgJ2xnx6vh520wek3RONlZdKEdI9eOfawKD3rPOF7kGx
        P/y35qlShoteqX52eITSCxm3aX8rckxOJBBZn1qQgO1eXof/S8PteXGZqUEoDa44
        Z+YNwl8+EffL9Q==
X-ME-Sender: <xms:lyaQXFa2ZTydIg0VmEHZyrL4td0vEo1zHR_NWo-6XYKbUNgbOb9T2w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddriedvgddtfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhn
    ucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkph
    epuddvgedrudeiledrudegledrgedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtohgs
    ihhnsehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpeeh
X-ME-Proxy: <xmx:lyaQXArcjGXslQkwU_HJXFIrLrGO2QAOwqBEaYB9NdtVchW9TTu1_A>
    <xmx:lyaQXC-ZjRFIHgejEvcy--RX81Fpcjzh5Y_D4FXwa_wl6IPIyc4xSw>
    <xmx:lyaQXH98PbkeTfH971z3WHSqq5q_LqoU-grOTXa5knUS-J-Zip1kDQ>
    <xmx:lyaQXHAzlcgYyGM-HVCCWyzHz320Yw8gnpy1Wug0QDaHsqpPA4ALWw>
Received: from eros.localdomain (124-169-149-40.dyn.iinet.net.au [124.169.149.40])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9AA3F10311;
        Mon, 18 Mar 2019 19:15:32 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/13] docs: filesystems: vfs: Use SPDX identifier
Date:   Tue, 19 Mar 2019 10:14:30 +1100
Message-Id: <20190318231437.1666-7-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190318231437.1666-1-tobin@kernel.org>
References: <20190318231437.1666-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the licence is indicated via a custom string.  We have SPDX
license identifiers now for this task.

Use SPDX license identifier matching current license string.

Tested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 Documentation/filesystems/vfs.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/vfs.txt b/Documentation/filesystems/vfs.txt
index 790feccca5f4..5c8358c73e30 100644
--- a/Documentation/filesystems/vfs.txt
+++ b/Documentation/filesystems/vfs.txt
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 =========================================
 Overview of the Linux Virtual File System
 =========================================
@@ -9,8 +11,6 @@ Overview of the Linux Virtual File System
   Copyright (C) 1999 Richard Gooch
   Copyright (C) 2005 Pekka Enberg
 
-  This file is released under the GPLv2.
-
 
 Introduction
 ============
-- 
2.21.0

