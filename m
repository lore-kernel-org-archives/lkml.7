Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC500C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91EC021924
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568931629;
	bh=h7bs5BaL3V7O2y9WW5ZRBJX0p8qiT4bHZLFJo4yFCI8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n+/1s5TFqXoFiC9mTovWws4IRnXHiG2+kmuQ30VFjfLg/4sQsQ0nnGUndzvjttoCu
	 w3L5mOF6Sl7/msMk7n61bYqgV+YKWQUBWzw3nqXHyvsbHMmLxLx8BaDBA3mtKiC7TU
	 NEKFvmEj38XjcuLgIHVHw9kP0Rj0fT4oRYVATaKk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732759AbfISWU2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 18:20:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:34410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394026AbfISWUZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 18:20:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A59721907;
        Thu, 19 Sep 2019 22:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568931624;
        bh=h7bs5BaL3V7O2y9WW5ZRBJX0p8qiT4bHZLFJo4yFCI8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y4/KJKy5Eyw/kGjEyhKF0DroOgd3eiPoo4/+03yUY4VHKurHijqKK0Ux6yhHujNbf
         3sSE5WWKfIC22GKht4MjSZs9RciWbJGlO3uFQ129TYbl6aVEHt4/bD5cGaQz8dNN9Q
         Y/P+AvfnftFnrsAr5p5h6r+UC9NTyFykivNm9LQs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Prashant Malani <pmalani@chromium.org>,
        Hayes Wang <hayeswang@realtek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 54/74] r8152: Set memory to all 0xFFs on failed reg reads
Date:   Fri, 20 Sep 2019 00:04:07 +0200
Message-Id: <20190919214810.052809203@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190919214800.519074117@linuxfoundation.org>
References: <20190919214800.519074117@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



