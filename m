Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A63C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E1FE218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254367;
	bh=qAMR5NO/NWgx2ESZ9kNu1NxZ+hslFfMjPvvwcNue8LM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NadUm4Oird42E4geSgcc1HF45YAkKorcsxpJH9Zg8rsROpOS2zZ+0U5DkcLtHl551
	 W76a8HlPm/IM0IMyxbz92nG9Gewxl1amMhlxjQUOOLnwqXHOkmjRVZJ1gDpxAaMWFz
	 aK/YCjDlA2GAkpGkBLSZ7C88FxhcIT0S6twNS7iU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730205AbfCVLcq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:32:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:32998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730191AbfCVLcm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:32:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2D57218B0;
        Fri, 22 Mar 2019 11:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254362;
        bh=qAMR5NO/NWgx2ESZ9kNu1NxZ+hslFfMjPvvwcNue8LM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JmrNNgBH6Cw8pHx0YdBa0iZJ3GjBph9CG1azv2LEp8lQCCrnmBT+Br56yTkkkpnOo
         J+/MbDfrHh+UZWkKx8psnrMRts6sDNOoWItyurooauB0cP6I8NVls6jhO+bvVbYeXY
         +qD0P5s9Dy3jg5KZ0EI1KJiD2vCJSmiSCf7TAefc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jason Gerecke <jason.gerecke@wacom.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.4 112/230] Input: wacom_serial4 - add support for Wacom ArtPad II tablet
Date:   Fri, 22 Mar 2019 12:14:10 +0100
Message-Id: <20190322111244.495417572@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111236.796964179@linuxfoundation.org>
References: <20190322111236.796964179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason Gerecke <jason.gerecke@wacom.com>

commit 44fc95e218a09d7966a9d448941fdb003f6bb69f upstream.

Tablet initially begins communicating at 9600 baud, so this command
should be used to connect to the device:

    $ inputattach --daemon --baud 9600 --wacom_iv /dev/ttyS0

https://github.com/linuxwacom/xf86-input-wacom/issues/40

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/tablet/wacom_serial4.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/input/tablet/wacom_serial4.c
+++ b/drivers/input/tablet/wacom_serial4.c
@@ -187,6 +187,7 @@ enum {
 	MODEL_DIGITIZER_II	= 0x5544, /* UD */
 	MODEL_GRAPHIRE		= 0x4554, /* ET */
 	MODEL_PENPARTNER	= 0x4354, /* CT */
+	MODEL_ARTPAD_II		= 0x4B54, /* KT */
 };
 
 static void wacom_handle_model_response(struct wacom *wacom)
@@ -245,6 +246,7 @@ static void wacom_handle_model_response(
 		wacom->flags = F_HAS_STYLUS2 | F_HAS_SCROLLWHEEL;
 		break;
 
+	case MODEL_ARTPAD_II:
 	case MODEL_DIGITIZER_II:
 		wacom->dev->name = "Wacom Digitizer II";
 		wacom->dev->id.version = MODEL_DIGITIZER_II;


