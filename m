Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A09EC4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 06:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7A4D21928
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 06:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568787632;
	bh=ayhMClDs6KUPnUIbyLFAJ77rrROSGjPqCz8zXTAHVNg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=c/GSWbN9gyyZHjxyVGoEi2bJDv14pKMUXr/Ly10tbemnwISsehcfOtV+IXnLMNVFM
	 xrDRiy5DGOmXxa6roB0sQVN0V6v9+qrJRc3uOZZ9/SG0GRcQRKNyG3F0U9iFW/wldo
	 NQQVd73oqftw0Eo4mFuvVEhTiBd4FHHOZMjN6n4E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbfIRGUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 02:20:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:39226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727672AbfIRGUZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 02:20:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9EED1218AE;
        Wed, 18 Sep 2019 06:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568787625;
        bh=ayhMClDs6KUPnUIbyLFAJ77rrROSGjPqCz8zXTAHVNg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qnwA+OTpuF/sOt9+Hg8+0mKd+3YR+/q3XNvJkqpFXVhFHXgwPeATHdMa9QqXRcwLB
         KBxVhqHBd1knxx/lWzy4bGj8/kFkaEN+5YBGExiRzPDLg2C7TfRMZ+aSBxHVKFRzGo
         xQgjKj//fYSvcmqpPES6XYTccT/Gnb15Fi05ekVE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kent Gibson <warthog618@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 4.14 19/45] gpio: fix line flag validation in lineevent_create
Date:   Wed, 18 Sep 2019 08:18:57 +0200
Message-Id: <20190918061224.932143894@linuxfoundation.org>
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
@@ -815,7 +815,9 @@ static int lineevent_create(struct gpio_
 	}
 
 	/* This is just wrong: we don't look for events on output lines */
-	if (lflags & GPIOHANDLE_REQUEST_OUTPUT) {
+	if ((lflags & GPIOHANDLE_REQUEST_OUTPUT) ||
+	    (lflags & GPIOHANDLE_REQUEST_OPEN_DRAIN) ||
+	    (lflags & GPIOHANDLE_REQUEST_OPEN_SOURCE)) {
 		ret = -EINVAL;
 		goto out_free_label;
 	}
@@ -829,10 +831,6 @@ static int lineevent_create(struct gpio_
 
 	if (lflags & GPIOHANDLE_REQUEST_ACTIVE_LOW)
 		set_bit(FLAG_ACTIVE_LOW, &desc->flags);
-	if (lflags & GPIOHANDLE_REQUEST_OPEN_DRAIN)
-		set_bit(FLAG_OPEN_DRAIN, &desc->flags);
-	if (lflags & GPIOHANDLE_REQUEST_OPEN_SOURCE)
-		set_bit(FLAG_OPEN_SOURCE, &desc->flags);
 
 	ret = gpiod_direction_input(desc);
 	if (ret)


