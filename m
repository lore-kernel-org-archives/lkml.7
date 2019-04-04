Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B3AC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52AAF21850
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554368627;
	bh=wT0DNajpIp6+zKv7jykHtcAKHuP6jiI0So7+Yfmz0YM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Q+X9UPir7ORP75mBCOcV0zCtum/vl+ApuVW991xj5NTGpNpYbKUHJdqtTu5sb+2KR
	 BSCfyRh6XMRo3F+wddPifOqogKU825o8QS+n8EYnkFuP5lBhpJS3NL+3TQS32qIObc
	 tCNPoEVl14NeaNp2SG8/4eL5mbwTgwQKxlcaHoNM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731378AbfDDJDq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:03:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:41410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731843AbfDDJDm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:03:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BD5421850;
        Thu,  4 Apr 2019 09:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368621;
        bh=wT0DNajpIp6+zKv7jykHtcAKHuP6jiI0So7+Yfmz0YM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eriyg2hAJ9k5jjdySQRHgdySteQT7xklEvEoyUnZQzq55cvjIc8L67hXAtqEtjFAf
         gpKXWVy3vEe0CDaPO8A/AFZBUTQpqJ2GlGqVAInI6HRH0Kym8h8aHVtO1d+9M40fGo
         78LUVG3/E1LS3fc9aAy119mIHZyKe/W2mZS7xSUQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Felix Fietkau <nbd@nbd.name>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 091/187] mt76: usb: do not run mt76u_queues_deinit twice
Date:   Thu,  4 Apr 2019 10:47:08 +0200
Message-Id: <20190404084607.404259781@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084603.119654039@linuxfoundation.org>
References: <20190404084603.119654039@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit b3098121c42caaf3aea239b8655cf52d45be116f ]

Do not call mt76u_queues_deinit routine in mt76u_alloc_queues error path
since it will be run in mt76x0u_register_device or
mt76x2u_register_device error path. Current implementation triggers the
following kernel warning:

