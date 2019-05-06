Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F4BC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D7F52053B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557154997;
	bh=7TPRLxLTFcgyHj50Btjvh0KiUBOEcT8EwlzWkavrPqo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lx9vrC5PPKSv39jUp0Wkmlg/w6M8IHFTP7OFKFWbWY6CD1W/GyQlAMGCmTb22oiI1
	 PV6wwcoTruH4lJmTAewU+X40aHe7qdtfiuMXN4NMVL9QAnhjZVFunwjLk6c1BOBquA
	 PvUcqbLRblF6ZHcOCOs732WRXJJTCwcBKgMJUN+o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbfEFOjy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 10:39:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:33006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727134AbfEFOjw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 10:39:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2F0520449;
        Mon,  6 May 2019 14:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557153592;
        bh=7TPRLxLTFcgyHj50Btjvh0KiUBOEcT8EwlzWkavrPqo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zt5v4qELT4G11414VtmfEYkDGpTLhU2BAiKHd7s0dbLaFBz+qCURiab5jwggIVjXY
         q4nlZNnrJf3b6dE4YnGH3UyC2tXjVQiuKgu5jyS2rV5HlP+xLVPp9+JyC8CRLbD4Dh
         31Ifx/DVXvy9IZUiKvBHnzOWxDEdKG1S8tFdtpi0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 4.19 06/99] i2c: Remove unnecessary call to irq_find_mapping
Date:   Mon,  6 May 2019 16:31:39 +0200
Message-Id: <20190506143054.443262341@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190506143053.899356316@linuxfoundation.org>
References: <20190506143053.899356316@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Charles Keepax <ckeepax@opensource.cirrus.com>

commit b9bb3fdf4e870fb655064f5c3c81c1fee7fd89ce upstream.

irq_create_mapping calls irq_find_mapping internally and will use the
found mapping if one exists, so there is no need to manually call this
from i2c_smbus_host_notify_to_irq.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/i2c/i2c-core-base.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -306,10 +306,7 @@ static int i2c_smbus_host_notify_to_irq(
 	if (client->flags & I2C_CLIENT_TEN)
 		return -EINVAL;
 
-	irq = irq_find_mapping(adap->host_notify_domain, client->addr);
-	if (!irq)
-		irq = irq_create_mapping(adap->host_notify_domain,
-					 client->addr);
+	irq = irq_create_mapping(adap->host_notify_domain, client->addr);
 
 	return irq > 0 ? irq : -ENXIO;
 }


