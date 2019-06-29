Return-Path: <SRS0=Dr8o=U4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB811C5B577
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 19:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE18D214DA
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 19:10:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t248GpiW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbfF2TKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Jun 2019 15:10:43 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38895 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbfF2TKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 15:10:42 -0400
Received: by mail-pf1-f193.google.com with SMTP id y15so4576692pfn.5
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2019 12:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=4Z+5F7GZWV6rxZhVeShHNbtKUyddpMRHWbu6DiZ08GA=;
        b=t248GpiWEmIRFs5MIDUs+28DYxiAWNjP36UII3qCngr8Lf/syn0fZAZ0UH8nbam4rd
         TjCM32w8LJE7r79g+I52LK04219ZMIgNP3w65LpHElwSzufsI/e8V4Z7/Bu/BB893+1R
         VWPqOn2Nl9CrcKcemUNvzZteLZwmrdkgwaDkh5nzp3UCHnnrH0+q5H9EscAaBqFEZcOU
         /U60CVJv558id4b75Ve1a6kbWvOlxfguuCdmye61wy95gFfOsN5fiNN+xJnH83tCwEN2
         axCrWWvXsqULG9BPJrP5d4Cx571lX6hEduLtpPGvc+JtCjr2rJu8s+zRZPt9eQ/wQE1g
         srKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=4Z+5F7GZWV6rxZhVeShHNbtKUyddpMRHWbu6DiZ08GA=;
        b=ISojh90Xp7S2AEHKNLRE+HqQaSSvuDyP+rVlcsOGJMea1Z7LB5eIeKPUDy7dGHwYh5
         aEfsioT8PMDww9xancJTomngeJ44nAwPcAYBPf6sW37zJvcdCkFid8xmtFQZSYuo9W98
         2nCHhlUQjQSKst4e8vxxgw5hmFbvLPIzB/zq8ZPJnOPBnNu7FH5TcMMUsEZnQDC73G7j
         wYL/L/VN2ayAJ08itPiFS679VpiJ/f4zlztJv+M3h/GITd2fFCXKWZP3anIPPMk8EeZO
         Mu98GlJQ3Kd6+FyOtlCh1e6bvYPJsVFgOJLbibYkqDNCO0L2VRcJaQnFU7jtjNZLj+8t
         oZrw==
X-Gm-Message-State: APjAAAVnsDGz5uniaXK3SqHylBbB7pJukzkiMrkWvR1H2cg1mnj+jbxi
        MGzPYj4mFmw5Ae8QOGEj984=
X-Google-Smtp-Source: APXvYqzfNPzemt4/vzbiZ1Eq4EiPFQlnvLf9LygcvLhrFA5WGnR01TsCMLQ4uYmsJc+7L83UkaNR0A==
X-Received: by 2002:a17:90a:1ae2:: with SMTP id p89mr19823864pjp.26.1561835441671;
        Sat, 29 Jun 2019 12:10:41 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.187])
        by smtp.gmail.com with ESMTPSA id s5sm5706805pgj.60.2019.06.29.12.10.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Jun 2019 12:10:40 -0700 (PDT)
Date:   Sun, 30 Jun 2019 00:40:35 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bhagyashri Dighole <digholebhagyashri@gmail.com>,
        Wentao Cai <etsai042@gmail.com>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Ivan Safonov <insafonov@gmail.com>,
        Alexander Duyck <alexander.h.duyck@intel.com>,
        Himadri Pandya <himadri18.07@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: netlogic: Change GFP_ATOMIC to GFP_KERNEL
Message-ID: <20190629191035.GA15292@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Below is data path of xlr_config_spill
xlr_net_probe
  -->xlr_config_fifo_spill_area
  --->xlr_config_spill

We can use GFP_KERNEL as this function is getting called from
xlr_net_probe and there are no locks.

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/staging/netlogic/xlr_net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/netlogic/xlr_net.c b/drivers/staging/netlogic/xlr_net.c
index 07a06c5..05079f7 100644
--- a/drivers/staging/netlogic/xlr_net.c
+++ b/drivers/staging/netlogic/xlr_net.c
@@ -385,7 +385,7 @@ static void *xlr_config_spill(struct xlr_net_priv *priv, int reg_start_0,
 
 	base = priv->base_addr;
 	spill_size = size;
-	spill = kmalloc(spill_size + SMP_CACHE_BYTES, GFP_ATOMIC);
+	spill = kmalloc(spill_size + SMP_CACHE_BYTES, GFP_KERNEL);
 	if (!spill)
 		return ZERO_SIZE_PTR;
 
-- 
2.7.4

