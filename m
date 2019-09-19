Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77884C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4119D20678
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568931523;
	bh=c1ndb59zZ1NqEZrcv/TqARD5qfsyX2LH2PgcQYhFYYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cLD5muKhFguRSwC7Cy7sI1ZLOL/NawV2cXAfB5XOImUkkzlFhuBycnsrc9t1aPj6u
	 CKnXE7Rl/I0IdMwxIa1nhVsUq3N0IwFKtMsMhbQPyR6qm7UVM/nHe3XLiSoBv+JqfR
	 hLqLy/WS/FHRvkbb2S4iU+VLK4zvz2WP8JuxSYvE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406577AbfISWSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 18:18:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:60188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393943AbfISWSf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 18:18:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD5CA217D6;
        Thu, 19 Sep 2019 22:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568931515;
        bh=c1ndb59zZ1NqEZrcv/TqARD5qfsyX2LH2PgcQYhFYYU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mkoig8i89zXYf/fwAQ56grjJOxU4CVBsB94iCZoNqKY3S/xh8xt5ird8mHvMywVtv
         WWM2kg1CS6hhRQRTmyA4M6JsZxRXe8wq7cdmXk3ZVqavRE0ooDub0hhLhamoJYeKjS
         VIqLJ+52ltdqxaYNnbqt01b1fpzhP3Tv1ougqm64=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kent Gibson <warthog618@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 4.9 15/74] gpio: fix line flag validation in lineevent_create
Date:   Fri, 20 Sep 2019 00:03:28 +0200
Message-Id: <20190919214805.805223002@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190919214800.519074117@linuxfoundation.org>
References: <20190919214800.519074117@linuxfoundation.org>
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
@@ -797,7 +797,9 @@ static int lineevent_create(struct gpio_
 	}
 
 	/* This is just wrong: we don't look for events on output lines */
-	if (lflags & GPIOHANDLE_REQUEST_OUTPUT) {
+	if ((lflags & GPIOHANDLE_REQUEST_OUTPUT) ||
+	    (lflags & GPIOHANDLE_REQUEST_OPEN_DRAIN) ||
+	    (lflags & GPIOHANDLE_REQUEST_OPEN_SOURCE)) {
 		ret = -EINVAL;
 		goto out_free_label;
 	}
@@ -811,10 +813,6 @@ static int lineevent_create(struct gpio_
 
 	if (lflags & GPIOHANDLE_REQUEST_ACTIVE_LOW)
 		set_bit(FLAG_ACTIVE_LOW, &desc->flags);
-	if (lflags & GPIOHANDLE_REQUEST_OPEN_DRAIN)
-		set_bit(FLAG_OPEN_DRAIN, &desc->flags);
-	if (lflags & GPIOHANDLE_REQUEST_OPEN_SOURCE)
-		set_bit(FLAG_OPEN_SOURCE, &desc->flags);
 
 	ret = gpiod_direction_input(desc);
 	if (ret)


