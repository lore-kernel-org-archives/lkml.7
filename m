Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D698BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A72532064A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553663989;
	bh=YorfQZY/7fhnq4+GpVbgtScS4VzBFwlO6uWgRf2vFik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=b72MkVOB7GOaT4J6ZWphPKIjgIk+iaMHrTT08vfnan9zFQyHqR2Ac4B/fk+DJUWfY
	 EEN9tV+dwaMU1toPBgjO+yRznpNPmCDP1Bp0HLqATEhHKr5NIdb3ctYeXTEsbLkiLE
	 2igbCT3LeK6sg/9cxfJeIj9OYlFa9LStmfNIqRWM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733284AbfC0FTs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 01:19:48 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:56779 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733150AbfC0FTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 01:19:44 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 4D533220BA;
        Wed, 27 Mar 2019 01:19:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 27 Mar 2019 01:19:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=jYYRim4LqDH/+ILdkjCwxlVTyWbzdeoyGlOuao86dMc=; b=Sot6Tacz
        QSWvgIHrLEHZ7eP8+ywsBgOsU0V8wsFqUtVJcuBeM/Wns2QVAaq8ae8JqtIS7Ljs
        KcfaDTp/VzKsXs78Ab9V2xp4M11gSPlgfXivwrG2NRMq0rbHL3TpRjn+YlbgY5Sv
        h10Fk0EhVfqQT5SXeUxk33ctjwGGippXXx/WFVI3f8Hr4ycMXhOnECEhmjwj09LI
        EJCGGkFI1FsX8pB5vbdMcAgw2BmDaOM5UsioZZxysuKfZoqZvfttQHzRsT8F6LU5
        LAX2RAFHTGJQw2uByk2P23/06gtn6JedLkv8NxG4gk0bCFThsu2RrDfG2aSG5rR3
        x8HhCmETfelsiA==
X-ME-Sender: <xms:7webXNfpry1-zBBJgg_DRs39TmSpWIwi9NVL-fYSBqDZYB_in3A0CQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrkedugdektdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhn
    ucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkph
    epuddvgedrudeiledrudefledrudelvdenucfrrghrrghmpehmrghilhhfrhhomhepthho
    sghinheskhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgepudek
X-ME-Proxy: <xmx:7webXEyy_-Cmpl5lmXuIbKaiFYfyRr0Hgu6PKh7p-cy6YYDduI8-8Q>
    <xmx:7webXB8VrKr7Fd_y6rJfy4RuyD3aFlUL0VbMSGpUNr5438_uUwrBMQ>
    <xmx:7webXFoZNKDRcCta8yfS_LguN5pknOFG4I0kDqtO_erTcTOat8JYzQ>
    <xmx:7webXEKjTnS_D2AFzUYxNS12WQlMai_lfGnqCQXJrJrHhfXwu0DEtw>
Received: from eros.localdomain (124-169-139-192.dyn.iinet.net.au [124.169.139.192])
        by mail.messagingengine.com (Postfix) with ESMTPA id CC199E415C;
        Wed, 27 Mar 2019 01:19:39 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Neil Brown <neilb@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 19/24] docs: filesystems: vfs: Use correct initial heading
Date:   Wed, 27 Mar 2019 16:17:12 +1100
Message-Id: <20190327051717.23225-20-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190327051717.23225-1-tobin@kernel.org>
References: <20190327051717.23225-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel RST has a preferred heading adornment scheme.  Currently all the
heading adornments follow this scheme except the document heading.

Use correct heading adornment for initial heading.

Tested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 Documentation/filesystems/vfs.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/vfs.txt b/Documentation/filesystems/vfs.txt
index b452b3fc5edc..0bc45c3a33db 100644
--- a/Documentation/filesystems/vfs.txt
+++ b/Documentation/filesystems/vfs.txt
@@ -1,5 +1,6 @@
-
-	      Overview of the Linux Virtual File System
+=========================================
+Overview of the Linux Virtual File System
+=========================================
 
 	Original author: Richard Gooch <rgooch@atnf.csiro.au>
 
-- 
2.21.0

