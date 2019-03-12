Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FEA7C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 336592147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552412785;
	bh=IHKqIbqC6oH1dIQFRWoG5DUpavdBCZC53ISO2ZmWhIw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=f7rf9GJIUEsg3En8Uq8pUVq24uCmxgWOGQgkhqRE7/SUabybmOE+bIERXPadIbok7
	 AWm45MLaQrdYXe2ZwOWGQjx7i7YSJX3ZsHjMLqI+xaZZ5bCdWgKx7pyNKopEw2+T51
	 xlAGfRflS7tmP4EsoLdadk1v6FXkYtwcfAezp35A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729164AbfCLRqX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:46:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:55708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728685AbfCLRPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:15:22 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C12C217D8;
        Tue, 12 Mar 2019 17:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410921;
        bh=IHKqIbqC6oH1dIQFRWoG5DUpavdBCZC53ISO2ZmWhIw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oS0+iyUC/8oq5B2VUDcsuzVksMKjJYQbIhqgkj1TMiMLudX7VZIHxFudW1EMMcEV4
         duSZF60lWkhk+cuPcqNPMJ5rq4aNguHwkTafM319xn4U6WYSc3XO8Jc3+uVrWybAFw
         Hi8G8mbsOAm0XgPLQ78xPFxjt4+uXof3qM044jJQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jason Gerecke <jason.gerecke@wacom.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.19 123/149] Input: wacom_serial4 - add support for Wacom ArtPad II tablet
Date:   Tue, 12 Mar 2019 10:09:01 -0700
Message-Id: <20190312170359.733146450@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170349.421581206@linuxfoundation.org>
References: <20190312170349.421581206@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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


