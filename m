Return-Path: <SRS0=Y9JJ=T2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84416C07542
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 01:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DA2C20815
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 01:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sSdwb2vE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbfEZBTe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 21:19:34 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:45795 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727622AbfEZBTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 21:19:33 -0400
Received: by mail-vk1-f196.google.com with SMTP id r23so3085713vkd.12
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2019 18:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b3q0HmTjK6ahA4s0OOAEIvrRZJfHHkbeVitRycuPpus=;
        b=sSdwb2vE3hxe2KGfBBFZ8AADbiEMIieWjiMGJoQIHG7mJc52DHR1BpLurF+JqTIrUf
         wZqZjB/I2vn5m37cue9TMKXOA2Ib8QIw+/3Aw7Eq1ZoM+ddfBNIe7qOyWh1+DJ5yzdrs
         5fb5fYe9IU4Knh++Acd3RMCuK5sej+ASBGqhbNkjkAt4PyHIUOqOJJcJ/8rCL4tZNS9G
         NMQU7MfQgIbN4oOF5Go7hzISJDST2enu3rAB5NfrqckBtlBP1ok3wqk3FCwMYWncllU2
         ZdANDDC63FG+tf7X46ZUQPUSmyHL6t4kQGQ/qD1qfmrpIf0BwjhqdfFCSgfYjCJK4cha
         YBIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b3q0HmTjK6ahA4s0OOAEIvrRZJfHHkbeVitRycuPpus=;
        b=iWo79cfHGpQF44o1bkRkpf0mL3WNe3a44dlV/anE3KowsYvwIkK8rDYopHbjrDfVdt
         M11FaeTarig4OLlVJ3hUwmvJ19UjsXTlR9rLjmgDT5CVuzvd5rkRo4bhVy/N60VE+/O2
         gwWbTSJQkaQh+5NIa1/g+kTtrjTMi1D161Fbj3iNHYfUqH3L2Vmo3EBCaH8oQ+hIIK3o
         tbYQzPGUKdTv/S7borgxSbfNmZ2jPJJnmJYW3ZMyYaVnk0B+s6Yz2IHaUp8DUKxcl7TV
         rR0iNePw3zNaEMzax28NPqtdrASSBv0toX6EjBZombgNH4hk+zD7E11y6v6eIWPhcfby
         gw5Q==
X-Gm-Message-State: APjAAAXEg8vFDeKii7OsmHKBGw2Uw3rDWBQodl9RUBlpAhj9OdDPN5Or
        W0DexSQ5mWNWSDKrzw2Fdi8=
X-Google-Smtp-Source: APXvYqzN5vYJxuBKMcm/frPuZsw9enO5mm/TxCLy6EWcMt96/+SBh6KPAmz8Es/yD0iHCVBYEYL4Jw==
X-Received: by 2002:a1f:2157:: with SMTP id h84mr12653417vkh.84.1558833572039;
        Sat, 25 May 2019 18:19:32 -0700 (PDT)
Received: from arch-01.home (c-73-132-202-198.hsd1.md.comcast.net. [73.132.202.198])
        by smtp.gmail.com with ESMTPSA id 9sm4593181vkk.43.2019.05.25.18.19.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 25 May 2019 18:19:31 -0700 (PDT)
From:   Geordan Neukum <gneukum1@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Geordan Neukum <gneukum1@gmail.com>
Subject: [PATCH 2/8] staging: kpc2000: kpc_i2c: Remove pldev from i2c_device structure
Date:   Sun, 26 May 2019 01:18:28 +0000
Message-Id: <21d8e5c3902c12d71c251d14d5b8607b5e25cf4c.1558832514.git.gneukum1@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1558832514.git.gneukum1@gmail.com>
References: <cover.1558832514.git.gneukum1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i2c_device structure contains a member used to stash a pointer to
a platform_device. The driver contains no cases of this member being
used after initialization. Remove the unnecessary struct member and
the initialization of this member in the sole instance where the
driver creates a variable of type: struct i2c_device.

Signed-off-by: Geordan Neukum <gneukum1@gmail.com>
---
 drivers/staging/kpc2000/kpc2000_i2c.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc2000_i2c.c b/drivers/staging/kpc2000/kpc2000_i2c.c
index 2c272ad8eca6..b2a9cda05f1b 100644
--- a/drivers/staging/kpc2000/kpc2000_i2c.c
+++ b/drivers/staging/kpc2000/kpc2000_i2c.c
@@ -36,7 +36,6 @@ MODULE_SOFTDEP("pre: i2c-dev");
 struct i2c_device {
 	unsigned long           smba;
 	struct i2c_adapter      adapter;
-	struct platform_device *pldev;
 	unsigned int            features;
 };
 
@@ -595,7 +594,6 @@ static int pi2c_probe(struct platform_device *pldev)
 	res = platform_get_resource(pldev, IORESOURCE_MEM, 0);
 	priv->smba = (unsigned long)ioremap_nocache(res->start, resource_size(res));
 
-	priv->pldev = pldev;
 	pldev->dev.platform_data = priv;
 
 	priv->features |= FEATURE_IDF;
-- 
2.21.0

