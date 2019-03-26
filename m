Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A6F6C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49D5E20857
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553581969;
	bh=UxPkjr5erKldwoJDywvA1LTjFawrd7Oht1e6RJQl3Rk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=X6pGkwJYGMC1iVRTECdEkm80ikl7IhItDeT3+dUUKcAc7S77adR+V/StaIg6TKYJX
	 niHK/TL5LVe0gta3v6bYPnNCvI3cG36V2t+pTHu8cOc9RsyLOyy2jMJR0JssKoAGSZ
	 PXSPIl71+s5k7bySUMEdgTPIwe2xOTrry03Doaug=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730750AbfCZGcs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:32:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:42176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731497AbfCZGcp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:32:45 -0400
Received: from localhost (unknown [104.132.152.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B5B720823;
        Tue, 26 Mar 2019 06:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553581964;
        bh=UxPkjr5erKldwoJDywvA1LTjFawrd7Oht1e6RJQl3Rk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IguofH3W3/YX549McW8lcn3Ghjl/u/bJHTmBPZRx9IUuymMLCDqz3aUbbLyurzR5j
         QOv9n14Gqi4bUVqqJ8LRrzhJzjs2ESBzoSEpPlMAf3Fqa76ch9s4n3+e1C3daNnTA6
         QS4DLJ9CLpp5vUg6atEePdIHwP9jzQy98UVEiYEQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wei Qiao <wei.qiao@spreadtrum.com>,
        Chunyan Zhang <chunyan.zhang@spreadtrum.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4.9 20/30] serial: sprd: adjust TIMEOUT to a big value
Date:   Tue, 26 Mar 2019 15:29:59 +0900
Message-Id: <20190326042608.252436998@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190326042607.558087893@linuxfoundation.org>
References: <20190326042607.558087893@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wei Qiao <wei.qiao@spreadtrum.com>

commit e1dc9b08051a2c2e694edf48d1e704f07c7c143c upstream.

SPRD_TIMEOUT was 256, which is too small to wait until the status
switched to workable in a while loop, so that the earlycon could
not work correctly.

Signed-off-by: Wei Qiao <wei.qiao@spreadtrum.com>
Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serial/sprd_serial.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/tty/serial/sprd_serial.c
+++ b/drivers/tty/serial/sprd_serial.c
@@ -36,7 +36,7 @@
 #define SPRD_FIFO_SIZE		128
 #define SPRD_DEF_RATE		26000000
 #define SPRD_BAUD_IO_LIMIT	3000000
-#define SPRD_TIMEOUT		256
+#define SPRD_TIMEOUT		256000
 
 /* the offset of serial registers and BITs for them */
 /* data registers */


