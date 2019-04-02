Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 921D9C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AC1320856
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:45:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732113AbfDBNph (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:45:37 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:43298 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731455AbfDBNkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 09:40:06 -0400
Received: from [167.98.27.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBJe0-0002ny-B1; Tue, 02 Apr 2019 14:40:04 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBJdx-0004wP-Di; Tue, 02 Apr 2019 14:40:01 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Dan Carpenter" <dan.carpenter@oracle.com>,
        "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Date:   Tue, 02 Apr 2019 14:38:28 +0100
Message-ID: <lsq.1554212308.713198748@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 74/99] Input: nomadik-ske-keypad - fix a loop timeout
 test
In-Reply-To: <lsq.1554212307.17110877@decadent.org.uk>
X-SA-Exim-Connect-IP: 167.98.27.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.65-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@oracle.com>

commit 4d8f727b83bcd6702c2d210330872c9122d2d360 upstream.

The loop exits with "timeout" set to -1 not to 0.

Fixes: 1158f0f16224 ("Input: add support for Nomadik SKE keypad controller")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/input/keyboard/nomadik-ske-keypad.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/input/keyboard/nomadik-ske-keypad.c
+++ b/drivers/input/keyboard/nomadik-ske-keypad.c
@@ -100,7 +100,7 @@ static int __init ske_keypad_chip_init(s
 	while ((readl(keypad->reg_base + SKE_RIS) != 0x00000000) && timeout--)
 		cpu_relax();
 
-	if (!timeout)
+	if (timeout == -1)
 		return -EINVAL;
 
 	/*

