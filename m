Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74CA9C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D2232068F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574420324;
	bh=/ocGoJgUZnU/MR4jKC+MPYAL4fHXHIMop3CtzsQDJYY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0BqmUP5K7oDxV9AeJEhSJW6tNCJua38szKbcfjoBFyX30F1jGOASCtAhYz8KcDaYL
	 J86AoeyF4ZSvIlJ/Gl17kfXGs3yjZiwQt7vely6PRBmP1xt9doZUnHITh2RHPxJCbR
	 eGq8ORhFlNWLOIMjBEZR4c+vvHaStGnT4KRqAUKU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730818AbfKVK6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:58:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:48752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730428AbfKVK6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:58:35 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF1162071F;
        Fri, 22 Nov 2019 10:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574420315;
        bh=/ocGoJgUZnU/MR4jKC+MPYAL4fHXHIMop3CtzsQDJYY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wvFAOX2uo4AFtKrvQuboFlMDeWuO3FhQV/QxA6lSWz761cIlReiITRvbgVypNpnKs
         fCWgCwilzOCNC6OuB7etLEDiUCk8V5HPwdAwY7ohSQodaHMRSyv15IISOKAoPPrFap
         eBu/OLDcpqi6Or8WhLcT+AzddOQQcm+TnEfwiA2U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 064/220] mei: samples: fix a signedness bug in amt_host_if_call()
Date:   Fri, 22 Nov 2019 11:27:09 +0100
Message-Id: <20191122100916.715118916@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100912.732983531@linuxfoundation.org>
References: <20191122100912.732983531@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



