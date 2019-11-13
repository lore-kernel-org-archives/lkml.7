Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 272C7C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAF8421783
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573611298;
	bh=/ocGoJgUZnU/MR4jKC+MPYAL4fHXHIMop3CtzsQDJYY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n3IAMs/R19YcZV+iRzD3nD919qNh2cXFi9+uN0JQV0NjY0lpp3DljpORn2gSW7eZC
	 EpQ5eO+/VhcN3FCDqjH2YqoeV4mFSsCDtWXrmYM+pTaNOXIWHtfkfHoxfOM+sm7f7c
	 jvwGlfF61hIdUXIGQsDwMOWtC5iGFVI8DLbel5wM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730338AbfKMCO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 21:14:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:49976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729659AbfKMB5E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 20:57:04 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0E1F2053B;
        Wed, 13 Nov 2019 01:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573610223;
        bh=/ocGoJgUZnU/MR4jKC+MPYAL4fHXHIMop3CtzsQDJYY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dYTPdzmtdtJXREuRpenS+1uj/OWtt0B8yyzHCQTPYiiyt/Qc44289qIzZd5aUv51/
         8Fg+YSkuto5eFk5/WUQDlOz8iCz5oXWNI9WhzvXA1A1M4ELD2WhF+56HrgLzyD3DGH
         zGCEqjIOYkrc2+7N9fFRw3NEdoC8S7YkyU/XO/eQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 028/115] mei: samples: fix a signedness bug in amt_host_if_call()
Date:   Tue, 12 Nov 2019 20:54:55 -0500
Message-Id: <20191113015622.11592-28-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113015622.11592-1-sashal@kernel.org>
References: <20191113015622.11592-1-sashal@kernel.org>
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

