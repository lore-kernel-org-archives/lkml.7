Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF6BAC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A973820707
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574419351;
	bh=kL6FU9R5156ffI4nRNa+Oy0TifVNeORlwgtnvFjve3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eJPrIptMqSJ/8J88pL9AUJ0q3JFjC5F/w2FzZ7PVLSZCqF8C5wWx4zZvuyNXip8j4
	 zl7uUqT+WbFL/92EznK4qdZaxa8faMEuZ5ADVHkBDCWhXJpzi8m9vc/Ev+O1L4sK2m
	 xWt/HW/FqcAFvD2n+AKL1C0df4nt246d++mHxx48=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729117AbfKVKma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:42:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:47594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727761AbfKVKm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:42:28 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45D3B20707;
        Fri, 22 Nov 2019 10:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574419348;
        bh=kL6FU9R5156ffI4nRNa+Oy0TifVNeORlwgtnvFjve3M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sR5BkyLjA/Qzaq0SIwAMuphNje8TSUxXNXDzH9u1/FqaYv4ovm0I8Mx8nmlro6sQc
         VvUEKa9IpkM+V5ucJy/USUEW7imW58PqYWBX/9KDcW16Eo//PmWRMSbpTz52stPb0r
         XdL8R0BrCC7AqjRHGfKcaMlV/ucPXLDGklTb6zkw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anton Vasilyev <vasilyev@ispras.ru>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 082/222] serial: mxs-auart: Fix potential infinite loop
Date:   Fri, 22 Nov 2019 11:27:02 +0100
Message-Id: <20191122100909.371468340@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100830.874290814@linuxfoundation.org>
References: <20191122100830.874290814@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anton Vasilyev <vasilyev@ispras.ru>

[ Upstream commit 5963e8a3122471cadfe0eba41c4ceaeaa5c8bb4d ]

On the error path of mxs_auart_request_gpio_irq() is performed
backward iterating with index i of enum type. Underline enum type
may be unsigned char. In this case check (--i >= 0) will be always
true and error handling goes into infinite loop.

The patch changes the check so that it is valid for signed and unsigned
types.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/mxs-auart.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index 1d9d778828bae..515bf18c82943 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -1635,8 +1635,9 @@ static int mxs_auart_request_gpio_irq(struct mxs_auart_port *s)
 
 	/*
 	 * If something went wrong, rollback.
+	 * Be careful: i may be unsigned.
 	 */
-	while (err && (--i >= 0))
+	while (err && (i-- > 0))
 		if (irq[i] >= 0)
 			free_irq(irq[i], s);
 
-- 
2.20.1



