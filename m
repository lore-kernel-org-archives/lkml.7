Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D850C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 09:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11C49255DA
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 09:05:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lpB1Jkw2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbfE3JFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 05:05:06 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33295 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbfE3JFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 05:05:05 -0400
Received: by mail-pg1-f196.google.com with SMTP id h17so1658229pgv.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 02:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=WB3NAADDilR+pQagX0XJnxPLeHo0i5e2Cuu9jSLHh1E=;
        b=lpB1Jkw2oOAqbZBAmZSQC/b66H4fQsO13YoayB5e3p+1e8WhK+IWndHuFP9yLrK1u1
         iO9e/9gce9SWDSC+7w9NQlZ+efezCgjpg1dK0UWYmsZM9eNs1c3AzQc2AoGGPqSoyGqw
         Gu0xu4MUoTWkmXVIHGfz+NUR7iwSTs9Kodx5w/q3G30pR1EaVQjWejdEXGZPmOpOijtT
         v1YbppCuE/0Eo4vObiamodDEwECOYxujFpONtXglKwiCCNfA9DYPZSrUyA0GJPQ8W3c+
         W5YxuNW3HFH/hsk6kIDEn8pNlPXUUhKfBx+DMGnJCygcdYLdpHPwiMmjix+wxiGOWsiX
         2c5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=WB3NAADDilR+pQagX0XJnxPLeHo0i5e2Cuu9jSLHh1E=;
        b=B2wtWDH+uLe7Uk8+azfhSnYNGP/6dJhgzIAiEnbuS8SE/MtfclfbW/yiqtbpuOmfJ9
         nXNyw23DT2aKgyG+dH31EEefugtU5leNWfuAJfSorQs4v29LcT2KqrVGBi2xKx0W/dyk
         /MyxenCCryzzCPET4M5nAuPqMfEzLKlZDaCyMRdjXt5w/DV8gxftzTus6D50bcrD5dV7
         kHpvYdMxa1TrrecR0PCGtxvYfcaL3X8Qr25GuRcAkVZF4mdZPvZnLWnZ4Bduyrp8Eyk7
         ATEnFvwFlqlzBwIFybsxDFrg3ZBUHLyeWRtGydjDdNrLoiau9jq20PSTvEPAXaUM1D2a
         MUlQ==
X-Gm-Message-State: APjAAAWdE7K29SvL+3y7fHJWCDjFy3pjK023CyjaiHD72AZd+dZsEMSG
        2z9ckXjzLIhtwwuEA8bzGEWUzYN8zEY=
X-Google-Smtp-Source: APXvYqzuZM8q4NuM6xInvIKRaIVPk2x6fMdjoOxyHExzjr+fV67DncXgE2+JwgNQneEOgzBTvCU44A==
X-Received: by 2002:a17:90a:dc86:: with SMTP id j6mr2336394pjv.141.1559207105150;
        Thu, 30 May 2019 02:05:05 -0700 (PDT)
Received: from zhanggen-UX430UQ ([66.42.35.75])
        by smtp.gmail.com with ESMTPSA id x10sm3427230pfj.136.2019.05.30.02.05.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 02:05:04 -0700 (PDT)
Date:   Thu, 30 May 2019 17:04:55 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     hubcap@omnibond.com, martin@omnibond.com
Cc:     devel@lists.orangefs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] orangefs-debugfs: fix a missing-check bug in
 debug_string_to_mask()
Message-ID: <20190530090455.GA3059@zhanggen-UX430UQ>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In debug_string_to_mask(), 'strsep_fodder' is allocated by kstrdup().
It returns NULL when fails. So 'strsep_fodder' should be checked.

Signed-off-by: Gen Zhang <blackgod016574.gmail>
---
diff --git a/fs/orangefs/orangefs-debugfs.c b/fs/orangefs/orangefs-debugfs.c
index 87b1a6f..a9a9aac 100644
--- a/fs/orangefs/orangefs-debugfs.c
+++ b/fs/orangefs/orangefs-debugfs.c
@@ -888,6 +888,8 @@ static void debug_string_to_mask(char *debug_string, void *mask, int type)
 	char *unchecked_keyword;
 	int i;
 	char *strsep_fodder = kstrdup(debug_string, GFP_KERNEL);
+	if (!strsep_fodder)
+		return;
 	char *original_pointer;
 	int element_count = 0;
 	struct client_debug_mask *c_mask = NULL;
