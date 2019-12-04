Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A90C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22979206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575483270;
	bh=HyRnJ4hHIIT88R4IE4XWdBuwVdb6Ox6saxvkkrM4gqQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OWp4BlwOwN2nb7rgUMcxkkFNC32F6lrPGdlERO+anLGtDvb43Z2S3kK8QsRGwi6GS
	 zYe+gL3n21IZT0oZdzB1LoRIBz2OnpUfK1L+ugQ4RojRdmmSHahhMm5uZ+yr3QJ6hA
	 hMjAfThjh9Gp9MLFSkpJCuR8PIVf+LHMyowVi8BQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731639AbfLDSO3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:14:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:43788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731625AbfLDSO0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 13:14:26 -0500
Received: from localhost (unknown [217.68.49.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35B3820674;
        Wed,  4 Dec 2019 18:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575483265;
        bh=HyRnJ4hHIIT88R4IE4XWdBuwVdb6Ox6saxvkkrM4gqQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bNIqle7/IRGIMiB1FvOb7SUSbEKv7y9W1WwFI61ZJvZBnJq64OFlKPdznytmfQqHF
         z3KrFXAGQFGXPZDChw4R4vCg0stIb+UI3heyYdUrSUETJM1gwz5xeaet0+69x5vVNp
         A4j2BWZrICDoTrPMQB26B0UKuHbKFy35YcC6Wu2E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        John Rutherford <john.rutherford@dektech.com.au>,
        Jon Maloy <jon.maloy@ericsson.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 119/125] tipc: fix link name length check
Date:   Wed,  4 Dec 2019 18:57:04 +0100
Message-Id: <20191204175326.498816873@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204175308.377746305@linuxfoundation.org>
References: <20191204175308.377746305@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Rutherford <john.rutherford@dektech.com.au>

[ Upstream commit fd567ac20cb0377ff466d3337e6e9ac5d0cb15e4 ]

In commit 4f07b80c9733 ("tipc: check msg->req data len in
tipc_nl_compat_bearer_disable") the same patch code was copied into
routines: tipc_nl_compat_bearer_disable(),
tipc_nl_compat_link_stat_dump() and tipc_nl_compat_link_reset_stats().
The two link routine occurrences should have been modified to check
the maximum link name length and not bearer name length.

Fixes: 4f07b80c9733 ("tipc: check msg->reg data len in tipc_nl_compat_bearer_disable")
Signed-off-by: John Rutherford <john.rutherford@dektech.com.au>
Acked-by: Jon Maloy <jon.maloy@ericsson.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/tipc/netlink_compat.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/net/tipc/netlink_compat.c
+++ b/net/tipc/netlink_compat.c
@@ -539,7 +539,7 @@ static int tipc_nl_compat_link_stat_dump
 	if (len <= 0)
 		return -EINVAL;
 
-	len = min_t(int, len, TIPC_MAX_BEARER_NAME);
+	len = min_t(int, len, TIPC_MAX_LINK_NAME);
 	if (!string_is_valid(name, len))
 		return -EINVAL;
 
@@ -821,7 +821,7 @@ static int tipc_nl_compat_link_reset_sta
 	if (len <= 0)
 		return -EINVAL;
 
-	len = min_t(int, len, TIPC_MAX_BEARER_NAME);
+	len = min_t(int, len, TIPC_MAX_LINK_NAME);
 	if (!string_is_valid(name, len))
 		return -EINVAL;
 


