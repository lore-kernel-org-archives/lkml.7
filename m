Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87C9C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 23:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EF212173C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 23:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552950979;
	bh=D5Mhm75a0ACku7LlVhVgdv7HU8LrtuNOISgMLZbCyno=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vbMuz7OqoqvWLaXgf4ujLmbaX+4q4Z6gF/LLXf/mSRKxaK9Po35ixc2kS7smigxN0
	 FATZAQsIDI3B37yXZPS76qOUs6grjzfrCPxvpnJWM3MLASjB2l2cgPv59HzAhe5Zjd
	 DkO627tJ2rdEgnLSbtwdiNdGOaqq0Rn0lCgBy22k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbfCRXQR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 19:16:17 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:42311 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727887AbfCRXP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 19:15:58 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 47E00220E0;
        Mon, 18 Mar 2019 19:15:57 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 18 Mar 2019 19:15:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=ZOz+dCigQD6M+16i89y5WGkd95DnyEE3MY9Cf6JzaU4=; b=KE8i+4CQ
        bu6KwoB2LS2/2YMSEPnVIIO0KwKDQ91kCAO2PX+v6RKv5DYTobWEAWGmx7XRrW9C
        2UOcGZnGOWzCpNCT9TSnp6tXiiNfhLGf/XUlFHCCbaOtP4TozEsHRe7JzxYRylEn
        /cP5xT9CS3b+grgcIG+aR4ClvON3KcyV56LuZkj2gOOAy+Ebb7VMqT7pLT8kZhTT
        G27MjG0VZi+Jvsxpj22LeHSOA9sacLqFBH5qcSR6LxAInZilMLMP4Jy/qetsXS8w
        w3pKmN7IkpRi4iSz5pr+jfB+FgMl++zY5iA1Uiw7RL0b3LyrfzRd4rEpXZHcMgZm
        esx77Y2OTubhCw==
X-ME-Sender: <xms:rSaQXOtIgMaJBI31quK8nalZW-_-pI0A5CQhrfnryHyCuAyGiSmlPQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddriedvgddtfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhn
    ucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkph
    epuddvgedrudeiledrudegledrgedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtohgs
    ihhnsehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpeduud
X-ME-Proxy: <xmx:rSaQXPmSnuL_7O6Y2IYUzPYF0hGMK4Dj5Z2hZSAnY3yCUrFrsYEQTw>
    <xmx:rSaQXF690c7ajnpP_l3JVa7WWZQvZp3Q9IJHcbsPK-uJx2iZusHcGQ>
    <xmx:rSaQXN0Ixt-NMfCWd7sceFr_IONraOx_dPBsfl2_pN8Em8N3ufmacg>
    <xmx:rSaQXGyCCH00-gyu4Az4qDlMFtbHCHXUBbSor7V4kLp3vf42hWm7kA>
Received: from eros.localdomain (124-169-149-40.dyn.iinet.net.au [124.169.149.40])
        by mail.messagingengine.com (Postfix) with ESMTPA id B17B310317;
        Mon, 18 Mar 2019 19:15:54 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 12/13] docs: filesystems: vfs: Do minor grammar fixes
Date:   Tue, 19 Mar 2019 10:14:36 +1100
Message-Id: <20190318231437.1666-13-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190318231437.1666-1-tobin@kernel.org>
References: <20190318231437.1666-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While converting to RST a few minor grammar mistakes were noticed.  Fix
these now the conversion is done.

Fix minor grammar mistakes.

Tested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 Documentation/filesystems/vfs.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index bd8f7891f44b..12b8e90403eb 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -1111,13 +1111,13 @@ defined:
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
@@ -1211,7 +1211,7 @@ manipulate dentries:
   d_instantiate().
 
 - ``d_instantiate``: add a dentry to the alias hash list for the inode and
-  updates the "d_inode" member.  The "i_count" member in the inode
+  update the "d_inode" member.  The "i_count" member in the inode
   structure should be set/incremented.  If the inode pointer is NULL, the
   dentry is called a "negative dentry".  This function is commonly called
   when an inode is created for an existing negative dentry.
-- 
2.21.0

