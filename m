Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB32CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 20:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5652020656
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 20:14:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KVsrrGiu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730212AbfJUUOJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 16:14:09 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:47031 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbfJUUOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 16:14:09 -0400
Received: by mail-io1-f67.google.com with SMTP id c6so17473376ioo.13
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 13:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=xEwJBNto9KAcWmpasBhmnl15oU+oNgu4Rb5htYycPys=;
        b=KVsrrGiu1YeYehU1az8RKsFfg4eBcY0CtUIjyUZtduksDidivB9UnrJlWVUdLlgOVA
         QruyywfTieWlIjSakbJuEMbtHqpEz+RmjFcyVRZXI4V7gCBdIJSFyWk6vSbOPSowIqi2
         +h/HSnECp8fmcx/QO4dOEdxJEjzngN34tmF81nWZgjBExEt4bFLV47uopshlr03ufNao
         +y215KjagRkRaKyww/tDc7H+j8LWHltqQhQvpW5w1nUFlZsvvhEJGiTZBsS/r13ch0nL
         60aYw/d567tToTPYr7qvJYiG5Cl2tIJZAMaIuSe0NkIsLUN1pKnkanpMJ5U3BRvD3Saa
         1f7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xEwJBNto9KAcWmpasBhmnl15oU+oNgu4Rb5htYycPys=;
        b=ojeB7axDtzv23G3wIWu+Dz23/drWy1M5hB3luqblYLFSUIpLzwvgl/sDox5ckXMX3P
         nojQqJrd5mji/wQQtAXjM12HWcOsShbOIcmtfLoIbZmt+uS0GMcPmOgoOduoGfsAuwVA
         giWofdKzNHIyC2sWN+ikmvProxrN1p4J+e8WLtkEmGQFKvu/H4BVvZNpgQ2bWBID7v23
         Dgoh9DiJl247++Hzsp1OKzt2oKYrTOkfEPJmBTsYTQmCL6biKCgiGgD9inoMjBSZwSqF
         NJpmMj73YEefTxELsaHojOu/ERw7XxU/SBEIuo7pj5nw9pUaHgeYMsSGlfmHfx9/XSu1
         x0sQ==
X-Gm-Message-State: APjAAAXZ8YHN+rVgGFhGdhIA3RTgNDuBnyhF4qPKwDsP7ql631KlkUTn
        BjNvo+CxADJTByZyQXlJpto=
X-Google-Smtp-Source: APXvYqyMysdRd5UuHT5ueyZwzA8prHNYS/S+jS9DrWr/U+gd47kIsoBaBz9G54WFClKzqAEAM+MQAw==
X-Received: by 2002:a5e:8219:: with SMTP id l25mr16723iom.292.1571688848028;
        Mon, 21 Oct 2019 13:14:08 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id m14sm5995877ild.3.2019.10.21.13.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 13:14:07 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <wahrenst@gmx.net>, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] locking/atomics: Fix memory leak in bcm2835_timer_init
Date:   Mon, 21 Oct 2019 15:13:59 -0500
Message-Id: <20191021201400.2760-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the impelementation of bcm2835_timer_init() the allocated memory for
timer should be released if setup_irq() fails.

Fixes: 84c39b8b7d46 ("clocksource/drivers/bcm2835_timer: Unmap region obtained by of_iomap")
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/clocksource/bcm2835_timer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clocksource/bcm2835_timer.c b/drivers/clocksource/bcm2835_timer.c
index 2b196cbfadb6..7b27cc53ce9c 100644
--- a/drivers/clocksource/bcm2835_timer.c
+++ b/drivers/clocksource/bcm2835_timer.c
@@ -121,6 +121,7 @@ static int __init bcm2835_timer_init(struct device_node *node)
 	ret = setup_irq(irq, &timer->act);
 	if (ret) {
 		pr_err("Can't set up timer IRQ\n");
+		kfree(timer);
 		goto err_iounmap;
 	}
 
-- 
2.17.1

