Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59933C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 16:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 248432084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 16:00:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XYupapqU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbfCKQA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 12:00:56 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:45652 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbfCKQA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 12:00:56 -0400
Received: by mail-io1-f68.google.com with SMTP id x9so4464615iog.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 09:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sEJ6Z1+CqNvu7IhQbM2Y+65pOInbk33Q6mV8kWRLSv0=;
        b=XYupapqUf991V+f7zTpBC64Js+6wrMtY6xPtMts6VdGrI8Inhd5yeBAvLmY/FAYcAF
         UZkW3AKErwyzLRsaUdiounyh7HwMzAL6ti8IpXu7MJ5c+C/wZSuaX/pVnQAxW3zx26dk
         JvnDnW0Cag8CTMzRgudnDQJfWZfrv1Qnd0AQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sEJ6Z1+CqNvu7IhQbM2Y+65pOInbk33Q6mV8kWRLSv0=;
        b=cE1nRvOpqo1Jl5Vrir4++WarszIGz32B9vbSS1pGVFOcvO6cHt0kZ4zQ+ynkkD4upN
         s8l0YVKF8+JRHbNnyVo5A91HmlBC8ow88pJbTa8YZzKkuwl92Wf7dclDMvTJXE1+Lj8W
         EYCoJt0V7RzPtwrcBroLMjDnvR8Cf+CWVgY2Ote5DDo5BsHUB+uy9JDvVyQB8JZM1Ffq
         ipVK4m6bjEYfIgfHXbWOvDgJoalyEkXoVCMbvhaZQjSzOaU1jfuE7+vi9ne/kMyrgPEf
         XhZ8iki4lrOgOYurRlb2hqUVp78iT+d/dDZTq2xvFNHGamBy3NAT4qfNspano6eZyM1z
         eW8w==
X-Gm-Message-State: APjAAAUEgpJ6Pnqbq16F1Kc85fnbGcyUHbKU5NYe39kjpDKnnfN2llTA
        V0wVvJPkZheIbKzhHlaSXpO73Q==
X-Google-Smtp-Source: APXvYqy7W5GY3W6AWWs3iEWx/hIH008tvmi+oXmiwjjgfgZamJTogQDX1L69F32oyyTTbBS96i1S4g==
X-Received: by 2002:a6b:f40d:: with SMTP id i13mr4743854iog.135.1552320055634;
        Mon, 11 Mar 2019 09:00:55 -0700 (PDT)
Received: from ncrews2.bld.corp.google.com ([2620:15c:183:200:3338:94cc:1814:b147])
        by smtp.gmail.com with ESMTPSA id w8sm2457919iob.34.2019.03.11.09.00.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 11 Mar 2019 09:00:54 -0700 (PDT)
From:   Nick Crews <ncrews@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org
Cc:     linux-kernel@vger.kernel.org, dlaurie@chromium.org,
        groeck@google.com, dtor@google.com,
        Nick Crews <ncrews@chromium.org>
Subject: [PATCH] platform/chrome: Fix locking pattern in wilco_ec_mailbox()
Date:   Mon, 11 Mar 2019 09:58:38 -0600
Message-Id: <20190311155838.255314-1-ncrews@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before, ec->data_buffer could be written to from multiple
contexts at the same time. Since the ec is shared data,
it needs to be inside the mutex as well.

Signed-off-by: Nick Crews <ncrews@chromium.org>
---
 drivers/platform/chrome/wilco_ec/mailbox.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/chrome/wilco_ec/mailbox.c b/drivers/platform/chrome/wilco_ec/mailbox.c
index f6ff29a11f1a..d6cb96168285 100644
--- a/drivers/platform/chrome/wilco_ec/mailbox.c
+++ b/drivers/platform/chrome/wilco_ec/mailbox.c
@@ -223,12 +223,12 @@ int wilco_ec_mailbox(struct wilco_ec_device *ec, struct wilco_ec_message *msg)
 		msg->command, msg->type, msg->flags, msg->response_size,
 		msg->request_size);
 
-	/* Prepare request packet */
+	mutex_lock(&ec->mailbox_lock);
+
 	rq = ec->data_buffer;
 	wilco_ec_prepare(msg, rq);
-
-	mutex_lock(&ec->mailbox_lock);
 	ret = wilco_ec_transfer(ec, msg, rq);
+	
 	mutex_unlock(&ec->mailbox_lock);
 
 	return ret;
-- 
