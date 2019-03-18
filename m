Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC523C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 23:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA7A320685
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 23:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552950971;
	bh=D9a5mfXIH6A0vc9AUxpi0w/qwtFkZJa+fjFzX9poOag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UazbwNT2ZW26rVIJIqEpWaWK0fHY7x290BN6/ZT6qnn2hakz/m9kqV6JHxHirAH1a
	 4vShhJmPP2OzHC8n6C2gZp81UuIht/Ck/qPYCXRPg/LpoLOVg7DnAWW/+Jw2AmKCHd
	 otnWgKCRZygY59va77LWVkeMJYt58p4vRJwUM1ys=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387416AbfCRXQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 19:16:10 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:56153 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727929AbfCRXQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 19:16:02 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id B25462225D;
        Mon, 18 Mar 2019 19:16:00 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 18 Mar 2019 19:16:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=wO87VhxlCRKJ6UZlTZ7CZPC3aFH+ZWg+1lDNDo6jzTY=; b=rj5LEI8w
        3oY1HSnHFAAy1aECihxdSO4BhYbR3a7m4h8aZVZyiSnRrHpvDwL7jULer2aIOK1Z
        usqY5sOx72yCP903jHAVEVB/Avnibesl+2dUC1hYkvuDcH4cQcohrUqz+I3oZOQm
        UrP5otMzKLvl/10Ke7IXlQoKxzriKFC/WUjDUzVcPXkpmMxr9il3SblpYS4LcHCN
        c64nfdrh7ezm437Rzu181/gY3iih9gOQz/bp0N3E3D0jbvqlPutPTUT7M0cbd2O4
        pJeOFPl70EIQmgM2TU/jJk3WaU1b/oFiiyPXNBnTcHXsIKdoANBUjuhwC4BbdH09
        xok9eiwaQWlFIg==
X-ME-Sender: <xms:sCaQXD1HKUltEkRci5I-OjP3UUQJu7xVTeqaqDkJKMhMwYIpjVl9UQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddriedvgddtfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhn
    ucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkph
    epuddvgedrudeiledrudegledrgedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtohgs
    ihhnsehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpeduud
X-ME-Proxy: <xmx:sCaQXGUY9W9cHeRX8axAOtPy6Xdc1T4GCX_2cxYFmM2DuZQBB6CYJQ>
    <xmx:sCaQXO4NDbQagNqawC0tuTT6TP8rVCMKLcMu0qwnkXJEhEcC-xVunA>
    <xmx:sCaQXNLLea7OaNHOdFniYNDDe3tbuVb9L6tpW3PsNwXvPvYQsAlnhw>
    <xmx:sCaQXFPSuzsQJF1tucUl0Ex_XiI1fX3-T-P17Z0XccRW8PVqdQqLlA>
Received: from eros.localdomain (124-169-149-40.dyn.iinet.net.au [124.169.149.40])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1C70910311;
        Mon, 18 Mar 2019 19:15:57 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 13/13] docs: filesystems: vfs: Use backticks to guard star
Date:   Tue, 19 Mar 2019 10:14:37 +1100
Message-Id: <20190318231437.1666-14-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190318231437.1666-1-tobin@kernel.org>
References: <20190318231437.1666-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sphinx emits a warning because of the use of a * (C pointer construct)
within the document.  We can prevent this by guarding the C source code
with back ticks.

Use backticks to guard star (C pointer).

Tested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 Documentation/filesystems/vfs.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 12b8e90403eb..8ad2507b3df6 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -355,7 +355,7 @@ Extended attributes are name:value pairs.
 
 When none of the xattr handlers of a filesystem match the specified
 attribute name or when a filesystem doesn't support extended attributes,
-the various *xattr(2) system calls return -EOPNOTSUPP.
+the various ``*xattr(2)`` system calls return -EOPNOTSUPP.
 
 
 The Inode Object
@@ -722,7 +722,7 @@ cache in your filesystem.  The following members are defined:
   out properly.
 
   The filesystem must return the locked pagecache page for the specified
-  offset, in *pagep, for the caller to write into.
+  offset, in ``*pagep``, for the caller to write into.
 
   It must be able to cope with short writes (where the length passed to
   write_begin is greater than the number of bytes copied into the page).
-- 
2.21.0

