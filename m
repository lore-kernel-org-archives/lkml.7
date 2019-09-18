Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB1DBC4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 06:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 822C421927
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 06:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568787628;
	bh=KcAuGXcLMyibSCh9f3a5Nc0iP/gxhLJsrVubJb8eZT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rh5DrZ7WOrNG8eWZ9h4G3j2qZfN7j0HWqEoaOtHzC+hx83xJ6e68MVZIVUX6FhXfn
	 Rid1+q5cVnjos/gN3g4RAuwWgxrBdmm/dp/SKhvFKNf++V+yyU9RBGuAzY5mB+syLZ
	 ba9PbVB3upC6gdhRsgQiRtCApdZWGn1ruxVkFDcE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbfIRGU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 02:20:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:39152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728239AbfIRGUX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 02:20:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECE2121929;
        Wed, 18 Sep 2019 06:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568787622;
        bh=KcAuGXcLMyibSCh9f3a5Nc0iP/gxhLJsrVubJb8eZT8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xGqZXIDojcdGmytbaW0D+MtcD0sCcyX/8fNWd57wIumVv4TpLzW1ZGi3AoXc1K9a1
         oktpHUN4RLp9nzf6NcQeAi2ldzA6XxaGnfNwr0rBiMDY5NKUPXFi8+SSQ0a1UZsJr5
         0pbZfGEEjT+8ivq3Fcz5KqgAHpaEtoaW9pJIwR2c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kent Gibson <warthog618@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 4.14 18/45] gpio: fix line flag validation in linehandle_create
Date:   Wed, 18 Sep 2019 08:18:56 +0200
Message-Id: <20190918061224.814891488@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190918061222.854132812@linuxfoundation.org>
References: <20190918061222.854132812@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kent Gibson <warthog618@gmail.com>

commit e95fbc130a162ba9ad956311b95aa0da269eea48 upstream.

linehandle_create should not allow both GPIOHANDLE_REQUEST_INPUT
and GPIOHANDLE_REQUEST_OUTPUT to be set.

Fixes: d7c51b47ac11 ("gpio: userspace ABI for reading/writing GPIO lines")
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Kent Gibson <warthog618@gmail.com>
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpio/gpiolib.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -444,12 +444,23 @@ static int linehandle_create(struct gpio
 	struct linehandle_state *lh;
 	struct file *file;
 	int fd, i, count = 0, ret;
+	u32 lflags;
 
 	if (copy_from_user(&handlereq, ip, sizeof(handlereq)))
 		return -EFAULT;
 	if ((handlereq.lines == 0) || (handlereq.lines > GPIOHANDLES_MAX))
 		return -EINVAL;
 
+	lflags = handlereq.flags;
+
+	/*
+	 * Do not allow both INPUT & OUTPUT flags to be set as they are
+	 * contradictory.
+	 */
+	if ((lflags & GPIOHANDLE_REQUEST_INPUT) &&
+	    (lflags & GPIOHANDLE_REQUEST_OUTPUT))
+		return -EINVAL;
+
 	lh = kzalloc(sizeof(*lh), GFP_KERNEL);
 	if (!lh)
 		return -ENOMEM;
@@ -470,7 +481,6 @@ static int linehandle_create(struct gpio
 	/* Request each GPIO */
 	for (i = 0; i < handlereq.lines; i++) {
 		u32 offset = handlereq.lineoffsets[i];
-		u32 lflags = handlereq.flags;
 		struct gpio_desc *desc;
 
 		if (offset >= gdev->ngpio) {


