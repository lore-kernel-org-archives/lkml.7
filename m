Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6259EC4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 02:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3356120700
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 02:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CsOyWOMQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbfCSCUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 22:20:37 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:37720 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbfCSCUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 22:20:35 -0400
Received: by mail-it1-f194.google.com with SMTP id z124so24620095itc.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 19:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pFZ8684u12waemMEDEpX4OQQjsUFR1UoCJAHSz/SOTk=;
        b=CsOyWOMQHaNkUiiRIRagw6S6BvsnBWJrBw+91Yw8SepLRNi/BOqsPj8dPQriDymB5i
         nnfJ8RgrScIHjVFIRWY++mb84+CqQzIntulUmVxWiFi7n6pDrS9gQmIfPffuhVI2BLXf
         0/2qv1b4vD6n1xl9OiYDovb2NvmVhfvEjVGqs4muhBh5gL+7oawvcKA3Y4X2MycS4foJ
         K+uybQ4fMc9vT3VpiKYTpGl+az1fssuFN7iwnqJsA4w2pWxHmb8OGWUSEHDNZi5z0jT7
         FBxl9aq9nB+9m3iOxH1GWSXyRJxexbK4ABxU0Yg36HFZ1e3oRhirUH89MQo8ESvR26SW
         aj9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pFZ8684u12waemMEDEpX4OQQjsUFR1UoCJAHSz/SOTk=;
        b=nqSYEuXaVDH9Vifdw/J6INSq29f/mqEgL9jDOW6yOV844wVPfPe/jKfxiyJW7Xi7xY
         XyuWOD3ZhDJfqwcYKO+sEn2vTTvXT0kHT3hfEPTQg31LVRcKIJuq9gwFOFyWuyjNUkRD
         2yW4txYf1a8qJeo3wm7HQ0AGvhQB57GgSWTNfmVRZg82uHtnYrCWRaAMCOyuUKT/Nkk5
         sjISCOc65ARrTPlCGx+bgkaUIT434S132QEoDTKFxmiWvGkL/jyBKdpwLHFiwXQExN25
         PogT51X8kpofX3EPMPH/IIu8brA6mTedITrplDhKr6Q799ZDhzXBqI+I9GFcuQVgyXz4
         L8vA==
X-Gm-Message-State: APjAAAUM1NXr7YlQas/3fC+I3yS60Iaxq1HzwGZzs7CSKCfFLuXHd4PK
        QEOChjKCPPwzebCSScOgaIg=
X-Google-Smtp-Source: APXvYqy8g3efcy7osyRrOLzggRr67trqVN6R6BFka76Uijl/wD5V/iRxMszRqnssI44Bs4Vh3iT4Gg==
X-Received: by 2002:a24:2789:: with SMTP id g131mr30755ita.127.1552962034048;
        Mon, 18 Mar 2019 19:20:34 -0700 (PDT)
Received: from localhost.localdomain (c-73-242-244-99.hsd1.nm.comcast.net. [73.242.244.99])
        by smtp.gmail.com with ESMTPSA id l8sm673838itl.26.2019.03.18.19.20.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 19:20:33 -0700 (PDT)
From:   George Hilliard <thirtythreeforty@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        George Hilliard <thirtythreeforty@gmail.com>
Subject: [PATCH v2 01/11] staging: mt7621-mmc: fix unused variable compiler warning
Date:   Mon, 18 Mar 2019 20:20:02 -0600
Message-Id: <20190319022012.11051-2-thirtythreeforty@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190319022012.11051-1-thirtythreeforty@gmail.com>
References: <20190319022012.11051-1-thirtythreeforty@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The compiler complains:

    drivers/staging/mt7621-mmc/dbg.c: In function ‘msdc_debug_proc_write’:
    drivers/staging/mt7621-mmc/dbg.c:237:12: warning: unused variable ‘size’ [-Wunused-variable]
      int mode, size;
                ^~~~
    drivers/staging/mt7621-mmc/dbg.c:237:6: warning: unused variable ‘mode’ [-Wunused-variable]
      int mode, size;
          ^~~~

Remove these declarations.

Signed-off-by: George Hilliard <thirtythreeforty@gmail.com>
---
 drivers/staging/mt7621-mmc/dbg.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/mt7621-mmc/dbg.c b/drivers/staging/mt7621-mmc/dbg.c
index 6b59ac8b323a..fda3ba38ba37 100644
--- a/drivers/staging/mt7621-mmc/dbg.c
+++ b/drivers/staging/mt7621-mmc/dbg.c
@@ -232,7 +232,6 @@ static ssize_t msdc_debug_proc_write(struct file *file,
 
 	int cmd, p1, p2;
 	int id, zone;
-	int mode, size;
 
 	if (count == 0)
 		return -1;
-- 
2.21.0