[   67.005516] WARNING: CPU: 2 PID: 761 at lib/refcount.c:187 refcount_sub_and_test_checked+0xa4/0xb8
[   67.019513] refcount_t: underflow; use-after-free.
[   67.099872] Hardware name: BCM2835
[   67.106268] Backtrace:
[   67.111584] [<8010c91c>] (dump_backtrace) from [<8010cc00>] (show_stack+0x20/0x24)
[   67.124974]  r6:60000013 r5:ffffffff r4:00000000 r3:a50bade6
[   67.132226] [<8010cbe0>] (show_stack) from [<807ca5f4>] (dump_stack+0xc8/0x114)
[   67.141225] [<807ca52c>] (dump_stack) from [<8011e65c>] (__warn+0xf4/0x120)
[   67.149849]  r9:000000bb r8:804d0138 r7:00000009 r6:8099dc84 r5:00000000 r4:b66c7b58
[   67.160767] [<8011e568>] (__warn) from [<8011e6d0>] (warn_slowpath_fmt+0x48/0x50)
[   67.171436]  r9:7f65e128 r8:80d1419c r7:80c0bac4 r6:b97b3044 r5:b7368e00 r4:00000000
[   67.182433] [<8011e68c>] (warn_slowpath_fmt) from [<804d0138>] (refcount_sub_and_test_checked+0xa4/0xb8)
[   67.195221]  r3:80c91c25 r2:8099dc94
[   67.200370]  r4:00000000
[   67.204397] [<804d0094>] (refcount_sub_and_test_checked) from [<804d0164>] (refcount_dec_and_test_checked+0x18/0x1c)
[   67.218046]  r4:b7368e00 r3:00000001
[   67.223125] [<804d014c>] (refcount_dec_and_test_checked) from [<805db49c>] (usb_free_urb+0x20/0x4c)
[   67.235358] [<805db47c>] (usb_free_urb) from [<7f639804>] (mt76u_buf_free+0x98/0xac [mt76_usb])
[   67.247302]  r4:00000001 r3:00000001
[   67.252468] [<7f63976c>] (mt76u_buf_free [mt76_usb]) from [<7f639ef8>] (mt76u_queues_deinit+0x44/0x100 [mt76_usb])
[   67.266102]  r8:b8fe8600 r7:b5dac480 r6:b5dace20 r5:00000001 r4:00000000 r3:00000080
[   67.277132] [<7f639eb4>] (mt76u_queues_deinit [mt76_usb]) from [<7f65c040>] (mt76x0u_cleanup+0x40/0x4c [mt76x0u])
[   67.290737]  r7:b5dac480 r6:b8fe8600 r5:ffffffea r4:b5dace20
[   67.298069] [<7f65c000>] (mt76x0u_cleanup [mt76x0u]) from [<7f65c564>] (mt76x0u_probe+0x1f0/0x354 [mt76x0u])
[   67.311174]  r4:b5dace20 r3:00000000
[   67.316312] [<7f65c374>] (mt76x0u_probe [mt76x0u]) from [<805e0b6c>] (usb_probe_interface+0x104/0x240)
[   67.328915]  r7:00000000 r6:7f65e034 r5:b6634800 r4:b8fe8620
[   67.336276] [<805e0a68>] (usb_probe_interface) from [<8056a8bc>] (really_probe+0x224/0x2f8)
[   67.347965]  r10:b65f0a00 r9:00000019 r8:7f65e034 r7:80d3e124 r6:00000000 r5:80d3e120
[   67.359175]  r4:b8fe8620 r3:805e0a68
[   67.364384] [<8056a698>] (really_probe) from [<8056ab60>] (driver_probe_device+0x6c/0x180)
[   67.375974]  r10:b65f0a00 r9:7f65e2c0 r8:b8fe8620 r7:00000000 r6:7f65e034 r5:7f65e034
[   67.387170]  r4:b8fe8620 r3:00000000
[   67.392378] [<8056aaf4>] (driver_probe_device) from [<8056ad54>] (__driver_attach+0xe0/0xe4)
[   67.404097]  r9:7f65e2c0 r8:7f65d22c r7:00000000 r6:b8fe8654 r5:7f65e034 r4:b8fe8620
[   67.415122] [<8056ac74>] (__driver_attach) from [<8056880c>] (bus_for_each_dev+0x68/0xa0)
[   67.426628]  r6:8056ac74 r5:7f65e034 r4:00000000 r3:00000027
[   67.434017] [<805687a4>] (bus_for_each_dev) from [<8056a1cc>] (driver_attach+0x28/0x30)
[   67.445394]  r6:80c6ddc8 r5:b7368f80 r4:7f65e034
[   67.451703] [<8056a1a4>] (driver_attach) from [<80569c24>] (bus_add_driver+0x194/0x21c)
[   67.463081] [<80569a90>] (bus_add_driver) from [<8056b504>] (driver_register+0x8c/0x124)
[   67.474560]  r7:80c6ddc8 r6:7f65e034 r5:00000000 r4:7f65e034
[   67.481964] [<8056b478>] (driver_register) from [<805df510>] (usb_register_driver+0x74/0x140)
[   67.493901]  r5:00000000 r4:7f65e000
[   67.499131] [<805df49c>] (usb_register_driver) from [<7f661024>] (mt76x0_driver_init+0x24/0x1000 [mt76x0u])
[   67.512258]  r9:00000001 r8:7f65e308 r7:00000000 r6:80c08d48 r5:7f661000 r4:7f65e2c0
[   67.523404] [<7f661000>] (mt76x0_driver_init [mt76x0u]) from [<80102f6c>] (do_one_initcall+0x4c/0x210)
[   67.536142] [<80102f20>] (do_one_initcall) from [<801ae63c>] (do_init_module+0x6c/0x21c)
[   67.547639]  r8:7f65e308 r7:80c08d48 r6:b65f0ac0 r5:7f65e2c0 r4:7f65e2c0
[   67.556129] [<801ae5d0>] (do_init_module) from [<801ad68c>] (load_module+0x1d10/0x2304)

Fixes: b40b15e1521f ("mt76: add usb support to mt76 layer")
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/usb.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index 79e59f2379a2..8d40e92fb6f2 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -796,16 +796,9 @@ int mt76u_alloc_queues(struct mt76_dev *dev)
 
 	err = mt76u_alloc_rx(dev);
 	if (err < 0)
-		goto err;
-
-	err = mt76u_alloc_tx(dev);
-	if (err < 0)
-		goto err;
+		return err;
 
-	return 0;
-err:
-	mt76u_queues_deinit(dev);
-	return err;
+	return mt76u_alloc_tx(dev);
 }
 EXPORT_SYMBOL_GPL(mt76u_alloc_queues);
 
-- 
2.19.1



