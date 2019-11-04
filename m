Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B5FCA9EC9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 21:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87764217F4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 21:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572904521;
	bh=StqaMSxdh6xeqT2gB1aXpUZsi+7s35JBbpkh66VjhEc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=x+JWxFJ90mro4MiftlSoszKxuW6nTY6St9wtiFPcm3DpAsmEjXdUJD8JFLO05FNX6
	 RHpTLCmA8Twc2plQbMHlfJiIaLJxKi/HgJRJMc6vc3R0ue/zJo5Ozoia56gjx6zddA
	 bkI6BpnNPzxaec8rvuHmrXmWzYNZYkpxNkHTezF8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388152AbfKDVzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 16:55:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:50444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387652AbfKDVzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 16:55:14 -0500
Received: from localhost (6.204-14-84.ripe.coltfrance.com [84.14.204.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E89DA217F4;
        Mon,  4 Nov 2019 21:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572904514;
        bh=StqaMSxdh6xeqT2gB1aXpUZsi+7s35JBbpkh66VjhEc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JjBB4B+SrmtLaSLEKLk7g5ubMqSYQCkCBUiwtOAVxInvvjDkwApKLWH4LDtsgalfr
         4rnPXw6qLuWk7QPNJMq6AJBND5ZBCvhwgISoPOtjCbRTJRWrK+nTS8Q5MV7umuyUPE
         WtNfm6UoXDguziukXraBW+W/ZOu3IbvE81ddDako=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.14 72/95] USB: serial: whiteheat: fix potential slab corruption
Date:   Mon,  4 Nov 2019 22:45:10 +0100
Message-Id: <20191104212115.478466063@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104212038.056365853@linuxfoundation.org>
References: <20191104212038.056365853@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

commit 1251dab9e0a2c4d0d2d48370ba5baa095a5e8774 upstream.

Fix a user-controlled slab buffer overflow due to a missing sanity check
on the bulk-out transfer buffer used for control requests.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://lore.kernel.org/r/20191029102354.2733-2-johan@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/serial/whiteheat.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/usb/serial/whiteheat.c
+++ b/drivers/usb/serial/whiteheat.c
@@ -575,6 +575,10 @@ static int firm_send_command(struct usb_
 
 	command_port = port->serial->port[COMMAND_PORT];
 	command_info = usb_get_serial_port_data(command_port);
+
+	if (command_port->bulk_out_size < datasize + 1)
+		return -EIO;
+
 	mutex_lock(&command_info->mutex);
 	command_info->command_finished = false;
 


