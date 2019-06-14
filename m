Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F85EC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 20:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D07472168B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 20:57:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GNCpS1E6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfFNU5G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 16:57:06 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:37432 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbfFNU5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 16:57:04 -0400
Received: by mail-io1-f67.google.com with SMTP id e5so8760271iok.4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 13:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vaLAv5uruC5N6GIJ3Ca+8odIT2de0GG0bR3H9unYxL4=;
        b=GNCpS1E66AyuJe0Or3YiOv6+a9iHoG5xGdE66eguUBk7a9hLaJA/F13zGHovn9T5fC
         whMbluwtNnf1Q2pdiN5ku86DpBxH06YhVzzbuHJ3dGYZMv+Z+Sl3OiIbH7spq0gEBmhU
         rrhBEkEjDSLJbUtCyD/6vy8Z94ejmgQ5ywGH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vaLAv5uruC5N6GIJ3Ca+8odIT2de0GG0bR3H9unYxL4=;
        b=VW4K/URKofYkLhiyRR453u90cZkU8/CtKo3aexAy7kGFNXI5cnT9jz2sAqYVpMzWja
         P1REtQqMyc2irA6UWf+BpFDWhldylOPU9FZ91lnciZersrmEaaaA/XzmT6SWfDRUYDmw
         MRtgKx87AVsDktMStamASMHS0JwgFqfuKnuk/D9TJ3TeQSCCTKpxtZZfYMCOgzebp1kd
         h+CPuUFte/bhcu4SM/gcd/+NWRvklsFbvaK+4M5pacacM1S/8MEyK3WBZkXQJtAo6L5b
         /Qif9Cg2CjoD4flO0ns3DGJn50Eslg6503r7gZPnhlP2bu0CDPEM5jJpSHACy5tLEqXa
         /lDw==
X-Gm-Message-State: APjAAAUXIdXj5gixWW9Crl6HgXJCdXAY8DtnuMHp5AFSm0JY3MwIvG7L
        3YvrjK0ci8s9g9E0nNvtK/i/eRDxgoksrg==
X-Google-Smtp-Source: APXvYqziCB1jl/0OOKv2p0Rq2UwHLDLX++1BYErohBUejPufwSfA6j1vkm6yv72PpEvetN+I3vSHNg==
X-Received: by 2002:a5d:8747:: with SMTP id k7mr10329058iol.20.1560545823769;
        Fri, 14 Jun 2019 13:57:03 -0700 (PDT)
Received: from ncrews2.bld.corp.google.com ([2620:15c:183:200:cb43:2cd4:65f5:5c84])
        by smtp.gmail.com with ESMTPSA id e22sm2947351iob.66.2019.06.14.13.57.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 14 Jun 2019 13:57:03 -0700 (PDT)
From:   Nick Crews <ncrews@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org
Cc:     linux-kernel@vger.kernel.org, dlaurie@chromium.org,
        djkurtz@chromium.org, dtor@google.com, sjg@chromium.org,
        kernel-janitors@vger.kernel.org, dan.carpenter@oracle.com,
        Nick Crews <ncrews@chromium.org>
Subject: [PATCH 1/2] platform/chrome: wilco_ec: Fix unreleased lock in event_read()
Date:   Fri, 14 Jun 2019 14:56:31 -0600
Message-Id: <20190614205631.90222-1-ncrews@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When copying an event to userspace failed, the event queue
lock was never released. This fixes that.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Nick Crews <ncrews@chromium.org>
---
 drivers/platform/chrome/wilco_ec/event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/wilco_ec/event.c b/drivers/platform/chrome/wilco_ec/event.c
index 4d2776f77dbd..1eed55681598 100644
--- a/drivers/platform/chrome/wilco_ec/event.c
+++ b/drivers/platform/chrome/wilco_ec/event.c
@@ -342,7 +342,7 @@ static ssize_t event_read(struct file *filp, char __user *buf, size_t count,
 				 struct ec_event_entry, list);
 	n_bytes_written = entry->size;
 	if (copy_to_user(buf, &entry->event, n_bytes_written))
-		return -EFAULT;
+		n_bytes_written = -EFAULT;
 	list_del(&entry->list);
 	kfree(entry);
 	dev_data->num_events--;
-- 
2.20.1

