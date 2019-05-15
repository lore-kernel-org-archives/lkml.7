Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C92C04AB4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 00:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 488FC20879
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 00:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557880279;
	bh=WqGRTJnLDjSHMU+k/XOkeQF1DqB114YpTHoQgyo5OvU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LXARl9YTkGsw7YxxJmgW5u4LVyDdYN5936KhVBhizK3PWSzAaLyvh+K2IDamwGRSa
	 wdws0ziGxxR6dCVk8Ui7aEJMRlNO3i7AALmhc0JufF4ywsr07OIgVVj58rQ9SZBh0o
	 8DzkXhWutvSAFbyvrS3oxrNE14x6KZo7R1KXBvNE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfEOAbS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 20:31:18 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:40725 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726604AbfEOAaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 20:30:23 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id ADFD1258FC;
        Tue, 14 May 2019 20:30:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 14 May 2019 20:30:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=ZDtsh7/RlQFuqxa53UJ32sKjTau19bO+C3vrwfjd2Sg=; b=J/JKVOS3
        I8fUgY8iS1dlFg9E4EnG/NTnCtsw6Ug3a8AQ6gEch9cBzKgUO329d8O0g+d3fqrg
        rHTvk58q2Rd5/8k48GSfX1TIlLIH10HCAiWqzHlqmZju8oMrWl5a9GEJJnlbNeZY
        3F3JvN6bVB8kz+jkWZ2evoXY20Q85QXK6C0qqvd/ub7n7OL+EL5IsirTCygCtZUr
        BTF6AtrTbD2yWw7PSNHZ9L+GqYVRCyNPSWHQEh83bkNXGFc/FWhnb1ZNi0IQvjdZ
        YFLZ4KA0AxE2xhNgOEN+GogJZmFsfojxAoWiSyzTgTmP3JQU/ThSMQjOhM0s0OkH
        tvJE/iRls9t+RQ==
X-ME-Sender: <xms:nl3bXKRj6WesNgy0SL57DkroL_RkxtEQr0lllg3Eo8SHrY2hxZATCw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrleejgdefiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhn
    ucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkph
    epuddvuddrgeegrddvvdefrddvuddunecurfgrrhgrmhepmhgrihhlfhhrohhmpehtohgs
    ihhnsehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpeeg
X-ME-Proxy: <xmx:nl3bXKvjRJCpdJ5dEzAuqOqfXUJeWWl5Gfmxbr_RoxbX27Y5nP0oDg>
    <xmx:nl3bXG0IjYu-zspxVAGL6Wf8RnoHuu53tdi5fCdV3WofSvuroKW09Q>
    <xmx:nl3bXLWI6GneQNlaTz5-a7oQ8aYwHTsuZsXh78D5u7WqaHrTsq8y_A>
    <xmx:nl3bXPhfd0w2acweGT49P1jl0rZltFCz-p87Sp9iNpncgyy3l0-RSg>
Received: from eros.localdomain (ppp121-44-223-211.bras1.syd2.internode.on.net [121.44.223.211])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4CEDC10379;
        Tue, 14 May 2019 20:30:19 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Neil Brown <neilb@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/9] docs: filesystems: vfs: Use correct initial heading
Date:   Wed, 15 May 2019 10:29:09 +1000
Message-Id: <20190515002913.12586-6-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515002913.12586-1-tobin@kernel.org>
References: <20190515002913.12586-1-tobin@kernel.org>
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

