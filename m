Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 406CEC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 15:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1323D2089E
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 15:21:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x15ajMuF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389566AbfHVPVG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 11:21:06 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38731 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389553AbfHVPVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 11:21:04 -0400
Received: by mail-wm1-f67.google.com with SMTP id m125so6184183wmm.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 08:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V/3hIve56TY3nPZuccDF0XScvmoR85KKgvEdDQPL/bY=;
        b=x15ajMuFW8CBP6Ko+tieGCodba9xi+nKg0uU130qGB/0AsMLTk7urKVBk2TvKyQbsP
         8eYi066CDFpPZTv92qUgfwveDdWeg5ZvMmndvKnt3/rBYG00Ki7965Gwv/B7/KeGOUfZ
         hROJzc6XjdBGMTZY9oNeNCJdTbgDo4/5+4MNYMA+sHeLlwPL8HeFE7Zyaen/f/Y+x2Ap
         pA82W5AU+LX5cxhZwUXARXQfBIeJbnptBQVGCgcqGBaegBNZ4iXnatQuMDI5yYtN/pWU
         3beqY7Bt2PEjSNKWfieDFMdLYw+tSNxj7+9txR1qynN4PcOa2ZXJtlhlBWUwhWjry+04
         tfWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V/3hIve56TY3nPZuccDF0XScvmoR85KKgvEdDQPL/bY=;
        b=phjJK1Q4z+UV7qtKytWZkvAuWGPPxXkUg00XsEM7R3eqPt893Nv9bdVn1n5znzwzjx
         F2R+jQ/em0ecu4toFTfQdE1UgurDCyJTV1Z0kULnpKi+TuL8zzClWvucFcjjRv620oF/
         mgp+YdtjBjkIBicEUTCl/7m+lNELiJhQ1A9/zYPLJQL/jAuRNM0FwgzlC0nQNiLZSOTW
         omLxQrKUrhykBwX1t+Vh0vmUteTj+TvE4wgwu2Kxw7SRpE9W9wWVcFejIJz+jfwhbdxb
         Pulqqlw4Nlb2iEGC9BB9IZmHdhp/BClydauRyGZOZTXMH+Ex6m50COEujcpqUqvj7A2p
         rLQA==
X-Gm-Message-State: APjAAAXdflWBlcq+kGAxkXjQpkeOoc1FhqLhRrf5WBwH8GHUcpbKQtLW
        Rbq8DpHm498Sthb/vuhlOojZgg==
X-Google-Smtp-Source: APXvYqx2AJWIy5rwYlpsVlzyIWsz9lY5cwcjUoA/zzfv53V5+toUk2ADJp3ZZOKSBp9RU/RVU9wrtw==
X-Received: by 2002:a05:600c:204:: with SMTP id 4mr7433884wmi.167.1566487262553;
        Thu, 22 Aug 2019 08:21:02 -0700 (PDT)
Received: from localhost.localdomain (146-241-115-105.dyn.eolo.it. [146.241.115.105])
        by smtp.gmail.com with ESMTPSA id a19sm79833974wra.2.2019.08.22.08.21.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Aug 2019 08:21:02 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH 3/4] block, bfq: increase update frequency of inject limit
Date:   Thu, 22 Aug 2019 17:20:36 +0200
Message-Id: <20190822152037.15413-4-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190822152037.15413-1-paolo.valente@linaro.org>
References: <20190822152037.15413-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The update period of the injection limit has been tentatively set to
100 ms, to reduce fluctuations. This value however proved to cause,
occasionally, the limit to be decremented for some bfq_queue only
after the queue underwent excessive injection for a lot of time. This
commit reduces the period to 10 ms.

Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index e114282204f6..ddac93e910fa 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -2016,7 +2016,7 @@ static void bfq_add_request(struct request *rq)
 		     (bfqq->last_serv_time_ns > 0 &&
 		      bfqd->rqs_injected && bfqd->rq_in_driver > 0)) &&
 		    time_is_before_eq_jiffies(bfqq->decrease_time_jif +
-					      msecs_to_jiffies(100))) {
+					      msecs_to_jiffies(10))) {
 			bfqd->last_empty_occupied_ns = ktime_get_ns();
 			/*
 			 * Start the state machine for measuring the
-- 
2.20.1

