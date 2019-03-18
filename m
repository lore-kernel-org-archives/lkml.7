Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E52C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 23:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 625872064C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 23:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552950937;
	bh=WqGRTJnLDjSHMU+k/XOkeQF1DqB114YpTHoQgyo5OvU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hpdM67dzgmhTry7ifi94UJ9xHT4ZLnNm/BjKRNkjSBMgjeEU7csc6Q0t9WsXNi/F+
	 3xRp6LuaF//EX7ziJdobOIDbHFqb0LkME80x0BehrxWlRujyWwHpcHLjqQzUsa5M6W
	 4sQ3l57W8xXP31AbWSWfnZskDgrKsJyxapnjnCCE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbfCRXPf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 19:15:35 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:37381 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727545AbfCRXPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 19:15:33 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id D2FEC20F6F;
        Mon, 18 Mar 2019 19:15:31 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 18 Mar 2019 19:15:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=ZDtsh7/RlQFuqxa53UJ32sKjTau19bO+C3vrwfjd2Sg=; b=Gkxbn3r/
        Ii5ZtTMLmbztzaDXNULkgBGMSgC0TDO5r+g0h8O6sIi5nWrv0LFGaYlUrWw2bdk/
        k2p1eI6o3AwP1p60sJWA9fVuqzUzO1yoCeejQ/rhzoZU52HCRjoOj5A9qeVSTEfJ
        Sn5HsUFZzoy2nkYd0IB+iy4S+bsXTVbj0z/JVA+mv/xkPLTfGzyqgdmaC1oH3Quw
        3LAJVb+BzCzux6a1QiPdQWKXLFURk5Yd8/nKuB2fZz88glJTMtKc9KVerEKEt0u8
        iGfeBzeR3kTbqQjV2xAQOXQ1QBnmK+7/1Caw7+rLn1nOuN12a4FkSCtndIfzKCox
        o/B16BvK8RuQYA==
X-ME-Sender: <xms:kyaQXA8n-cBQ_ZiHvqAOzf5JnSmgVeK6_RxqPnkZcaOqPcpqIZrzww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddriedvgddtfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhn
    ucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkph
    epuddvgedrudeiledrudegledrgedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtohgs
    ihhnsehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpeef
X-ME-Proxy: <xmx:kyaQXBhYwRE7ig1gVZiTjvbq-EhNVcdlI01MKkC74mEAHABuQAiS8g>
    <xmx:kyaQXMVaAd7zziLvqDRbFSDOEfq5Vri4wL2AFtRF-eQZ2TfWVeghrQ>
    <xmx:kyaQXHEZSTMz2FsAtpgyZsXgNWlSxS8pORX8oHg4jyYiGI_QLPuEUw>
    <xmx:kyaQXBp1zm8NSQnE5RHOtBBNU1nGh6oNolj_U3qVei5-DzYJoT-eLQ>
Received: from eros.localdomain (124-169-149-40.dyn.iinet.net.au [124.169.149.40])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3DF1510317;
        Mon, 18 Mar 2019 19:15:28 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/13] docs: filesystems: vfs: Use correct initial heading
Date:   Tue, 19 Mar 2019 10:14:29 +1100
Message-Id: <20190318231437.1666-6-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190318231437.1666-1-tobin@kernel.org>
References: <20190318231437.1666-1-tobin@kernel.org>
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
index ed12d28bda62..790feccca5f4 100644
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

