Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B32C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 04:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA88421841
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 04:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552450238;
	bh=UujBzh40LEip2TVaHg/I5Hee7q3rLwg0FxotKC2bF2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SlCgBB1fatw+DB5ROsa/UOBxY9hWQTQfBKwJpX/MktVf3GRUbv6kci+7s635FZtXD
	 bMMD8MBYuOXxI1Ii8sTjSssBSFCDFZ/dSBh8SmW+QesCvu8O3ET5/fhOFVgvqxDTnI
	 y9X7k7sh9YkAkqBiDZ3UrwkoN6F8Vt1hcSvAbIV4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbfCMEKh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 00:10:37 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:59307 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727258AbfCMEKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 00:10:35 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id A1B1438C1;
        Wed, 13 Mar 2019 00:10:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 13 Mar 2019 00:10:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=/uYyHp2C5qNkec3CFTK3krdT4o54GYZecwcPozFshok=; b=N91pzALj
        n32bxetRXgTt8wAKOJIB+/Tlwf5gGavpdxlMZWftMOb/4dA9LISI/+SBAho3ZlVk
        dUupVTYv0OIgE/3bBOXemxjcPbUtyuIhMuxv1LQXKi77gG/gkdGEvbI+VsIpmibd
        zXMY9moxjaxpv2eubWAteUeSI21whbEBRFeHIHr8Va1TdDEihzmFS5OQooxvktP/
        5oo7H8IbLdDoOz+aElBgMw99bY4669jnFH1Jp7xlIUu6xAzkd6Pv+M+BbMXHbYYJ
        MsbQ3R5tq+b3MFYkLqqBnfgq1xruqVP7xBGdDPwqnZtpx/wLbyc8OuUP8niNctMd
        lqZVSSomeOmkzg==
X-ME-Sender: <xms:uYKIXFpGrUTgjorIxV8jaJcx_XHvDYYVq7gmW8ZHujpISFv0DIzBrQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrgeelgdeijecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhn
    ucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkph
    epuddvgedrudeiledrvdefrddukeegnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtohgs
    ihhnsehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpeduud
X-ME-Proxy: <xmx:uYKIXL7FGHPUu9XWbu-Wzt3Bu1dNqd7RPiubMt8sK5rOs9qUlhkWzg>
    <xmx:uYKIXNPSBxSa1mQ7oS-ZkqCfJ0X4L-kbKGtNtftETMbtyq5NL1Rjsw>
    <xmx:uYKIXFNfQfJj-FrDC3g93DTSw7PhyuLkE0oliGK5p2sO_GTAVvUNBw>
    <xmx:uYKIXCYg6TY5L3V9tKWKGq3Nix7eSulLU8pnL0m2kIEwTv_wYrHCPQ>
Received: from eros.localdomain (124-169-23-184.dyn.iinet.net.au [124.169.23.184])
        by mail.messagingengine.com (Postfix) with ESMTPA id DA701E427E;
        Wed, 13 Mar 2019 00:10:30 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     "Tobin C. Harding" <tobin@kernel.org>, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 12/13] docs: filesystems: vfs: Do minor grammar fixes
Date:   Wed, 13 Mar 2019 15:09:18 +1100
Message-Id: <20190313040919.6937-13-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190313040919.6937-1-tobin@kernel.org>
References: <20190313040919.6937-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While converting to RST a few minor grammar mistakes were noticed.  Fix
these now the conversion is done.

Fix minor grammar mistakes.

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 Documentation/filesystems/vfs.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 2cdd4700aba3..c0259538a759 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -1107,13 +1107,13 @@ defined:
 - ``d_dname``: called when the pathname of a dentry should be generated.
   Useful for some pseudo filesystems (sockfs, pipefs, ...) to delay
   pathname generation.  (Instead of doing it when dentry is created,
-  it's done only when the path is needed.).  Real filesystems probably
-  dont want to use it, because their dentries are present in global
+  it's done only when the path is needed.)  Real filesystems probably
+  don't want to use it, because their dentries are present in global
   dcache hash, so their hash should be an invariant.  As no lock is
   held, d_dname() should not try to modify the dentry itself, unless
   appropriate SMP safety is used.  CAUTION : d_path() logic is quite
   tricky.  The correct way to return for example "Hello" is to put it at
-  the end of the buffer, and returns a pointer to the first char.
+  the end of the buffer, and return a pointer to the first char.
   dynamic_dname() helper function is provided to take care of this.
 
   .. code-block:: c
@@ -1207,7 +1207,7 @@ manipulate dentries:
   d_instantiate().
 
 - ``d_instantiate``: add a dentry to the alias hash list for the inode and
-  updates the "d_inode" member.  The "i_count" member in the inode
+  update the "d_inode" member.  The "i_count" member in the inode
   structure should be set/incremented.  If the inode pointer is NULL, the
   dentry is called a "negative dentry".  This function is commonly called
   when an inode is created for an existing negative dentry.
-- 
2.21.0

