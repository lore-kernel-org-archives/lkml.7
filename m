Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 322A4C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 02:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E085E20862
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 02:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g3644O0Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388696AbfEXCMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 22:12:40 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45313 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387960AbfEXCMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 22:12:40 -0400
Received: by mail-pl1-f196.google.com with SMTP id a5so3488183pls.12
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 19:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=KhyzEO6gm2Usal2JZM1pOHPArw9B2AFuGWgFY2WjYss=;
        b=g3644O0ZmeU+nqIb6Kwh0lI6jiCQ7h3YQLDk8r8ZQJU0SyglPqWoTmYTJh35D90YV2
         /KH2Bk9Xz/+w18thaM4erdQVvaKEYARCD8xDt7O8OUlJh/VORggOFTmXVQ1je4RnCC/l
         8zPtaFLeVUYqU32xAqVE0v9JBtryIvRwarb/T1HW7f7XZu4/5OjsnlN840Wtij0Fk2l5
         VkJD9zztg4n3krekfGxPq70XbMebwBGzDhkfLxAEPs+fQTeZ2678/DV+LVYmBASi4IiS
         +HJgWlhxaidtSluQgtOklcBofMQ67wsV2ayae+i7/hR4VzpFvuPhp3mNSJX33ZMaXQCK
         CtGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=KhyzEO6gm2Usal2JZM1pOHPArw9B2AFuGWgFY2WjYss=;
        b=oEMz8lc+IHfO4b3gPuFDvw8S3yretwh+Xea154g1oiiNZK9xuhH+IbHG5RLFjFTK3B
         K34q/oTvieGQumryaMffVpNQVQVjcxjpQzfjopaoG/OpnMKR/CSvN3sPVBtFiFJgAzvH
         IVlX67G/pPnXJdGtTzTeuIJhX8wwoPHXHiUuRUEr8i+AWwd9AtPiUF8k/4tXDGnkQKeR
         fgfAwK+2qQugGPcJqwpXjA/SD9h0gKEJkittvY0ltkzuGm4V0gO+O8XmQf2/iQUFCS8N
         yzxy0r8Fmo0FwMP1E2+vaq1DXS9y11HrRZOo8ZNUwk6XmQzhSoWkO80P5Xkz37f/3oNL
         yD2w==
X-Gm-Message-State: APjAAAWYVkPVnKe1tH/cacMcS+C1ZYK09zDUjBzMB+cqjorW/I6+eVWy
        ORiu9wTjfRlRViIxsk+PCAA=
X-Google-Smtp-Source: APXvYqynZHdL0FJb/ejGsKpya0J9CI/4wBC9tTUjkaVApyUAoSdtyzZdHPnZXTKxPGrg6JwUqDiX9g==
X-Received: by 2002:a17:902:690b:: with SMTP id j11mr27720616plk.149.1558663959177;
        Thu, 23 May 2019 19:12:39 -0700 (PDT)
Received: from zhanggen-UX430UQ ([66.42.35.75])
        by smtp.gmail.com with ESMTPSA id q193sm796881pfc.52.2019.05.23.19.12.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 19:12:38 -0700 (PDT)
Date:   Fri, 24 May 2019 10:12:21 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     broonie@kernel.org, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pcm030-audio-fabric: Fix a memory leaking bug in
 pcm030_fabric_probe()
Message-ID: <20190524021221.GA4753@zhanggen-UX430UQ>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In pcm030_fabric_probe(), 'pdata->codec_device' is allocated by
platform_device_alloc(). When this allocation fails, ENOMEM is returned.
However, 'pdata' is allocated by devm_kzalloc() before this site. We
should free 'pdata' before function ends to prevent memory leaking.

Similarly, we should free 'pdata' when 'pdata->codec_device' is NULL.
And we should free 'pdata->codec_device' and 'pdata' when 'ret' is error
to prevent memory leaking.

Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
---
diff --git a/sound/soc/fsl/pcm030-audio-fabric.c b/sound/soc/fsl/pcm030-audio-fabric.c
index a7fe4ad..d2e6eae 100644
--- a/sound/soc/fsl/pcm030-audio-fabric.c
+++ b/sound/soc/fsl/pcm030-audio-fabric.c
@@ -72,29 +72,43 @@ static int pcm030_fabric_probe(struct platform_device *op)
 	platform_np = of_parse_phandle(np, "asoc-platform", 0);
 	if (!platform_np) {
 		dev_err(&op->dev, "ac97 not registered\n");
-		return -ENODEV;
+		ret = -ENODEV;
+		goto out_free1;
 	}
 
 	for_each_card_prelinks(card, i, dai_link)
 		dai_link->platform_of_node = platform_np;
 
 	ret = request_module("snd-soc-wm9712");
-	if (ret)
+	if (ret) {
 		dev_err(&op->dev, "request_module returned: %d\n", ret);
+		goto out_free1;
+	}
 
 	pdata->codec_device = platform_device_alloc("wm9712-codec", -1);
-	if (!pdata->codec_device)
+	if (!pdata->codec_device) {
 		dev_err(&op->dev, "platform_device_alloc() failed\n");
+		ret = -ENOMEM;
+		goto out_free1;
+	}
 
 	ret = platform_device_add(pdata->codec_device);
-	if (ret)
+	if (ret) {
 		dev_err(&op->dev, "platform_device_add() failed: %d\n", ret);
+		goto out_free2;
+	}
 
 	ret = snd_soc_register_card(card);
-	if (ret)
+	if (ret) {
 		dev_err(&op->dev, "snd_soc_register_card() failed: %d\n", ret);
+		goto out_free2;
+	}
 
 	platform_set_drvdata(op, pdata);
+out_free2:
+	platform_device_put(pdata->codec_device);
+out_free1:
+	devm_kfree(&op->dev, pdata);
 
 	return ret;
 }
---
