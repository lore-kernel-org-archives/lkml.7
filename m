Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4AA9C3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 17:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FDCC2080C
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 17:58:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rKB8xGjq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728815AbfHYR6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 13:58:54 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39054 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbfHYR6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 13:58:53 -0400
Received: by mail-pf1-f195.google.com with SMTP id y200so2397850pfb.6
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2019 10:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=AUReMEj+OWI7uTCmSw4KZpSaGrKQiydQlLo7sRyzOyI=;
        b=rKB8xGjqgcOq1wbh46xt0gd91xRKZAJQmmV26JCj+kJPySYK7hQkJqg99P2MNtKFnV
         vYwDo53vblu5MJHouWyTa0CmT9MmXwswtyQhrqbai1AgAYCOyyIduNA4SUrxrLERUKcO
         IPcTMdgoiQnfgbJLD1uFU+8FO2SA/XIGT3hHlN+pCf4Ylc1hLsaRtldZG4Qt9VMR6F5q
         VOa9IpZS3aINxBLupLqqNE64APc+CMF3n2NU06iqzUqPS1IJjy+i/uXzh+Mn8eo8rEk5
         fXb3pA2Kj9j0GxSKw0oeDx+5w7THwrJIG6emSNw3+zdo6SMvInxXcCCsaZnUbfaD+F4u
         oTSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=AUReMEj+OWI7uTCmSw4KZpSaGrKQiydQlLo7sRyzOyI=;
        b=UKRWNjcaC52UV91cq9WxvhInlS/P+gBiM1OUApcGAhys6tGMAT8dLV/lyzVw7js2WR
         JZOLDjcynqPAqNsDqEu9hQdX8RdKSE8erN+0VIEyhuGvT6I97ixDdQMy9l0rIdDPmwsn
         OVqvz2kUexGjyPcYj5DdAZ+WQHwogUPgJMpEbQtJdAQQnkv0t5doX4METhFvq8zFNH0z
         LBBmWxQbY+bJaVcJ8vDO7dzrn10JMKWmjLYfHZTuKXGFvTbDubfbLn/4d/2Yk70MN2b/
         nhY0s3XD/PSK0WtmA8/dV83vHUft0Nukhzlfguag3M9tLoTn08Sbllltz7/PuqeeAuFi
         XDVw==
X-Gm-Message-State: APjAAAUk2+FrWM3AA6Crvh686bGpS5wzsP+oDeqdsR5nsOBjHq+atRJ9
        d/ww/9QTj/eBy9FM6JweVw==
X-Google-Smtp-Source: APXvYqzZjtpwNGnlCP86552/rOEvaIwNoEyT9S8H3LCLyJ8Mck9/aaViEjR7fPNiAIsnev7/SAXdhw==
X-Received: by 2002:a63:4404:: with SMTP id r4mr12728454pga.245.1566755933156;
        Sun, 25 Aug 2019 10:58:53 -0700 (PDT)
Received: from MarkdeMacBook-Pro.local (114-32-231-59.HINET-IP.hinet.net. [114.32.231.59])
        by smtp.gmail.com with ESMTPSA id 4sm8881965pfn.118.2019.08.25.10.58.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Aug 2019 10:58:52 -0700 (PDT)
Date:   Mon, 26 Aug 2019 01:58:49 +0800
From:   Peikan Tsai <peikantsai@gmail.com>
To:     gregkh@linuxfoundation.org, christian.gromm@microchip.com,
        gustavo@embeddedor.com, suzuki.poulose@arm.com,
        colin.king@canonical.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: most-core: Fix checkpatch warnings
Message-ID: <20190825175849.GA74586@MarkdeMacBook-Pro.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch solves the following checkpatch.pl's messages in drivers/staging/most/core.c.

WARNING: line over 80 characters
+			return snprintf(buf, PAGE_SIZE, "%s", ch_data_type[i].name);

CHECK: Please use a blank line after function/struct/union/enum declarations
+}
+/**

Signed-off-by: Peikan Tsai <peikantsai@gmail.com>
---
 drivers/staging/most/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/most/core.c b/drivers/staging/most/core.c
index b9841adb7181..8e9a0b67c6ed 100644
--- a/drivers/staging/most/core.c
+++ b/drivers/staging/most/core.c
@@ -303,7 +303,8 @@ static ssize_t set_datatype_show(struct device *dev,
 
 	for (i = 0; i < ARRAY_SIZE(ch_data_type); i++) {
 		if (c->cfg.data_type & ch_data_type[i].most_ch_data_type)
-			return snprintf(buf, PAGE_SIZE, "%s", ch_data_type[i].name);
+			return snprintf(buf, PAGE_SIZE, "%s",
+					ch_data_type[i].name);
 	}
 	return snprintf(buf, PAGE_SIZE, "unconfigured\n");
 }
@@ -721,6 +722,7 @@ int most_add_link(char *mdev, char *mdev_ch, char *comp_name, char *link_name,
 
 	return link_channel_to_component(c, comp, link_name, comp_param);
 }
+
 /**
  * remove_link_store - store function for remove_link attribute
  * @drv: device driver
-- 
2.13.1

