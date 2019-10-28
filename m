Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 266CACA9EC1
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 21:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E819421835
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 21:59:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eKVqOuBe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390579AbfJ1V75 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 17:59:57 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43162 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389866AbfJ1V72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 17:59:28 -0400
Received: by mail-pg1-f193.google.com with SMTP id l24so7887203pgh.10
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 14:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NtLLzsDOIuiH39rP2uuMmF0oaTj9DHzaakbaIjXt74A=;
        b=eKVqOuBe2qG/OSWZsaD3gbQVQnORi6YUJToqthQFixtmU1bAKAXU6V1ldupWC6VvTw
         RsTMuqOIvs7Az8gxZhBzjgrhkGKRmX9qGZW+fIrHiDuDEeJLZMgyj+Yiz23bw9wfOREr
         1gy4gtJ5MEfAGjn5SKvx5ks/STelDtQ4g6DKlAX9MLoSJ7+ETf+rl3nxipwO/X0YbJ04
         kid2Lg+PjKbhGtco88Xw2DyknmmFVdZYVERdIKGLgbwv1F2AXXjq7WjmRyIVT9oJRoR5
         I+dQGFLedmEvEqVeXZO4y+jfXBTe37AQds4D07d5UF/oXDarJbpUt6Jj34ERRyreJ5JA
         JttQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NtLLzsDOIuiH39rP2uuMmF0oaTj9DHzaakbaIjXt74A=;
        b=laIqKnVt1eb3RQ/RWwpQn9SpbhYbbvVSrL8GJkonnPeCXO/ygQCM3AX6Dx8oBOQ04W
         0m2iajhC39+2C/3RHMNVhvje58Pa5ISfuKr7+6lkpbSnS0tRCtZXKx5ewD+T7QwR7KPJ
         pyMJf9Xeim8gKN8cidtozyCH2nCH/ExO1TZJ+wINYEBYY6ZYKVXja1154jG+N9eCBvMb
         AZqfQaRz1coJSzd6IIRW3BIjrHfdXDjmpCHpeGdbKlYxVWlbSufyUZM6jONCpfv153Bk
         JMGu8qP3XjThvUbIIS/vGVyxI5RwriwDYCiB2JNSdXpcWbzbolQmw1cwX6v/drwBW6bq
         9o4Q==
X-Gm-Message-State: APjAAAXyTWazFsDSJuQ15I2WA/MRbM8ErG4tjH6kvyyhsA8xXsSUqtz9
        Hss8IyYmnmnjysFJOL8HhrPBXFHneCM=
X-Google-Smtp-Source: APXvYqygibWkWPMAb7wZK/7S2yus1n7uqa1S6UdpudK6pIw6iG7qeF5t6FQaHX/vFB83z9Il5b0N2g==
X-Received: by 2002:a63:67c3:: with SMTP id b186mr12427931pgc.152.1572299967053;
        Mon, 28 Oct 2019 14:59:27 -0700 (PDT)
Received: from localhost.localdomain (c-67-170-172-113.hsd1.or.comcast.net. [67.170.172.113])
        by smtp.gmail.com with ESMTPSA id f12sm10880612pfn.152.2019.10.28.14.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 14:59:26 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Yu Chen <chenyu56@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        ShuFan Lee <shufan_lee@richtek.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Felipe Balbi <balbi@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jun Li <lijun.kernel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Jack Pham <jackp@codeaurora.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, John Stultz <john.stultz@linaro.org>
Subject: [PATCH v4 3/9] usb: dwc3: Increase timeout for CmdAct cleared by device controller
Date:   Mon, 28 Oct 2019 21:59:13 +0000
Message-Id: <20191028215919.83697-4-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191028215919.83697-1-john.stultz@linaro.org>
References: <20191028215919.83697-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Chen <chenyu56@huawei.com>

It needs more time for the device controller to clear the CmdAct of
DEPCMD on Hisilicon Kirin Soc.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
CC: ShuFan Lee <shufan_lee@richtek.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: Yu Chen <chenyu56@huawei.com>
Cc: Felipe Balbi <balbi@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jun Li <lijun.kernel@gmail.com>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: Jack Pham <jackp@codeaurora.org>
Cc: linux-usb@vger.kernel.org
Cc: devicetree@vger.kernel.org
Signed-off-by: Yu Chen <chenyu56@huawei.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/usb/dwc3/gadget.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 86dc1db788a9..168eb4a0a9b0 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -270,7 +270,7 @@ int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned cmd,
 {
 	const struct usb_endpoint_descriptor *desc = dep->endpoint.desc;
 	struct dwc3		*dwc = dep->dwc;
-	u32			timeout = 1000;
+	u32			timeout = 5000;
 	u32			saved_config = 0;
 	u32			reg;
 
-- 
2.17.1

