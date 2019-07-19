Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC6EC76195
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 03:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D5B42082E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 03:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563508642;
	bh=J9xmBBYeV7Falpsj/fnhibMUKyl29JeWIf2sYOj903g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iNh1+Kh3mFTHhAWI0C77eKiq8xI+CLIf/OEYNSC6zZ0qesvYkMsOcKkWa53X1amVs
	 74IIheeUrKgBvjVq+hXBNk77MHwwSsfYNK92cm5Rns068Y7czXZVwtrV8/Q79Hu8zd
	 COEx6wRHQE0xCW+kW/Mk5mz6U35kje5adC5veYdY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbfGSD5U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 23:57:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:56554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727174AbfGSD5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 23:57:17 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 533162082E;
        Fri, 19 Jul 2019 03:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563508636;
        bh=J9xmBBYeV7Falpsj/fnhibMUKyl29JeWIf2sYOj903g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1kgziHW/yVN/+HjXjWH8qJDMOhAOUrqfLOV26rn3rp+nI2fXqm/gyHzwhWH4C9B+s
         JIS2m+ecXYR6o6WcmACCpIMSnar7byhCLHQl6KzW0wrJZ04z2B2Q2Vf0MltNbxRYMx
         gFeL0qwukhqy+4kDdnWz6cySI/CgZYHvJvCu9jIo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Gen Zhang <blackgod016574@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.2 014/171] consolemap: Fix a memory leaking bug in drivers/tty/vt/consolemap.c
Date:   Thu, 18 Jul 2019 23:54:05 -0400
Message-Id: <20190719035643.14300-14-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190719035643.14300-1-sashal@kernel.org>
References: <20190719035643.14300-1-sashal@kernel.org>
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
index b28aa0d289f8..79fcc96cc7c0 100644
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

