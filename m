Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D719C4360D
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 23:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1973C21D7F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 23:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XvDA+NkZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732802AbfIYXmj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 19:42:39 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46952 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732415AbfIYXmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 19:42:37 -0400
Received: by mail-pl1-f196.google.com with SMTP id q24so125475plr.13
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 16:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oFS6SaDoQ5fogHAHlhUMYfV/B7rrjNj6XYxhAXSXdHY=;
        b=XvDA+NkZlQlzPntPpjyLnCwo/WMpiawNV16X6mS3GsH4vcvrLxIwDzxYjPuOD4qfwe
         bTRHEmnPfk0/rdKZnFAtoCQ/uIhxYV+bdRcwqF4ULyV+nZYiAAeF3Hi+sb9L4Czig47U
         /yVBx0tgtnVfRk5pxFgslL0VtxWhQD9bw6cQnOCIGsZHsRmU5hkfrqI011qcoF/iRPYA
         i3HVbdthKqwyEnRg6KjgxzIkY/XUU6CHm6+e6rL7aUTdfykUhIvWnKW4kc9siqTAtV45
         O2D9wxGy8ZzlLJort0W50oCWJ+aH9H4HR9Veu43IDm7Sm29yvfGM/qaBLLF3Fzsi11R4
         0JtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oFS6SaDoQ5fogHAHlhUMYfV/B7rrjNj6XYxhAXSXdHY=;
        b=NF0T/7bCZZPq7ArQetM9zPqchU3eJv2CUnSiXDeBtI6TqzODesgry+cXfSn6m2iZfq
         r9o8rTMMFHgmrp9LMyl3iKnGyFBthlK7pbUFLqSRkl6qr/6FuIPvoC2xHhI7BmNxDaHm
         N26Ayuo74ECUZ9WoaK9GdpUmldHpRHHiEuF++t4Q7cPdwNZG1SUdBE6mOZ1oKl6kl6xl
         5LXrBmadiWucwxWW3h3yL6KQSGgUwpyDKo47J56wy5GEGo7gD5wS3aSaA6qBSAZvjHfh
         XumBDmrCEt/zRlvk5isQrOr0D/KaBC5gwcYrOySmu6khegBGzF2oDqti4the4dT7sR7b
         g/sg==
X-Gm-Message-State: APjAAAVtWBjVREaW6k1fQ300VsnI5sapLF7ELORpP39rOMX4mCAwuSk8
        O2EEE9qY2krdnrJUJtWasNxZewFn8NA=
X-Google-Smtp-Source: APXvYqyOtcEZXkAQw/XIO3JzERDkezLxycWYYHw08A6acjxATTtdAu3X9Fx8RAKp+WZv6SnW21J0rw==
X-Received: by 2002:a17:902:aa07:: with SMTP id be7mr738556plb.172.1569454956010;
        Wed, 25 Sep 2019 16:42:36 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id d1sm131127pfc.98.2019.09.25.16.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 16:42:35 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Yu Chen <chenyu56@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        John Stultz <john.stultz@linaro.org>
Subject: [PATCH 3/5] usb: dwc3: Increase timeout for CmdAct cleared by device controller
Date:   Wed, 25 Sep 2019 23:42:22 +0000
Message-Id: <20190925234224.95216-4-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190925234224.95216-1-john.stultz@linaro.org>
References: <20190925234224.95216-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Chen <chenyu56@huawei.com>

It needs more time for the device controller to clear the CmdAct of
DEPCMD on Hisilicon Kirin Soc.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Felipe Balbi <balbi@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Yu Chen <chenyu56@huawei.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: linux-usb@vger.kernel.org
Cc: devicetree@vger.kernel.org
Signed-off-by: Yu Chen <chenyu56@huawei.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/usb/dwc3/gadget.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 8adb59f8e4f1..81907e163252 100644
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

