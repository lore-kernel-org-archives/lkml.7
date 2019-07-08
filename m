Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 711D8C606C1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AC29216E3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562599091;
	bh=g5XSuJXDPPx1t/SoGy5oUODDhay0cexUUbaJaPStrbc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fQpbLvTkQdldJ/XpAnimWzs2209CrrUdsFIk7RkSIiifbNFzEesfO9MZgfA7csVs4
	 W2og/JoaGtOegYcv6EUT2jo+b7Wklx7nZWaiWlHSRS6s5YdZyyPzTbrl57REVvV8vV
	 lb8eU9nloCiFIaGTf2DsAiL6uXhPoYxJScZaufgg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732977AbfGHPSK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:18:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:41514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732890AbfGHPR4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:17:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD365216E3;
        Mon,  8 Jul 2019 15:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562599076;
        bh=g5XSuJXDPPx1t/SoGy5oUODDhay0cexUUbaJaPStrbc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mpy7z2ixCdMRwFJL7g8umHVHJZIbFpcQtXEIe1kfLEmlAe10Q1QmfDjjDM6Ze9muE
         xUMWxm05ikx8UKzBoM91MSWzoqj6tllozO/OGpegDB3sW9qNbH8vxKlXEkCmz1+RlT
         4hKWGXtq0OCcPgKBw/kYX9WdL3yFiMSVvUUWkCCo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 69/73] tty: rocket: fix incorrect forward declaration of rp_init()
Date:   Mon,  8 Jul 2019 17:13:19 +0200
Message-Id: <20190708150524.901695706@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190708150513.136580595@linuxfoundation.org>
References: <20190708150513.136580595@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 423ea3255424b954947d167681b71ded1b8fca53 ]

Make the forward declaration actually match the real function
definition, something that previous versions of gcc had just ignored.

This is another patch to fix new warnings from gcc-9 before I start the
merge window pulls.  I don't want to miss legitimate new warnings just
because my system update brought a new compiler with new warnings.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/rocket.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/rocket.c b/drivers/tty/rocket.c
index 2b8f2e0a4224..ec6d20f25e8b 100644
--- a/drivers/tty/rocket.c
+++ b/drivers/tty/rocket.c
@@ -279,7 +279,7 @@ MODULE_PARM_DESC(pc104_3, "set interface types for ISA(PC104) board #3 (e.g. pc1
 module_param_array(pc104_4, ulong, NULL, 0);
 MODULE_PARM_DESC(pc104_4, "set interface types for ISA(PC104) board #4 (e.g. pc104_4=232,232,485,485,...");
 
-static int rp_init(void);
+static int __init rp_init(void);
 static void rp_cleanup_module(void);
 
 module_init(rp_init);
-- 
2.20.1



