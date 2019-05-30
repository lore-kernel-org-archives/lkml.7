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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC3ADC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 01:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7777B24303
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 01:19:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lX4CuB8e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbfE3BTc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 21:19:32 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38725 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbfE3BTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 21:19:31 -0400
Received: by mail-pg1-f194.google.com with SMTP id v11so946888pgl.5;
        Wed, 29 May 2019 18:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Ju0QjLaKHMpo9B3Po4kU3At9+LwIIPyVDQ+BvFghLrI=;
        b=lX4CuB8eOyA7QF/57zT7RK9lixCm+OyNm8D8ZVmi2KxhtOksB9AGpwUgoyF+MPApMa
         pll+ktMkCLbni5bpON82iwkC1TGIm26YLFOtTR1ywcZL07pUdPJ3B/o0J4Ym/wQ4cbHd
         m3zDjW7Qd+Q5AvRZ7zu8O4hP3YWmImbdpBepUEqoXnj6JHbW0Rk9ufg5cCAvUevtFjND
         LfAfXC3iDHImgBTQBvSS0hflql/0gGTn3FawfGGcbN33k6ql9U7eKMDNZE8+milBdNlf
         MqQ4TIWe1woKg3o4m0+Y8UkPLx1nPsdhygl2+DfX6BDho2xnUUeDpxIE+R5W27jRmIeQ
         w6Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Ju0QjLaKHMpo9B3Po4kU3At9+LwIIPyVDQ+BvFghLrI=;
        b=c5jISYx1v+rQ2gdYkDbgQThuExQ9t0FrmhLRS5ncz6SXgLECm99IIrVgIqMvKo0ewz
         fJSXsK/LTCX4YSsGwY7E68h7VRqL19NJHB0CYG31fvP1klPF5p6utgRkfEAwGb9KvPuo
         bO/XuZPA8gHOhJ4bZFcAvzDXVnYAPhg5dx7FYSUCOpJNtcGQkK0p7pObULZL2DKGUhqK
         Q94UVTg8CncDJzKoOMPW0sbmE9zvEnuPdStQ0xjWzj4HnYEdjmwtiVwB5mFkWCHVDvTe
         wpDfPwJyEtO436jnU2g8akJc1q0eURZnMBn6BXZBc/MJOSqy4W8rs+OAHpFjpUmgYNTW
         Quew==
X-Gm-Message-State: APjAAAVB6/9jWfQHSkXHfzvEzq2m5ovP9Khz2fxNTinjAHz+0OQylJio
        aTPOEI/NVN7UroHS+KxQfhmiZaA5B2A=
X-Google-Smtp-Source: APXvYqyk3b6rPBoYGrVxmLhgh08kHsqMzJmI9J1lJuHPUugHIAaYOmRgkKADUKmyBdzmqcTbK7rq+w==
X-Received: by 2002:a17:90a:2401:: with SMTP id h1mr695700pje.123.1559179171109;
        Wed, 29 May 2019 18:19:31 -0700 (PDT)
Received: from zhanggen-UX430UQ ([66.42.35.75])
        by smtp.gmail.com with ESMTPSA id a26sm896721pfl.177.2019.05.29.18.19.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 18:19:30 -0700 (PDT)
Date:   Thu, 30 May 2019 09:19:20 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     jassisinghbrar@gmail.com
Cc:     thierry.reding@gmail.com, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH] tegra-hsp: fix a missing-check bug in
 tegra_hsp_doorbell_create()
Message-ID: <20190530011920.GA6490@zhanggen-UX430UQ>
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
Acked-by: Thierry Reding <treding@nvidia.com>
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
