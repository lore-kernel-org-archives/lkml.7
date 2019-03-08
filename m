Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6308BC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3610F20661
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552050035;
	bh=ZWQZrhpn17p/OmUStHJnmbJwGuPtlSS8etvGyc/c0s8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lSvdHWDF0AboPdp40izxyotevVG+Uc4pi2bSEurVtm0R8J0OTylIfD3E5rzLi1r69
	 szcCbKHNismqd1wLD2vKPP5gyZAYNMynff2GRVe87QKnrNzQWQJClP5KkAMNMqCj4P
	 m9EQGxj37CpS36Fl3HHRP2EHobC9wk6NhA6v52Lk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbfCHNAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 08:00:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:37522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728310AbfCHNAa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 08:00:30 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F100320449;
        Fri,  8 Mar 2019 13:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552050029;
        bh=ZWQZrhpn17p/OmUStHJnmbJwGuPtlSS8etvGyc/c0s8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xm/iWBQl7WHjRwbuKoNby0MFYHFH9PhHBrOTwLwc096OinOgqTfwQJr9EfKzhAqUR
         O0XlToKJZBQkoTKMvbqnyz+MQXjsm7Q191Q/CGb5W7aPxySX4ydf41Khqx0QI5UqL+
         3gF9TUrpS0JiMHJfxZZiRP83GGJksSNOc3GLhOYs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.19 61/68] gnss: sirf: fix premature wakeup interrupt enable
Date:   Fri,  8 Mar 2019 13:50:31 +0100
Message-Id: <20190308124913.581050394@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190308124910.696595153@linuxfoundation.org>
References: <20190308124910.696595153@linuxfoundation.org>
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

From: Johan Hovold <johan@kernel.org>

commit 82f844c22588bf47132c82faeda50b6db473162c upstream.

Make sure the receiver is powered (and booted) before enabling the
wakeup interrupt to avoid spurious interrupts due to a floating input.

Similarly, disable the interrupt before powering off on probe errors and
on unbind.

Fixes: d2efbbd18b1e ("gnss: add driver for sirfstar-based receivers")
Cc: stable <stable@vger.kernel.org>	# 4.19
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gnss/sirf.c |   32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

--- a/drivers/gnss/sirf.c
+++ b/drivers/gnss/sirf.c
@@ -310,30 +310,26 @@ static int sirf_probe(struct serdev_devi
 			ret = -ENODEV;
 			goto err_put_device;
 		}
+
+		ret = regulator_enable(data->vcc);
+		if (ret)
+			goto err_put_device;
+
+		/* Wait for chip to boot into hibernate mode. */
+		msleep(SIRF_BOOT_DELAY);
 	}
 
 	if (data->wakeup) {
 		ret = gpiod_to_irq(data->wakeup);
 		if (ret < 0)
-			goto err_put_device;
-
+			goto err_disable_vcc;
 		data->irq = ret;
 
-		ret = devm_request_threaded_irq(dev, data->irq, NULL,
-				sirf_wakeup_handler,
+		ret = request_threaded_irq(data->irq, NULL, sirf_wakeup_handler,
 				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 				"wakeup", data);
 		if (ret)
-			goto err_put_device;
-	}
-
-	if (data->on_off) {
-		ret = regulator_enable(data->vcc);
-		if (ret)
-			goto err_put_device;
-
-		/* Wait for chip to boot into hibernate mode */
-		msleep(SIRF_BOOT_DELAY);
+			goto err_disable_vcc;
 	}
 
 	if (IS_ENABLED(CONFIG_PM)) {
@@ -342,7 +338,7 @@ static int sirf_probe(struct serdev_devi
 	} else {
 		ret = sirf_runtime_resume(dev);
 		if (ret < 0)
-			goto err_disable_vcc;
+			goto err_free_irq;
 	}
 
 	ret = gnss_register_device(gdev);
@@ -356,6 +352,9 @@ err_disable_rpm:
 		pm_runtime_disable(dev);
 	else
 		sirf_runtime_suspend(dev);
+err_free_irq:
+	if (data->wakeup)
+		free_irq(data->irq, data);
 err_disable_vcc:
 	if (data->on_off)
 		regulator_disable(data->vcc);
@@ -376,6 +375,9 @@ static void sirf_remove(struct serdev_de
 	else
 		sirf_runtime_suspend(&serdev->dev);
 
+	if (data->wakeup)
+		free_irq(data->irq, data);
+
 	if (data->on_off)
 		regulator_disable(data->vcc);
 


