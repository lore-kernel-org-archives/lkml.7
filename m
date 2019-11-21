Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F100DC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 08:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C631B20855
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 08:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="XqOdQRqr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbfKUIPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 03:15:11 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41186 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbfKUIPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 03:15:08 -0500
Received: by mail-wr1-f67.google.com with SMTP id b18so3172199wrj.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 00:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PWu78UINgvkRWlyy7C2l33u4Ab0VHrEoRAcLucw18qk=;
        b=XqOdQRqr10yWN+dWU90C3TOiiM7U+afUg5RoCUD9mrhxJ1chH1NB1cHYSxBuOAECJW
         FNsZkI594sRUM9YOwxkKlrZSOZ1DWPa4TJH/8c/8UhKxOIqlY94ZnZ0bv2P08b2SEgtt
         4uROj1VyG+qDB4rfkZKxIqfSHMUS1PaT82DZj0PNxKvmOU7n8NUyMSmLO6hw6IZa6p8a
         t0MzYI/aEdjlZriIJFmuVu2xI/k2B+xqPkOoNey2HytPq+CDNOM/rghrPKhC+rbEJeIo
         KXnYygs0HWRYuJFqMX32jbpkOjrkDhlf1Dg0YebmPya8KmjBXPshBqZMwJbng6uzcAZu
         ukqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PWu78UINgvkRWlyy7C2l33u4Ab0VHrEoRAcLucw18qk=;
        b=Nxf2dPxOGHgzIYekR0mQMfDaee7Me8fGjLRss7lI8cdlPZiIwBxL+/0E6isehsSo9f
         xmWUQ5saTyfQJWrJywLbvIJyPXIyvRS5dFbp7AFxT18k7FZ4DWvpjIJguZoddYJ6MOVf
         gxYCcE/TVSAGW7E0mkUTmbIAtLPo1EpeMYj5mti9YUAax11oAoryd5vI52sg+CsJN1sH
         Lehy1bHum0NRsK0JkfpmApTcohR6ZeOtn/VVnTUvxud1EgI6RBCvlNXmKHPlnz452NvT
         F7Z6E08SFZl7JhCsmoYPCpMLCM+8kKNfZdtPDK7Q1h2A1yhiPU1ZBgziK4GVlLRVyjUR
         6yTQ==
X-Gm-Message-State: APjAAAVwxPElOkYdOpXAMAohz/Dy75FqqzxbeCG5GQGmNnBAjuQntAAQ
        nC0sVWaZ8ddu8gRujI68cwtpXw==
X-Google-Smtp-Source: APXvYqxdYs0ZCbj2Oo3SWAIgbzvdDddpJsbWDdSZQ+EtdgnmJT1X2EeAckZD4HKkVNYhYfEZuzV4sg==
X-Received: by 2002:adf:f150:: with SMTP id y16mr561679wro.192.1574324106029;
        Thu, 21 Nov 2019 00:15:06 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id w13sm2315075wrm.8.2019.11.21.00.15.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 21 Nov 2019 00:15:05 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     airlied@redhat.com, airlied@linux.ie, arnd@arndb.de,
        fenghua.yu@intel.com, gregkh@linuxfoundation.org,
        tony.luck@intel.com
Cc:     linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v2 3/5] agp: remove unused variable num_segments
Date:   Thu, 21 Nov 2019 08:14:43 +0000
Message-Id: <1574324085-4338-4-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574324085-4338-1-git-send-email-clabbe@baylibre.com>
References: <1574324085-4338-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fix the following build warning:
warning: variable 'num_segments' set but not used [-Wunused-but-set-variable]

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/char/agp/frontend.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/char/agp/frontend.c b/drivers/char/agp/frontend.c
index f6955888e676..47098648502d 100644
--- a/drivers/char/agp/frontend.c
+++ b/drivers/char/agp/frontend.c
@@ -102,14 +102,13 @@ agp_segment_priv *agp_find_seg_in_client(const struct agp_client *client,
 					    int size, pgprot_t page_prot)
 {
 	struct agp_segment_priv *seg;
-	int num_segments, i;
+	int i;
 	off_t pg_start;
 	size_t pg_count;
 
 	pg_start = offset / 4096;
 	pg_count = size / 4096;
 	seg = *(client->segments);
-	num_segments = client->num_segments;
 
 	for (i = 0; i < client->num_segments; i++) {
 		if ((seg[i].pg_start == pg_start) &&
-- 
2.23.0

