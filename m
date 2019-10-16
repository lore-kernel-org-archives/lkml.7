Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F95EECE599
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDB24207FF
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571264522;
	bh=Bf+ER69cBxaSgSskm14ZAD6nSzKcf7naYP/B+3ZIYU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sGf+sjtrnxU9LJG6GruSZqIH5qekDn9Q6rZAksXJvWfMkcDQBFuxRTDzgipAYt7yK
	 SBMb26+a6geuoIujCYQt/oG7ATx1Jn+9mPD8Smkh9BvhF2BxioJXDpPpRY/SvHGcSV
	 6TG1w5lSXYrL0PKZNAvMm6hTWnxvtUv5m6XPpBak=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439402AbfJPWWA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 18:22:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:42306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394858AbfJPVx0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:53:26 -0400
Received: from localhost (unknown [192.55.54.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30F7721925;
        Wed, 16 Oct 2019 21:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571262806;
        bh=Bf+ER69cBxaSgSskm14ZAD6nSzKcf7naYP/B+3ZIYU8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ag92/JOGMWolXSIdPiD8z0PbLPAcMoVj3Ep7ofrlQLA7BbrQ+EGsNFwxjTGSj7KKw
         4WbLElfyhXTVxGs6AVi6AAeRR+SvaMhL7xLVpgz690iHOgBXmLtDJFifrQe33y1SEc
         OM6bZUp4LV9jf73xnzS9DHaYZfGnYNyva+7KNaaY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Peter Korsgaard <jacmet@sunsite.dk>
Subject: [PATCH 4.4 48/79] serial: uartlite: fix exit path null pointer
Date:   Wed, 16 Oct 2019 14:50:23 -0700
Message-Id: <20191016214811.705472460@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016214729.758892904@linuxfoundation.org>
References: <20191016214729.758892904@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

commit a553add0846f355a28ed4e81134012e4a1e280c2 upstream.

Call uart_unregister_driver() conditionally instead of
unconditionally, only if it has been previously registered.

This uses driver.state, just as the sh-sci.c driver does.

Fixes this null pointer dereference in tty_unregister_driver(),
since the 'driver' argument is null:

  general protection fault: 0000 [#1] PREEMPT SMP KASAN PTI
  RIP: 0010:tty_unregister_driver+0x25/0x1d0

Fixes: 238b8721a554 ("[PATCH] serial uartlite driver")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: stable <stable@vger.kernel.org>
Cc: Peter Korsgaard <jacmet@sunsite.dk>
Link: https://lore.kernel.org/r/9c8e6581-6fcc-a595-0897-4d90f5d710df@infradead.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serial/uartlite.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -701,7 +701,8 @@ err_uart:
 static void __exit ulite_exit(void)
 {
 	platform_driver_unregister(&ulite_platform_driver);
-	uart_unregister_driver(&ulite_uart_driver);
+	if (ulite_uart_driver.state)
+		uart_unregister_driver(&ulite_uart_driver);
 }
 
 module_init(ulite_init);


