Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFECDCA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 14:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82A1920700
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 14:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QzsodSJf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729346AbfJUOVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 10:21:18 -0400
Received: from mail-wm1-f74.google.com ([209.85.128.74]:57374 "EHLO
        mail-wm1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbfJUOVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 10:21:17 -0400
Received: by mail-wm1-f74.google.com with SMTP id m68so1266960wme.7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 07:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=on4/idiV9oaS/IR8jAQI0iaB3VMV3aTStZbS/UnOUko=;
        b=QzsodSJfTcR+ufqqv1YzNohzVZCaQ7UjuI6sf6P3JxkLy/VaKISnvfhqy/SV2K8Okg
         nXE/UkzqGS2/YiDOPKl1JFSPo/QWUEVJzmDfpzuMfmxNaqv2rCAp+crVEmFOnt5daDvQ
         k+rxVHnbCAaPLOoGc5SrR0Nb8ASM5vyqAsHV0eJWsRkHrZ5gh4zlcYlb6vZO86yFLIea
         UcorsSOze5s/hpxbrw0m/p/UzugFY1mn+SuMcSNTcLFOX+Phs0KYIqZzd2d3SZRU9Fzs
         UWOjREsxJ9lsVgNCnOfN/w/iXJgFgPyBvcKUH+yelrCCYUtIVGAwXRqAivnA5PWWPZoW
         Um4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=on4/idiV9oaS/IR8jAQI0iaB3VMV3aTStZbS/UnOUko=;
        b=ekoXxobn/lLYR9OIueap7ikkDeSG24eQ6OaPFA519MZotQF57psY0FTj/bJ99fvF/E
         wqgMlfyQG6Vm/aBdSYtgiB0a8zmYaTMbq7clHVvVmaiF0uzYwt/HDpp19XJ4Ydx0rj/9
         tuY2z3fdqype8rKYVBHBUP9azQUTTApfFEjOlV8B0G+qKJjykC94wx13IlCwovYbuxY/
         pIweecuZOo7SRna9iZ8ty+XXMcR4U/j0C72n/UCUDgvLl2TwoGtayWrvXWD3fTjLMoje
         G0wJvkN6i6Q0R+YinMQcYhyO8n2BKo8jtyW64SasDtFU1FKijphrvHbbWgz1+flz0wHh
         FHWQ==
X-Gm-Message-State: APjAAAVs9K4h+p+Yy2sXLe2DZOQiiaId2Vkhyx2nkFnHeT+eprZ8i+In
        8+TgYMWMp4r93iIC9bYX73hw6yShhDk/kYGG
X-Google-Smtp-Source: APXvYqx8/1/VpRgkzTaXT7elbGdj8wMsh9ChrrFJHVEeMNfKAo3+ORHj0vkDBDkeawbudSZib3uXrRMAw0yDwmZX
X-Received: by 2002:adf:8289:: with SMTP id 9mr21260326wrc.0.1571667673653;
 Mon, 21 Oct 2019 07:21:13 -0700 (PDT)
Date:   Mon, 21 Oct 2019 16:20:58 +0200
In-Reply-To: <cover.1571667489.git.andreyknvl@google.com>
Message-Id: <665578f904484069bb6100fb20283b22a046ad9b.1571667489.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1571667489.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
Subject: [PATCH v2 1/2] USB: dummy-hcd: increase max number of devices to 32
From:   Andrey Konovalov <andreyknvl@google.com>
To:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        "Jacky . Cao @ sony . com" <Jacky.Cao@sony.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When fuzzing the USB subsystem with syzkaller, we currently use 8 testing
processes within one VM. To isolate testing processes from one another it
is desirable to assign a dedicated USB bus to each of those, which means
we need at least 8 Dummy UDC/HCD devices.

This patch increases the maximum number of Dummy UDC/HCD devices to 32
(more than 8 in case we need more of them in the future).

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 drivers/usb/gadget/udc/dummy_hcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/dummy_hcd.c b/drivers/usb/gadget/udc/dummy_hcd.c
index 3d499d93c083..a8f1e5707c14 100644
--- a/drivers/usb/gadget/udc/dummy_hcd.c
+++ b/drivers/usb/gadget/udc/dummy_hcd.c
@@ -2725,7 +2725,7 @@ static struct platform_driver dummy_hcd_driver = {
 };
 
 /*-------------------------------------------------------------------------*/
-#define MAX_NUM_UDC	2
+#define MAX_NUM_UDC	32
 static struct platform_device *the_udc_pdev[MAX_NUM_UDC];
 static struct platform_device *the_hcd_pdev[MAX_NUM_UDC];
 
-- 
2.23.0.866.gb869b98d4c-goog

