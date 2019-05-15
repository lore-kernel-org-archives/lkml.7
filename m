Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF7F8C04AB7
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 00:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8087820873
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 00:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557880268;
	bh=txmzL9qyDgmrOy5l5Czsl5Q9wJBEjZAI/vVV5E/taJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xVlYXE6fpx2mWsumvyPlZV8YKdtr2B43I6Ct3ovUgJv0IXL68hentP0XdAaf07/ZT
	 Kq8IIqrqRXdmE8FpEjX1dlNnwcB13cZQI2x2HJcWDhen39dDia7OwgNGljzuZmpH1T
	 b52/AuQJBMGAepDesAmLyHWhkQopIn7gWMcga+bE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbfEOAbH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 20:31:07 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:49113 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726766AbfEOAa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 20:30:27 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 7D46C25939;
        Tue, 14 May 2019 20:30:26 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 14 May 2019 20:30:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=ooOKa/ZqqBINC0OX8j3RPnzyNMPjMfRf5UkgG248/x4=; b=3wx3nQvV
        9JJFt1hQ5HwakV1L14h2ZaPHWWwKX2MdGQKCeiiiWVVYSxBBabhF8VoHNJwHfnCE
        5ZE/cEMk5NvOUHlrnx1WOqJbrTFKXW2aQ6mqMAA6zn8W9Qp5SLSolnmGDELVzsSS
        muCc8ONOVAbWsfK0lQj/CB9qVqmckHguMDUG0i9F16Iu2+IsKYeCjxRQznHnh/Qn
        BwkngeSbKZhwvC99mCBcOsbudvkSo4iIaSOJJ3crhQBBXfTO8/ebS3VDmsKQhOys
        gPUs+qtaDPc7d5ID8PbGr7TeoL/ureCfuAgIZCxM2RCm7OqH7Kr0kzzNW8L7L+7l
        IW9yureqm/W9oA==
X-ME-Sender: <xms:ol3bXAMAC2nQmR6krRNLxSDwBHbs8DVAos-MpnIv_ziXwcA7NebOnw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrleejgdefiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhn
    ucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkph
    epuddvuddrgeegrddvvdefrddvuddunecurfgrrhgrmhepmhgrihhlfhhrohhmpehtohgs
    ihhnsehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpeeh
X-ME-Proxy: <xmx:ol3bXDsq5V73iF4d64PIn4Z6uSf3zKin72joYwVGjxR1dpNeBAssLg>
    <xmx:ol3bXC2YALvR5Uf4GerJvgXVWzpBrq_cLzxb7jmB5EgEWnKRak8kMQ>
    <xmx:ol3bXO1EhcpGmVY67xnAgHruU-sB7bqVOIneRBYBev6dlJJ073Qjvg>
    <xmx:ol3bXMb43kk5h1MZPrUs9dHP5BTXaSylgEIr_qKmRwEAnRzB3PIsjA>
Received: from eros.localdomain (ppp121-44-223-211.bras1.syd2.internode.on.net [121.44.223.211])
        by mail.messagingengine.com (Postfix) with ESMTPA id F0CEF1037C;
        Tue, 14 May 2019 20:30:22 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Neil Brown <neilb@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 6/9] docs: filesystems: vfs: Use SPDX identifier
Date:   Wed, 15 May 2019 10:29:10 +1000
Message-Id: <20190515002913.12586-7-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515002913.12586-1-tobin@kernel.org>
References: <20190515002913.12586-1-tobin@kernel.org>
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

