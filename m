Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF81ECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BAB320B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570697546;
	bh=LZt8K+pFKJyJFvN9uH562Rpkc7q8eYhurxMZU2lrw3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=K7f3m477JSlzwULgsxXSY0DIYu3eJ+teCMc53CpyYRAntf8TnfJqb4WkdPUnE7SZl
	 BS1iQRvcFJBgjGH0ZQHI4D9bpLTLPnZOqmHsBhDbWQFSTLX0bF6xg0bjFap7q+nQZa
	 /Ouh62+q72LMiFjxYOutyseZ0LcF1r58qE07+uMU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389719AbfJJIwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 04:52:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:60208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389485AbfJJIwU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 04:52:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 016CC2064A;
        Thu, 10 Oct 2019 08:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570697539;
        bh=LZt8K+pFKJyJFvN9uH562Rpkc7q8eYhurxMZU2lrw3c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fbLOvx0MKJ1Z0i7h9/FqXyBibLoOR2rX02IDE+mkQ57akBmLnqnIgMMLrfEKnhwC8
         JjjTH4ZxDi0+vuCJ0YNV1fKaWR1KxEmtMRUfl5iuhwFc6wSAhjbVBZJsmQtEYD5DVe
         Bm8tfG1Fe5Nholc6D9cePwbW5+4DPQBgrdRyeBbg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 28/61] ima: always return negative code for error
Date:   Thu, 10 Oct 2019 10:36:53 +0200
Message-Id: <20191010083507.117565530@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191010083449.500442342@linuxfoundation.org>
References: <20191010083449.500442342@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sascha Hauer <s.hauer@pengutronix.de>

[ Upstream commit f5e1040196dbfe14c77ce3dfe3b7b08d2d961e88 ]

integrity_kernel_read() returns the number of bytes read. If this is
a short read then this positive value is returned from
ima_calc_file_hash_atfm(). Currently this is only indirectly called from
ima_calc_file_hash() and this function only tests for the return value
being zero or nonzero and also doesn't forward the return value.
Nevertheless there's no point in returning a positive value as an error,
so translate a short read into -EINVAL.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/integrity/ima/ima_crypto.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
index af680b5b678a4..06b0ee75f34fb 100644
--- a/security/integrity/ima/ima_crypto.c
+++ b/security/integrity/ima/ima_crypto.c
@@ -293,8 +293,11 @@ static int ima_calc_file_hash_atfm(struct file *file,
 		rbuf_len = min_t(loff_t, i_size - offset, rbuf_size[active]);
 		rc = integrity_kernel_read(file, offset, rbuf[active],
 					   rbuf_len);
-		if (rc != rbuf_len)
+		if (rc != rbuf_len) {
+			if (rc >= 0)
+				rc = -EINVAL;
 			goto out3;
+		}
 
 		if (rbuf[1] && offset) {
 			/* Using two buffers, and it is not the first
-- 
2.20.1



