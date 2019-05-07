Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 861F9C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 06:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5770F20675
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 06:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557209055;
	bh=KAUimBQdj+nHpMqsvXOl+n6LyDgo2wZ0ySM7WIKm6I8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iHnYL0Z/gurA9MCHZMA801IEqUzirDK+udF0VHsVvhS+4h63L8mxxLzpeyBUZnn/1
	 IilV6GA61hzpD8Z3JvLNYMdl90Ce75cWz4RVIZ/n8Mwg9g0YjHXkQErpeBk5vfYOTd
	 kH+Yw/YkwUQfYBjH5iE4tXKnHllMbWRw2/uIzb90=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbfEGGEI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 02:04:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:54922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727624AbfEGFey (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 01:34:54 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDBFD20C01;
        Tue,  7 May 2019 05:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557207293;
        bh=KAUimBQdj+nHpMqsvXOl+n6LyDgo2wZ0ySM7WIKm6I8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tsl2pdbTEvWqpFKr86bz4RvBUru2tF6etFYW+dQfySBASwalSc/1AGy5cL9E5ss2g
         hWGJgSGHukZvKELygC8v8DQBmfPSi4A0pW5tvHW1vWrmmOyEC6W0UvPvOtgNpVxubq
         v1uEzLrkSBkIJWizUCbyw8smNI3/QidGukVXVQs4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Julian Wiedmann <jwi@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 68/99] s390: ctcm: fix ctcm_new_device error return code
Date:   Tue,  7 May 2019 01:32:02 -0400
Message-Id: <20190507053235.29900-68-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190507053235.29900-1-sashal@kernel.org>
References: <20190507053235.29900-1-sashal@kernel.org>
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
index 7617d21cb296..f63c5c871d3d 100644
--- a/drivers/s390/net/ctcm_main.c
+++ b/drivers/s390/net/ctcm_main.c
@@ -1595,6 +1595,7 @@ static int ctcm_new_device(struct ccwgroup_device *cgdev)
 		if (priv->channel[direction] == NULL) {
 			if (direction == CTCM_WRITE)
 				channel_free(priv->channel[CTCM_READ]);
+			result = -ENODEV;
 			goto out_dev;
 		}
 		priv->channel[direction]->netdev = dev;
-- 
2.20.1

