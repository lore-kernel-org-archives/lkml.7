Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA79CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85352218D4
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nkcHtWpj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbfCVPxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 11:53:12 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37752 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbfCVPxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 11:53:12 -0400
Received: by mail-wr1-f66.google.com with SMTP id w10so2919531wrm.4;
        Fri, 22 Mar 2019 08:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=18PmN9KQr/H1F84Tkb4n95xe4xVl12w2H+KQLyY4pKY=;
        b=nkcHtWpjjPrRTsbTuB3iZf17kZBwzEM6Zn2+iiz3HbHJNffUOfSq5iq1FiAMNSr7HX
         XPGwIwzZM4T753eB/qFuZA3wf7qm8gnqMDH/FKCZlLDBCM0bgx+i/PeHboe1VxcH6CWv
         n8wy1fMfV8crw+14LMSR9QQlU9I4q5sjXT24mzMxDzECn/OKVqB7s5wFxb5Es42glCVl
         R+xjuulBaC2D73TqS0BVA5clwZyeZ2yNmR1k8BRgJnP0cIat6/P/b0KcZyLJf7yQO5DP
         W/YgpT+fibxa6PbHWsaEew74IdbLsVpMiJp1mqSO9I1IMBfjvz4YTfC89q5QAJQ2t+Z1
         a5Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=18PmN9KQr/H1F84Tkb4n95xe4xVl12w2H+KQLyY4pKY=;
        b=Lp1ytW1ZHfYDU+d19wzl6JIlPy+Gzd46LKwqCq3Hg3gmqWEAYpkjEenkuB9iHQM63V
         +mJignkL7hz/jedZRNqltYV7wYGU7HcG95z0rKuk5ipB+5cAPSf7miHdEq+7iv50as+K
         tdygWcfVBLvHXL0F9w5d2x4ME9XciJoCliuekfAScsv+x9xhPbsUv+HMMlYYrxzByATP
         C5QOg/7GopdwwExyiyI2B1MMwwhkL5uUA2fVyXqCgjk1J6/67xPKq/QRKbQWi+SIA1Ng
         SHYkjjp9Hf7OekYmKcll69/Jrpc/jRqgfKnk3RVZ3lMReG+797Kl+QPigm/LU6ENjhZL
         neNw==
X-Gm-Message-State: APjAAAXoQiPVBBERJS9zHbzI5KylpdanHPtBt9+WXmmeJAJm59td/igq
        T2TmOYcfi7QQ5H+n6jMkW90=
X-Google-Smtp-Source: APXvYqwTs+S8BZOeD1dgGTDmID8ir3CB4oX59/jDsDTNb81sGE/a7G3vLFpKpdCvdO/VbFIinOQI9Q==
X-Received: by 2002:a5d:52ca:: with SMTP id r10mr7261493wrv.187.1553269990086;
        Fri, 22 Mar 2019 08:53:10 -0700 (PDT)
Received: from 5WDYG62.mdi (static-css-cqn-143221.business.bouyguestelecom.com. [176.149.143.221])
        by smtp.gmail.com with ESMTPSA id w16sm8136833wrt.84.2019.03.22.08.53.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 08:53:09 -0700 (PDT)
From:   Romain Izard <romain.izard.pro@gmail.com>
To:     Oliver Neukum <oneukum@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Romain Izard <romain.izard.pro@gmail.com>
Subject: [PATCH] usb: cdc-acm: fix race during wakeup blocking TX traffic
Date:   Fri, 22 Mar 2019 16:53:02 +0100
Message-Id: <20190322155302.28414-1-romain.izard.pro@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the kernel is compiled with preemption enabled, the URB completion
handler can run in parallel with the work responsible for waking up the
tty layer. If the URB handler sets the EVENT_TTY_WAKEUP bit during the
call to tty_port_tty_wakeup() to signal that there is room for additional
input, it will be cleared at the end of this call. As a result, TX traffic
on the upper layer will be blocked.

This can be seen with a kernel configured with CONFIG_PREEMPT, and a fast
modem connected with PPP running over a USB CDC-ACM port.

Use test_and_clear_bit() instead, which ensures that each wakeup requested
by the URB completion code will trigger a call to tty_port_tty_wakeup().

Fixes: 1aba579f3cf5 cdc-acm: handle read pipe errors
Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
---
 drivers/usb/class/cdc-acm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index 739f8960811a..ec666eb4b7b4 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -558,10 +558,8 @@ static void acm_softint(struct work_struct *work)
 		clear_bit(EVENT_RX_STALL, &acm->flags);
 	}
 
-	if (test_bit(EVENT_TTY_WAKEUP, &acm->flags)) {
+	if (test_and_clear_bit(EVENT_TTY_WAKEUP, &acm->flags))
 		tty_port_tty_wakeup(&acm->port);
-		clear_bit(EVENT_TTY_WAKEUP, &acm->flags);
-	}
 }
 
 /*
-- 
2.17.1

