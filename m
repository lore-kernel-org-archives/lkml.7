Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA4ACC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B8122177B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556624713;
	bh=1E80f6C6KKklPmtdQ4vXPcXRkfI+cNj4GBx96Yoj1oI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ypMBHViHvKU2iOruJAyNOItZddnGGcVix8zTeldowUGTvRqhBxEmgXRqm2QXK0fAi
	 Q5WjC9jL7YZaNLcuv7u+C0PIAAEJ4fsXp8o1x8BdbD1PPrTdGnOSJazwOY1Vpq8xrW
	 yiK5+cZ9deWJ5Jq4QTFV9y/eFoSFGreZL5wTxXn0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730356AbfD3LpM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 07:45:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:57150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730342AbfD3LpI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 07:45:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 976AB21707;
        Tue, 30 Apr 2019 11:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556624708;
        bh=1E80f6C6KKklPmtdQ4vXPcXRkfI+cNj4GBx96Yoj1oI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oxk1fR9TqOAhS2Sp2NpM+bq7jTajS3hj+anlS4QwyN3l4V+z3JdWEnjA9eam7+E9Z
         FFvNgYxIBKN4t9WHYWZOiJOQYhVxUsVy1uNWZe4N9VZoqSwf1kRQfcLB1sWMKuWRiJ
         8gJr6vZcgkLUbjb3JzStKMNvMk7UsKLtAivnELs8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lucas Stach <l.stach@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.19 041/100] Input: synaptics-rmi4 - write config register values to the right offset
Date:   Tue, 30 Apr 2019 13:38:10 +0200
Message-Id: <20190430113611.080959564@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190430113608.616903219@linuxfoundation.org>
References: <20190430113608.616903219@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Stach <l.stach@pengutronix.de>

commit 3a349763cf11e63534b8f2d302f2d0c790566497 upstream.

Currently any changed config register values don't take effect, as the
function to write them back is called with the wrong register offset.

Fixes: ff8f83708b3e (Input: synaptics-rmi4 - add support for 2D
                     sensors and F11)
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/rmi4/rmi_f11.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/input/rmi4/rmi_f11.c
+++ b/drivers/input/rmi4/rmi_f11.c
@@ -1230,7 +1230,7 @@ static int rmi_f11_initialize(struct rmi
 	}
 
 	rc = f11_write_control_regs(fn, &f11->sens_query,
-			   &f11->dev_controls, fn->fd.query_base_addr);
+			   &f11->dev_controls, fn->fd.control_base_addr);
 	if (rc)
 		dev_warn(&fn->dev, "Failed to write control registers\n");
 


