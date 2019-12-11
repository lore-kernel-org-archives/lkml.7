Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 518B9C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AA1022B48
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576077565;
	bh=yQEPvGzlhbcnX9ZQ96qD836OfgT8GScDCFHzaTP2QZ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZfQq0FdmhtnPZl9rII6ymb53BSo8oHcJRykmpfw12Pyk5NlU60QPOyQvcfk+dzKp9
	 G//TIP5TQ1xzYc4L7twxhJlti/t6dpbHv8DVS9Oj3Gc4kaQ0ihJqaiBCL+ROs7rRZp
	 Nfw77hrXhIRNqYxnIXtVVp1PzDv7m8XP4rEBJlnE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731949AbfLKPTX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:19:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:47970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732195AbfLKPTQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:19:16 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2AFF2465B;
        Wed, 11 Dec 2019 15:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576077556;
        bh=yQEPvGzlhbcnX9ZQ96qD836OfgT8GScDCFHzaTP2QZ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gpkNvM34fQl42C48QvDWEApasDxbbkoNj0k6SNnW1rKtiTrn5JmDWQYUnbRGau74G
         1hdXqiQ9cPJccI6YhNCoV5FxN9DIlXOAQ5F0ElyWCgKcfpGhqo6YQxw5D3PpINKvki
         SHLoi4aVKN6BZIPsXYyI4oJfI9aw3TjvnDw/a+3o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 084/243] rtc: max8997: Fix the returned value in case of error in max8997_rtc_read_alarm()
Date:   Wed, 11 Dec 2019 16:04:06 +0100
Message-Id: <20191211150344.781117917@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191211150339.185439726@linuxfoundation.org>
References: <20191211150339.185439726@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 41ef3878203cd9218d92eaa07df4b85a2cb128fb ]

In case of error, we return 0.
This is spurious and not consistent with the other functions of the driver.
Propagate the error code instead.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/rtc/rtc-max8997.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-max8997.c b/drivers/rtc/rtc-max8997.c
index 08c661a332ec0..20e50d9fdf882 100644
--- a/drivers/rtc/rtc-max8997.c
+++ b/drivers/rtc/rtc-max8997.c
@@ -215,7 +215,7 @@ static int max8997_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 
 out:
 	mutex_unlock(&info->lock);
-	return 0;
+	return ret;
 }
 
 static int max8997_rtc_stop_alarm(struct max8997_rtc_info *info)
-- 
2.20.1



