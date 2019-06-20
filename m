Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E253C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5093215EA
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561053791;
	bh=gZWrYGruu5U/CADA8WM2KdoZ5CPFKIrqP3iR77YIUcw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BeGpNLO3LAt7aJ5HpgNW+NkUmz4h8xlumjLivbx7D/bOia72FRJvUvUIrJJWHiyth
	 zS5I05sLI64f99LbZCYVMd9uSVGxfysxGJZ2GhFCH0Xf/B0YRAkxyoiBlHqpBC2B6D
	 UtBBQFKLdj5dEDT/guihcSpl/vasjiAb7gding+g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbfFTSDJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 14:03:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:54082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727566AbfFTSDF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:03:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47CC2204FD;
        Thu, 20 Jun 2019 18:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561053784;
        bh=gZWrYGruu5U/CADA8WM2KdoZ5CPFKIrqP3iR77YIUcw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=McwJBfQ3tE3JoYlftFwf91CMIGkMPRrKUyTv5GWpARfVOSdD7vbYSva5zh+/rv1xm
         9CvnhC0O3FSCkapaXiVKsehntgxBqcx0ZdT0P9vF49+bYKC2IRkvqAaRrsL7Va8V1E
         G+kyvCnPmV+umH2BNQmN6RBNOh9fj5zeXE8Mw8SQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Georg Hofmann <georg@hofmannsweb.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 026/117] watchdog: imx2_wdt: Fix set_timeout for big timeout values
Date:   Thu, 20 Jun 2019 19:56:00 +0200
Message-Id: <20190620174353.545162591@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190620174351.964339809@linuxfoundation.org>
References: <20190620174351.964339809@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit b07e228eee69601addba98b47b1a3850569e5013 ]

The documentated behavior is: if max_hw_heartbeat_ms is implemented, the
minimum of the set_timeout argument and max_hw_heartbeat_ms should be used.
This patch implements this behavior.
Previously only the first 7bits were used and the input argument was
returned.

Signed-off-by: Georg Hofmann <georg@hofmannsweb.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/watchdog/imx2_wdt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
index 518dfa1047cb..5098982e1a58 100644
--- a/drivers/watchdog/imx2_wdt.c
+++ b/drivers/watchdog/imx2_wdt.c
@@ -181,8 +181,10 @@ static void __imx2_wdt_set_timeout(struct watchdog_device *wdog,
 static int imx2_wdt_set_timeout(struct watchdog_device *wdog,
 				unsigned int new_timeout)
 {
-	__imx2_wdt_set_timeout(wdog, new_timeout);
+	unsigned int actual;
 
+	actual = min(new_timeout, wdog->max_hw_heartbeat_ms * 1000);
+	__imx2_wdt_set_timeout(wdog, actual);
 	wdog->timeout = new_timeout;
 	return 0;
 }
-- 
2.20.1



