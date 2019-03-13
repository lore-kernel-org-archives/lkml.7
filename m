Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F8DDC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 04:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AEBB217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 04:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552450289;
	bh=Z7xZv2aUZrlVB9GQLuINbDjIpAF8GNZKenlIb9ZBBZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lQ32O6UqdtGvNY3KDjjJUzFGPjwcnSTt/5fwe5y+fH3CvbqLSzfguH4Yr0DwML/kt
	 /ONSOuhuVnJwYkB+Rjfh+uM2jdjIk0c/Yn2PnkHKFb9rR18T7V2hVYMDAYp3QpZCL2
	 hLBJOqi6K3AA1eX8YN2CnjluKu1lIiPbBmS+fNIc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbfCMEL2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 00:11:28 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:41471 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727077AbfCMEKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 00:10:15 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 5CB9638B6;
        Wed, 13 Mar 2019 00:10:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 13 Mar 2019 00:10:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=QEqHkcumIRQAZueCEWrTfbmwetRcGmg8fFh7ub3TUqw=; b=7v6c3mIj
        m1C/ENCFW8K2fDnYImc9/lthZVTHyB/5S6c0OnTBQizkGrYbgKozViwInHfof5+c
        XlXj4EwaGR/mIfMnosN4yNcQ0VGyRBGhC2TRMgE17RfNhHqN5C1kGL1n4eGhgeDt
        44VWFckf0Dm+2bCDwDjILIT2/RCzWaebHQxrIS3eRvNUPKArwIkmgX647WuTlYQL
        Mr9+EwylcVeXsrklHLCwdLgBfMVEGjnoj7EY3zm26l4xteHWfiz3Gn8vn7G9myfO
        iWY8x0UTrPsF4RpRKGGHOdnU4vJHAfCJFzKWH3ubM3UrFK3al1smm7h2I+b2pWnU
        IK8zwon+DUrmlw==
X-ME-Sender: <xms:pYKIXAEJGM3ljzzjY90NnEjNqa9mRJoGDpFjxk7nhPbVDAFoTphDEQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrgeelgdeijecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhn
    ucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkph
    epuddvgedrudeiledrvdefrddukeegnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtohgs
    ihhnsehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpeef
X-ME-Proxy: <xmx:pYKIXCFXZ7Mgcj2nZ4QFcuQteLA5J7etjL72mw8F-YobDJCTfmlXcg>
    <xmx:pYKIXI3eUnYi3fY_Lv668TZWw01uLTqO1ra_sexW0FgsWYufaQ8Hgg>
    <xmx:pYKIXEcHUqf2YkhYRH99eITvzmYLV0grC8erCfncE0RIj7XGFhO2Kg>
    <xmx:pYKIXGH4AIz-iio5znCzmDHLAlPphyXFBbQPHGGGtoDhd6kqKUCR0g>
Received: from eros.localdomain (124-169-23-184.dyn.iinet.net.au [124.169.23.184])
        by mail.messagingengine.com (Postfix) with ESMTPA id 997AAE4583;
        Wed, 13 Mar 2019 00:10:11 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     "Tobin C. Harding" <tobin@kernel.org>, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/13] docs: filesystems: vfs: Use SPDX identifier
Date:   Wed, 13 Mar 2019 15:09:12 +1100
Message-Id: <20190313040919.6937-7-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190313040919.6937-1-tobin@kernel.org>
References: <20190313040919.6937-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the licence is indicated via a custom string.  We have SPDX
license identifiers now for this task.

Use SPDX license identifier matching current license string.

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

