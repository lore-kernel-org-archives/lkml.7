Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB008CA9ECF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 18:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5637214D8
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 18:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sCW7KUGI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729552AbfKDSNA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 13:13:00 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43546 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729312AbfKDSM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 13:12:57 -0500
Received: by mail-pg1-f193.google.com with SMTP id l24so11849503pgh.10
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 10:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6tmVV51SnSk2HYvVHQW3Mgj1F0ShkbzQvD8YUBsAymU=;
        b=sCW7KUGIc3HUE/GqsL9BzjnT6sINFkDABF3L4NVTNMpCiVH7pENhwh6OKQKYZB2MbO
         CjMf6NICEFUuCou6SNeKlkeuiqvshvVGcVvFrIxz1zL3M/LRrF1+XVQDIzmxjh1YS3MT
         B43VjLhL7ZiuVqm9Gm+zPezFN+24EEBjkweQ0MKJgSIhhLvVFoumq5DQeSxf7ymH6HNW
         FdzJPcQ2hjawP9UTYMeFbbQCUpztJHek3Hyd0ryyG3j65Qt4BH2RYCzlbO+fXpqSFcv5
         ZVOAyNlYSLQo7tztXFvQj/SS9f/Bq8P9d+//OYRZQUY9wyJfqoiJJomD73hO1OySYycI
         RBSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6tmVV51SnSk2HYvVHQW3Mgj1F0ShkbzQvD8YUBsAymU=;
        b=IUtPXu5DXGPkiqiNFcDkcTFfj2uo+onzOj0jhe4QQczrpKVUobBtUZbD95QtZ6ejEv
         Ftr9fsluUIXJY6/yOWyqZUdy5tiPjKk9KcJ13mz/+M7CFL64nK5zu9eePReAPIqQRuVT
         ri51s6EbLHsCP/gGxFnduz+FDbuwS3TE28TQpepr2ICnmDrqwaYApfWiAKX9ROaPsYyN
         wkd2NC+XBCL9lnvhhD7S/rRPASikNbhJI8ezf80j29FEfN9QA5Uyir55qbsRvIyiAHtH
         oEPLG+cy8VFuHxJupdLG6mkOEeTwnJwH2Jkm9QAz83vcgB0JWvq5CtIQAm2kcOHDcLbu
         jy4A==
X-Gm-Message-State: APjAAAUY0gaFOa0Cd7Zh5aBEX+LlCxjG1kdm4bSuGIPeSJDl8BJCsvio
        cboVSiSSNCmqUowvhzUQN1PMGg==
X-Google-Smtp-Source: APXvYqzXup5kFh+zU7dXgRCBdDuKqJJYbpQ0F3tarAJNBFrh0YuprUsd4gWgCWKC1AjnDuI55Funqg==
X-Received: by 2002:a63:5f44:: with SMTP id t65mr23902892pgb.124.1572891176673;
        Mon, 04 Nov 2019 10:12:56 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id o12sm16149520pgl.86.2019.11.04.10.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 10:12:56 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/14] coresight: etm4x: Add support for ThunderX2
Date:   Mon,  4 Nov 2019 11:12:40 -0700
Message-Id: <20191104181251.26732-4-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191104181251.26732-1-mathieu.poirier@linaro.org>
References: <20191104181251.26732-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tanmay Vilas Kumar Jagdale <tanmay@marvell.com>

Add ETMv4 periperhal ID for Marvell's ThunderX2 chip.
This chip contains ETMv4.1 version.

Signed-off-by: Tanmay Vilas Kumar Jagdale <tanmay@marvell.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm4x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index 4cecabdd051b..8f98701cadc5 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -1529,6 +1529,7 @@ static const struct amba_id etm4_ids[] = {
 	CS_AMBA_UCI_ID(0x000f0211, uci_id_etm4),/* Qualcomm Kryo */
 	CS_AMBA_ID(0x000bb802),			/* Qualcomm Kryo 385 Cortex-A55 */
 	CS_AMBA_ID(0x000bb803),			/* Qualcomm Kryo 385 Cortex-A75 */
+	CS_AMBA_UCI_ID(0x000cc0af, uci_id_etm4),/* Marvell ThunderX2 */
 	{},
 };
 
-- 
2.17.1

