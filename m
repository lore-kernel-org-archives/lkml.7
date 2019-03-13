Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3879C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 04:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B098D21841
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 04:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552450223;
	bh=6cfa76xEem73Ta6Nl6NfNuVGMEzag5bAfhvJslKBWKc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aP09eYBu51R13+x1B+APNQBxYoTHndq0FijIJr5IC3NThDLZzqA4Ulekc46YwNLCy
	 pLQlt79sRNWXpdEhz2Omj5Eis5ABOPCyKrQuRv/d0no+nEyMOuMhm3mSeomZkuxBB/
	 1db0ymRDsIcye+ctWp/qCDdESih9z4xXojzhhCXc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbfCMEKW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 00:10:22 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:54309 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727116AbfCMEKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 00:10:18 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 0FF0438C1;
        Wed, 13 Mar 2019 00:10:17 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 13 Mar 2019 00:10:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=mqjX7JB6K1FW343RnkavozJ7jmsp1ga9lSkuIny43R4=; b=zYPFemBc
        fa7Oc9usBc0Ue8pQMl0Ms31OKbq2GyrCRdUgopASRyZhGy25cgr4mwhnlNs/0wnL
        HJjbpGoRuMAYYZ4JRfIOn0sfJJj4ojWIRanV28VQuBf/v1g6yjotxGemy29VM1Q0
        xIGDM9mCCZ9aRc++GIwd62V0dg7u57TWxcCuEGqnfmtbE26yaQ9rw9Aauh369Cws
        V9qd8uou3gbSsdWdP5GT62JcPU4Ayfcu3PHAW9RwnitTCUUqTahpBP+ve+EDOesd
        JVf/CG1X5GLFooFZRoA8uA5bSmZ6qagvbjc7kFVagtpT+IkurC4ULnjAsE9wsd7j
        hMtB3fE9cP8P+w==
X-ME-Sender: <xms:qIKIXELtpt4DAavdrJgcW2kkJfpIs_0Wr9itnDp4sWwvmwX1OA9yCw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrgeelgdeijecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhn
    ucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkph
    epuddvgedrudeiledrvdefrddukeegnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtohgs
    ihhnsehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpeei
X-ME-Proxy: <xmx:qIKIXGf1DVhBV90wx86IKc0siltStgPaQwQU-qFOf1e5WYbpp6AHJQ>
    <xmx:qIKIXDZkM7IG1qCRDcvcMoVPQ7KhX6GOl-eVcAMkRvTp-4BkT3TSiA>
    <xmx:qIKIXOVE37q7Mft7VCuwNp29wdp0IfCwdcvYe4ECJz49UqQg1gx4qg>
    <xmx:qIKIXECiYcnFkM4e6ZJNj08DEHxejWyzNTVz7unqR-Ba2CY6xHww6Q>
Received: from eros.localdomain (124-169-23-184.dyn.iinet.net.au [124.169.23.184])
        by mail.messagingengine.com (Postfix) with ESMTPA id 328ACE4665;
        Wed, 13 Mar 2019 00:10:13 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     "Tobin C. Harding" <tobin@kernel.org>, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/13] docs: filesystems: vfs: Fix pre-amble indentation
Date:   Wed, 13 Mar 2019 15:09:13 +1100
Message-Id: <20190313040919.6937-8-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190313040919.6937-1-tobin@kernel.org>
References: <20190313040919.6937-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently file pre-amble contains custom indentation.  RST is not going
to like this, lets left-align the text.  Put the copyright notices in a
list in preparation for converting document to RST.

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

