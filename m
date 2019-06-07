Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 197CFC28CC3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 08:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2FC320B7C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 08:29:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cOSA5ceD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbfFGI3v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 04:29:51 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45146 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727436AbfFGI3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 04:29:05 -0400
Received: by mail-wr1-f67.google.com with SMTP id f9so1211256wre.12
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 01:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jzlILgVOq+qa8QnWXtHWObcbjxta0J+JIjopEg5uUuk=;
        b=cOSA5ceD6DU90AczpWWeDFQqT7XMn1TslGtXrC+8Qgjy95ZdnObkBVL8UMmW9IYqFZ
         ly1EA8Xk7mSCU+6Q97tX0JUm4+q68XTAiT5Mh8Stkx6bEhUsxeOx0qdEw45vNnkrBk/o
         /RGAxiHMWRp1LjcUAV0QP4+SMHQaUjIfnlbdXIt5EEi3e6g1JqKnlSvd2p5n9IskMzYX
         O5cxIdBRkHbuQletelSuTniO4lKcrqHCsUaTJOOH/wwIODiqHSs2BZLqtQUKArJK3uEh
         3zDlBQREIzgp71Rt4d6nl5fPxN2UMvLeReBM/2nuGvF5iobsw4ccx3az8ignVslYorRA
         pELA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jzlILgVOq+qa8QnWXtHWObcbjxta0J+JIjopEg5uUuk=;
        b=QiQ7tPIuVMGf2eJMMx9qXqwpR8I//ZgGAhSjx8STGlhh7yb9k72rA/7jOSquwGSH8A
         xRNTryaF1mXPz/wmAw2CzMCIcEdC0pl9F1trQPRklLinHbNDS1ZABwQCAH3t9cWiC6wq
         f1LzZDMl/0vD+UO6ahuB2YZabGUV+uQ9UqPDEZlEjEI2jzb5zTaUcMDR0nNCmUe8GpF8
         oyM7/Obum3KoUUkJI7VQhjyzKbUcwjiCQTlu5tEQBx5oe/52qhknPOCUz03eWvhbOff8
         gpmg89hN0heSyKE7UBLacSQN9XyNGmgU06JJsvzz1u/sZuOqbbYqOfrOzqAiUimDIOFY
         XNMA==
X-Gm-Message-State: APjAAAVf5TkF/MYyPXgUqNfa9AvbO+9qXvwk8aONW8aLZkcHwD+L7GWh
        VBvO4boz5H1rkv9ybtdy5FqKkQ==
X-Google-Smtp-Source: APXvYqx1YuZGxxKFiVBuD7xZybj8kxKfRJulFeBpjaeUZaRQAyQoPtZmlBqhdZPXDhNc0hnte6SOyQ==
X-Received: by 2002:adf:e344:: with SMTP id n4mr8538433wrj.192.1559896144520;
        Fri, 07 Jun 2019 01:29:04 -0700 (PDT)
Received: from localhost.localdomain ([2.31.167.229])
        by smtp.gmail.com with ESMTPSA id a3sm1092946wmb.35.2019.06.07.01.29.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 01:29:04 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     alokc@codeaurora.org, andy.gross@linaro.org,
        david.brown@linaro.org, wsa+renesas@sang-engineering.com,
        bjorn.andersson@linaro.org, linus.walleij@linaro.org,
        balbi@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jlhugo@gmail.com, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-usb@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v2 2/8] i2c: i2c-qcom-geni: Signify successful driver probe
Date:   Fri,  7 Jun 2019 09:28:55 +0100
Message-Id: <20190607082901.6491-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190607082901.6491-1-lee.jones@linaro.org>
References: <20190607082901.6491-1-lee.jones@linaro.org>
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

