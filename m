Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B89AC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 09:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 034E8214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 09:38:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="VMN2Xlv9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388610AbfDRJiW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 05:38:22 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:41796 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387971AbfDRJiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 05:38:19 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3I9bPqK020922;
        Thu, 18 Apr 2019 11:38:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=CrmqrU1P3b3z4M4N3dbz9yDIRZmDOZLq4+eBzhG+d0U=;
 b=VMN2Xlv9B2c9QUZgGlHZ9VgwcMGabCXcC06CpPGOhs0RHcqV06K+AoQxQ5DtkZMlxq0m
 m1P6wo0C5xdFy7/SEdxSyREeuD8tWGg0EPjENytb+TPlFM35o3JMOcnYmEpmfXmucJlD
 rIAMSw5X+cPSf6OSVJfHUQxU+901sEM0bfg7dp9zSnX2k8n3Eu4JBUBDo3kGizi3AXpI
 dYFVHCw86YJcCM9sNNAJ9yQo8QhPwB8EhTSDZ9RtiNLAgS4pQL2zvjT80Yh1J9sHcT9l
 8FVJXj4Zo8du7oBtIMgodC7Laltf4AJfvy73rbkxhGdVdkbD/H+nCiqpP/dzRlHt4aSf iw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2ru6nh4ycn-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 18 Apr 2019 11:38:00 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 501A83D;
        Thu, 18 Apr 2019 09:37:59 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 26F3C15AC;
        Thu, 18 Apr 2019 09:37:59 +0000 (GMT)
Received: from localhost (10.75.127.45) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 18 Apr 2019 11:37:58
 +0200
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <thierry.reding@gmail.com>
CC:     <robh+dt@kernel.org>, <u.kleine-koenig@pengutronix.de>,
        <tduszyns@gmail.com>, <mark.rutland@arm.com>,
        <alexandre.torgue@st.com>, <mcoquelin.stm32@gmail.com>,
        <fabrice.gasnier@st.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [RESEND PATCH v5 3/3] pwm: core: add consumer device link
Date:   Thu, 18 Apr 2019 11:37:47 +0200
Message-ID: <1555580267-29299-4-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555580267-29299-1-git-send-email-fabrice.gasnier@st.com>
References: <1555580267-29299-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG5NODE1.st.com (10.75.127.13) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-18_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a device link between the PWM consumer and the PWM provider. This
enforces the PWM user to get suspended before the PWM provider. It
allows proper synchronization of suspend/resume sequences: the PWM user
is responsible for properly stopping PWM, before the provider gets
suspended: see [1]. Add the device link in:
- of_pwm_get()
- pwm_get()
- devm_*pwm_get() variants
as it requires a reference to the device for the PWM consumer.

[1] https://lkml.org/lkml/2019/2/5/770

Suggested-by: Thierry Reding <thierry.reding@gmail.com>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
Changes in v5:
- fix a style issue
- use dev_warn() instead of pr_warn

Changes in v4:
- rework error handling following Thierry's comments
- turn/split pr_debug() into dev_err()/pr_warn().

Changes in v3:
- add struct device to of_get_pwm() arguments to handle device link from
  there as discussed with Uwe.
---
 drivers/pwm/core.c  | 50 +++++++++++++++++++++++++++++++++++++++++++++++---
 include/linux/pwm.h |  6 ++++--
 2 files changed, 51 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 3149204..e8d4958 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -639,8 +639,35 @@ static struct pwm_chip *of_node_to_pwmchip(struct device_node *np)
 	return ERR_PTR(-EPROBE_DEFER);
 }
 
+static struct device_link *pwm_device_link_add(struct device *dev,
+					       struct pwm_device *pwm)
+{
+	struct device_link *dl;
+
+	if (!dev) {
+		/*
+		 * No device for the PWM consumer has been provided. It may
+		 * impact the PM sequence ordering: the PWM supplier may get
+		 * suspended before the consumer.
+		 */
+		dev_warn(pwm->chip->dev,
+			 "No consumer device specified to create a link to\n");
+		return NULL;
+	}
+
+	dl = device_link_add(dev, pwm->chip->dev, DL_FLAG_AUTOREMOVE_CONSUMER);
+	if (!dl) {
+		dev_err(dev, "failed to create device link to %s\n",
+			dev_name(pwm->chip->dev));
+		return ERR_PTR(-EINVAL);
+	}
+
+	return dl;
+}
+
 /**
  * of_pwm_get() - request a PWM via the PWM framework
+ * @dev: device for PWM consumer
  * @np: device node to get the PWM from
  * @con_id: consumer name
  *
@@ -658,10 +685,12 @@ static struct pwm_chip *of_node_to_pwmchip(struct device_node *np)
  * Returns: A pointer to the requested PWM device or an ERR_PTR()-encoded
  * error code on failure.
  */
