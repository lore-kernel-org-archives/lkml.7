Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E44C47E49
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 16:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81765214B2
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 16:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJWoLzZ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbfJUQRR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 12:17:17 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39096 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbfJUQRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 12:17:17 -0400
Received: by mail-wm1-f66.google.com with SMTP id r141so3827187wme.4;
        Mon, 21 Oct 2019 09:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=jk6ZF8wcrRJTLUS9uAlYiz82fH05G0XIqpCiC2ocfFM=;
        b=fJWoLzZ6a+LlQjRWNuRitS+xH49t0zmke71CsU4929ekM46VTLeKMIxXvpEQhPB/vV
         4ncBlWFH2k/kNXucS99pn0k24PF/LDoL/Z4Dvno9rEtmFXY4cErrUfR+rJaKbvMXtDJq
         aRErFriPnP5sJnCHxpovSWLyTbDnKpMQqZ9tUM7DxtepELbUlUeoCsU0et5DSuHksHpb
         EtR1rsYf2sBrjHI6LOT+KSXiMx1nuZ0cA1Abm2uoRL32Y4Ucy3KtD/MyUAQ4cqWRjnmF
         OQQdteO9bL/Iu0vBE2fy0J4mhuAlQWeLb3+FBa5WgLpIXXL2oOk538erIdzC/oAs6f48
         HUzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jk6ZF8wcrRJTLUS9uAlYiz82fH05G0XIqpCiC2ocfFM=;
        b=jF/YQw8kOIyNuFB58aPpKXccg4L7DaF06zrvMRYujGIeGEPpAi1QHQQDkzOrSV4Mot
         TzvyMVlrYHFBLpWxqrokIAl3VRGkeIIM46m+y0IVgOUgHzA2jI3CBQMON/4ALI0uSt12
         udvX/XJXfbASITV8ZmbBrvuxeU8C9HnpGcYkwDo8uihVZrF1vwu9vACYtcnccSUKv8F+
         B/lWn9vYpS4DNh7hT+2ITFDZh3ICbjVicAG0/B1Q7UP5nvLj2I8VB+O03VTrk7cX3N7V
         +ahwaY+2v50uszWUj1WckWyjvFACcv+eeeqpWk5aUqP5NxAk8Fc1xnhEG+WNno8bd1v7
         CRtQ==
X-Gm-Message-State: APjAAAV2bTKYzqW695mm/LU+51rCfJLTekYwXs/jsEoG4n1gPwdlJ1/b
        PsXsp45q2+ITl1MaqK70zOTcb13N6mI=
X-Google-Smtp-Source: APXvYqygFPVbzSSqh3ZyVAIa/Dl8Di+XZC/dcgGcwvn0045pPG2FVsNEZizH7EjTqVyb/Kl7kBMPcA==
X-Received: by 2002:a1c:dd06:: with SMTP id u6mr7987797wmg.109.1571674633421;
        Mon, 21 Oct 2019 09:17:13 -0700 (PDT)
Received: from localhost ([194.105.145.90])
        by smtp.gmail.com with ESMTPSA id a71sm14551087wme.11.2019.10.21.09.17.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Oct 2019 09:17:12 -0700 (PDT)
From:   Igor Opaniuk <igor.opaniuk@gmail.com>
To:     linux-usb@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Stefan Agner <stefan.agner@toradex.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Sanchayan Maity <maitysanchayan@gmail.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <Peter.Chen@nxp.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] usb: chipidea: use of extcon framework to work for non OTG case
Date:   Mon, 21 Oct 2019 19:16:53 +0300
Message-Id: <20191021161654.14353-1-igor.opaniuk@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Agner <stefan.agner@toradex.com>

The existing usage of extcon in chipidea driver freezes the kernel
presumably due to OTGSC register access.

Prevent accessing any OTG registers for SoC with dual role devices
but no true OTG support. Use the flag CI_HDRC_DUAL_ROLE_NOT_OTG for
those devices and in case extcon is present, do the role switch
using extcon only.

Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
Signed-off-by: Stefan Agner <stefan.agner@toradex.com>
Signed-off-by: Igor Opaniuk <igor.opaniuk@toradex.com>
---

 drivers/usb/chipidea/ci.h   |  2 +
 drivers/usb/chipidea/core.c | 87 +++++++++++++++++++++++++++++++++----
 2 files changed, 80 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/chipidea/ci.h b/drivers/usb/chipidea/ci.h
