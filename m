Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34150C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 032C021924
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554138641;
	bh=Nm2OMvfi99GsJmOGU+7MASJ26ev43I0cXZ0qgu2spgk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JGNKxmHyu7DI6LUaWaiMp18sXB615NuuUqB6kwoWbmlLz6mXUsNGX/uW/sXsF+23x
	 hmZXJyfWAN4HwObhoL0n+HL0mC7x/4A4WJbNPhXKmzFK8rsv43QV4rwyxqeu/gTzgW
	 GtqXcWcV5FY8/xhThyMQYlkRW75Wl9qITTcfa1fY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730009AbfDARKj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:10:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:58448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729650AbfDARKh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:10:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC54A206B8;
        Mon,  1 Apr 2019 17:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138637;
        bh=Nm2OMvfi99GsJmOGU+7MASJ26ev43I0cXZ0qgu2spgk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G8RJuugyD6oqA1gB1eiuGvDv6WKyfyIxQ6r5gddBJJNnvA8ddz4A0ArzOREupYBIj
         UtZOl2S+ycJSY/f79bi/8+m/7pLSGfQVXABLTbEBBect7+YkCrqJbmilgEsPtFwM8L
         InpYmpJEz+Vulu5du4l1C9t2b1tB3usnjMHg4Pg4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Romain Izard <romain.izard.pro@gmail.com>,
        Oliver Neukum <oneukum@suse.com>
Subject: [PATCH 5.0 122/146] usb: cdc-acm: fix race during wakeup blocking TX traffic
Date:   Mon,  1 Apr 2019 19:02:14 +0200
Message-Id: <20190401170058.669057070@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170048.449559024@linuxfoundation.org>
References: <20190401170048.449559024@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Romain Izard <romain.izard.pro@gmail.com>

commit 93e1c8a638308980309e009cc40b5a57ef87caf1 upstream.

When the kernel is compiled with preemption enabled, the URB completion
handler can run in parallel with the work responsible for waking up the
tty layer. If the URB handler sets the EVENT_TTY_WAKEUP bit during the
call to tty_port_tty_wakeup() to signal that there is room for additional
input, it will be cleared at the end of this call. As a result, TX traffic
on the upper layer will be blocked.

This can be seen with a kernel configured with CONFIG_PREEMPT, and a fast
modem connected with PPP running over a USB CDC-ACM port.

Use test_and_clear_bit() instead, which ensures that each wakeup requested
by the URB completion code will trigger a call to tty_port_tty_wakeup().

Fixes: 1aba579f3cf5 cdc-acm: handle read pipe errors
Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
Cc: stable <stable@vger.kernel.org>
Acked-by: Oliver Neukum <oneukum@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/class/cdc-acm.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -558,10 +558,8 @@ static void acm_softint(struct work_stru
 		clear_bit(EVENT_RX_STALL, &acm->flags);
 	}
 
-	if (test_bit(EVENT_TTY_WAKEUP, &acm->flags)) {
+	if (test_and_clear_bit(EVENT_TTY_WAKEUP, &acm->flags))
 		tty_port_tty_wakeup(&acm->port);
-		clear_bit(EVENT_TTY_WAKEUP, &acm->flags);
-	}
 }
 
 /*


