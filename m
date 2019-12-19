Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA9F7C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C2D724680
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576780991;
	bh=YitMJak+QJ5u7f/nA4YofkormATrSvmkfaTtgbRZJzM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=R9hB4X/p+hLu8jiJIrOoxKObzG8fOUxVY1HvPLYScu9m0F0dTGNlYi9+0KCrcXteH
	 J9sqkXIu+0PoSqZgATljiYq4UMcuNrtSpZNm3rKiatbflFhq4qqW0aiiGeJpxkD2f/
	 za87qucWy/nuQGiaSSzo7U0htZyzAsTCgWexjHI0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728810AbfLSSnK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:43:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:34590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728789AbfLSSnF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:43:05 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5593424672;
        Thu, 19 Dec 2019 18:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576780984;
        bh=YitMJak+QJ5u7f/nA4YofkormATrSvmkfaTtgbRZJzM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MFlLftY5L4Zu1kmeTat91RME+tx5kkJrs+HfsITJu++qm6LedavhbimGex6CSUsdk
         FpDilJOc2dmSvWpagTNoey+Qi1DRKEi1jwRAX5UGu4MNZYeyipGV/ru3KHdgWMmCo8
         JC1Qha9Nl2XYuVtVAmHfhBz4cZsC1yezFYJKMm98=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 034/199] rtc: max8997: Fix the returned value in case of error in max8997_rtc_read_alarm()
Date:   Thu, 19 Dec 2019 19:31:56 +0100
Message-Id: <20191219183216.791262015@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219183214.629503389@linuxfoundation.org>
References: <20191219183214.629503389@linuxfoundation.org>
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
index db984d4bf9526..4cce5bd448f65 100644
--- a/drivers/rtc/rtc-max8997.c
+++ b/drivers/rtc/rtc-max8997.c
@@ -221,7 +221,7 @@ static int max8997_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 
 out:
 	mutex_unlock(&info->lock);
-	return 0;
+	return ret;
 }
 
 static int max8997_rtc_stop_alarm(struct max8997_rtc_info *info)
-- 
2.20.1



