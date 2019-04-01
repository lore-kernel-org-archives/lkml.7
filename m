Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 986CDC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 540C220830
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554140636;
	bh=FQd+dJzdVd9FR0PYGKyMPgGgwte+wn4XVH65G49az3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Y4w/MsSMLyfkWagTVd8Y2Ce7yUA1ZIb1uk4Uuk0hlwlNWqYU5oxL7IRU56gfxCpy+
	 9kEvSWrt2dycgNqkQdIDe+BWKl5ndXGfKg3ChGEd8HzGmwCmQWUbrdy7NYwGgAjxEM
	 i84qgufZBd7zT8Lzd4sOlxZUZqiI/mmnIeAIUN9Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388093AbfDARny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:43:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:46420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387719AbfDARfc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:35:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB3022171F;
        Mon,  1 Apr 2019 17:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554140132;
        bh=FQd+dJzdVd9FR0PYGKyMPgGgwte+wn4XVH65G49az3A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pxYT5dNU5kYHC5bDwUjPjZgAlvL5OUENEESiBwaZ7NdVPMdnZgbmTgpZ4u5Tmr9Nm
         rQlfaj9xxxbuK67EsE4+qoR0QKtqtrfcggiKxjJyq7qxqmpoBZEF70xv+xgKD46kvO
         oTHDoQldTswd/tkim9knpKl3iTsz0BXOyFu2vr4c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aditya Pakki <pakki001@umn.edu>
Subject: [PATCH 4.4 114/131] serial: max310x: Fix to avoid potential NULL pointer dereference
Date:   Mon,  1 Apr 2019 19:03:04 +0200
Message-Id: <20190401170101.207997696@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170051.645954551@linuxfoundation.org>
References: <20190401170051.645954551@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aditya Pakki <pakki001@umn.edu>

commit 3a10e3dd52e80b9a97a3346020024d17b2c272d6 upstream.

of_match_device can return a NULL pointer when matching device is not
found. This patch avoids a scenario causing NULL pointer derefernce.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serial/max310x.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -1306,6 +1306,8 @@ static int max310x_spi_probe(struct spi_
 	if (spi->dev.of_node) {
 		const struct of_device_id *of_id =
 			of_match_device(max310x_dt_ids, &spi->dev);
+		if (!of_id)
+			return -ENODEV;
 
 		devtype = (struct max310x_devtype *)of_id->data;
 	} else {


