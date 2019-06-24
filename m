Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B38AFC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 19:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FCE420663
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 19:01:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="U0oLeFIh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729863AbfFXTBa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 15:01:30 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:40870 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbfFXTB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 15:01:29 -0400
Received: by mail-io1-f67.google.com with SMTP id n5so4523834ioc.7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 12:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vaLAv5uruC5N6GIJ3Ca+8odIT2de0GG0bR3H9unYxL4=;
        b=U0oLeFIheqRkMaEDOA7ytntbjmAbd7b/ZvXK9QB17ojsD1bnHJimSSiJPNfZdF0lcu
         bQBXC6gmBJG147ncDrZzV76gmcDtZOfUG3wankkay8U/d/i6vE2jh5suu3A3YgoK/FoO
         CNqIpqNB3MqPg13DyW9IJakTWthuii4a+EvIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vaLAv5uruC5N6GIJ3Ca+8odIT2de0GG0bR3H9unYxL4=;
        b=O6eWrwjV0KJ0i/XYEpp8+/GSxfThqX7XL3sUE5o88oDvECSMhIn4331lBbi+G3BrzE
         Q6EGRVNa7zeGp+BUIOAzrDNls0Nx0u/iue2E6OjgkmKFga4u6e1xde4MbaU4V47W/9wj
         NYv0Jm42lEb6mYE1m8QcsEl6Yqefr0ZWQxIGTiLMhtWxzRDL/OgMdWE/DmFRKRlma4n0
         wzTrD8eghFfWd/H4VRk0sCn1SisxrHl9acVn2Tsn0WyZivwT9Pt4peg2Hn/zB0dC2/hg
         3kcmbv8jAq+KrF3ceFZrJO2oWE6rsLANahhdVjmkF/L7g+rpdtO0u5Mz2N10kUketj59
         uOOQ==
X-Gm-Message-State: APjAAAU355SnfUikrm/XM3WP5k54JOdAdt5NVcwF+P7OwBA+CxF+pTSV
        OxwGdTlCadJ1PuhfddxcD+idxg==
X-Google-Smtp-Source: APXvYqxeFZ2DuzMyCo/FkqOBaG6DyhR5EthZVkIKPGiAh0uomSOuKADzGpO6gIKGDrxbiNxU78fifw==
X-Received: by 2002:a5d:948a:: with SMTP id v10mr16481899ioj.103.1561402888853;
        Mon, 24 Jun 2019 12:01:28 -0700 (PDT)
Received: from ncrews2.bld.corp.google.com ([2620:15c:183:200:cb43:2cd4:65f5:5c84])
        by smtp.gmail.com with ESMTPSA id n17sm12577120iog.63.2019.06.24.12.01.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 24 Jun 2019 12:01:28 -0700 (PDT)
From:   Nick Crews <ncrews@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org
Cc:     linux-kernel@vger.kernel.org, dlaurie@chromium.org,
        djkurtz@chromium.org, dtor@google.com, sjg@chromium.org,
        yuehaibing@huawei.com, colin.king@canonical.com,
        dan.carpenter@oracle.com, Nick Crews <ncrews@chromium.org>
Subject: [PATCH v2 1/2] platform/chrome: wilco_ec: Fix unreleased lock in event_read()
Date:   Mon, 24 Jun 2019 13:00:40 -0600
Message-Id: <20190624190040.132120-1-ncrews@chromium.org>
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

