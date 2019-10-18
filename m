Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99104CA9ED0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BAAC222BD
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:24:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IfD36HjG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442032AbfJRFYS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 01:24:18 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34219 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2442007AbfJRFYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 01:24:16 -0400
Received: by mail-pg1-f193.google.com with SMTP id k20so2702878pgi.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 22:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A290/OLSMIdz1gm9E9GKn5KBPV2wOKoLOZi6+j+W8B0=;
        b=IfD36HjGXoGW/VytrSV0TZUsgREKFpfzsFqdazfZT5W9+9uAFfPaereqHTYaqLxqSP
         vmFfmuKv7WFbkNZP2ssJRHR3sMm2GyNJenRdVZ+L5vmjKAgJGosyzWEyJXRzeZmjPngU
         5aG4eZJuVoaAPzHfyx9iVKXEDZgmgcNmCGIv/0OnvNnY6HPDo1FPy0bmXaMJjfB95Em2
         XJ9DDJp7yjOJ8DKUUe6ZYpaNawX+bnZltgVLbJ8o9ueyVv5vmB3Hji1mTAstDOOJHXoP
         /7GzzhJschEmR5wMZJTzENRhZVT5G98euWMDl50oSmvCQjsBExx2Nk6FNVkbQNwfkHAp
         TUbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A290/OLSMIdz1gm9E9GKn5KBPV2wOKoLOZi6+j+W8B0=;
        b=BI8b96jHg0/arSyTpH0fBhwOd6OnXIXMq8zdXk+v1SMQ3Lpp80BPWjX67iShmp7Mwg
         m2AP3VKe5czmL97KCeXALPruggr7ruPLv8OLGi1UaRl0BruljXgNLus1rWbcUGjECx9N
         mPaBVIorawLhuNe4yQ1SEpjmxuuFjuxHBVc8EAj4n0G+4VBgC7i6pafzpK6wrFuFfpZW
         S+ujL1oGEybSOGmSCYzgi1IoLae+AL04mTeCq5rzLtHVKMz+AGBK7S+ST389Y/1LKS0p
         WRGiiI74QjI16QUE1QvyUadqWkFyQfbN/YOTl/ZpeO2f4Vr22itSASq+OAv4B0unha+9
         8syA==
X-Gm-Message-State: APjAAAUQsNdiMTXTmrUgHZRAAnG3ShQILPHupMEpKG8rZaJPbkjjW7I+
        OvpPiG7jaUQYTdj1mp7WK4PwBQ==
X-Google-Smtp-Source: APXvYqx0ozYSKrJgMxYmOdz9sS6M85YH2jq18jmBXCmjgB4jia0KZ5uXnddL537MflX50Cf7VM8eOA==
X-Received: by 2002:a63:1904:: with SMTP id z4mr8210286pgl.413.1571376253468;
        Thu, 17 Oct 2019 22:24:13 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id u11sm2178760pgc.61.2019.10.17.22.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 22:24:12 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 4/4] Bluetooth: hci_qca: Split qca_power_setup()
Date:   Thu, 17 Oct 2019 22:24:04 -0700
Message-Id: <20191018052405.3693555-5-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191018052405.3693555-1-bjorn.andersson@linaro.org>
References: <20191018052405.3693555-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split and rename qca_power_setup() in order to simplify each code path
and to clarify that it is unrelated to qca_power_off() and
qca_power_setup().

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/bluetooth/hci_qca.c | 61 ++++++++++++++++++++++---------------
 1 file changed, 36 insertions(+), 25 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 01f941e9adf3..c591a8ba9d93 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -160,7 +160,8 @@ struct qca_serdev {
 	const char *firmware_name;
 };
 
-static int qca_power_setup(struct hci_uart *hu, bool on);
+static int qca_regulator_enable(struct qca_serdev *qcadev);
+static void qca_regulator_disable(struct qca_serdev *qcadev);
 static void qca_power_shutdown(struct hci_uart *hu);
 static int qca_power_off(struct hci_dev *hdev);
 
