Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36970C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 11:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A7C720866
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 11:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Phzisd+T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbfFELq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 07:46:29 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54146 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727330AbfFELnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 07:43:10 -0400
Received: by mail-wm1-f66.google.com with SMTP id d17so1924512wmb.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 04:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jzlILgVOq+qa8QnWXtHWObcbjxta0J+JIjopEg5uUuk=;
        b=Phzisd+Tdhfzrf2cnfJc7/3YsGZ48Ro4ChpgCOPMYGdsND4hfBtzYRbIro3IyIF/ok
         d2VoAM0CSoZqsLeb7daN/0gWZRf5oYOfyq6HbGajovhrFh9+ylcx1OfSnJPxDyboNKNr
         HMsHNOxcL/twPctqJndkmBghg6/cgcpivviP8tG3X6yJFC/6J1FDnX8ZMfAdcOoCwEOE
         wYt3lEugdF3bWe3lo3j+YIfzADWTggVyqZI8qjFBFYZq7yYU/hEkxsZURtN7iMzbDiKy
         SDGdToE7A6QwBNbr1y/nGX+1OFl/mOFABzdOKeAYX/+AtInl2tcDDgusYUFJjEOXiceF
         NJYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jzlILgVOq+qa8QnWXtHWObcbjxta0J+JIjopEg5uUuk=;
        b=rUn263LMUJjN0r9zKMB+LcDQSvnuzk9heBpbVF1TtIuW+oYwKtD0PZnCqoHkZA9DYj
         3wbaA/H96zuREzMJmaY0AgG35V4739LGmpmylGlr6D8JMGVBlfxTkfiDYiW3a9TGswxz
         XxSAV7Rb+ZKXdwLRmdbeanfc3ATszbBH2GahsZfVRGoIsomUHxo2581ECZbRpe/YO4jL
         7cCl6kmewcnOwif7dRoj0OJ0vb2XCHZzNpG4vTBQcTgsxeHefExufYznvLwZ8NOI0CCH
         Ci6ltD9PhsfGZfY1CH/vCxtVWHUEXyQ5twBbbS3IY9wrR+foXGqiEHzQ3iUKqcgZhH7l
         mGAw==
X-Gm-Message-State: APjAAAUq9kxV8JUvh+76zRlpQxBBh5mJAQvEPyssMgOkD8sm5pDuglba
        mFA+VChOnzvWqUFnhCP4eAVV7A==
X-Google-Smtp-Source: APXvYqyIKCzRjK5C2cfGwWv0aa6X+yD0CtMUNDQac+1g9TUKp+wHCO+xwEod0nMcftdvvIOKCPSkVg==
X-Received: by 2002:a1c:acc8:: with SMTP id v191mr22806026wme.177.1559734988581;
        Wed, 05 Jun 2019 04:43:08 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id 34sm27718740wre.32.2019.06.05.04.43.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 04:43:08 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     alokc@codeaurora.org, andy.gross@linaro.org,
        david.brown@linaro.org, wsa+renesas@sang-engineering.com,
        bjorn.andersson@linaro.org, linus.walleij@linaro.org,
        balbi@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jlhugo@gmail.com, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-usb@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 2/8] i2c: i2c-qcom-geni: Signify successful driver probe
Date:   Wed,  5 Jun 2019 12:42:56 +0100
Message-Id: <20190605114302.22509-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190605114302.22509-1-lee.jones@linaro.org>
References: <20190605114302.22509-1-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Qualcomm Geni I2C driver currently probes silently which can be
confusing when debugging potential issues.  Add a low level (INFO)
print when each I2C controller is successfully initially set-up.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/i2c/busses/i2c-qcom-geni.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index 0fa93b448e8d..720131c40fe0 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -598,6 +598,8 @@ static int geni_i2c_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	dev_dbg(&pdev->dev, "Geni-I2C adaptor successfully added\n");
+
 	return 0;
 }
 
-- 
2.17.1

