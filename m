Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C5B9C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D2222064A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553663992;
	bh=hpyexiZLP/wePw9kS7edw/hVM3zaz02llBiWj3V780U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DKfcVsdJl4rSTw3IY7pnDQYBXJZLnjSCGkjckBhXTSgaltxxxsS8rSTQTt35HDLWW
	 iq1iaydy6fTiAdITv0PV+B2tt4+V2wVvdDeNPKrUSEjUPqKemZNSQge7KJ57si+lFa
	 Ss4oPO4RNTWfmzQlS4NBDMgf2nzWqHWzoyqvodew=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbfC0FTv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 01:19:51 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:50689 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733277AbfC0FTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 01:19:48 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 45CED21F40;
        Wed, 27 Mar 2019 01:19:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 27 Mar 2019 01:19:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=4d+OaY4wGb3ez43s1Ih67ffl69AK+5hY5gV6ueidyAI=; b=gSmzRhyb
        t/bYnlKXSjkllDRyJCDRlOx8KvJMIV1c0e1hGCu3z8gxMAxmTsjXIdhEPgsEmDW6
        NqImnfgAAMHw/pFr4mhHt1U0fUAQPaDAmGOoBuiAEBZ7PiDA52cZ1aGk3XzWcr4H
        x0kLbIzJdqDj6oXuGnKIzaLiQ4LFi1/Z90mCM2xzDR6BCfB3QJLAO32xykYXQEnM
        +/4acX2C+wKjj119p53iJnLMr7qnV6XAEpPGZUlnEHJ2EESTvhQiXKdg3HiAQG2S
        z5itd9IH9Vm06p/QPxibTrBl/y4Flhyg9Rv2HYQgGRtaKszrM5Bq3FgyQHldboas
        j+EHaRC/gtTc6g==
X-ME-Sender: <xms:8webXDSUoUEa2RkQAo2Wpc_CuaKjJT3vT-SAvZXW2dgYEdirPfAvGw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrkedugdektdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhn
    ucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkph
    epuddvgedrudeiledrudefledrudelvdenucfrrghrrghmpehmrghilhhfrhhomhepthho
    sghinheskhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgepudel
X-ME-Proxy: <xmx:8webXKDb4eP4gnFGAVkzA2S4WRXXFAtbiSVh6pf4EjK5go4FnEfGJw>
    <xmx:8webXKjijwIRAQUzQnXXgDy7bS84d8IpPe2rdhZocXwY26QJAcgsmw>
    <xmx:8webXLNnDzS8fw9KYWzkaNCB24xjxytX3f3cXrlprXiFrTdPDnK4RQ>
    <xmx:8webXBn9Y0iHHFkv-yeZaT3aeiJAshA4saGxfMaWedysf_LotpiCIA>
Received: from eros.localdomain (124-169-139-192.dyn.iinet.net.au [124.169.139.192])
        by mail.messagingengine.com (Postfix) with ESMTPA id 847DDE415C;
        Wed, 27 Mar 2019 01:19:43 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Neil Brown <neilb@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 20/24] docs: filesystems: vfs: Use SPDX identifier
Date:   Wed, 27 Mar 2019 16:17:13 +1100
Message-Id: <20190327051717.23225-21-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190327051717.23225-1-tobin@kernel.org>
References: <20190327051717.23225-1-tobin@kernel.org>
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
index 0bc45c3a33db..dcc1f66932e7 100644
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

