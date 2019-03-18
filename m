Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04DFCC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA2B72064A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbfCRRtQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 13:49:16 -0400
Received: from foss.arm.com ([217.140.101.70]:39044 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726623AbfCRRtP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 13:49:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0CB16EBD;
        Mon, 18 Mar 2019 10:49:15 -0700 (PDT)
Received: from why.lan (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ADD583F614;
        Mon, 18 Mar 2019 10:49:13 -0700 (PDT)
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] usb: typec: fusb302: Fix debugfs mutex initialisation
Date:   Mon, 18 Mar 2019 17:49:06 +0000
Message-Id: <20190318174906.10429-1-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Running a kernel with the fusb302 driver and lockdep enabled
leads to an unpleasant warning:

[    4.617477] INFO: trying to register non-static key.
[    4.617930] the code is fine but needs lockdep annotation.
[    4.618418] turning off the locking correctness validator.
[    4.618913] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.1.0-rc1-00007-g3542533f3fc9 #13
[    4.619620] Hardware name: rockchip evb_rk3399/evb_rk3399, BIOS 2019.04-rc3-00124-g2feec69fb1 03/15/2019
[    4.620454] Call trace:
[    4.620693]  dump_backtrace+0x0/0x138
[    4.621028]  show_stack+0x24/0x30
[    4.621336]  dump_stack+0xbc/0x104
[    4.621649]  register_lock_class+0x594/0x598
[    4.622036]  __lock_acquire+0x80/0x11b8
[    4.622384]  lock_acquire+0xdc/0x260
[    4.622711]  __mutex_lock+0x90/0x8a0
[    4.623037]  mutex_lock_nested+0x3c/0x50
[    4.623394]  _fusb302_log+0x88/0x1f0
[    4.623721]  fusb302_log+0x7c/0xa0
[    4.624033]  tcpm_init+0x5c/0x190
[    4.624336]  tcpm_init+0x3c/0x130
[    4.624640]  tcpm_register_port+0x574/0x878
[    4.625019]  fusb302_probe+0x2c8/0x590

Despite what the message says, the code isn't fine, as it tries to
make use of the fusb302_log facility pretty early. This requires the
logbuffer_lock mutex to be initialised, but that only happens much
later. Boo.

Hoist the fusb302_debugfs_init call before tcpm_register_port so that
we can enjoy a working mutex. At Guenter's request, also add teardown
of the debugfs facility on the error path.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/usb/typec/tcpm/fusb302.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/tcpm/fusb302.c b/drivers/usb/typec/tcpm/fusb302.c
index e9344997329c..76cb8be6f3eb 100644
--- a/drivers/usb/typec/tcpm/fusb302.c
+++ b/drivers/usb/typec/tcpm/fusb302.c
@@ -1790,12 +1790,13 @@ static int fusb302_probe(struct i2c_client *client,
 			goto destroy_workqueue;
 	}
 
+	fusb302_debugfs_init(chip);
 	chip->tcpm_port = tcpm_register_port(&client->dev, &chip->tcpc_dev);
 	if (IS_ERR(chip->tcpm_port)) {
 		ret = PTR_ERR(chip->tcpm_port);
 		if (ret != -EPROBE_DEFER)
 			dev_err(dev, "cannot register tcpm port, ret=%d", ret);
-		goto destroy_workqueue;
+		goto unregister_debugfs;
 	}
 
 	ret = devm_request_threaded_irq(chip->dev, chip->gpio_int_n_irq,
@@ -1807,13 +1808,14 @@ static int fusb302_probe(struct i2c_client *client,
 		goto tcpm_unregister_port;
 	}
 	enable_irq_wake(chip->gpio_int_n_irq);
-	fusb302_debugfs_init(chip);
 	i2c_set_clientdata(client, chip);
 
 	return ret;
 
 tcpm_unregister_port:
 	tcpm_unregister_port(chip->tcpm_port);
+unregister_debugfs:
+	fusb302_debugfs_exit(chip);
 destroy_workqueue:
 	destroy_workqueue(chip->wq);
 
-- 
2.20.1

