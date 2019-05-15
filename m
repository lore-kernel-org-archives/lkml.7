Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B076C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3860E20657
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557921466;
	bh=eFQjP66oTnVHWqZBj9HYryRNiX4vDQqo/nQR3Xb5xcI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=E1764v7Qm7V4lC8o8EYqdL1DnHJqFDrApFwbzpTV7N5d5nhLXmN91GcjPRrIJd0q+
	 z9H8Oe7wN5HqJHujP9h3i6xs+sOOFo8ul4MtR/WwpL75glTpMy7U6AYg90iMA4oN7z
	 l4fAm19U/aswHWaTsAMCAP1d8W7eGprsPJjgJJjo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730986AbfEOL5o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:57:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:53712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730565AbfEOLQt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:16:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F6592084E;
        Wed, 15 May 2019 11:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557919008;
        bh=eFQjP66oTnVHWqZBj9HYryRNiX4vDQqo/nQR3Xb5xcI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=br1gyMJ6HFdabCo1Bzbd94W7l/vvfHRKw0GIKwkEOzIlDCbms4Gxb+BUvjNHC7mwZ
         2O0/a5/P+pB1L86yFAGVIZmD3X9PYjYclZRriny1cVbTnpD0PnLX+Dajy5HMx6vDtM
         VgqyTM5HSivRafahhjtTD0cSVEiALGyRzeEb1K6A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Julian Wiedmann <jwi@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 032/115] s390: ctcm: fix ctcm_new_device error return code
Date:   Wed, 15 May 2019 12:55:12 +0200
Message-Id: <20190515090701.723139375@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090659.123121100@linuxfoundation.org>
References: <20190515090659.123121100@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 26363e0816fe4..fbe35c2ac8981 100644
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



