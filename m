Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 604ADC04AAD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 05:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31B52205ED
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 05:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557208333;
	bh=jsiaPODoAbrT8Y6GeItVfA6P+hSZ5IrF27NFV2ZE480=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pgcIorMwaS3qb4M8bjl4b2dEFSCYZSIh5dIz6Bk8VgDKoMgdT2PwmPcawSekJbwMe
	 98wulzIxeWs5M0DvRM/URu6bVXlt5xOAf9F8cotg2MinOrHCZcl9DnJldU3FzopjmR
	 kW734q5AfDxFROjPtCm1cx54aShEKe2PgKZBpHlI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728881AbfEGFjb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 01:39:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:59030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728851AbfEGFjY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 01:39:24 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08418205ED;
        Tue,  7 May 2019 05:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557207563;
        bh=jsiaPODoAbrT8Y6GeItVfA6P+hSZ5IrF27NFV2ZE480=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iRQyusCKvlZhJgWThAql3e1pdu43JZiv9H3y8/4d1MivjFZ/MPOdsrXlgEM7m4t/4
         NcCG9zvEUuCqqtls2q+0XQpVVk4imZ+yy4ooe6Pc/9l8TgJ21AYzjR5hx8vqZ2lzfj
         Sy5HKM4KO+yXdKb0LEIR2QP2XCUGn28S/zI37Y+U=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Julian Wiedmann <jwi@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 27/95] s390: ctcm: fix ctcm_new_device error return code
Date:   Tue,  7 May 2019 01:37:16 -0400
Message-Id: <20190507053826.31622-27-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190507053826.31622-1-sashal@kernel.org>
References: <20190507053826.31622-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 27b141fc234a3670d21bd742c35d7205d03cbb3a ]

clang points out that the return code from this function is
undefined for one of the error paths:

../drivers/s390/net/ctcm_main.c:1595:7: warning: variable 'result' is used uninitialized whenever 'if' condition is true
      [-Wsometimes-uninitialized]
                if (priv->channel[direction] == NULL) {
                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/s390/net/ctcm_main.c:1638:9: note: uninitialized use occurs here
        return result;
               ^~~~~~
../drivers/s390/net/ctcm_main.c:1595:3: note: remove the 'if' if its condition is always false
                if (priv->channel[direction] == NULL) {
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../drivers/s390/net/ctcm_main.c:1539:12: note: initialize the variable 'result' to silence this warning
        int result;
                  ^

Make it return -ENODEV here, as in the related failure cases.
gcc has a known bug in underreporting some of these warnings
when it has already eliminated the assignment of the return code
based on some earlier optimization step.

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/net/ctcm_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/s390/net/ctcm_main.c b/drivers/s390/net/ctcm_main.c
index 26363e0816fe..fbe35c2ac898 100644
--- a/drivers/s390/net/ctcm_main.c
+++ b/drivers/s390/net/ctcm_main.c
@@ -1594,6 +1594,7 @@ static int ctcm_new_device(struct ccwgroup_device *cgdev)
 		if (priv->channel[direction] == NULL) {
 			if (direction == CTCM_WRITE)
 				channel_free(priv->channel[CTCM_READ]);
+			result = -ENODEV;
 			goto out_dev;
 		}
 		priv->channel[direction]->netdev = dev;
-- 
2.20.1