-struct pwm_device *of_pwm_get(struct device_node *np, const char *con_id)
+struct pwm_device *of_pwm_get(struct device *dev, struct device_node *np,
+			      const char *con_id)
 {
 	struct pwm_device *pwm = NULL;
 	struct of_phandle_args args;
+	struct device_link *dl;
 	struct pwm_chip *pc;
 	int index = 0;
 	int err;
@@ -692,6 +721,14 @@ struct pwm_device *of_pwm_get(struct device_node *np, const char *con_id)
 	if (IS_ERR(pwm))
 		goto put;
 
+	dl = pwm_device_link_add(dev, pwm);
+	if (IS_ERR(dl)) {
+		/* of_xlate ended up calling pwm_request_from_chip() */
+		pwm_free(pwm);
+		pwm = ERR_CAST(dl);
+		goto put;
+	}
+
 	/*
 	 * If a consumer name was not given, try to look it up from the
 	 * "pwm-names" property if it exists. Otherwise use the name of
@@ -767,6 +804,7 @@ struct pwm_device *pwm_get(struct device *dev, const char *con_id)
 	const char *dev_id = dev ? dev_name(dev) : NULL;
 	struct pwm_device *pwm;
 	struct pwm_chip *chip;
+	struct device_link *dl;
 	unsigned int best = 0;
 	struct pwm_lookup *p, *chosen = NULL;
 	unsigned int match;
@@ -774,7 +812,7 @@ struct pwm_device *pwm_get(struct device *dev, const char *con_id)
 
 	/* look up via DT first */
 	if (IS_ENABLED(CONFIG_OF) && dev && dev->of_node)
-		return of_pwm_get(dev->of_node, con_id);
+		return of_pwm_get(dev, dev->of_node, con_id);
 
 	/*
 	 * We look up the provider in the static table typically provided by
@@ -851,6 +889,12 @@ struct pwm_device *pwm_get(struct device *dev, const char *con_id)
 	if (IS_ERR(pwm))
 		return pwm;
 
+	dl = pwm_device_link_add(dev, pwm);
+	if (IS_ERR(dl)) {
+		pwm_free(pwm);
+		return ERR_CAST(dl);
+	}
+
 	pwm->args.period = chosen->period;
 	pwm->args.polarity = chosen->polarity;
 
@@ -942,7 +986,7 @@ struct pwm_device *devm_of_pwm_get(struct device *dev, struct device_node *np,
 	if (!ptr)
 		return ERR_PTR(-ENOMEM);
 
-	pwm = of_pwm_get(np, con_id);
+	pwm = of_pwm_get(dev, np, con_id);
 	if (!IS_ERR(pwm)) {
 		*ptr = pwm;
 		devres_add(dev, ptr);
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index b628abf..7dad301 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -405,7 +405,8 @@ struct pwm_device *of_pwm_xlate_with_flags(struct pwm_chip *pc,
 		const struct of_phandle_args *args);
 
 struct pwm_device *pwm_get(struct device *dev, const char *con_id);
-struct pwm_device *of_pwm_get(struct device_node *np, const char *con_id);
+struct pwm_device *of_pwm_get(struct device *dev, struct device_node *np,
+			      const char *con_id);
 void pwm_put(struct pwm_device *pwm);
 
 struct pwm_device *devm_pwm_get(struct device *dev, const char *con_id);
@@ -493,7 +494,8 @@ static inline struct pwm_device *pwm_get(struct device *dev,
 	return ERR_PTR(-ENODEV);
 }
 
-static inline struct pwm_device *of_pwm_get(struct device_node *np,
+static inline struct pwm_device *of_pwm_get(struct device *dev,
+					    struct device_node *np,
 					    const char *con_id)
 {
 	return ERR_PTR(-ENODEV);
-- 
2.7.4

