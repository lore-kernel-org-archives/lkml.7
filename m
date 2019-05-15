Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD54C04AA7
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 04:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A44720675
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 04:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="XZoH7GtX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbfEOEcj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 00:32:39 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:36858 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfEOEcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 00:32:39 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id x4F4VXWg022418;
        Wed, 15 May 2019 13:31:33 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x4F4VXWg022418
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1557894694;
        bh=GBhVHyqB4V20+0mYJbhNu4y/q2WNmGqZYid9a78MJE4=;
        h=From:To:Cc:Subject:Date:From;
        b=XZoH7GtXDV3vnWy/v1VeM769Jo2+KIK7XrWBoUzLH+vAEQVHuUB+aQ0pB1R+mRxKJ
         0U5BDbpC8OFqBsg2cPaunQNiFz4AeqGvD4Gxpkvjg/LfhCzC7I2ezxxMx9JXxx6hyC
         z0oJpm8ZlgNj9aoOsJOVkJ4x3qV/Q9wHUpQNuWSiHKR5EfiwRNY04P7fJI/1WGxshg
         CXt/t8aZTV9nNp9mZ9mclzGZtqZfqHTMMnYmm91G8ChGdesX1dEEzEaz0ibNc0XUw9
         daXB72Ye/pQ9liUDlNoL5b1wvf8XDVQPLtMF6er7M8xDkR28ez/IOA1alpkDiXzk9P
         l09lvnoo1PWIw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Gao Xiang <gaoxiang25@huawei.com>, Chao Yu <yuchao0@huawei.com>,
        linux-erofs@lists.ozlabs.org, Greg KH <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: erofs: drop unneeded -Wall addition
Date:   Wed, 15 May 2019 13:31:22 +0900
Message-Id: <20190515043123.9106-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The top level Makefile adds -Wall globally:

  KBUILD_CFLAGS   := -Wall -Wundef -Werror=strict-prototypes -Wno-trigraphs \

I see two "-Wall" added for compiling objects in drivers/staging/erofs/.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/staging/erofs/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/erofs/Makefile b/drivers/staging/erofs/Makefile
index 38ab344a285e..a34248a2a16a 100644
--- a/drivers/staging/erofs/Makefile
+++ b/drivers/staging/erofs/Makefile
@@ -2,7 +2,7 @@
 
 EROFS_VERSION = "1.0pre1"
 
-ccflags-y += -Wall -DEROFS_VERSION=\"$(EROFS_VERSION)\"
+ccflags-y += -DEROFS_VERSION=\"$(EROFS_VERSION)\"
 
 obj-$(CONFIG_EROFS_FS) += erofs.o
 # staging requirement: to be self-contained in its own directory
-- 
2.17.1

