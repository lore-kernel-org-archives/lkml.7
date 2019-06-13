Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7786C31E49
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0940206BB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VaQNczpK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389451AbfFMPq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:46:57 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43639 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731772AbfFMJe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 05:34:26 -0400
Received: by mail-lf1-f66.google.com with SMTP id j29so14511915lfk.10;
        Thu, 13 Jun 2019 02:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=D4VkNejS3l89DpjptrqgXwGcwS4Wano2U0wz4lwUEa0=;
        b=VaQNczpK/3BmxeL4sv5hN1gRqsuOe4NI9bIsuhefGirRwQ2Ep+xA5p2rvPlmUUSHTw
         L+zsLfwVahm75pjugCW/QTbAGRpG8Lph5iydCA61rPHz1MosqOauTJnQPwpX33GyhLo1
         DDVkaUOAsiiHv4uOVnw2cVbzGsru5vICGLbGYhUMGbZiqm2It8Hn7r7V0MuuJr1DiTOD
         qm1rZB9Prw9Luxid/u5KHBvpPi2bYdTC5BG7XIa2SG11ijMYz29+oS9u40Ytdtqr4hup
         XCXEGHScUttgcoLhm0jdTyOvq+vqlCUDr8cuj9LNcof3A97bkmtITZGdp7WiKBgxW9OJ
         uh7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=D4VkNejS3l89DpjptrqgXwGcwS4Wano2U0wz4lwUEa0=;
        b=MqisVzaiR4RZUeQguk0h+zHQy4RHJtFufT5nZvANGlIzXCCQjH9cxqZojS/lOEgfZa
         dSOd9dV4ZC7NO7OgfewSOYbh2VpnsDhKfqkkRVmPO7Mx59jG6zYR5M9n2q1637oG33Hf
         LBY7CB4HnR/rsmLDTJk5bre1ToOUkUcJFmZsqvyB7mMCb7NqpGyqw7HMlt8nEZJx/niv
         tQPigY8gvZS+QbH9IJw/d/wJsqZ9i5aUYxQluW0Xf9YAKAhiStRo8niYXOmyxF1YZEae
         3ps2ClDyPlsGdF/GEeF8D41GHSWrEE1dArjK4yCUWhHdKjqToKUHQ4N+jG/ZjCZh+0nw
         hywg==
X-Gm-Message-State: APjAAAVy/ijPsy6T4VhdY9S6pd/+OeDss1Wv+dZf18RkO4CdoyJaACXN
        j4R9RblEk4RP+Hex10SDw2SdyzXsHfw=
X-Google-Smtp-Source: APXvYqyfZ4+dBY9GGiHtRnUXuqpxEoChE5mHTzoE5aKczii6KVRstIKjFeEE1l2WGWN4DtxQPyYKng==
X-Received: by 2002:a05:6512:4c5:: with SMTP id w5mr5128674lfq.171.1560418464220;
        Thu, 13 Jun 2019 02:34:24 -0700 (PDT)
Received: from ub1 (h-160-100.A251.priv.bahnhof.se. [37.123.160.100])
        by smtp.gmail.com with ESMTPSA id s20sm485172lfb.95.2019.06.13.02.34.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Jun 2019 02:34:23 -0700 (PDT)
Date:   Thu, 13 Jun 2019 11:34:33 +0200
From:   Jonas Stenvall <jonas.stenvall.umea@gmail.com>
To:     balbi@kernel.org
Cc:     gregkh@linuxfoundation.org, erosca@de.adit-jv.com,
        vladimir_zapolskiy@mentor.com, joshua_frkuska@mentor.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: gadget: u_audio: Fixed variable declaration coding
 style issue
Message-ID: <20190613093433.GA3878@ub1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed a coding style issue, replacing unsigned with unsigned int.

Signed-off-by: Jonas Stenvall <jonas.stenvall.umea@gmail.com>
---
 drivers/usb/gadget/function/u_audio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/function/u_audio.c b/drivers/usb/gadget/function/u_audio.c
index fb5ed97572e5..56906d15fb55 100644
--- a/drivers/usb/gadget/function/u_audio.c
+++ b/drivers/usb/gadget/function/u_audio.c
@@ -40,7 +40,7 @@ struct uac_rtd_params {
 
 	void *rbuf;
 
-	unsigned max_psize;	/* MaxPacketSize of endpoint */
+	unsigned int max_psize;	/* MaxPacketSize of endpoint */
 	struct uac_req *ureq;
 
 	spinlock_t lock;
@@ -78,7 +78,7 @@ static const struct snd_pcm_hardware uac_pcm_hardware = {
 
 static void u_audio_iso_complete(struct usb_ep *ep, struct usb_request *req)
 {
-	unsigned pending;
+	unsigned int pending;
 	unsigned long flags, flags2;
 	unsigned int hw_ptr;
 	int status = req->status;
-- 
2.17.1