@@ -516,7 +517,7 @@ static int qca_open(struct hci_uart *hu)
 		} else {
 			hu->init_speed = qcadev->init_speed;
 			hu->oper_speed = qcadev->oper_speed;
-			ret = qca_power_setup(hu, true);
+			ret = qca_regulator_enable(qcadev);
 			if (ret) {
 				destroy_workqueue(qca->workqueue);
 				kfree_skb(qca->rx_skb);
@@ -1186,7 +1187,7 @@ static int qca_wcn3990_init(struct hci_uart *hu)
 	qcadev = serdev_device_get_drvdata(hu->serdev);
 	if (!qcadev->bt_power->vregs_on) {
 		serdev_device_close(hu->serdev);
-		ret = qca_power_setup(hu, true);
+		ret = qca_regulator_enable(qcadev);
 		if (ret)
 			return ret;
 
@@ -1351,9 +1352,12 @@ static const struct qca_vreg_data qca_soc_data_wcn3998 = {
 
 static void qca_power_shutdown(struct hci_uart *hu)
 {
+	struct qca_serdev *qcadev;
 	struct qca_data *qca = hu->priv;
 	unsigned long flags;
 
+	qcadev = serdev_device_get_drvdata(hu->serdev);
+
 	/* From this point we go into power off state. But serial port is
 	 * still open, stop queueing the IBS data and flush all the buffered
 	 * data in skb's.
@@ -1365,7 +1369,7 @@ static void qca_power_shutdown(struct hci_uart *hu)
 
 	host_set_baudrate(hu, 2400);
 	qca_send_power_pulse(hu, false);
-	qca_power_setup(hu, false);
+	qca_regulator_disable(qcadev);
 }
 
 static int qca_power_off(struct hci_dev *hdev)
@@ -1381,36 +1385,43 @@ static int qca_power_off(struct hci_dev *hdev)
 	return 0;
 }
 
-static int qca_power_setup(struct hci_uart *hu, bool on)
+static int qca_regulator_enable(struct qca_serdev *qcadev)
 {
-	struct regulator_bulk_data *vreg_bulk;
-	struct qca_serdev *qcadev;
-	int num_vregs;
-	int ret = 0;
+	struct qca_power *power = qcadev->bt_power;
+	int ret;
 
-	qcadev = serdev_device_get_drvdata(hu->serdev);
-	if (!qcadev || !qcadev->bt_power || !qcadev->bt_power->vreg_bulk)
-		return -EINVAL;
+	/* Already enabled */
+	if (power->vregs_on)
+		return 0;
 
-	vreg_bulk = qcadev->bt_power->vreg_bulk;
-	num_vregs = qcadev->bt_power->num_vregs;
-	BT_DBG("on: %d (%d regulators)", on, num_vregs);
-	if (on && !qcadev->bt_power->vregs_on) {
-		ret = regulator_bulk_enable(num_vregs, vreg_bulk);
-		if (ret)
-			return ret;
+	BT_DBG("enabling %d regulators)", power->num_vregs);
 
-		qcadev->bt_power->vregs_on = true;
-	} else if (!on && qcadev->bt_power->vregs_on) {
-		/* turn off regulator in reverse order */
-		regulator_bulk_disable(num_vregs, vreg_bulk);
+	ret = regulator_bulk_enable(power->num_vregs, power->vreg_bulk);
+	if (ret)
+		return ret;
 
-		qcadev->bt_power->vregs_on = false;
-	}
+	power->vregs_on = true;
 
 	return 0;
 }
 
+static void qca_regulator_disable(struct qca_serdev *qcadev)
+{
+	struct qca_power *power;
+
+	if (!qcadev)
+		return;
+
+	power = qcadev->bt_power;
+
+	/* Already disabled? */
+	if (!power->vregs_on)
+		return;
+
+	regulator_bulk_disable(power->num_vregs, power->vreg_bulk);
+	power->vregs_on = false;
+}
+
 static int qca_init_regulators(struct qca_power *qca,
 				const struct qca_vreg *vregs, size_t num_vregs)
 {
-- 
2.23.0

