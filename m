Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC32CC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92CE1204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564000275;
	bh=rxnY3wrfDDLzY2Euytksiym4+Ent8PQJYLcAuC5pEYg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=knIZJAMdoCFKGZxDf5T69uIqtg9tWwuqlq85BonIaz7TwM95bU0ZaCe2RyEisY10d
	 xE/SSZiAqhnaUs3r4r9udCfggBj8ruuDJPSw+QMccVa58NMs7zT566fTWRlsNmTd3J
	 vsY/WEtT2ZyBkh+YTSSPca8qv8/AqYVo85ZpzcGU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728919AbfGXUbO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 16:31:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:51448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388442AbfGXTa7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:30:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23239218EA;
        Wed, 24 Jul 2019 19:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563996658;
        bh=rxnY3wrfDDLzY2Euytksiym4+Ent8PQJYLcAuC5pEYg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RNTwYvELR2+v4eqHBz/e24hIWD+JQ76UxtSU6TJRSsuuDhpkFnPXY04En3MFcqsGR
         xBl5jWtIfkQdOJvkJ7HfH76332v32iWguhJ0i1yL+OUox7YJ5X5UkYGzk1BjLVKjfO
         ub436rzcLMX8uUvdXP0/j6BopIa4124jhHvb5U3w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 173/413] rslib: Fix decoding of shortened codes
Date:   Wed, 24 Jul 2019 21:17:44 +0200
Message-Id: <20190724191747.314463325@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191735.096702571@linuxfoundation.org>
References: <20190724191735.096702571@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 2034a42d1747fc1e1eeef2c6f1789c4d0762cb9c ]

The decoding of shortenend codes is broken. It only works as expected if
there are no erasures.

When decoding with erasures, Lambda (the error and erasure locator
polynomial) is initialized from the given erasure positions. The pad
parameter is not accounted for by the initialisation code, and hence
Lambda is initialized from incorrect erasure positions.

The fix is to adjust the erasure positions by the supplied pad.

Signed-off-by: Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190620141039.9874-3-ferdinand.blomqvist@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/reed_solomon/decode_rs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/reed_solomon/decode_rs.c b/lib/reed_solomon/decode_rs.c
index 1db74eb098d0..3313bf944ff1 100644
--- a/lib/reed_solomon/decode_rs.c
+++ b/lib/reed_solomon/decode_rs.c
@@ -99,9 +99,9 @@
 	if (no_eras > 0) {
 		/* Init lambda to be the erasure locator polynomial */
 		lambda[1] = alpha_to[rs_modnn(rs,
-					      prim * (nn - 1 - eras_pos[0]))];
+					prim * (nn - 1 - (eras_pos[0] + pad)))];
 		for (i = 1; i < no_eras; i++) {
-			u = rs_modnn(rs, prim * (nn - 1 - eras_pos[i]));
+			u = rs_modnn(rs, prim * (nn - 1 - (eras_pos[i] + pad)));
 			for (j = i + 1; j > 0; j--) {
 				tmp = index_of[lambda[j - 1]];
 				if (tmp != nn) {
-- 
2.20.1



