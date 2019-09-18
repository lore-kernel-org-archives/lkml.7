Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5830C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 06:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC12221920
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 06:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568787849;
	bh=pAUTJC5wqLfsT9L0OAx6PZQXQLHUTTEDnyAZBYt62T8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yIXXFS0pZrHb9jNXdQP6dEKnKgzbsrvZy2gq/l4/RRTkkPyU17DePFf5byF3qerGA
	 WeLlbX7h0IJFKtpG5WD3zJiS3yU3PFen+dAuu/Oee63zKKbvCrBjGqtBtqUNqP3gHv
	 5yuF6Xw9kr/VaVvVL7D3WHxMWBPm23gHaAsF3764=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729772AbfIRGYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 02:24:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:44420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727496AbfIRGYE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 02:24:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B08821928;
        Wed, 18 Sep 2019 06:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568787842;
        bh=pAUTJC5wqLfsT9L0OAx6PZQXQLHUTTEDnyAZBYt62T8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=finSDRgsTVX9vnT50TfxHJEJAenf8U1Heu963rvLAGCyyV0NQRqzW8E42bMMmvpkC
         9TfVhE+VrIIIVEDI3HvxOVzYQoobBbW2MmCPgTRM3RzvN6AsRqAxWXgHb+TJ3a+qIc
         AwUDxNOYsmgCU5jm7cEpv/9M1PZmKQx8pHAd0SYY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kent Gibson <warthog618@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 4.19 31/50] gpio: fix line flag validation in lineevent_create
Date:   Wed, 18 Sep 2019 08:19:14 +0200
Message-Id: <20190918061226.681398811@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190918061223.116178343@linuxfoundation.org>
References: <20190918061223.116178343@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kent Gibson <warthog618@gmail.com>

commit 5ca2f54b597c816df54ff1b28eb99cf7262b955d upstream.

lineevent_create should not allow any of GPIOHANDLE_REQUEST_OUTPUT,
GPIOHANDLE_REQUEST_OPEN_DRAIN or GPIOHANDLE_REQUEST_OPEN_SOURCE to be set.

Fixes: d7c51b47ac11 ("gpio: userspace ABI for reading/writing GPIO lines")
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Kent Gibson <warthog618@gmail.com>
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpio/gpiolib.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -924,7 +924,9 @@ static int lineevent_create(struct gpio_
 	}
 
 	/* This is just wrong: we don't look for events on output lines */
-	if (lflags & GPIOHANDLE_REQUEST_OUTPUT) {
+	if ((lflags & GPIOHANDLE_REQUEST_OUTPUT) ||
+	    (lflags & GPIOHANDLE_REQUEST_OPEN_DRAIN) ||
+	    (lflags & GPIOHANDLE_REQUEST_OPEN_SOURCE)) {
 		ret = -EINVAL;
 		goto out_free_label;
 	}
@@ -938,10 +940,6 @@ static int lineevent_create(struct gpio_
 
 	if (lflags & GPIOHANDLE_REQUEST_ACTIVE_LOW)
 		set_bit(FLAG_ACTIVE_LOW, &desc->flags);
-	if (lflags & GPIOHANDLE_REQUEST_OPEN_DRAIN)
-		set_bit(FLAG_OPEN_DRAIN, &desc->flags);
-	if (lflags & GPIOHANDLE_REQUEST_OPEN_SOURCE)
-		set_bit(FLAG_OPEN_SOURCE, &desc->flags);
 
 	ret = gpiod_direction_input(desc);
 	if (ret)


