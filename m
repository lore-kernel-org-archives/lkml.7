Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C476C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 22:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5961A216F4
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 22:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GbTjz/2s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbfHFWpq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 18:45:46 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35785 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbfHFWpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 18:45:45 -0400
Received: by mail-lj1-f193.google.com with SMTP id x25so83691828ljh.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 15:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=yFlcIGmAU2Q+uytclp71VZt3u5YOqHJodYGg72mUCzc=;
        b=GbTjz/2s4NjsyNf0XtwpIGx2XV/fhtcfMSKIKlRJXkD9uQ5mQ9ip7LHSp5MrQDSHT2
         9H/vZ9roGFqPllWoYovJJRa2aOtFjhsPn9Iw0pWUW1ZMVPfk9U//Ju8G/l9ovKsbufzw
         q2wrMMGsHQ2w/MUQavcj7lKXuvcx6eitC4HKg3t7C7rlYZzovmqS49rkgQ/esrqfnDVw
         eezHif8/em/bku2sgVbKe1P/SCNc7B0DBllLUk87nFP6btrR4iLrw8zILBq4PP0IJrY3
         LT3JoHgVDe597SQVwij/Fx9Mu4spKfE9Qcfen+HJUIyptPt55p48MZm3sA5kvjY5UYGY
         hK0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yFlcIGmAU2Q+uytclp71VZt3u5YOqHJodYGg72mUCzc=;
        b=R2gfEozw2LZW+RNYwRUuBEaocdl4XIbDe/YDCglDZpbzCNqgnDj3FymMZ18dxRkAOP
         t/sYXZO0Qf40Ve8byhMbI2lsTcrxP+34Zd8vbDChY4M1mKU3agtzHQxQ9oY+62WgyLJ1
         zXbVXIHxAc+Z66ApZMSLD6T0kFuyHVh54R2gZv2hSXcdhYmMCJTHBNxIoq4ERIqT2hJR
         PBgs9XUuIcym4+lcVp9C/15MuLIJSF60ZIo7yfJvClCzFr8P9bK84E7ugF7V3F/LL1/3
         7P0tGQ5W5S92PHnFevFkoyCBWRgQbPMZJTY7t2wDx0Ee0TVwiLUKPWuRO2AyO5tTWZVb
         nh+Q==
X-Gm-Message-State: APjAAAWs8PTwVhnMIe3Md+CbcXoxy6zTVThJvxd5r50WJIa7vkJ5sMOx
        nz/6AR0mUFEVnHNj7XK7LTkHNQ==
X-Google-Smtp-Source: APXvYqzv5v+UvSduzIqq3jgfq6+g5eZaOOBvLM0FzCtbv2aLfiIX6ycIMkVZq1lfC5ch9/jKKSToMg==
X-Received: by 2002:a2e:96d5:: with SMTP id d21mr3024100ljj.170.1565131543482;
        Tue, 06 Aug 2019 15:45:43 -0700 (PDT)
Received: from localhost.localdomain (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id j30sm2540507lfk.48.2019.08.06.15.45.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 15:45:42 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     vinicius.gomes@intel.com, davem@davemloft.net
Cc:     jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH v2] net: sched: sch_taprio: fix memleak in error path for sched list parse
Date:   Wed,  7 Aug 2019 01:45:40 +0300
Message-Id: <20190806224540.24912-1-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In error case, all entries should be freed from the sched list
before deleting it. For simplicity use rcu way.

Fixes: 5a781ccbd19e46 ("tc: Add support for configuring the taprio scheduler")
Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 net/sched/sch_taprio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index c39db507ba3f..e25d414ae12f 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -1195,7 +1195,8 @@ static int taprio_change(struct Qdisc *sch, struct nlattr *opt,
 	spin_unlock_bh(qdisc_lock(sch));
 
 free_sched:
-	kfree(new_admin);
+	if (new_admin)
+		call_rcu(&new_admin->rcu, taprio_free_sched_cb);
 
 	return err;
 }
-- 
2.17.1

