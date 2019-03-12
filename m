Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 896B3C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BB99206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552412095;
	bh=ZilIsfzycKMVUn6a7zeeXQ+x4wUlL0/pluHZFdWPhy8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DeopfQXQybNh/SWMbxPaeqn6UHm7QbqlWuc8ilfkRog3/RrANaqn+iqQgjPynkP8d
	 09ZA3Vm9kZ4+D6Qmz6FJ7jpdqJPRp6BbMCaHxzw3CgEDujDd1737JqgNnV9Y9zfu6w
	 Gv/KIuQJ9CktcqcLf5oNW4CAhtdCP/+ZoLwt0cK0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729558AbfCLRex (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:34:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:59836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729365AbfCLRQz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:16:55 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6B86217D4;
        Tue, 12 Mar 2019 17:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552411015;
        bh=ZilIsfzycKMVUn6a7zeeXQ+x4wUlL0/pluHZFdWPhy8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tHAA9HhrF+h/DIlMHzOWRofGF5lTlW2F0ixnzrLLYUVg0SyILUVuuae1e4Srb2ixe
         xludTiEpdq5rc3B6L3f41VMn21qdxMxThAo/Bz+5ZHwxCCIXACRkJL5oW8DMo4AR0d
         jogQaGRkNqo4HOpNdK/elWOVJxpsKhBBlAhi3EC8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jason Gerecke <jason.gerecke@wacom.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.14 120/135] Input: wacom_serial4 - add support for Wacom ArtPad II tablet
Date:   Tue, 12 Mar 2019 10:09:27 -0700
Message-Id: <20190312170352.247018779@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170341.127810985@linuxfoundation.org>
References: <20190312170341.127810985@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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


