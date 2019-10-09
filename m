Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A0F7C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 04:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CD532133F
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 04:53:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ewr0dLfG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730290AbfJIExD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 00:53:03 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43410 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729040AbfJIExD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 00:53:03 -0400
Received: by mail-pg1-f193.google.com with SMTP id i32so577168pgl.10
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 21:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=BVPDZ+UM30WirOqNPfNn7Zfe1sfZXxP2P+omCF1CkXM=;
        b=Ewr0dLfGV3C81iZtiq9ImVyUdComMA/4a9GbeiEGsQkyAMNZ8/e6pDLMSebzRSbIa+
         ryYN1cXcBAnzJINPo1cfm1WuV6rWMqP8tX5H+40EwiMZe8GTU1U3Hwrh3nihEpdbDIAP
         Bgsp28d0W3GhraUzHJNS370erIjrDJ8nSZTVjnfpk5SvdvPChqTp1gUBK7IGqYaWzaj9
         XRWxyVfPldyZUKYFKCBoDdV9sPI4L7UffXU7BQEhPIpVZEkeX5WjO/DC9FKuVIVACTdg
         O5n9B+S9dUT2OY/gP8muAzeueJy3nXOCQp8hXJ2QCumAvydNQWa2SQS+UJRKp+TxH+GF
         DPUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BVPDZ+UM30WirOqNPfNn7Zfe1sfZXxP2P+omCF1CkXM=;
        b=Ld1ulE14GOcd90cz3tL2Ttq1/o54+v0TkRYhd/YmVndbEGss6hijtQ976kVvyx24Vp
         K2AH87oCVxuj5CpKVV2LtP7Gyfe+R3O7UIButyE94Kv70y2dqIZOEMlyMmp9qihPP+Oy
         8AWRBEKy1VEvQ5RBPUdmEg1RJedG/KjnPD6PvdDgvs/2KT9xKo2AksFtrOvzf6+1uhur
         eYepFhhug+U0VobjRVlSIWa8ILvjlnb/Cmwlk9gzuLDLvifZpMACoSPCgMy1F16eOmxU
         j0HFLfQOVVGJgnez/ztYBykNrPmmodp0opv8QiiVuE4B4AVXHS+um+uiVVCKIwGrw2zl
         WmXQ==
X-Gm-Message-State: APjAAAVQ4/NqseJPkIwnOgNXI3wMMzGwkvxnozDVvy4lMR9OtAJ+e6M6
        dfIgT/GTBaMIqZo8ZEqUrgK0jg==
X-Google-Smtp-Source: APXvYqyfpuTkCgyxfhyRsMlgzXxl1EcKj9bSJP/ThZa9N+wKRgLR04rtxULOcr832GHuu/Rc2AH7wQ==
X-Received: by 2002:a65:520d:: with SMTP id o13mr2343089pgp.42.1570596782870;
        Tue, 08 Oct 2019 21:53:02 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id 7sm732678pgx.26.2019.10.08.21.53.00
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 08 Oct 2019 21:53:02 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     linus.walleij@linaro.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, baolin.wang@linaro.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pinctrl: sprd: Add PIN_CONFIG_BIAS_DISABLE configuration support
Date:   Wed,  9 Oct 2019 12:52:45 +0800
Message-Id: <66d373ddee61e8be2fcef49aac5e80bd58f14915.1570596606.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PIN_CONFIG_BIAS_DISABLE configuration support for Spreadtrum pin
controller.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/pinctrl/sprd/pinctrl-sprd.c |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/pinctrl/sprd/pinctrl-sprd.c b/drivers/pinctrl/sprd/pinctrl-sprd.c
index 7b95bf5..8869843 100644
--- a/drivers/pinctrl/sprd/pinctrl-sprd.c
+++ b/drivers/pinctrl/sprd/pinctrl-sprd.c
@@ -484,6 +484,13 @@ static int sprd_pinconf_get(struct pinctrl_dev *pctldev, unsigned int pin_id,
 			       SLEEP_PULL_UP_MASK) << 16;
 			arg |= (reg >> PULL_UP_SHIFT) & PULL_UP_MASK;
 			break;
+		case PIN_CONFIG_BIAS_DISABLE:
+			if ((reg & (SLEEP_PULL_DOWN | SLEEP_PULL_UP)) ||
+			    (reg & (PULL_DOWN | PULL_UP_4_7K | PULL_UP_20K)))
+				return -EINVAL;
+
+			arg = 1;
+			break;
 		case PIN_CONFIG_SLEEP_HARDWARE_STATE:
 			arg = 0;
 			break;
@@ -674,6 +681,16 @@ static int sprd_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin_id,
 					shift = PULL_UP_SHIFT;
 				}
 				break;
+			case PIN_CONFIG_BIAS_DISABLE:
+				if (is_sleep_config == true) {
+					val = shift = 0;
+					mask = SLEEP_PULL_DOWN | SLEEP_PULL_UP;
+				} else {
+					val = shift = 0;
+					mask = PULL_DOWN | PULL_UP_20K |
+						PULL_UP_4_7K;
+				}
+				break;
 			case PIN_CONFIG_SLEEP_HARDWARE_STATE:
 				continue;
 			default:
-- 
1.7.9.5

