Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 433F0C072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CE5B259D9
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559191279;
	bh=bDXiMGFvmldpxTxfhq4JdbAQvsgjlZNGG0/Vu9YG5q8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=c0cMZn5MwKnE3qLeF4RD9smaUJlB27/R6h1ousjCcBRm1NgosXe7YJEcteZ7R/7FI
	 9ez58bQos4h3YY9LowJWYJNuhzEKto4lPpgx5MNRuR6RUQfUybmqDmklXdjwOiZIm9
	 WIFb+Gq9PN5HrDknlB1lKjtQnsT8jr2zIZKF9G0k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388691AbfE3ElS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:41:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:55166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729027AbfE3DM1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:12:27 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B01A023D14;
        Thu, 30 May 2019 03:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559185946;
        bh=bDXiMGFvmldpxTxfhq4JdbAQvsgjlZNGG0/Vu9YG5q8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZIoNFO3ryFs69HAOlbX04+bv2TLBfwHgPFCNuSwONJBh/QzNfkJI58fHq6HtB0v3C
         BjuC5B8mTwcN+KYdl1Jdu+04GOM1RBNcg4xyvWEPmV+ZuhFSJKXOBinp86BSJyLhRA
         v5iAJA/K2ZF5Tf5TPXOQaXooqeOl6svWO7LmhXJU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 356/405] media: go7007: avoid clang frame overflow warning with KASAN
Date:   Wed, 29 May 2019 20:05:54 -0700
Message-Id: <20190530030558.645730883@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.291644921@linuxfoundation.org>
References: <20190530030540.291644921@linuxfoundation.org>
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
index 24f5b615dc7af..dfa9f899d0c25 100644
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



