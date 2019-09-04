Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2BD1C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB00A22CED
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567613403;
	bh=MObqDKyCwUFv4ZdRPDIg/JRo1tcGAB+2SCyl6lE37/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ieXFebKPdkjohXWsbLdGVF1Xv8J4oKa+lj+gVMmN4AVxhQMoYUbpIViCpvoalEJUf
	 Ioh2xAETCWmulaRjikb+C8dLXULLZ/x47xUXVGmpkydS5qunKynukHgbvPMdk3lRf1
	 QZg/MqgsMRP1XwLN9gNKzi/kK4PH572/v3bKy3A0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732870AbfIDQBB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 12:01:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:35754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732164AbfIDQAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 12:00:46 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C4B022CED;
        Wed,  4 Sep 2019 16:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567612846;
        bh=MObqDKyCwUFv4ZdRPDIg/JRo1tcGAB+2SCyl6lE37/s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sUORdJQcgI3EpKZKLOywd/VIOAHDPwJwfrjk6CnKJV25ypXqseYI6bpm8SShgqphh
         3dabOShoQDdf09RPEz0YgdoIKkPNVNNLxeoPMHHcq7CKyWKLoO/Ssg9PoS8/dTjGwj
         fZlGjFajDq42C282LN4pt2MXeliU/9sv0MSK0P0E=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Prashant Malani <pmalani@chromium.org>,
        Hayes Wang <hayeswang@realtek.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 29/52] r8152: Set memory to all 0xFFs on failed reg reads
Date:   Wed,  4 Sep 2019 11:59:41 -0400
Message-Id: <20190904160004.3671-29-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190904160004.3671-1-sashal@kernel.org>
References: <20190904160004.3671-1-sashal@kernel.org>
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
index f1b5201cc3207..a065a6184f7e4 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -788,8 +788,11 @@ int get_registers(struct r8152 *tp, u16 value, u16 index, u16 size, void *data)
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

