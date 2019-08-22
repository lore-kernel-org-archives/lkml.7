Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26366C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 15:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB077233A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 15:21:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WxubH5IM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389576AbfHVPVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 11:21:07 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34119 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727874AbfHVPVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 11:21:03 -0400
Received: by mail-wm1-f66.google.com with SMTP id e8so7328793wme.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 08:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WfflNsfWkOa6pDM4wMxWMhDSV9/CiHm7eu3wCLgDzBU=;
        b=WxubH5IM9oW568/MgT51L+h21Si3KP9c61YYF5GvYWHjdbSIuOZ/m/Eaaie57qoBBH
         V8hSlixmGOC65GsJmPd0C0vMwWXjyj//eDWScbbXZcZXMyjj6HUdLfXM0lcLyGXG8Oqx
         GJ5rTPeme/pt21MuzMB/06hQvsegWX/XIxG2MNuRJH8fRCO+IuzLj5xORN4EeKkzY48R
         4RnlHXhbuoU8FIWuXnY4575N6dAbeh1VsRMp2bxkHFnqempkE3COghjTH+usytRicBXD
         p227kQctSISa0SnIurmQfANjWM7hT0+E7Ave92JZVbMYqRwBv8syEH+nUGekI7pIrdhA
         hhxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WfflNsfWkOa6pDM4wMxWMhDSV9/CiHm7eu3wCLgDzBU=;
        b=bCfLzHjDUrg2hZ5GF5vCCI8+MdCFpNUo/XilsQfZPqapuL0GKUg3GFJpXMcpylfcJ0
         YYAZj8hlE8kzW+6k8MNQK35inaT/wM2zoQr/degqaiYlrvHGA5cPIAq77nhZP2/o9mYA
         tp2o97N6A/ZPQfu57o8gVdcz4c3vL5aSWLt06CzW1PBR0NeYTLbzqvCrg4fKAUSEWNG6
         9i3EWPjVaSTen9p7HqOSEr4hMIfignYt+8iMlXQEqA/Xhz+OPAAaum1TgN9IItw0GW5o
         yFLqOGlAYsGPV7FakWYQ/FUIlXFRjylqKX2VWi9rHW2jDYa77DaYHHZQWLE1Xiktys25
         CWwg==
X-Gm-Message-State: APjAAAWhXwP1WUTG6+cqoqcNfrIwoh0Q2pRIThjI+/QoC3TLUf/bYFC6
        iIGiTITZiRr9LP8EAk0075Bi+A==
X-Google-Smtp-Source: APXvYqzMaMgyUxed5nIeBrM7zPfQoFGPc2dhGkxbotpKunfDdfJiEfwav0xtWpFhMC6k+tofaFqNFA==
X-Received: by 2002:a1c:a70d:: with SMTP id q13mr7343210wme.26.1566487261463;
        Thu, 22 Aug 2019 08:21:01 -0700 (PDT)
Received: from localhost.localdomain (146-241-115-105.dyn.eolo.it. [146.241.115.105])
        by smtp.gmail.com with ESMTPSA id a19sm79833974wra.2.2019.08.22.08.21.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Aug 2019 08:21:01 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH 2/4] block, bfq: reduce upper bound for inject limit to max_rq_in_driver+1
Date:   Thu, 22 Aug 2019 17:20:35 +0200
Message-Id: <20190822152037.15413-3-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190822152037.15413-1-paolo.valente@linaro.org>
References: <20190822152037.15413-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Upon an increment attempt of the injection limit, the latter is
constrained not to become higher than twice the maximum number
max_rq_in_driver of I/O requests that have happened to be in service
in the drive. This high bound allows the injection limit to grow
beyond max_rq_in_driver, which may then cause max_rq_in_driver itself
to grow.

However, since the limit is incremented by only one unit at a time,
there is no need for such a high bound, and just max_rq_in_driver+1 is
enough.

Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 5a2bbd8613a8..e114282204f6 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -5805,7 +5805,7 @@ static void bfq_update_inject_limit(struct bfq_data *bfqd,
 			bfqq->inject_limit--;
 			bfqq->decrease_time_jif = jiffies;
 		} else if (tot_time_ns < threshold &&
-			   old_limit < bfqd->max_rq_in_driver<<1)
+			   old_limit <= bfqd->max_rq_in_driver)
 			bfqq->inject_limit++;
 	}
 
-- 
2.20.1

