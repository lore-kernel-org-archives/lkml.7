Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C01AC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E228320880
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139520;
	bh=4hc8+VfxJq6ro2Pgz1M83a75L0RWYHRRuVZ8INshSzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PmQnbv4CyiqTefR8czWA/SL0U5SzV2SlMbBi8Q9UKcNzJ9cLlCFKkbeWdMkh8wpId
	 Sdub+zac5wOUSCid4M3Usjt3REWi7E/A6wmPvTgXlX9b8as7iXMRzPD5nCA28Z6WfE
	 bfasbQqMfXBSILoW6gYJOxVHnXCSm017RPHRMHuw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732396AbfDARZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:25:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:56436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732178AbfDARZQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:25:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CB3A20830;
        Mon,  1 Apr 2019 17:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139515;
        bh=4hc8+VfxJq6ro2Pgz1M83a75L0RWYHRRuVZ8INshSzs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TQM8AV8/NBSx1bxEktJlPj04HRJBXFoUuOlo7xBxcuAxpW40wIkrIt5H7URPFgXgX
         zLa+Izb3pE4p1snj4p6lvVXhlqF5ft1lMEKK4jgDx0gBLyWXFFmLOjGxCt3+yf2Tix
         WIqNGG4ByBYf1E52c680FyQJvxVNWjMWl4Bu0fxs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Romain Izard <romain.izard.pro@gmail.com>,
        Oliver Neukum <oneukum@suse.com>
Subject: [PATCH 4.14 099/107] usb: cdc-acm: fix race during wakeup blocking TX traffic
Date:   Mon,  1 Apr 2019 19:02:54 +0200
Message-Id: <20190401170054.703090718@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170045.246405031@linuxfoundation.org>
References: <20190401170045.246405031@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -570,10 +570,8 @@ static void acm_softint(struct work_stru
 		clear_bit(EVENT_RX_STALL, &acm->flags);
 	}
 
-	if (test_bit(EVENT_TTY_WAKEUP, &acm->flags)) {
+	if (test_and_clear_bit(EVENT_TTY_WAKEUP, &acm->flags))
 		tty_port_tty_wakeup(&acm->port);
-		clear_bit(EVENT_TTY_WAKEUP, &acm->flags);
-	}
 }
 
 /*


