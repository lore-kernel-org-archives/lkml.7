Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BAD5ECDE20
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 05:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3060B21D7B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 05:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BOHRN2LD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbfIKF7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 01:59:44 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45194 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbfIKF7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 01:59:43 -0400
Received: by mail-pg1-f193.google.com with SMTP id 4so10932744pgm.12
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 22:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Z8bM74aV0Gm1NNmyfLGAjx3pN/OjFJf2r4RfCm9oqoo=;
        b=BOHRN2LDxWkitqnOtoRNf5XxHi74PnBd2fVeqX1kJtxLe8Or3gvVe+rIkD1BXp7bpJ
         HkSj04Pw7PF8pwiKzD756dKaStqPdZ2TO7WJRp0fiODPdqneBj1UXBxKmY0GOkRRbLat
         9Lss5hEcP4gxp4Qq/4kzCFLrnQUA/u4LmLHr3dJ5KgIsqlKXEeDscPCcNwJ9f8z8KZOy
         b8ZoCtCVtbAnQJh8Bzpdt1GN+E12h1AQOSfh/PU1qevNta7D/FrbxXRHEcT9AZdtfuEU
         SH7aUBoJ7ILbRvdYwk0S8AaayNUZXwTBFsqSLJQaQre465sMjSNsXB+OQnaxQxCJn1pC
         w9EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Z8bM74aV0Gm1NNmyfLGAjx3pN/OjFJf2r4RfCm9oqoo=;
        b=ZfKBm38U8lOzug3yLJNx1QlsY7rCuF46l7ptLJjPBqbkRS9rP/CP4utg0Y+Vk/fVUr
         KPE0/HA4H8hDgXKyrJyqpAItwkyLRc80hHcJfobvPX2zOACjEKh243oF6sgHWsCvqSe7
         gk7t3W3uEFjP/3aF9oBXxJMZ0n64jo8iuFlMfbIs6xneoSMp378pKsJy9yzYPQ4BrwrE
         wz8+1Ho1eHrFV3XMrSUBvuvVbp6SWjLB306q29PHhl04SbCssol+PO2AEVwck7ROJkMA
         4+963FK2EYpRe+R+KxOffp4vhC8eoPf3vjZHkWn4T1oBPRFVcbPImMloW/HS0ggv8Ra4
         xwRw==
X-Gm-Message-State: APjAAAUYHzUk0g3cq3BfdLZDbmUC4xbsjf7cNSSQFaEq8CNCplnAv9DS
        jyqEObdflFLdIR7SzT/SM2VJKbmGQSs=
X-Google-Smtp-Source: APXvYqypS0dXymbRXAvx2kwVeb1S+kI+5zoYOOA7IrCfv/NzkfUpMkc3qrHQzM/ygDzzL9FG8LTYdw==
X-Received: by 2002:a62:e910:: with SMTP id j16mr41357212pfh.123.1568181582511;
        Tue, 10 Sep 2019 22:59:42 -0700 (PDT)
Received: from LGEARND20B15 ([27.122.242.75])
        by smtp.gmail.com with ESMTPSA id k8sm16736280pgm.14.2019.09.10.22.59.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Sep 2019 22:59:42 -0700 (PDT)
Date:   Wed, 11 Sep 2019 14:59:38 +0900
From:   Austin Kim <austindh.kim@gmail.com>
To:     marek.behun@nic.cz
Cc:     linux-kernel@vger.kernel.org, austindh.kim@gmail.com
Subject: [PATCH] bus: moxtet: Update proper type 'size_t' to 'ssize_t'
Message-ID: <20190911055938.GA130589@LGEARND20B15>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The simple_write_to_buffer() returns ssize_t type value,
which is either positive or negative.

However 'res' is declared as size_t(unsigned int)
which contains non-negative type.

So 'res < 0' statement is always false,
this cannot execute execptional-case  handling.

To prevent this case,
update proper type 'size_t' to 'ssize_t' for execptional handling.

Signed-off-by: Austin Kim <austindh.kim@gmail.com>
---
 drivers/bus/moxtet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/moxtet.c b/drivers/bus/moxtet.c
index 1ee4570..288a9e4 100644
--- a/drivers/bus/moxtet.c
+++ b/drivers/bus/moxtet.c
@@ -514,7 +514,7 @@ static ssize_t output_write(struct file *file, const char __user *buf,
 	struct moxtet *moxtet = file->private_data;
 	u8 bin[TURRIS_MOX_MAX_MODULES];
 	u8 hex[sizeof(bin) * 2 + 1];
-	size_t res;
+	ssize_t res;
 	loff_t dummy = 0;
 	int err, i;
 
-- 
2.6.2

