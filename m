Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC074C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 21:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8078B206BB
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 21:45:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mz2RyE2T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731101AbfI3Vpm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 17:45:42 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36367 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbfI3Vpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 17:45:42 -0400
Received: by mail-pl1-f193.google.com with SMTP id j11so1097196plk.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 14:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8ruDqNKuGSU2nVlbiXjG0y95FwzvT0teQMa8Utr4bjY=;
        b=mz2RyE2T1EEgFtF2UoSk0GlId6YYMtxfaH0WZSz1pBxbMFDcZJgaudo+MEtEnhYd47
         kpdtaTObWcCO5VnWRUNVW6cbxu9RyElOZc7C7kZx2scjX/MBTERcMog61yB/thr8wR0e
         gZbmsHTqrvMCEE/LZfgDFzGnE/5BLJT3GzjBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8ruDqNKuGSU2nVlbiXjG0y95FwzvT0teQMa8Utr4bjY=;
        b=ZYGO+eaJ5Cxp8TVVXnLCUxum0QfS7TaFI9hoBnUY9CI4/UPzzBtOLS0/q7Ml5snCsa
         0YcROp8VnenoeXviOHWA5DueCvZbzXp9YAZ4j8VhTXcIscB9fFbmZ6avMK7ZVwwXK7JP
         Ww/rpIadYt7GP4qPXMgLgM6gzsM6euBM5aZMV83kfPDrNdu8bZYpcQ9nR8zCKmjcrr0j
         ifHAUfcuJizblrgj8M6k//VyV2jx28r/lnGEN74nPPaD9Yy9iSTys73B4S5tILYUbozT
         W9ZNOalxhe7DYNSwEzSro1WGKB+cuhvONJxcOccF4RicRzdGbZdf4QgBjKmwy25eMPvc
         oo8A==
X-Gm-Message-State: APjAAAUo7wQHfEQA1qtU/xYIZ03ghlkAnsRzurw9cA66R/cDkwN4aFNa
        9OgsnNxTtErKMROQGuogp85xQQ==
X-Google-Smtp-Source: APXvYqxnFdaDxDxYpbu8HAxNuStIYedtTAtZN+OLvOJowJsm2okX8LAbs9bA+tVGyBnqbwGoCdrzDg==
X-Received: by 2002:a17:902:9684:: with SMTP id n4mr23179781plp.14.1569879940623;
        Mon, 30 Sep 2019 14:45:40 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:534:b7c0:a63c:460c])
        by smtp.gmail.com with ESMTPSA id r185sm13893394pfr.68.2019.09.30.14.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 14:45:39 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Hung-Te Lin <hungte@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        stable@vger.kernel.org, Guenter Roeck <groeck@chromium.org>
Subject: [PATCH] firmware: google: increment VPD key_len properly
Date:   Mon, 30 Sep 2019 14:45:22 -0700
Message-Id: <20190930214522.240680-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.23.0.444.g18eeb5a265-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 4b708b7b1a2c ("firmware: google: check if size is valid when
decoding VPD data") adds length checks, but the new vpd_decode_entry()
function botched the logic -- it adds the key length twice, instead of
adding the key and value lengths separately.

On my local system, this means vpd.c's vpd_section_create_attribs() hits
an error case after the first attribute it parses, since it's no longer
looking at the correct offset. With this patch, I'm back to seeing all
the correct attributes in /sys/firmware/vpd/...

Fixes: 4b708b7b1a2c ("firmware: google: check if size is valid when decoding VPD data")
Cc: <stable@vger.kernel.org>
Cc: Hung-Te Lin <hungte@chromium.org>
Cc: Guenter Roeck <groeck@chromium.org>
Cc: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 drivers/firmware/google/vpd_decode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/google/vpd_decode.c b/drivers/firmware/google/vpd_decode.c
index dda525c0f968..5c6f2a74f104 100644
--- a/drivers/firmware/google/vpd_decode.c
+++ b/drivers/firmware/google/vpd_decode.c
@@ -52,7 +52,7 @@ static int vpd_decode_entry(const u32 max_len, const u8 *input_buf,
 	if (max_len - consumed < *entry_len)
 		return VPD_FAIL;
 
-	consumed += decoded_len;
+	consumed += *entry_len;
 	*_consumed = consumed;
 	return VPD_OK;
 }
-- 
2.23.0.444.g18eeb5a265-goog

