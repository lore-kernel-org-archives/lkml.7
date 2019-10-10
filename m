Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61425ECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BCBC208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570697190;
	bh=yKGquLgQJM6xHAVIyQdIcYLEBg8ctH6tGylCXrJKmP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=x4TS+figGkqQKZpirIXfwH1Z7og4IVDeF0LNsh2cnpghk++uEsVwhs1VDuK5Jr2n1
	 RSkccNAIQC8o5lP33xaYCgQQM/VlUiTebsKMa1nL1ijnFKHLdtilZ+GNCna7ao4Q9J
	 3n5ZZPmq/Vlly7vUaOXjbUJdwHX8JcLrQv5QJ8T4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389324AbfJJIq2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 04:46:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:52176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387615AbfJJIqY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 04:46:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE8C0208C3;
        Thu, 10 Oct 2019 08:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570697182;
        bh=yKGquLgQJM6xHAVIyQdIcYLEBg8ctH6tGylCXrJKmP4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IZf5zC9FDHKXh7Y8Abm69b9HFtdapmsduzf3waDT5Bz7Yw+1tR2f6ZMWsFxdseY5Z
         PfM4H7LcK96BRpaRfgIoAEPIF96/iXx4QYrQwgH8K/lyLXnNXn6kOadTD35oV87Ckp
         vSS7Xn49bdLzYV47RJJZ7AWdyzLw1c66wiGTJM/Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 049/114] ima: always return negative code for error
Date:   Thu, 10 Oct 2019 10:35:56 +0200
Message-Id: <20191010083608.030280521@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191010083544.711104709@linuxfoundation.org>
References: <20191010083544.711104709@linuxfoundation.org>
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
index d9e7728027c6c..b7822d2b79736 100644
--- a/security/integrity/ima/ima_crypto.c
+++ b/security/integrity/ima/ima_crypto.c
@@ -271,8 +271,11 @@ static int ima_calc_file_hash_atfm(struct file *file,
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



