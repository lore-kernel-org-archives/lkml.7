Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B95C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B31252064A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553663994;
	bh=O7oFPq28VE0wJmphec9uSU7ztoy0WS3b8nWTwZuwz5U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=G/ojPMOaYB30AOin51r3mRAZudf9QLzihzLp9Yhmt/g5RXWNSy+JVZdi4LnMlWNZb
	 yVV0VtdcRuz6dmXzV3IQj0B8FWw1DcNutymfndBG5GZ1Hsr+33wvYZB9iQCf54GsnA
	 8X9vELsyQZHuy/XoPLoCr6KXYjfexiX8OrAw8zSY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731571AbfC0FTx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 01:19:53 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:35491 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733302AbfC0FTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 01:19:51 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id DA27F22148;
        Wed, 27 Mar 2019 01:19:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 27 Mar 2019 01:19:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=2mjDV76CgLZ1V8hWykdYzfL69yXn1pc7PVUZOH6s5ug=; b=f5ncpj2b
        FA6DT1d+2VdiCqk2v6ePwwMrnmixsbDehNe7Wdj+G5j7ZIO22diYzfT1iikVrbay
        jdFcw+0OtkKhyxSiCYY7IJ5343ypOE7GIABX2MCufqax5SqvPsrxpm49mpAeME+9
        l9F57R1k+Dmx6MrYAffbfKk+QRkUX9AMtHwujyDzy+BjGgt3e7quBmlp/yKVBRks
        QI1PJn1fant5nIZQgLkcDwWurXaN1iBcDFDp/KVDAHgIuL2h6Q/9e4KP16yZ8SYb
        wgJlUDozX2Gi0jhWRNj3AK28gL5CuRk84+lj73u8eAL2V6bY6Eg0WutX9cDBtkEc
        5z1tmSDSihr+QQ==
X-ME-Sender: <xms:9gebXEhxvQ83TKgKYGqIAhYF0CgtVONgCh0AbFU-OXiOCEhJMhbvgw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrkedugdektdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhn
    ucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkph
    epuddvgedrudeiledrudefledrudelvdenucfrrghrrghmpehmrghilhhfrhhomhepthho
    sghinheskhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgepudel
X-ME-Proxy: <xmx:9gebXCT1ztRBITMlJTdE0XJJalsWAj0mmaih0SxzzodwUUp0kw_4PQ>
    <xmx:9gebXNxXIJov4hpRFDMGXnPZQp7IW5CxDvjNpc6roenpjROtQ9pFcw>
    <xmx:9gebXNcGzqkUyzImFX59vhpp5T6EEmjmmZPuEnxR1suG6F6NwMtiuQ>
    <xmx:9gebXE0njIDfZoWaK_XP2b4CKxDg-ZRTfbPuup5j4CF2HaHc4_nhRw>
Received: from eros.localdomain (124-169-139-192.dyn.iinet.net.au [124.169.139.192])
        by mail.messagingengine.com (Postfix) with ESMTPA id 70632E4210;
        Wed, 27 Mar 2019 01:19:47 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Neil Brown <neilb@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 21/24] docs: filesystems: vfs: Fix pre-amble indentation
Date:   Wed, 27 Mar 2019 16:17:14 +1100
Message-Id: <20190327051717.23225-22-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190327051717.23225-1-tobin@kernel.org>
References: <20190327051717.23225-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently file pre-amble contains custom indentation.  RST is not going
to like this, lets left-align the text.  Put the copyright notices in a
list in preparation for converting document to RST.

Tested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 Documentation/filesystems/vfs.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/filesystems/vfs.txt b/Documentation/filesystems/vfs.txt
index dcc1f66932e7..e5c877e817c3 100644
--- a/Documentation/filesystems/vfs.txt
+++ b/Documentation/filesystems/vfs.txt
@@ -4,12 +4,12 @@
 Overview of the Linux Virtual File System
 =========================================
 
-	Original author: Richard Gooch <rgooch@atnf.csiro.au>
+Original author: Richard Gooch <rgooch@atnf.csiro.au>
 
-		  Last updated on June 24, 2007.
+Last updated on June 24, 2007.
 
-  Copyright (C) 1999 Richard Gooch
-  Copyright (C) 2005 Pekka Enberg
+- Copyright (C) 1999 Richard Gooch
+- Copyright (C) 2005 Pekka Enberg
 
 
 Introduction
-- 
2.21.0

