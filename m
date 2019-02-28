Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D34EBC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 12:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A09012083D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 12:27:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JNP+0LMs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731647AbfB1M1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 07:27:31 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40319 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731571AbfB1M12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 07:27:28 -0500
Received: by mail-wm1-f66.google.com with SMTP id g20so7975367wmh.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 04:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=5rNls9PJRn4v8yy/hG2zwnbZ+uPiqMw2tvNWVfaTE3s=;
        b=JNP+0LMsdZEAuxUlH07ex986yDXpk6607vbc8v5oR6cGShkyhAD2uqSWayDF69vU+3
         E7xVC06s8fAxUyu122JXU4uiSU2m1C9eIggCzLOoUtf3oiArQbtZhDM8h99K3xu8R1GQ
         S7NAGCEWZhD9/QF24Z914k1+dL2b/Q/xHo0P1X+NY8DLrZfah/fGq3mtG7oaaQrCgu1x
         cXkSYUWMe+Fb8gFlghNfRuhx8F9Fy0kVaKdGhkARFugxt6dc2bYYVlhEi5EHDE44WJWN
         ylBmy3GSRugs4ylL9HxRnCGNqA3enBd9xrmsd+7b7X9QKpexjeYJUunoujlu7j0GLOaW
         FD5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=5rNls9PJRn4v8yy/hG2zwnbZ+uPiqMw2tvNWVfaTE3s=;
        b=dsFMsmSOW8OQRR2Smt7fX2tHmx98zpOqALgTdebv75px31svKVbanjzMdw7eTLIs7p
         xRcZqQEcKOfPgzamGjEyMXSPH9Qx6H3y1AannT7O7gdUBYi9ZiXfDhvtiE2seCSP+Vx2
         yH4/VD0KHF8trdRWXm1kW36DVDxK7Eu8M95dcxnIzGznsZaFsyUatlQ+0KlFQyshEXnV
         rdwDYnZ8+LAlapP12xXQO+WD1GvDb3hEzaEu8NjlLUH9ylIWHBG+LZLt1B+PJZd+Y1kb
         YWvzVok5RSlDInLi1v/pz0wuo3KrBO4AE4j986/DElyHdcnHDTquso2EyLHHctDQtdYW
         Z+Jw==
X-Gm-Message-State: AHQUAuYOSPMIu+9wotOrUp9MlrJKzWfZD6Q1zqfZwy80+H76f4tXUVHQ
        7GbTQ0DZM3EpaHa9tbkkRxv+SOZZx2M=
X-Google-Smtp-Source: APXvYqxzWrrqBwV+ftkRLFSYRZ/LSiryOWWt+evoyQMpzQImdG+MG8Hm2JluUfDcBonZMzFUz4zmxw==
X-Received: by 2002:a1c:2097:: with SMTP id g145mr2665465wmg.81.1551356846508;
        Thu, 28 Feb 2019 04:27:26 -0800 (PST)
Received: from localhost ([49.248.54.130])
        by smtp.gmail.com with ESMTPSA id x17sm32944388wrd.95.2019.02.28.04.27.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 04:27:25 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH v2 15/24] drivers: thermal: tsens: change data type for sensor IDs
Date:   Thu, 28 Feb 2019 17:51:05 +0530
Message-Id: <031b5d48e77a0372d27cd9c79fe60730e47447e7.1551355503.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1551355503.git.amit.kucheria@linaro.org>
References: <cover.1551355503.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1551355503.git.amit.kucheria@linaro.org>
References: <cover.1551355503.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IDs cannot be negative, fix the data type.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/tsens.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index 023fed3352e3..a20725b1cc67 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -29,8 +29,8 @@ struct tsens_sensor {
 	struct tsens_priv		*priv;
 	struct thermal_zone_device	*tzd;
 	int				offset;
-	int				id;
-	int				hw_id;
+	unsigned int			id;
+	unsigned int			hw_id;
 	int				slope;
 	u32				status;
 };
-- 
2.17.1

