Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3247CC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05BAE206C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553713631;
	bh=v7Jd0JAl+/9UcRWQKrnPGywfye/WvuRuVHs5NvaZEWc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eMkiiBr8ojMyT92a6r74jUlJ9HW5aa8vBNMlZRL1nB1NV4Ze+jPqTjRIE7G0APkKN
	 VtX+T0USVbTN5JZcYtFJBveZspbwSuhSHZMHif+zdxsmqZ8VwXPzPZBRXQrHbd1lvd
	 goaMXg2Y904KS+pC+h55N4P9dlxLmondzmXcLpQQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389585AbfC0THJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 15:07:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:54742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388532AbfC0SMT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:12:19 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50C1521738;
        Wed, 27 Mar 2019 18:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710338;
        bh=v7Jd0JAl+/9UcRWQKrnPGywfye/WvuRuVHs5NvaZEWc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CsP0/IDznJb6gEv38//8rX/UebeSh/ROBkdSR08AiS7ruFjyXBWJs/cdsKDJGh1+p
         v1NiPl3bVuLQ2S8pi6IebcydKwsASJKYtNnGA/3+9t4DS3Dx9KQInhBX2+6NzmjLh1
         2dDu0IjAcdag4exOtn6Chkk3dtsAU+RngI+7F0wE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andrew Lunn <andrew@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 063/192] net: dsa: mv88e6xxx: Add lockdep classes to fix false positive splat
Date:   Wed, 27 Mar 2019 14:08:15 -0400
Message-Id: <20190327181025.13507-63-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327181025.13507-1-sashal@kernel.org>
References: <20190327181025.13507-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Lunn <andrew@lunn.ch>

[ Upstream commit f6d9758b12660484b6639364cc406da92a918c96 ]

The following false positive lockdep splat has been observed.

======================================================
WARNING: possible circular locking dependency detected
4.20.0+ #302 Not tainted
------------------------------------------------------
systemd-udevd/160 is trying to acquire lock:
edea6080 (&chip->reg_lock){+.+.}, at: __setup_irq+0x640/0x704

but task is already holding lock:
edff0340 (&desc->request_mutex){+.+.}, at: __setup_irq+0xa0/0x704

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #1 (&desc->request_mutex){+.+.}:
       mutex_lock_nested+0x1c/0x24
       __setup_irq+0xa0/0x704
       request_threaded_irq+0xd0/0x150
       mv88e6xxx_probe+0x41c/0x694 [mv88e6xxx]
       mdio_probe+0x2c/0x54
       really_probe+0x200/0x2c4
       driver_probe_device+0x5c/0x174
       __driver_attach+0xd8/0xdc
       bus_for_each_dev+0x58/0x7c
       bus_add_driver+0xe4/0x1f0
       driver_register+0x7c/0x110
       mdio_driver_register+0x24/0x58
       do_one_initcall+0x74/0x2e8
       do_init_module+0x60/0x1d0
       load_module+0x1968/0x1ff4
       sys_finit_module+0x8c/0x98
       ret_fast_syscall+0x0/0x28
       0xbedf2ae8

-> #0 (&chip->reg_lock){+.+.}:
       __mutex_lock+0x50/0x8b8
       mutex_lock_nested+0x1c/0x24
       __setup_irq+0x640/0x704
       request_threaded_irq+0xd0/0x150
       mv88e6xxx_g2_irq_setup+0xcc/0x1b4 [mv88e6xxx]
       mv88e6xxx_probe+0x44c/0x694 [mv88e6xxx]
       mdio_probe+0x2c/0x54
       really_probe+0x200/0x2c4
       driver_probe_device+0x5c/0x174
       __driver_attach+0xd8/0xdc
       bus_for_each_dev+0x58/0x7c
       bus_add_driver+0xe4/0x1f0
       driver_register+0x7c/0x110
       mdio_driver_register+0x24/0x58
       do_one_initcall+0x74/0x2e8
       do_init_module+0x60/0x1d0
       load_module+0x1968/0x1ff4
       sys_finit_module+0x8c/0x98
       ret_fast_syscall+0x0/0x28
       0xbedf2ae8

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&desc->request_mutex);
                               lock(&chip->reg_lock);
                               lock(&desc->request_mutex);
  lock(&chip->reg_lock);

&desc->request_mutex refer to two different mutex. #1 is the GPIO for
the chip interrupt. #2 is the chained interrupt between global 1 and
global 2.

Add lockdep classes to the GPIO interrupt to avoid this.

Reported-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index c078c791f481..dabe89968a78 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -442,12 +442,20 @@ static int mv88e6xxx_g1_irq_setup_common(struct mv88e6xxx_chip *chip)
 
 static int mv88e6xxx_g1_irq_setup(struct mv88e6xxx_chip *chip)
 {
+	static struct lock_class_key lock_key;
+	static struct lock_class_key request_key;
 	int err;
 
 	err = mv88e6xxx_g1_irq_setup_common(chip);
 	if (err)
 		return err;
 
+	/* These lock classes tells lockdep that global 1 irqs are in
+	 * a different category than their parent GPIO, so it won't
+	 * report false recursion.
+	 */
+	irq_set_lockdep_class(chip->irq, &lock_key, &request_key);
+
 	err = request_threaded_irq(chip->irq, NULL,
 				   mv88e6xxx_g1_irq_thread_fn,
 				   IRQF_ONESHOT,
-- 
2.19.1

