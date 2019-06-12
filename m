Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A45DBC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 14:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E90920B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 14:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ThCLa8t3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439808AbfFLO17 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 10:27:59 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55857 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439643AbfFLO1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 10:27:02 -0400
Received: by mail-wm1-f67.google.com with SMTP id a15so6785248wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 07:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sZgUWoDIjlp1AADdoY2p7F+W0Gj8IYxrvEu+mq9KTCQ=;
        b=ThCLa8t3mfLlLTD+JYyjOG6ksSBzbsRKPHrxJlijHkCpRc+/WWHb1OthqzocW1Q84S
         MpNp8Y/1dFfEsYS7a75G2juDpZzuA+kbzktHPUUG9uWEjmWQUZtj494NWkBUiypWi9yf
         n4LCAJFKzrB56BTYY41lJ17pCUELOG2TK1at6xcbda8EYVl/FG2i0UNTMxkgt3JpYYif
         r1NFHKJ2TRQNI4kIyOJIIORlJ0i5XNs5C/Jl+N02cMWrlXkK+HCqWMxLcTESMnd1Ka4p
         qVsL3oNmOhGVY/Ora0UysqUsr9VkoU4CJj/w9QNDA8hVNYXMGz6ooR1wRVzk4sEiP76M
         7lug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sZgUWoDIjlp1AADdoY2p7F+W0Gj8IYxrvEu+mq9KTCQ=;
        b=LULLMDy8VYEv1oHU6EXAc1dVLLVv3KjsqY2fTgnbWL6/4aKMc4baARucZf1ToS9zNj
         kiPuS0zkD8bmevIZ54Leoj5bx78XE9IL3wqiblxcHxOR7NHbYx0lxsYJB0GkBqNc6EM+
         S3gqXLwoj/eXAPMDXfEhpJ4vdn+N9pR6U1SZUl/DSeTk/OJU0ri560qqAF8xCAUj+lKJ
         7edGE09ZGIcRNDHZR66MD61m7YkvZ0ddJdyJmXfjOmW6PhOo1FAKAyV5HINVYi4MASHQ
         F7CKD7XXz5CNjBpT4Jp2ParZK7ToSUbc7xDCpvH6GHkw4++cpUi2nD8ffH/ahDA5MUz0
         1v6Q==
X-Gm-Message-State: APjAAAXpXeM+UCO0imVAkXmM5JW1+6z3TYCjtjAI5as0KpB4YOV28RK8
        tht9R45+c18p32QzQdg99O7MNA==
X-Google-Smtp-Source: APXvYqyB5BLzCKR3nJOtnmcfyjuqV3SjjUH851bbpxYVxf/6JQ+1BprzeCx6NHeeU76rXYDOeSvIIw==
X-Received: by 2002:a1c:e0c4:: with SMTP id x187mr21406913wmg.177.1560349620555;
        Wed, 12 Jun 2019 07:27:00 -0700 (PDT)
Received: from dell.watershed.co.uk ([185.80.132.160])
        by smtp.gmail.com with ESMTPSA id y18sm203959wmd.29.2019.06.12.07.26.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 07:27:00 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     alokc@codeaurora.org, agross@kernel.org, david.brown@linaro.org,
        wsa+renesas@sang-engineering.com, bjorn.andersson@linaro.org,
        balbi@kernel.org, gregkh@linuxfoundation.org,
        ard.biesheuvel@linaro.org, jlhugo@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-usb@vger.kernel.or,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v4 2/6] i2c: i2c-qcom-geni: Signify successful driver probe
Date:   Wed, 12 Jun 2019 15:26:50 +0100
Message-Id: <20190612142654.9639-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190612142654.9639-1-lee.jones@linaro.org>
References: <20190612142654.9639-1-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Qualcomm Geni I2C driver currently probes silently which can be
confusing when debugging potential issues.  Add a low level (INFO)
print when each I2C controller is successfully initially set-up.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/i2c/busses/i2c-qcom-geni.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index 9e3b8a98688d..a89bfce5388e 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -596,6 +596,8 @@ static int geni_i2c_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	dev_dbg(&pdev->dev, "Geni-I2C adaptor successfully added\n");
+
 	return 0;
 }
 
-- 
2.17.1

