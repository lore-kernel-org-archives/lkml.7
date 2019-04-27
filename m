Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F76C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 049B3206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:29:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbfD0PPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:15:17 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60584 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726530AbfD0PPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:10 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2h-0000z9-Fk; Sat, 27 Apr 2019 16:15:07 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2h-0004Nx-6s; Sat, 27 Apr 2019 16:15:07 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Jonathan Hunter" <jonathanh@nvidia.com>,
        "Thierry Reding" <treding@nvidia.com>,
        "Dmitry Osipenko" <digetx@gmail.com>,
        "Lee Jones" <lee.jones@linaro.org>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.541266452@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 005/202] mfd: tps6586x: Handle interrupts on suspend
In-Reply-To: <lsq.1556377988.384060557@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.66-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Jonathan Hunter <jonathanh@nvidia.com>

commit ac4ca4b9f4623ba5e1ea7a582f286567c611e027 upstream.

The tps6586x driver creates an irqchip that is used by its various child
devices for managing interrupts. The tps6586x-rtc device is one of its
children that uses the tps6586x irqchip. When using the tps6586x-rtc as
a wake-up device from suspend, the following is seen:

 PM: Syncing filesystems ... done.
 Freezing user space processes ... (elapsed 0.001 seconds) done.
 OOM killer disabled.
 Freezing remaining freezable tasks ... (elapsed 0.000 seconds) done.
 Disabling non-boot CPUs ...
 Entering suspend state LP1
 Enabling non-boot CPUs ...
 CPU1 is up
 tps6586x 3-0034: failed to read interrupt status
 tps6586x 3-0034: failed to read interrupt status

The reason why the tps6586x interrupt status cannot be read is because
the tps6586x interrupt is not masked during suspend and when the
tps6586x-rtc interrupt occurs, to wake-up the device, the interrupt is
seen before the i2c controller has been resumed in order to read the
tps6586x interrupt status.

The tps6586x-rtc driver sets it's interrupt as a wake-up source during
suspend, which gets propagated to the parent tps6586x interrupt.
However, the tps6586x-rtc driver cannot disable it's interrupt during
suspend otherwise we would never be woken up and so the tps6586x must
disable it's interrupt instead.

Prevent the tps6586x interrupt handler from executing on exiting suspend
before the i2c controller has been resumed by disabling the tps6586x
interrupt on entering suspend and re-enabling it on resuming from
suspend.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
Tested-by: Dmitry Osipenko <digetx@gmail.com>
Acked-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/mfd/tps6586x.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

--- a/drivers/mfd/tps6586x.c
+++ b/drivers/mfd/tps6586x.c
@@ -601,6 +601,29 @@ static int tps6586x_i2c_remove(struct i2
 	return 0;
 }
 
+static int __maybe_unused tps6586x_i2c_suspend(struct device *dev)
+{
+	struct tps6586x *tps6586x = dev_get_drvdata(dev);
+
+	if (tps6586x->client->irq)
+		disable_irq(tps6586x->client->irq);
+
+	return 0;
+}
+
+static int __maybe_unused tps6586x_i2c_resume(struct device *dev)
+{
+	struct tps6586x *tps6586x = dev_get_drvdata(dev);
+
+	if (tps6586x->client->irq)
+		enable_irq(tps6586x->client->irq);
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(tps6586x_pm_ops, tps6586x_i2c_suspend,
+			 tps6586x_i2c_resume);
+
 static const struct i2c_device_id tps6586x_id_table[] = {
 	{ "tps6586x", 0 },
 	{ },
@@ -612,6 +635,7 @@ static struct i2c_driver tps6586x_driver
 		.name	= "tps6586x",
 		.owner	= THIS_MODULE,
 		.of_match_table = of_match_ptr(tps6586x_of_match),
+		.pm	= &tps6586x_pm_ops,
 	},
 	.probe		= tps6586x_i2c_probe,
 	.remove		= tps6586x_i2c_remove,

