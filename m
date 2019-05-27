Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC6C7C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 13:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B25A720859
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 13:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jC7eajPW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbfE0NEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 09:04:40 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34958 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfE0NEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 09:04:40 -0400
Received: by mail-pg1-f196.google.com with SMTP id t1so9100932pgc.2;
        Mon, 27 May 2019 06:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=8nEvWdeXB353GkLTXsYXaoTX1Inedn4FgEz1vhTKYzA=;
        b=jC7eajPWyBEabmQ+SQNNVO0g3VpabETTz1MQAxcpb4lMaooOZtMfF2zyYCjg/KAm0D
         cwrzVt8ONAxQgODhnP68iH98DZSoWrT1CFBmt0j5RuMnR6+qf+WUtO/BCudQKVfRhrsL
         FO1Os+mvVGbYcFPJhhMEDjbxtdCQkBC9z36ed5JVjnLrrtdHzGc4/gWh23nHPqUd/L6j
         C1Jimi9wb7Gzuhwv8DgMFimajTwd98nT8owUy9DkOTFmNz8P3/BcGoOWCX2V8Zg6tito
         7lIDkkcaH6ks9MuaWi6FLJu/dVWAKI0WL/cMt3OMlNBBtCU9SGDs3WnC8XpvKXXb5xrN
         qkxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=8nEvWdeXB353GkLTXsYXaoTX1Inedn4FgEz1vhTKYzA=;
        b=Z1c84XYtpinfU87T4lGQ6kbjpMAq31mG0oRM8PigiC46RHN91lPiMWrZqkd9zAh76N
         2TBGClrlwcexE130SxBXHZ/bSWz+66bMBdPTt+yUjSB9usU1q4VLb+mFIppElHUPhbNi
         DeE4zsLAYdKv9t8SU8trxka7LX/MCVRusyqTQgU1wB287oy+1OJvhO70HzoBZTMU8S1n
         sgxvo16fFiBcNWrFGIZW+Ooe4JZecfxPrU9kGWkSOLauUfdHSuORSIjrM390m+hRYdsZ
         frE4Vb6nHdZcBXaMSklPbd2sg9KeNbAR85+nAxQZlcmOmf+JyWR57dOLAGzHtoaAJXHm
         aeXw==
X-Gm-Message-State: APjAAAXLVsqre0V+qD2HfmfDbTVWfFz6Ws49ZPAwlVYyHhVmHuYFi5Rf
        5/yoOraEEl0lvZM9shfHaXhNMaLf
X-Google-Smtp-Source: APXvYqzhiX5WieFozlD4LN379CfF6I6m6azS3kWics+rEo7niYRAQW+W9n5n2Y4ph7YP2fkrrufjNg==
X-Received: by 2002:a62:ee05:: with SMTP id e5mr133336776pfi.117.1558962279371;
        Mon, 27 May 2019 06:04:39 -0700 (PDT)
Received: from zhanggen-UX430UQ ([66.42.35.75])
        by smtp.gmail.com with ESMTPSA id l7sm13469882pfl.9.2019.05.27.06.04.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 06:04:38 -0700 (PDT)
Date:   Mon, 27 May 2019 21:04:30 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     jassisinghbrar@gmail.com, thierry.reding@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH] tegra-hsp: fix a missing-check bug in
 tegra_hsp_doorbell_create()
Message-ID: <20190527130430.GA5367@zhanggen-UX430UQ>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In tegra_hsp_doorbell_create(), 'db->name' is allocated by 
devm_kstrdup_const(). It returns NULL when fails. So 'db->name' should
be checked.

Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
---
diff --git a/drivers/mailbox/tegra-hsp.c b/drivers/mailbox/tegra-hsp.c
index 11fc9fd..b613c46 100644
--- a/drivers/mailbox/tegra-hsp.c
+++ b/drivers/mailbox/tegra-hsp.c
@@ -292,6 +292,8 @@ tegra_hsp_doorbell_create(struct tegra_hsp *hsp, const char *name,
 	db->channel.hsp = hsp;
 
 	db->name = devm_kstrdup_const(hsp->dev, name, GFP_KERNEL);
+	if (!db->name)
+		return ERR_PTR(-ENOMEM);
 	db->master = master;
 	db->index = index;
 
---
