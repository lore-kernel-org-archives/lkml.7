Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 267C7C04AB4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 00:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB50820879
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 00:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557880234;
	bh=gcFzwZNpmv+GWUYixEsA52cd+lwsfHe+N/EYtEpKFoY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=i9rp7gZX8dS5lsYJK6FazqMICm0j8GOkfi8K3r2KWM9B55hNiBys0x3DavbU5DFmy
	 EjorElXY+QTo7iVFS36qO2la+RHOi2fFsmm10IpSq2BQ69wtXIvc/Om+VeLgvBRCaE
	 u1518Qj88VYKghpqjNC+KauwGakDEP1TT/IeG5Ok=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfEOAad (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 20:30:33 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:56873 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726709AbfEOAab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 20:30:31 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id B622F25888;
        Tue, 14 May 2019 20:30:30 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 14 May 2019 20:30:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=00rAFAWmUlAnpzYom9QoZFSRMRtPL32nxsWL64DrfUU=; b=aohgfCRL
        NZVn/LCmj3DdmzABy104SejW8LgTYy+PrOpTFDbxUM1tFKWMLlII1FLrWQF+DVlB
        swwVVs4j1CPV0r2iKKbpF/wjH8hwUZdSKJsMLN/scaiZCYSl4SJvu2OPvy0OQWFo
        UoKqj438tKjyY31uDMKZ8nA498JuLLVQv38vtRz4YDlEU7mwoWkE2JA+FnHo8zzD
        bAAKh0n91JDrC/ELDsj3wKNZZzcKBT/zaQS13hXU6m/FmiO/8PmIs4KtvWoMsWTv
        vOv5nU5x/FRkp9Y9xobWDX9KEQyNSt6Ue2lt14pDvLILp5pH3SoIocCVZmTT48WJ
        m9uxfs1QDzbAug==
X-ME-Sender: <xms:pl3bXAOcmNKxii7Mzghy6j2NniuqaP-5ZcopejliKNoyfh2tO3DS8g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrleejgdefiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhn
    ucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkph
    epuddvuddrgeegrddvvdefrddvuddunecurfgrrhgrmhepmhgrihhlfhhrohhmpehtohgs
    ihhnsehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpeeh
X-ME-Proxy: <xmx:pl3bXPxbqT75ExnY2dXeQ785M6tntKiO451xvJ2ljaffkEjyXdDyCQ>
    <xmx:pl3bXNnaeb5IohY0Kojk3z7xN3r8N4WfZonIihGShSAOy1eKPvwA5Q>
    <xmx:pl3bXPWZGXQPAo7vATdoJkpLTlDv2IAa8ST6usdj526xV8sGUshdzw>
    <xmx:pl3bXBXCMzc8Ui0Mht8LSXhXZxjVLcmCUjHMoV6-Ei5nTOU0E18mDQ>
Received: from eros.localdomain (ppp121-44-223-211.bras1.syd2.internode.on.net [121.44.223.211])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4239110378;
        Tue, 14 May 2019 20:30:26 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Neil Brown <neilb@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 7/9] docs: filesystems: vfs: Fix pre-amble indentation
Date:   Wed, 15 May 2019 10:29:11 +1000
Message-Id: <20190515002913.12586-8-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515002913.12586-1-tobin@kernel.org>
References: <20190515002913.12586-1-tobin@kernel.org>
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
index 5c8358c73e30..43b18bafbc20 100644
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

