Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79FD6C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 19:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4080B20880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 19:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bpTQcaG5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfDHTzi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 15:55:38 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41080 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbfDHTzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 15:55:37 -0400
Received: by mail-qk1-f194.google.com with SMTP id o129so8783046qke.8;
        Mon, 08 Apr 2019 12:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=81SpTuGU7Y/G7KomHE5ruoxz9+agrItlkUAxeDaXk4c=;
        b=bpTQcaG5QS+DU7wAwIN5dmr7zyIAPAxXCEkOovsOu8HccuVHecdbpnchMFBRUNDSE9
         q+Ch1PO43sUgwBuuDPzsE15NJq7Li3maPvsVarJGB1Sf9RLS6CWQlnBaqslirCeW6qfl
         60WHG9Uk66tFwKvO2LlR7KnMQPFcBS0bOWNUklQLhVK8dT+fbkXV4+kAaqMJdvoVNqux
         AITn8ouSOyR5AnnkP9cb1sRy17HxtpSork9kzbDE7CNT9dAfPrE4yIoNpp6nUs3SNu8H
         8oS3nOLz0cewnseh9+at4aOWtlmsMsF5vPBv4wQKzOsF1Hl+SzH7cEKDyaAsAWpoERzw
         g2lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=81SpTuGU7Y/G7KomHE5ruoxz9+agrItlkUAxeDaXk4c=;
        b=dbvaV+NL4EcN/+mMVnvrvcsg2vYJltmA7V73UnGRPO4ixNrMzCMjrD+IhhrZk42/7Q
         AvjnZtVZwXQCYEAgWjR6o4Iz0ko5HEczmA4fJzMmHcBuhYeogkAMAJ8/tF4qW8tv81TZ
         kwTt5/jU0PP/gQwzNB5AXtO+a/Vb2D/glkmmvMjJFCynrwLj4PAAbnHxu4YBvHZNlSSa
         9yWl2p/SdHhlMP/YFiQXX2ekyHzT+UVrwB1bRMDtHmhBrN8kRhrqreY9z+cfULkaA7T0
         YbswKH73dSZNcFATqJlSVtjxtEIUN2tWdM+mEsKXUunefHqG0vhNQGCQ+u4Ik65uuvyO
         dZ0w==
X-Gm-Message-State: APjAAAWt7LLN9pFQss6U9ObbnkHIH4bZVPCMbrhSKIaHr+QK5LdnsPWw
        8qzDLVJ8TlfiFnBHXYBTRZU=
X-Google-Smtp-Source: APXvYqxv6hajrPSCDTgGy/Lonmpd0lArxmz8v+rS0CM/LqXV2ZbZ72CC5MaQbLAIGsrgGmTscWWoSw==
X-Received: by 2002:a37:68cc:: with SMTP id d195mr23253729qkc.131.1554753336690;
        Mon, 08 Apr 2019 12:55:36 -0700 (PDT)
Received: from urano.lrc.ic.unicamp.br (lrc-gw.ic.unicamp.br. [143.106.7.163])
        by smtp.gmail.com with ESMTPSA id r20sm21982733qtc.48.2019.04.08.12.55.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 08 Apr 2019 12:55:36 -0700 (PDT)
From:   Felipe Estrada-Solano <festradasolano@gmail.com>
To:     mchehab@kernel.org, gregkh@linuxfoundation.org,
        mjpeg-users@lists.sourceforge.net, linux-media@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org
Subject: [PATCH] staging: zoran: "foo * bar" should be "foo *bar"
Date:   Mon,  8 Apr 2019 16:55:26 -0300
Message-Id: <1554753326-1811-1-git-send-email-festradasolano@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the checkpatch.pl error:
ERROR: "foo * bar" should be "foo *bar"

Signed-off-by: Felipe Estrada-Solano <festradasolano@gmail.com>
---
 drivers/staging/media/zoran/zoran.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/zoran/zoran.h b/drivers/staging/media/zoran/zoran.h
index e84fb60..dc91e51 100644
--- a/drivers/staging/media/zoran/zoran.h
+++ b/drivers/staging/media/zoran/zoran.h
@@ -262,7 +262,7 @@ struct card_info {
 	/* avs6eyes mux setting */
 	u8 input_mux;
 
-	void (*init) (struct zoran * zr);
+	void (*init)(struct zoran *zr);
 };
 
 struct zoran {
-- 
2.7.4

