Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A6D5C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6579020409
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574404119;
	bh=ABAw+0UN3/JtufQLU7PxhHLTB+FOGf2VHn3pTd88+wM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qhNerTqXxI075tLYKfZXn16b/aJud7YbjFZDNCsaaM1pQf80QZbXpckaezHUuBjwA
	 6J4dreUU+JJgBGoWx7O7WdngiBi7hoYo4nWiIAtPMMYA1o2GZw0BrBTLnaj7ez1dIF
	 UD7l91QPbWN2aufuMy2IYq8VUtW4bqm5udPUJaxg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbfKVG2i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 01:28:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:54536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727522AbfKVFuJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 00:50:09 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5E9020708;
        Fri, 22 Nov 2019 05:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574401808;
        bh=ABAw+0UN3/JtufQLU7PxhHLTB+FOGf2VHn3pTd88+wM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ODxV6DLoaswtK3qc1dOmYn2xrUE4GumOaqzrzH52rouyEBKFu0C2vV6TXxwka2tGa
         pdm8gf1ZrzsHS5T0zvL/wKws5mxswjf9UFM2zfvUXuwbKAMmonPfFo47EcQthBzZ4Y
         GVNBR5l1iR7wS/hJXEuPkDbmgH70cWFEmdNNGAlU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Gabor Juhos <juhosg@openwrt.org>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Richard Weinberger <richard@nod.at>,
        Sasha Levin <sashal@kernel.org>, linux-mtd@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 053/219] ubifs: Fix default compression selection in ubifs
Date:   Fri, 22 Nov 2019 00:46:25 -0500
Message-Id: <20191122054911.1750-46-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122054911.1750-1-sashal@kernel.org>
References: <20191122054911.1750-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gabor Juhos <juhosg@openwrt.org>

[ Upstream commit d62e98ed1efcaa94caa004f622944afdce5f1c3c ]

When ubifs is build without the LZO compressor and no compressor is
given the creation of the default file system will fail. before
selection the LZO compressor check if it is present and if not fall back
to the zlib or none.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ubifs/sb.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/ubifs/sb.c b/fs/ubifs/sb.c
index bf17f58908ff9..11dc3977fb64f 100644
--- a/fs/ubifs/sb.c
+++ b/fs/ubifs/sb.c
@@ -63,6 +63,17 @@
 /* Default time granularity in nanoseconds */
 #define DEFAULT_TIME_GRAN 1000000000
 
+static int get_default_compressor(struct ubifs_info *c)
+{
+	if (ubifs_compr_present(c, UBIFS_COMPR_LZO))
+		return UBIFS_COMPR_LZO;
+
+	if (ubifs_compr_present(c, UBIFS_COMPR_ZLIB))
+		return UBIFS_COMPR_ZLIB;
+
+	return UBIFS_COMPR_NONE;
+}
+
 /**
  * create_default_filesystem - format empty UBI volume.
  * @c: UBIFS file-system description object
@@ -186,7 +197,7 @@ static int create_default_filesystem(struct ubifs_info *c)
 	if (c->mount_opts.override_compr)
 		sup->default_compr = cpu_to_le16(c->mount_opts.compr_type);
 	else
-		sup->default_compr = cpu_to_le16(UBIFS_COMPR_LZO);
+		sup->default_compr = cpu_to_le16(get_default_compressor(c));
 
 	generate_random_uuid(sup->uuid);
 
-- 
2.20.1

