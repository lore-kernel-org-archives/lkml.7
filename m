Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A10B0C352A9
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 13:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D19821924
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 13:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569765549;
	bh=z2cC+n1rIUMVeEHpIOOVVWC99VjcHafZ2tlIc1+zhrs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=H0nFKs1KMQ/tjtBtEdzN6RLcxtoNwv6oVbUfMbMOmp1OBqZSdngzwTChjbH/e824l
	 +kKXAisV5XwuR9gyr9qTwD0VCJ9UJ7wdNEzDnsd6o/mxboEuaexCdkE/IbLA1/zSgu
	 i9IymTajm5b4jfe4ooXokibuGKzkULKojFWqkEU0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729657AbfI2N7I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 09:59:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:40054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729639AbfI2N7E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 09:59:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 604A8218AC;
        Sun, 29 Sep 2019 13:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569765544;
        bh=z2cC+n1rIUMVeEHpIOOVVWC99VjcHafZ2tlIc1+zhrs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ppgv2y7r8SkH4B+mZ3wbInEFv1xh7Kui5ADaZ7cW3BL3XY+nAzfQT1f3zT4hddF43
         UhkX+sD0OL8klwLTtTGAE+S9zLKiui5jpVKSF0WH4nA9MalB7RdX30+Nurinwxl3O1
         uMwaU1oihCjVGS1HgpH+XbC+9GWXJnta0z9146PI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Lechner <david@lechnology.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 35/63] power: supply: sysfs: ratelimit property read error message
Date:   Sun, 29 Sep 2019 15:54:08 +0200
Message-Id: <20190929135038.378746421@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190929135031.382429403@linuxfoundation.org>
References: <20190929135031.382429403@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Lechner <david@lechnology.com>

[ Upstream commit 87a2b65fc855e6be50f791c2ebbb492541896827 ]

This adds rate limiting to the message that is printed when reading a
power supply property via sysfs returns an error. This will prevent
userspace applications from unintentionally dDOSing the system by
continuously reading a property that returns an error.

Signed-off-by: David Lechner <david@lechnology.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/power_supply_sysfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index 5a2757a7f4088..5358a80d854f9 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -131,7 +131,8 @@ static ssize_t power_supply_show_property(struct device *dev,
 				dev_dbg(dev, "driver has no data for `%s' property\n",
 					attr->attr.name);
 			else if (ret != -ENODEV && ret != -EAGAIN)
-				dev_err(dev, "driver failed to report `%s' property: %zd\n",
+				dev_err_ratelimited(dev,
+					"driver failed to report `%s' property: %zd\n",
 					attr->attr.name, ret);
 			return ret;
 		}
-- 
2.20.1



