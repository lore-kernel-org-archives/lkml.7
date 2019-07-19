Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F2A8C76195
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 201D120659
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563508995;
	bh=iBYGP2XBc6Wct1cGsCLA+hgQgp6l9VQMtNASFOIsf4o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GoCC0abvTwrnxxgsqRw0J6WxoPbjgXNuR5Yq+3q0eQKc9LTG92Ux5Kz7f7Vo0hKm/
	 QUz6P7ruLvca3t8PCokw4N62mOgM25nZYXZ5yXMUqk7obd4K69HIH/pysMJLyUlAqC
	 D1iTB+h/n+Keq5j4+/rcWzfx35Da42misBGXCEPE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730339AbfGSEDO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 00:03:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:35216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729333AbfGSEDL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 00:03:11 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B95A121882;
        Fri, 19 Jul 2019 04:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563508990;
        bh=iBYGP2XBc6Wct1cGsCLA+hgQgp6l9VQMtNASFOIsf4o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RiACEpoQ57IyVleN8cDAWE4u/uNhI2Z6gMypgF8749y1jaAnWPDRq/mVFGkHHGZrp
         sp0ufbUMTGkNtNZzh/jP1D1qW/h8rI7HEG5WSfC93kyzFWG3+pxCGbjyH4FNoGmtBA
         4aK9WZPMrhzVfpozPgbq9RAbnLJqcR8NgZd3Ss+c=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Gen Zhang <blackgod016574@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.1 012/141] consolemap: Fix a memory leaking bug in drivers/tty/vt/consolemap.c
Date:   Fri, 19 Jul 2019 00:00:37 -0400
Message-Id: <20190719040246.15945-12-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190719040246.15945-1-sashal@kernel.org>
References: <20190719040246.15945-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gen Zhang <blackgod016574@gmail.com>

[ Upstream commit 84ecc2f6eb1cb12e6d44818f94fa49b50f06e6ac ]

In function con_insert_unipair(), when allocation for p2 and p1[n]
fails, ENOMEM is returned, but previously allocated p1 is not freed,
remains as leaking memory. Thus we should free p1 as well when this
allocation fails.

Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/vt/consolemap.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
index 7c7ada0b3ea0..814d1b7967ae 100644
--- a/drivers/tty/vt/consolemap.c
+++ b/drivers/tty/vt/consolemap.c
@@ -489,7 +489,11 @@ con_insert_unipair(struct uni_pagedir *p, u_short unicode, u_short fontpos)
 	p2 = p1[n = (unicode >> 6) & 0x1f];
 	if (!p2) {
 		p2 = p1[n] = kmalloc_array(64, sizeof(u16), GFP_KERNEL);
-		if (!p2) return -ENOMEM;
+		if (!p2) {
+			kfree(p1);
+			p->uni_pgdir[n] = NULL;
+			return -ENOMEM;
+		}
 		memset(p2, 0xff, 64*sizeof(u16)); /* No glyphs for the characters (yet) */
 	}
 
-- 
2.20.1

