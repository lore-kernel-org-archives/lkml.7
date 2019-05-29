Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1920DC04AB6
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 01:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD1B0216FD
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 01:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCodE0k1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbfE2Bdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 21:33:38 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38710 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfE2Bdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 21:33:37 -0400
Received: by mail-pg1-f193.google.com with SMTP id v11so307011pgl.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 18:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=zKrr4VP4HF8/3gxRsVG1U8oxmyUqmlQMzF2rdcl+ZUM=;
        b=fCodE0k1SR/XgnrXwksZ/0NgsCpj7/T3qew3IBA9J/yxjzYxeyS9vTXtiaCyi17Pju
         nMAJAz/T6F6KbEodURtPN+bvEVMPnyd3ofqkUwrqM7Mb+qj2HxUMosooMW93nCWtkF0F
         USPZMB13X14sL75tYkeeqMsfZ6jZrG0YPVJElRNzfPI7d0gtAjcxLtydQn+zGAmUKKrk
         mA3sQuIuK8iM5LdXbvbj8r7ohMC9CEvOW1M+RvIVkFPti5TnNnq5wksXC5gX0kuAl96W
         zDMUn1be8VFlWVppg75/cEJ5VY/DDJO4Z0vd6onGf2N9R02DcgziwRutZcUsmT+H9ZUy
         n8ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=zKrr4VP4HF8/3gxRsVG1U8oxmyUqmlQMzF2rdcl+ZUM=;
        b=Qe1mbo1XdprIwAVKaI6EOTLOejI54C/bL4RLSzCb6FUpa697ZuwOa+/Y1OyQR2GIxB
         tzHqdBe/lY1rDUQUF8x/ERZN2NyQJAaK0zIY8LKdQ0fUrc7bAZXo5iIU2UF6r/QFZyw0
         GGfYW4ZhVlKtQf27/p5U8KzLly4E210uY/UYErBawVkRB+8X/9YIRFcNjJH5lBO9DfQU
         Wju1ZXYuhI0JLtWuEkmt//PbbTB/xDsI8HqxC6mL7m03LS8YPU2dh+aSDMUK2VvrOYD+
         1wJ27nSDJa+aeJ9nkCVxr5s5m94cFVPY5EKHp15YPVxs2XNAGKufTEuOtoHCJaYqmri8
         hiSg==
X-Gm-Message-State: APjAAAVYgD/YXP8lo+ihUPTVj41SCefJQctJzScdEcCEW0W88qu9O9PU
        xoEfUjEH61J34IrcaNBeNXy0TlI0
X-Google-Smtp-Source: APXvYqzjPYA3TCWsvkoDa9t1uozb9hmBqywF2OndUSgMrFkdKfbQ5TGa8smbi6UBhouA2hDLcUae0g==
X-Received: by 2002:a63:520a:: with SMTP id g10mr10490754pgb.136.1559093617233;
        Tue, 28 May 2019 18:33:37 -0700 (PDT)
Received: from zhanggen-UX430UQ ([66.42.35.75])
        by smtp.gmail.com with ESMTPSA id k6sm15981806pfi.86.2019.05.28.18.33.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 18:33:36 -0700 (PDT)
Date:   Wed, 29 May 2019 09:33:20 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] dm-init: fix 2 incorrect use of kstrndup()
Message-ID: <20190529013320.GA3307@zhanggen-UX430UQ>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In drivers/md/dm-init.c, kstrndup() is incorrectly used twice.

It should be: char *kstrndup(const char *s, size_t max, gfp_t gfp);

Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
---
diff --git a/drivers/md/dm-init.c b/drivers/md/dm-init.c
index 352e803..526e261 100644
--- a/drivers/md/dm-init.c
+++ b/drivers/md/dm-init.c
@@ -140,8 +140,8 @@ static char __init *dm_parse_table_entry(struct dm_device *dev, char *str)
 		return ERR_PTR(-EINVAL);
 	}
 	/* target_args */
-	dev->target_args_array[n] = kstrndup(field[3], GFP_KERNEL,
-					     DM_MAX_STR_SIZE);
+	dev->target_args_array[n] = kstrndup(field[3], DM_MAX_STR_SIZE,
+						GFP_KERNEL);
 	if (!dev->target_args_array[n])
 		return ERR_PTR(-ENOMEM);
 
@@ -275,7 +275,7 @@ static int __init dm_init_init(void)
 		DMERR("Argument is too big. Limit is %d\n", DM_MAX_STR_SIZE);
 		return -EINVAL;
 	}
-	str = kstrndup(create, GFP_KERNEL, DM_MAX_STR_SIZE);
+	str = kstrndup(create, DM_MAX_STR_SIZE, GFP_KERNEL);
 	if (!str)
 		return -ENOMEM;
 
---
