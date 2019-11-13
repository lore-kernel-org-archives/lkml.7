Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD384C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CEDB206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573610930;
	bh=/ocGoJgUZnU/MR4jKC+MPYAL4fHXHIMop3CtzsQDJYY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PY3WzRQQlonogfPB2EwneBxpWKFMLK3XN8kZkr5GjBQfW8AUYtZuEG/vyPcV4AO+X
	 e1Fxhv2aojwlTrzRcGfG3ap5klKw5EC3JVV5RjoKRrLqT9PknT+nOOQ9d2k3TzNGMC
	 1QNWF3p8cxEoMu7xZG467MxW3v3sTDMcZlOSle4o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730867AbfKMCIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 21:08:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:54858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728320AbfKMB76 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 20:59:58 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C1BB2246A;
        Wed, 13 Nov 2019 01:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573610397;
        bh=/ocGoJgUZnU/MR4jKC+MPYAL4fHXHIMop3CtzsQDJYY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rrisPo0efyoWR/GStI/qUDQ9bKmgMOSltilAoT4BfGDecMWWEPWQLf2aqCZa0HvQq
         2zZGoqs6PTATu2Gp2ZD1ncpGDQujl/qaUDSkwbXcc4e557CddaZkOGYTgFIoYkM0fN
         BNgUhvom7FO7LHmwru4IR1zFCeiAw8pBLyF/WUZQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 16/68] mei: samples: fix a signedness bug in amt_host_if_call()
Date:   Tue, 12 Nov 2019 20:58:40 -0500
Message-Id: <20191113015932.12655-16-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113015932.12655-1-sashal@kernel.org>
References: <20191113015932.12655-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 185647813cac080453cb73a2e034a8821049f2a7 ]

"out_buf_sz" needs to be signed for the error handling to work.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 samples/mei/mei-amt-version.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/mei/mei-amt-version.c b/samples/mei/mei-amt-version.c
index bb9988914a563..32234481ad7db 100644
--- a/samples/mei/mei-amt-version.c
+++ b/samples/mei/mei-amt-version.c
@@ -370,7 +370,7 @@ static uint32_t amt_host_if_call(struct amt_host_if *acmd,
 			unsigned int expected_sz)
 {
 	uint32_t in_buf_sz;
-	uint32_t out_buf_sz;
+	ssize_t out_buf_sz;
 	ssize_t written;
 	uint32_t status;
 	struct amt_host_if_resp_header *msg_hdr;
-- 
2.20.1

