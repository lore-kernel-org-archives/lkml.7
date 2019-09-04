Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8414FC3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5539B23401
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567612965;
	bh=h7bs5BaL3V7O2y9WW5ZRBJX0p8qiT4bHZLFJo4yFCI8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iIY7SOQikQvnzM+LzXNv3GMHDGmdlItL8L6n5p72hYBMm1PbnoE4lMGrq1Cda7pA0
	 2LlRHoc5TcUZ1nv9s8J4FkfLlHDJo08tKCZmqXwZepyzv+GNqPqAgrlZmM11/c1o8R
	 hH2vPpSdrzHZRZgFrZk0+DnT3gFfDLiEql6gZQkM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387477AbfIDQCn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 12:02:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:38760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387455AbfIDQCk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 12:02:40 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2E0B2087E;
        Wed,  4 Sep 2019 16:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567612959;
        bh=h7bs5BaL3V7O2y9WW5ZRBJX0p8qiT4bHZLFJo4yFCI8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P+2/Nbq2yYbSyK4xiC1K5Q1heuwET2SxU5qeRHN7q8bqeyso2afd2NU1dYcagQvTt
         S0QcHMnKzCtfjd11l+azHl1017Q65/AROp/MsJWWeUaWUBzKYcAKdttEOeJBeiUzO2
         4oXbDl1k1LylClygBrs9YXBWd0/rvu//Oa4Ol5+s=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Prashant Malani <pmalani@chromium.org>,
        Hayes Wang <hayeswang@realtek.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 13/27] r8152: Set memory to all 0xFFs on failed reg reads
Date:   Wed,  4 Sep 2019 12:02:06 -0400
Message-Id: <20190904160220.4545-13-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190904160220.4545-1-sashal@kernel.org>
References: <20190904160220.4545-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Prashant Malani <pmalani@chromium.org>

[ Upstream commit f53a7ad189594a112167efaf17ea8d0242b5ac00 ]

get_registers() blindly copies the memory written to by the
usb_control_msg() call even if the underlying urb failed.

This could lead to junk register values being read by the driver, since
some indirect callers of get_registers() ignore the return values. One
example is:
  ocp_read_dword() ignores the return value of generic_ocp_read(), which
  calls get_registers().

So, emulate PCI "Master Abort" behavior by setting the buffer to all
0xFFs when usb_control_msg() fails.

This patch is copied from the r8152 driver (v2.12.0) published by
Realtek (www.realtek.com).

Signed-off-by: Prashant Malani <pmalani@chromium.org>
Acked-by: Hayes Wang <hayeswang@realtek.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/r8152.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 02e29562d254e..15dc70c118579 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -689,8 +689,11 @@ int get_registers(struct r8152 *tp, u16 value, u16 index, u16 size, void *data)
 	ret = usb_control_msg(tp->udev, usb_rcvctrlpipe(tp->udev, 0),
 			      RTL8152_REQ_GET_REGS, RTL8152_REQT_READ,
 			      value, index, tmp, size, 500);
+	if (ret < 0)
+		memset(data, 0xff, size);
+	else
+		memcpy(data, tmp, size);
 
-	memcpy(data, tmp, size);
 	kfree(tmp);
 
 	return ret;
-- 
2.20.1

