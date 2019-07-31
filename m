Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D6D6C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 09:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 242AD208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 09:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="ohM6AEXw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728723AbfGaJmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 05:42:24 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42414 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727497AbfGaJmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 05:42:20 -0400
Received: by mail-lj1-f194.google.com with SMTP id t28so64932355lje.9
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 02:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uCrB5ySZUcR28Rx9lWPqtsy+QKHPyb7HykwAFaRFqlU=;
        b=ohM6AEXwlJ8JvsmmDKw7ZGh4xVhzDWdJplwFu7vnXSndsSC3nHaIVCeKCraa7czupb
         j9MK5E4NpZf7yMl2Xy6hDqpSOyyWMdmE+ejqsEo4Ud4xqfl4tDK7qrWsBZJC6KOldfmO
         j0kCSWCQORgN1gRrrcFRZ8IYDt0l6t1fIE3BQhKCL1+FeigsAwQVMHyxfN3r0OTiJVHr
         XSwHg08zBqZJ51gjqwARIziUHDj3P746h1qPfUAYDtFn0Fs0lO7uEaRyGG/Zrq/h8QeT
         KyhkFuMxeEBWGJEDwwRPqKcmTSoVwfuVJi+13RiBAMfX+sw/5g+8zqhEYP7YvKVRbNOp
         Y6uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uCrB5ySZUcR28Rx9lWPqtsy+QKHPyb7HykwAFaRFqlU=;
        b=ovIogE0F+SeSSLrhsxOP0qg1QoxyFk9wf7GWOJ9pkWpUW/1ykCRBT0okhf/rSiSieo
         Q8+aHNBDnSLs+lLYqPQSG+dqQoR+dU6+t7UZHwlVI6bW1VWuP3hGe3l+mZG3It0M8Ubx
         HDH8kdGPlCp8W91LoGJ1H0sgcVEbnhvlrIay0n8vEscAsIkKUCw+1yo5gSuyzP3Htvqf
         wYiFhIHAhbxOYZZy2fmxvnvrDdzMxfkKLN9so9W/m9+/DPjRrtfu0IdQfe15m1Du7LFV
         KLL+Odm4uppiNLwlNbwVdcoPofF9FIP89weODl0gDR0vs9a6KI/LUKxThdo8LKtMyBHy
         8qVg==
X-Gm-Message-State: APjAAAWkp7DqR1HKxbfTpolQbTJxT8pPh4XQCp8ObvkZWOaf/Oopq1mV
        7FiLCU7sjh5Mm17/JW5en8o=
X-Google-Smtp-Source: APXvYqyBegkSyiU4m9zufYeMcW3WRboBF6uzdFMkPzmlZiDBXYx7+7BVn4rE8c+1CuTM7jKd+LIGOQ==
X-Received: by 2002:a2e:89c8:: with SMTP id c8mr64670727ljk.70.1564566138274;
        Wed, 31 Jul 2019 02:42:18 -0700 (PDT)
Received: from titan.lan (90-230-197-193-no86.tbcn.telia.com. [90.230.197.193])
        by smtp.gmail.com with ESMTPSA id t4sm15408200ljh.9.2019.07.31.02.42.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 31 Jul 2019 02:42:17 -0700 (PDT)
From:   Hans Holmberg <hans@owltronix.com>
To:     Matias Bjorling <mb@lightnvm.io>
Cc:     Christoph Hellwig <hch@lst.de>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Holmberg <hans@owltronix.com>
Subject: [PATCH 4/4] block: stop exporting bio_map_kern
Date:   Wed, 31 Jul 2019 11:41:36 +0200
Message-Id: <1564566096-28756-5-git-send-email-hans@owltronix.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1564566096-28756-1-git-send-email-hans@owltronix.com>
References: <1564566096-28756-1-git-send-email-hans@owltronix.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that there no module users left of bio_map_kern, stop
exporting the symbol.

Signed-off-by: Hans Holmberg <hans@owltronix.com>
---
 block/bio.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index 299a0e7651ec..96ca0b4e73bb 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1521,7 +1521,6 @@ struct bio *bio_map_kern(struct request_queue *q, void *data, unsigned int len,
 	bio->bi_end_io = bio_map_kern_endio;
 	return bio;
 }
-EXPORT_SYMBOL(bio_map_kern);
 
 static void bio_copy_kern_endio(struct bio *bio)
 {
-- 
2.7.4

