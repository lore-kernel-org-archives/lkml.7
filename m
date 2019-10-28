Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F96CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 21:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1461521479
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 21:59:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yK8XTi+y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390522AbfJ1V7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 17:59:42 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39079 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390427AbfJ1V7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 17:59:33 -0400
Received: by mail-pg1-f195.google.com with SMTP id p12so7903655pgn.6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 14:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PwMMZk9WZCsU4Du96enXrC4F3u/XmD+gFRyu+Xx8uI0=;
        b=yK8XTi+yTqTvJtzBmsrxxZLC61ETTwPZxqGYnTbkgxYjA6GIs/gPQoC01K2sxBxzFl
         MMEwxtYn+EJXpjSvIP6eGGl7wmPAW+jGbqWOHspOj7EiQko05VJsEfSp1MN18G1jOUEU
         /5vTuSj/FWaKNs2T4pu58ii6asJl3R5vuhWgK6r81QFP2V0ka7iE7k4OCpik8Nm6QAy/
         60it1XUz8BIpKv+SwD5N6xFqcNCU49JuBRhvm4ufv4JLjR081Bk5Hwi2cJwsZDpPF1/P
         DuxqNluasrbfqixUPmc41KVHc9FIFjCHiqGdjiSmYwyl9wuBRQpRJs6hkDEtjHnf22EU
         /0MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PwMMZk9WZCsU4Du96enXrC4F3u/XmD+gFRyu+Xx8uI0=;
        b=K+p8ZRkSe9iqIIfuKpp08URD0Z364kX59IHQxtTT2cqjyM9a48bFmQpdrmyZZhl4eM
         DQa1Lw7D46PrADkiW5W547QdcVAaWdT1UVV1bG0UeKHHFyCQdJ5qgjljhPC8VIZGmjnv
         u5/nbUyxK5kXMm5tYa+5CLeFPgCmH512Gi71/SzKD47IU/ALN3eXgAJhtaGXZnIw/Zo+
         BHcOkdu7uns2pOZ5Xg1R7FQtQwllKJ+L7KZ0T2y2A5N796hUDoL0xoZtyDEyfWsQwrk2
         Jm2uxf+O1JQgdbKiKvscr5oLcm1/mCDKism4dt0OGp70dvwWBmNlHZ69qEIrE0T92BH7
         3g8Q==
X-Gm-Message-State: APjAAAVaYhD/G92aHcdfmnBZaNRlDd7ayFg0g0pEfj8BPwExt2WgFD5c
        Ht8jc+W9xPJvvTdhe6geqx8m0H0zYJk=
X-Google-Smtp-Source: APXvYqw+lIWkxCOYZfgUieLhn03j3Firptukiq0WcBWbrHmeAQRBK9que/SoMHJEv+L5UyY/O19Z1Q==
X-Received: by 2002:a17:90a:a616:: with SMTP id c22mr1907346pjq.61.1572299972866;
        Mon, 28 Oct 2019 14:59:32 -0700 (PDT)
Received: from localhost.localdomain (c-67-170-172-113.hsd1.or.comcast.net. [67.170.172.113])
        by smtp.gmail.com with ESMTPSA id f12sm10880612pfn.152.2019.10.28.14.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 14:59:32 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        ShuFan Lee <shufan_lee@richtek.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Yu Chen <chenyu56@huawei.com>, Felipe Balbi <balbi@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jun Li <lijun.kernel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Jack Pham <jackp@codeaurora.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v4 8/9] dt-bindings: usb: generic: Add role-switch-default-host binding
Date:   Mon, 28 Oct 2019 21:59:18 +0000
Message-Id: <20191028215919.83697-9-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191028215919.83697-1-john.stultz@linaro.org>
References: <20191028215919.83697-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding to configure the default role the controller
assumes is host mode when the usb role is USB_ROLE_NONE.

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
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 Documentation/devicetree/bindings/usb/generic.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/generic.txt b/Documentation/devicetree/bindings/usb/generic.txt
index cf5a1ad456e6..013782fde293 100644
--- a/Documentation/devicetree/bindings/usb/generic.txt
+++ b/Documentation/devicetree/bindings/usb/generic.txt
@@ -34,6 +34,11 @@ Optional properties:
 			the USB data role (USB host or USB device) for a given
 			USB connector, such as Type-C, Type-B(micro).
 			see connector/usb-connector.txt.
+ - role-switch-default-host: boolean, indicating if usb-role-switch is enabled
+			the device default operation mode of controller while
+			usb role is USB_ROLE_NONE is host mode. If this is not
+			set or false, it will be assumed the default is device
+			mode.
 
 This is an attribute to a USB controller such as:
 
-- 
2.17.1

