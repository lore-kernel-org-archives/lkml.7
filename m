Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4495EC76186
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DA0B2053B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563419969;
	bh=i3mzDnD/KWoojrQomDSE9ZcdChge1zm0uhA25Sy7j48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=T3CEG5cwh8s5sbr6INP9yhc3Xx4NbAIBaE3OQ1xOX8rc0i4kC7f1o5i7ejPiqfjjb
	 tNbWqrzwAneq4OJzH8yMjzSOeAtFTyuT9bUDGBUfhqmqnP7yswViu3ZOfMObyfjzXU
	 +KABackgb3B4y/dAhUMaFp/mIAOCDJmTzKL6iqZc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392181AbfGRDT1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 23:19:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:46034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403903AbfGRDMA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 23:12:00 -0400
Received: from localhost (115.42.148.210.bf.2iij.net [210.148.42.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C1A52053B;
        Thu, 18 Jul 2019 03:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563419519;
        bh=i3mzDnD/KWoojrQomDSE9ZcdChge1zm0uhA25Sy7j48=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aFfqXeGQM2FfiKNi0hUQYXeS31LBUAC2osYzfUHJkIJnakgUm88dc0h/vmieFZSQG
         AMxgsMiJyFdISvnDF23OQ/VDN3cPFDpBfhYmTy6koXAMASBDSN0h4hrraFKj6hyVZ8
         GmYhVfPTijEjS2xY41qpggfmM1O4B3TJrYlWQ8gY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aaron Ma <aaron.ma@canonical.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 02/54] Input: elantech - enable middle button support on 2 ThinkPads
Date:   Thu, 18 Jul 2019 12:01:32 +0900
Message-Id: <20190718030048.971862823@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190718030048.392549994@linuxfoundation.org>
References: <20190718030048.392549994@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit aa440de3058a3ef530851f9ef373fbb5f694dbc3 ]

Adding 2 new touchpad PNPIDs to enable middle button support.

Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/mouse/elantech.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index 38edf8f5bf8a..15be3ee6cc50 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -1187,6 +1187,8 @@ static const char * const middle_button_pnp_ids[] = {
 	"LEN2132", /* ThinkPad P52 */
 	"LEN2133", /* ThinkPad P72 w/ NFC */
 	"LEN2134", /* ThinkPad P72 */
+	"LEN0407",
+	"LEN0408",
 	NULL
 };
 
-- 
2.20.1



