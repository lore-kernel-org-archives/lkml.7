Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CDB0C072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC97124BE1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559187676;
	bh=+kIEXJMeTP1KdmW/tnGqQswG8llJuLBkzgOSww3SMcs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=guajoq8bUT4ZVRReyCbW/NjU9AWcQUAFhIKhgsnXi7QJOUaDwsm80XHAM2EG9Rnuu
	 NpGLZpldHEB4ASmzO/qKNWG24uqIpEY2OffZfJdkuQjPuIG/iwZM4ZrFTACwT8oy8x
	 yeOs8oiO0wF3u1zD9F79TGW0zVC9JWDXorYSXAgw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732604AbfE3DlL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 23:41:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:34356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732533AbfE3DVW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:21:22 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 583C8248FC;
        Thu, 30 May 2019 03:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186482;
        bh=+kIEXJMeTP1KdmW/tnGqQswG8llJuLBkzgOSww3SMcs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F1ksj66DqDg6W8YgZPBhFGDcBEllEgkYbbzgdyeYX806DQsl3dT/JqHUOvC1tYI9D
         GUOyFgBrkNPCr2qe6UxMrmeNczSE9ENWmMOm5FLmSCpHTMlAc/X/oR23L4MfD7rfKo
         Ul9Ih3zJb5fFqVBCHkHNQdCUEym37mm0jzQ4t2N8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 120/128] media: go7007: avoid clang frame overflow warning with KASAN
Date:   Wed, 29 May 2019 20:07:32 -0700
Message-Id: <20190530030456.105919164@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030432.977908967@linuxfoundation.org>
References: <20190530030432.977908967@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit ed713a4a1367aca5c0f2f329579465db00c17995 ]

clang-8 warns about one function here when KASAN is enabled, even
without the 'asan-stack' option:

drivers/media/usb/go7007/go7007-fw.c:1551:5: warning: stack frame size of 2656 bytes in function

I have reported this issue in the llvm bugzilla, but to make
it work with the clang-8 release, a small annotation is still
needed.

Link: https://bugs.llvm.org/show_bug.cgi?id=38809

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
[hverkuil-cisco@xs4all.nl: fix checkpatch warning]
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/usb/go7007/go7007-fw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/go7007/go7007-fw.c b/drivers/media/usb/go7007/go7007-fw.c
index 60bf5f0644d11..a5efcd4f7b4f5 100644
--- a/drivers/media/usb/go7007/go7007-fw.c
+++ b/drivers/media/usb/go7007/go7007-fw.c
@@ -1499,8 +1499,8 @@ static int modet_to_package(struct go7007 *go, __le16 *code, int space)
 	return cnt;
 }
 
-static int do_special(struct go7007 *go, u16 type, __le16 *code, int space,
-			int *framelen)
+static noinline_for_stack int do_special(struct go7007 *go, u16 type,
+					 __le16 *code, int space, int *framelen)
 {
 	switch (type) {
 	case SPECIAL_FRM_HEAD:
-- 
2.20.1



