Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D81C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 13:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46D7320717
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 13:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRnwFo6B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbfLPNO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 08:14:28 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54353 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727847AbfLPNO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 08:14:27 -0500
Received: by mail-wm1-f66.google.com with SMTP id b19so6666906wmj.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 05:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YCtc4aC4feTs8GDi5Ak3Mqtw6YBY2okUGhT9QJAgeDo=;
        b=KRnwFo6Bpxb3OwOpnqR1bobnvU1EJlPqDXBYED0wOYU9sCr2oZ7MDO+9WIS7/evhWW
         W2HOVN0BfzT4KcmZscQIq+VropJDKKkdKd+CFMaXExih9uEIb+zzKByaeVleZUyYjo2C
         ZcaaOLA9MvPteZXFOZmImoi0jGyP0HtG+yzX5V+T41sv5eK9J8VL/xfCa+QWSkUQpXL/
         4tk5esBXR3XN8ikPOC9FGpOSA0PJ94KEWcO8ooseecXSzDwMp3r5tcyMUeizPZ//0yWd
         iCmG3pUPYGyEBhRO6RLJLSIS1ycA9pCX5bE6tPUx8bEwzCOTzb3U87M2CoRF4Kyll+1W
         nIsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YCtc4aC4feTs8GDi5Ak3Mqtw6YBY2okUGhT9QJAgeDo=;
        b=QJMGpIBeKE/L8C/35G7Sx+Yq/NRLXoUwR24xdRx0e9ucp30BSczlW3zy3wI9rWSCxk
         PAma9VcDNr4UPeVA+mcDWHUZ4x2dK0RLoP309yRhU4q26B2MlhioTi6R+om0PoeE9ngr
         eOIUKgU0RxWfYyWjMU80Hgsb6zhuwTOJ8o/XXxF1XlhJPtfqGxhK1s42raN5rd2eUbFH
         9IfVb6UWcArTQ0oxlynvSbBo4kjAznvh74Y0JIIwVh3nrMjQhA2jOXwhDZ7L6Zn40USH
         glB8yg5NuCQN7CkFCgHgLaqWPtJw9dqi6flpRYfmqn5YTEu1yt3ELm0p8fFuMP9enaCj
         5htQ==
X-Gm-Message-State: APjAAAXA5gXwtErLUMyZPrlxyHj11ELJ3jZd5eaMmYxr+ghnenS9JT7T
        pQ/cDhXSyj6BGvTF/7aspw==
X-Google-Smtp-Source: APXvYqyYdmkZfbhXjiqoJwbM3J1JjBL5wUKkU/a2TDTuhwIKBy04mKdnlZkMwkTujntAhgNRiQOGPg==
X-Received: by 2002:a1c:488a:: with SMTP id v132mr29041455wma.153.1576502065668;
        Mon, 16 Dec 2019 05:14:25 -0800 (PST)
Received: from ninjahub.lan (host-92-15-174-53.as43234.net. [92.15.174.53])
        by smtp.googlemail.com with ESMTPSA id n67sm21554029wmb.8.2019.12.16.05.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 05:14:25 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     bokun.feng@gmail.com
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, Jules Irenge <jbi.octave@gmail.com>
Subject: [PATCH v2] kernel: events: add releases() annotation
Date:   Mon, 16 Dec 2019 13:14:15 +0000
Message-Id: <20191216131415.23508-1-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add releases() annotation to remove issue detected by sparse tool.
warning: context imbalance in perf_output_end() - unexpected unlock

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
Change
Added RCU as an argument in the releases() annotation

 kernel/events/ring_buffer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 7ffd5c763f93..3381e70fb0f5 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -295,6 +295,7 @@ unsigned int perf_output_skip(struct perf_output_handle *handle,
 }
 
 void perf_output_end(struct perf_output_handle *handle)
+	__releases(RCU)
 {
 	perf_output_put_handle(handle);
 	rcu_read_unlock();
-- 
2.23.0

