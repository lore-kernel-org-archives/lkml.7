Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F39C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBE4421916
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553253836;
	bh=7mAq9zVF4ZS5gRbysstHcgzpO0cBuX10/ax8lAbfkHI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NkvFom2ONTF1xFJIKWzNB6W0kq8wPDVQbKUfaExu+E8AXsEGCL/qw1DoRg89XFRPT
	 mditmfkb99tBxTE8FQJCphtafRUyg2T8rB9MlSL7ImmirgaYQ8qPcPAgQVfY+1vfd4
	 s00a2VkOX0kwCHW8sSB+Lg8QnkhLqoWam1gKAAH8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729033AbfCVLXy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:23:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:50890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729014AbfCVLXw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:23:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFFA521917;
        Fri, 22 Mar 2019 11:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553253831;
        bh=7mAq9zVF4ZS5gRbysstHcgzpO0cBuX10/ax8lAbfkHI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DZopEIED6oSGXWDPaTxYH9idwLN/f9Kaix04BE9UnyugkWca1VI1OvpdZvNo5RCwW
         U56klRn1eaSpuQTnHLqs0GGqQsW0H+iC+KaNeh3ufSH/hOrt3Ooyw+96asasB1wHuU
         0eoAHpUySkmKGOH/UFsLHzEm0QxRRJYC9zFNd5p4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jason Gerecke <jason.gerecke@wacom.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 3.18 077/134] Input: wacom_serial4 - add support for Wacom ArtPad II tablet
Date:   Fri, 22 Mar 2019 12:14:50 +0100
Message-Id: <20190322111215.672177563@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111210.465931067@linuxfoundation.org>
References: <20190322111210.465931067@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

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


