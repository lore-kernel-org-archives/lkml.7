Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE7F1C072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDB2425D37
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559191821;
	bh=UIoZc5owPmJU0ms9w6jKmXYPLGFCtit3EcHRKOkHaCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EUql91UgfWdmxmt6KI4kFs7+WKBtkJ06TKB7lI1HrYoY7xbAwvXVzNIsa+nM+mtzK
	 7gZ3VHdXR4lqpOXY+9RHN5SjHJnvFeifQxQGAgibHFz+22+vtlVZju/tFQfYQ8YmbZ
	 2200phB6Ao0ogGNSCf7ec0apJ5X8ZBhrsU33ZylM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388914AbfE3EuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:50:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:49578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728334AbfE3DLD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:11:03 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D773724496;
        Thu, 30 May 2019 03:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559185863;
        bh=UIoZc5owPmJU0ms9w6jKmXYPLGFCtit3EcHRKOkHaCY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2YXNDCA5BRmbQry4KH8FsjbNd1skMJz3Fo8jnR6PAYP9KKk826ZegmiSdINSqcMRl
         WciXuSSL2gVERfmN4MQ38E1m9HppDcJ9m0kJWYu+R9ZUUN7ezop9/kyq1pn+Qn3gaM
         T5cB62HwmAE1/DPLT6ZAXR6aYI8BAJNWsucDiR+0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kefeng Wang <wangkefeng.wang@huawei.com>,
        John Garry <john.garry@huawei.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 199/405] hwmon: (smsc47b397) Use request_muxed_region for Super-IO accesses
Date:   Wed, 29 May 2019 20:03:17 -0700
Message-Id: <20190530030551.269436881@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.291644921@linuxfoundation.org>
References: <20190530030540.291644921@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 8c0826756744c0ac1df600a5e4cca1a341b13101 ]

Super-IO accesses may fail on a system with no or unmapped LPC bus.

Also, other drivers may attempt to access the LPC bus at the same time,
resulting in undefined behavior.

Use request_muxed_region() to ensure that IO access on the requested
address space is supported, and to ensure that access by multiple drivers
is synchronized.

Fixes: 8d5d45fb1468 ("I2C: Move hwmon drivers (2/3)")
Reported-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Reported-by: John Garry <john.garry@huawei.com>
Cc: John Garry <john.garry@huawei.com>
Acked-by: John Garry <john.garry@huawei.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/smsc47b397.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/smsc47b397.c b/drivers/hwmon/smsc47b397.c
index c0775084dde00..60e193f2e9707 100644
--- a/drivers/hwmon/smsc47b397.c
+++ b/drivers/hwmon/smsc47b397.c
@@ -72,14 +72,19 @@ static inline void superio_select(int ld)
 	superio_outb(0x07, ld);
 }
 
-static inline void superio_enter(void)
+static inline int superio_enter(void)
 {
+	if (!request_muxed_region(REG, 2, DRVNAME))
+		return -EBUSY;
+
 	outb(0x55, REG);
+	return 0;
 }
 
 static inline void superio_exit(void)
 {
 	outb(0xAA, REG);
+	release_region(REG, 2);
 }
 
 #define SUPERIO_REG_DEVID	0x20
@@ -300,8 +305,12 @@ static int __init smsc47b397_find(void)
 	u8 id, rev;
 	char *name;
 	unsigned short addr;
+	int err;
+
+	err = superio_enter();
+	if (err)
+		return err;
 
-	superio_enter();
 	id = force_id ? force_id : superio_inb(SUPERIO_REG_DEVID);
 
 	switch (id) {
-- 
2.20.1



