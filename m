Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC79C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E76620856
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139836;
	bh=YKrF8HsqFixDd71eOLAmxLe+ICN442VSNKKpH2ueAC4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=q75f6WwLMnibYY2W0t2k/5kCqvHJRFBoQMFpo7rAXSMkflznTf7593u3Gfj27AiUG
	 wtCnzmIndP4xGuGghYeU/+4XeQxPi5wwvdx4JwRD3nEqZpt7WWAr3mrqBtg0OSnap4
	 SL+AjlNhISfZ8xdjx44f5vthAqXMTNL881BU1eVw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733118AbfDARaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:30:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:37616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728698AbfDARac (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:30:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D26922070B;
        Mon,  1 Apr 2019 17:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139832;
        bh=YKrF8HsqFixDd71eOLAmxLe+ICN442VSNKKpH2ueAC4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ulIp7TgFWmgpEH2WHexNa3Dnrwaf32a5qzWZY97bnjokyB+CYvqF5kH71HrX9llU3
         GHRZNurKb6IP644QM1jVTPlX4mQ6T/boXX7ix+HS5tEWVg51JZ1FNYqQhaKpLoefS/
         7h83qahs55Rig3OAR7nu+smeX357nk4wEs2V2aRM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Baolin Wang <baolin.wang@linaro.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4.4 027/131] usb: gadget: Add the gserial port checking in gs_start_tx()
Date:   Mon,  1 Apr 2019 19:01:37 +0200
Message-Id: <20190401170054.338704490@linuxfoundation.org>
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

From: Baolin Wang <baolin.wang@linaro.org>

commit 511a36d2f357724312bb3776d2f6eed3890928b2 upstream.

When usb gadget is set gadget serial function, it will be crash in below
situation.

It will clean the 'port->port_usb' pointer in gserial_disconnect() function
when usb link is inactive, but it will release lock for disabling the endpoints
in this function. Druing the lock release period, it maybe complete one request
to issue gs_write_complete()--->gs_start_tx() function, but the 'port->port_usb'
pointer had been set NULL, thus it will be crash in gs_start_tx() function.

This patch adds the 'port->port_usb' pointer checking in gs_start_tx() function
to avoid this situation.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/gadget/function/u_serial.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/drivers/usb/gadget/function/u_serial.c
+++ b/drivers/usb/gadget/function/u_serial.c
@@ -361,10 +361,15 @@ __acquires(&port->port_lock)
 */
 {
 	struct list_head	*pool = &port->write_pool;
-	struct usb_ep		*in = port->port_usb->in;
+	struct usb_ep		*in;
 	int			status = 0;
 	bool			do_tty_wake = false;
 
+	if (!port->port_usb)
+		return status;
+
+	in = port->port_usb->in;
+
 	while (!port->write_busy && !list_empty(pool)) {
 		struct usb_request	*req;
 		int			len;


