Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 416CEC3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 11:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19D5621726
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 11:07:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388019AbfHVLHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 07:07:10 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60187 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730029AbfHVLHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 07:07:09 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1i0kvp-0000BI-NN; Thu, 22 Aug 2019 11:07:05 +0000
From:   Colin King <colin.king@canonical.com>
To:     Benjamin LaHaise <bcrl@kvack.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] aio: remove redundant assignment to variable ret
Date:   Thu, 22 Aug 2019 12:07:05 +0100
Message-Id: <20190822110705.19065-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable ret is being set to -EINVAL however this is never read
and later it is being reassigned to a new value. The assignment is
redundant and hence can be removed.

Addresses-Coverity: ("Unused Value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/aio.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/aio.c b/fs/aio.c
index f9f441b59966..3e290dfac10a 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1528,7 +1528,6 @@ static int aio_read(struct kiocb *req, const struct iocb *iocb,
 	file = req->ki_filp;
 	if (unlikely(!(file->f_mode & FMODE_READ)))
 		return -EBADF;
-	ret = -EINVAL;
 	if (unlikely(!file->f_op->read_iter))
 		return -EINVAL;
 
-- 
2.20.1