index cf9cc9402826..3a1a549ed39e 100644
--- a/drivers/usb/chipidea/ci.h
+++ b/drivers/usb/chipidea/ci.h
@@ -170,6 +170,7 @@ struct hw_bank {
  * @enabled_otg_timer_bits: bits of enabled otg timers
  * @next_otg_timer: next nearest enabled timer to be expired
  * @work: work for role changing
+ * @work_dr: work for role changing for non-OTG controllers
  * @wq: workqueue thread
  * @qh_pool: allocation pool for queue heads
  * @td_pool: allocation pool for transfer descriptors
@@ -220,6 +221,7 @@ struct ci_hdrc {
 	enum otg_fsm_timer		next_otg_timer;
 	struct usb_role_switch		*role_switch;
 	struct work_struct		work;
+	struct work_struct		work_dr;
 	struct workqueue_struct		*wq;
 
 	struct dma_pool			*qh_pool;
diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index dce5db41501c..48ecc846735c 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -534,6 +534,46 @@ int hw_device_reset(struct ci_hdrc *ci)
 	return 0;
 }
 
+static void usb_roleswitch_workqueue(struct work_struct *work)
+{
+	struct ci_hdrc *ci = container_of(work, struct ci_hdrc, work_dr);
+	struct ci_hdrc_cable *id, *vbus;
+	int ret;
+
+	pm_runtime_get_sync(ci->dev);
+
+	id = &ci->platdata->id_extcon;
+	if (!IS_ERR(id->edev)) {
+		int new_role;
+
+		ci_role_stop(ci);
+		hw_wait_phy_stable();
+
+		ret = extcon_get_state(id->edev, EXTCON_USB_HOST);
+		if (ret) {
+			new_role = CI_ROLE_HOST;
+			dev_info(ci->dev, "switching to host role\n");
+		} else {
+			new_role = CI_ROLE_GADGET;
+			dev_info(ci->dev, "switching to gadget role\n");
+		}
+		ci_role_start(ci, new_role);
+	}
+
+	vbus = &ci->platdata->vbus_extcon;
+	if (!IS_ERR(vbus->edev)) {
+		ret = extcon_get_state(vbus->edev, EXTCON_USB);
+		if (ret)
+			usb_gadget_vbus_connect(&ci->gadget);
+		else
+			usb_gadget_vbus_disconnect(&ci->gadget);
+	}
+
+	pm_runtime_put_sync(ci->dev);
+
+	enable_irq(ci->irq);
+}
+
 static irqreturn_t ci_irq(int irq, void *data)
 {
 	struct ci_hdrc *ci = data;
@@ -593,10 +633,24 @@ static int ci_cable_notifier(struct notifier_block *nb, unsigned long event,
 	struct ci_hdrc_cable *cbl = container_of(nb, struct ci_hdrc_cable, nb);
 	struct ci_hdrc *ci = cbl->ci;
 
-	cbl->connected = event;
-	cbl->changed = true;
+	if (ci->platdata->flags & CI_HDRC_DUAL_ROLE_NOT_OTG) {
+		disable_irq_nosync(ci->irq);
+
+		/*
+		 * This notifier might get called twice in succession,
+		 * once for the ID pin and once for the VBUS pin. Make
+		 * sure we only disable irq in case we successfully add
+		 * work to the work queue.
+		 */
+		if (!queue_work(system_power_efficient_wq, &ci->work_dr))
+			enable_irq(ci->irq);
+	} else {
+		cbl->connected = event;
+		cbl->changed = true;
+
+		ci_irq(ci->irq, ci);
+	}
 
-	ci_irq(ci->irq, ci);
 	return NOTIFY_DONE;
 }
 
@@ -765,6 +819,7 @@ static int ci_get_platdata(struct device *dev,
 		ext_id = extcon_get_edev_by_phandle(dev, 1);
 		if (IS_ERR(ext_id) && PTR_ERR(ext_id) != -ENODEV)
 			return PTR_ERR(ext_id);
+		platdata->flags |= CI_HDRC_DUAL_ROLE_NOT_OTG;
 	}
 
 	cable = &platdata->vbus_extcon;
@@ -1079,7 +1134,15 @@ static int ci_hdrc_probe(struct platform_device *pdev)
 
 	ci_get_otg_capable(ci);
 
+	if (ci->platdata->flags & CI_HDRC_DUAL_ROLE_NOT_OTG)
+		INIT_WORK(&ci->work_dr, usb_roleswitch_workqueue);
+
+	ret = ci_extcon_register(ci);
+	if (ret)
+		goto stop;
+
 	dr_mode = ci->platdata->dr_mode;
+
 	/* initialize role(s) before the interrupt is requested */
 	if (dr_mode == USB_DR_MODE_OTG || dr_mode == USB_DR_MODE_HOST) {
 		ret = ci_hdrc_host_init(ci);
@@ -1145,8 +1208,18 @@ static int ci_hdrc_probe(struct platform_device *pdev)
 
 	if (!ci_otg_is_fsm_mode(ci)) {
 		/* only update vbus status for peripheral */
-		if (ci->role == CI_ROLE_GADGET)
-			ci_handle_vbus_change(ci);
+		if (dr_mode == USB_DR_MODE_PERIPHERAL) {
+			usb_gadget_vbus_connect(&ci->gadget);
+		} else if (ci->role == CI_ROLE_GADGET) {
+			struct ci_hdrc_cable *vbus = &ci->platdata->vbus_extcon;
+
+			/* Use vbus state from extcon if provided */
+			if (!IS_ERR(vbus->edev) &&
+			    extcon_get_state(vbus->edev, EXTCON_USB))
+				usb_gadget_vbus_connect(&ci->gadget);
+			else
+				ci_handle_vbus_change(ci);
+		}
 
 		ret = ci_role_start(ci, ci->role);
 		if (ret) {
@@ -1161,10 +1234,6 @@ static int ci_hdrc_probe(struct platform_device *pdev)
 	if (ret)
 		goto stop;
 
-	ret = ci_extcon_register(ci);
-	if (ret)
-		goto stop;
-
 	if (ci->supports_runtime_pm) {
 		pm_runtime_set_active(&pdev->dev);
 		pm_runtime_enable(&pdev->dev);
-- 
2.17.1

