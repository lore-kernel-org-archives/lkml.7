Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A610CA9EB9
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 13:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D752321655
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 13:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572097043;
	bh=FZLtB1Zx6xS/anFkQ9xchpIgUkbONW+4mQagDOlzths=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rnzVyTlD+CiGqS5L4DZOiwoaUp4exzYnipy8BClcx5TKCzgSNoUWCnIqEM3jmew5Z
	 ZmgsPVjRAJB52usr9SUag09Opr97ayAlgGcrjoh6EpJe83Pvp3gclaqr9tnf3hlrib
	 msAfQ9vgCXP3t5A1IzhXk5emptZ9zaIOVhj51Sqw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbfJZNhW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 09:37:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:37832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726628AbfJZNQU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 09:16:20 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A53C421D7F;
        Sat, 26 Oct 2019 13:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572095779;
        bh=FZLtB1Zx6xS/anFkQ9xchpIgUkbONW+4mQagDOlzths=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VSS2E1pD5RxfGpXipUZ9ph8qEsR6zP8hKzncBBwJd1s2FXkRr3m+b548oVAmwNW9M
         5UHNP55dmPzc/jF3/rPOJpHWJFtaW56ZoK92oeI7ZYdLLsAPbCWZtgQdyuv9lI3R1z
         rEIQ8RY1RY5OiN5K0KEKOKLafW1DYUiCzpcEnsB8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Hubert Feurstein <h.feurstein@gmail.com>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.3 10/99] net: dsa: b53: Do not clear existing mirrored port mask
Date:   Sat, 26 Oct 2019 09:14:31 -0400
Message-Id: <20191026131600.2507-10-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191026131600.2507-1-sashal@kernel.org>
References: <20191026131600.2507-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>

[ Upstream commit c763ac436b668d7417f0979430ec0312ede4093d ]

Clearing the existing bitmask of mirrored ports essentially prevents us
from capturing more than one port at any given time. This is clearly
wrong, do not clear the bitmask prior to setting up the new port.

Reported-by: Hubert Feurstein <h.feurstein@gmail.com>
Fixes: ed3af5fd08eb ("net: dsa: b53: Add support for port mirroring")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Reviewed-by: Vivien Didelot <vivien.didelot@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/b53/b53_common.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 907af62846ba8..0721c22e2bc8b 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -1808,7 +1808,6 @@ int b53_mirror_add(struct dsa_switch *ds, int port,
 		loc = B53_EG_MIR_CTL;
 
 	b53_read16(dev, B53_MGMT_PAGE, loc, &reg);
-	reg &= ~MIRROR_MASK;
 	reg |= BIT(port);
 	b53_write16(dev, B53_MGMT_PAGE, loc, reg);
 
-- 
2.20.1

