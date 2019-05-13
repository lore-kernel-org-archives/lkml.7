Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 025B3C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 22:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6FF8208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 22:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Eel2qDLN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbfEMWGU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 18:06:20 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39111 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbfEMWGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 18:06:19 -0400
Received: by mail-pg1-f193.google.com with SMTP id w22so7465618pgi.6
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 15:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ATRowXd7ipMmgvB8lyB4O5HcMo+A1bzkWKXt9bScEU4=;
        b=Eel2qDLNAo6NsGHWt1d/VXGsyvrURyD6LVgqznjvdn1UQqI0gtHQrhLfgCZ/xGRZ21
         xj8SDqqHBUHQe6VeYTiu2IDgEsoxTM0Wior4MK+fl/DCaqF4N+/YuqlU2pXtkDCgdSoV
         5wJ5dseJ59ftKAzYzAX2A0EQH04MC9EbZM6ng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ATRowXd7ipMmgvB8lyB4O5HcMo+A1bzkWKXt9bScEU4=;
        b=g71p/MsJXpe11/l4S/UYAJv1W54oF4SFjA3qE4yFnw/E03vnxzi2MITmq4FpBMppxB
         ufPm04iFXWET0KYmAn1BPd7QXTRzP+8GkCYjpt8YMA462V9FQ4O1vE96jxkUpxpPwzNF
         IM/0FlpfD8NJmH57yJX//DcPA3m7jsnkXkoIEocX7R6IH8bE7yXkhvqbufQnJwUrvo+L
         511dypGJXMXh2T3iXhCXMeLkGoL4ohG82vbFL3ZRGenYTk4k56LavOqXLEP1t6sFTUqA
         JB4cXhsLKCrbQZ94SYwK2kvpNDm9oiWG9VNt1RI/tN/LgdM81Nr48QEATIEX9ZQWZgZG
         XK/A==
X-Gm-Message-State: APjAAAUbh0C6YhAr7gHUxSxl1ERGmRrx1TKtnPoedWcdJbSmVre48V16
        GiCXCxNzEUJDeJ6wqkK8OVAM7Q==
X-Google-Smtp-Source: APXvYqyoA9CuAHGlEl/FI0l/Yo0SsimibyLXrO4rejpsbwjre4iS0UmqRqHT6l+p8utmMlWuJ9jnNQ==
X-Received: by 2002:aa7:90ce:: with SMTP id k14mr35926946pfk.239.1557785178277;
        Mon, 13 May 2019 15:06:18 -0700 (PDT)
Received: from ravisadineni0.mtv.corp.google.com ([2620:15c:202:1:98d2:1663:78dd:3593])
        by smtp.gmail.com with ESMTPSA id q20sm24559977pgq.66.2019.05.13.15.06.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 May 2019 15:06:17 -0700 (PDT)
From:   Ravi Chandra Sadineni <ravisadineni@chromium.org>
To:     dmitry.torokhov@gmail.com, ravisadineni@chromium.org,
        kt.liao@emc.com.tw, benjamin.tissoires@redhat.com,
        abhishekbh@google.com, tbroch@google.com,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [PATCH V1] elan_i2c: Increment wakeup count if wake source.
Date:   Mon, 13 May 2019 15:06:10 -0700
Message-Id: <20190513220610.177489-1-ravisadineni@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Notify the PM core that this dev is the wake source. This helps
userspace daemon tracking the wake source to identify the origin of the
wake.

Signed-off-by: Ravi Chandra Sadineni <ravisadineni@chromium.org>
---
 drivers/input/mouse/elan_i2c_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index f9525d6f0bfe..2c0561e20b7f 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -981,6 +981,8 @@ static irqreturn_t elan_isr(int irq, void *dev_id)
 	if (error)
 		goto out;
 
+	pm_wakeup_event(dev, 0);
+
 	switch (report[ETP_REPORT_ID_OFFSET]) {
 	case ETP_REPORT_ID:
 		elan_report_absolute(data, report);
-- 
2.20.1

