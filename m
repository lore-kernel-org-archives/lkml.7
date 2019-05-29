Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA6CC04AB6
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 01:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71EA620B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 01:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gf6uf9ZL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbfE2Bxa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 21:53:30 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41563 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbfE2Bxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 21:53:30 -0400
Received: by mail-pg1-f195.google.com with SMTP id z3so326099pgp.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 18:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=GFkfdKcziRNK4G5X1v4GEXAK4KAxWzSyd1rG3iBhpqE=;
        b=Gf6uf9ZLJFdbF2Tz3CtbEi5DpT7zoLEJswQZZlqfv62FlIUi96M62iFykxyCx2RZYV
         C0EWTeRU33+5d03Ow2UeCv+x6g5nqmfFFS8E4ckBgSCnFQSrOu4oHjZQGBLMHlRlk/a0
         xyKzPWHOb8+JXHFfNlpn7S5d70/n4j7ErVcoEuG8pyhICJeF1h7X8ynUwqEOgwNh/+4a
         Wq7GggU3PYOAGWpkYx1bMMRvOAEqjCsY6JuY5zzUnCT1lwpm1+Y3zO1ABgcRm5TxbVBy
         cKPdLbJvHwqb9VyIaVRYrS7ELRu2uxeerFeta0Mb/Mv76DWFRngOse4aSm1ZjdCgnHMW
         fhjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=GFkfdKcziRNK4G5X1v4GEXAK4KAxWzSyd1rG3iBhpqE=;
        b=ItGAx5p8grc1lOTGl1hbr0A10q1VC0Kn81y5Lu1EuR8He0kGZ7DtOTjCNKPdCfn0Dg
         EAM1EP2G/9K6W3DqUcLDbY15iQ4KVg0uvy9r9Fj+gwnm+Y+DV94rrwgoHdN84X0tJ90R
         6rRcumW5LXmg9jriqmigDztmget7v7vzCQ19zWmglSIJUGPLWndY6JypVqDbCPCrGXsz
         XYgE4o9F1AzOdndSBuxS5sERhipZgjFjPnBmqfBm9UcTGXfh41dX08U/9phP5ksM2LmX
         mI2++TkL7rHoKhtyomi8+zE9ZI5YANCyu4j6mloCv3ek+9kVMJ5XCH72A5suwbL+Hupz
         9MyQ==
X-Gm-Message-State: APjAAAUqNyXfFuXxXp/Eqt/pXkFPaD4SHVkvzzyQvVry4JU8x1CDnTbd
        eJ0o6cK99l3MTp7lBjwgSCI=
X-Google-Smtp-Source: APXvYqxxWam7KfL/O/GisA3wPveL8l5MJwx68efl0AKePXCW1X8GjrVWOHqomHwq6xiE4jzisBH34g==
X-Received: by 2002:a17:90a:35c1:: with SMTP id r59mr2222430pjb.49.1559094809768;
        Tue, 28 May 2019 18:53:29 -0700 (PDT)
Received: from zhanggen-UX430UQ ([66.42.35.75])
        by smtp.gmail.com with ESMTPSA id l13sm3654097pjq.20.2019.05.28.18.53.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 18:53:28 -0700 (PDT)
Date:   Wed, 29 May 2019 09:53:05 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        wen.yang99@zte.com.cn
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] wcd9335: fix a incorrect use of kstrndup()
Message-ID: <20190529015305.GA4700@zhanggen-UX430UQ>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In wcd9335_codec_enable_dec(), 'widget_name' is allocated by kstrndup().
However, according to doc: "Note: Use kmemdup_nul() instead if the size
is known exactly." So we should use kmemdup_nul() here instead of
kstrndup().

Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
---
diff --git a/sound/soc/codecs/wcd9335.c b/sound/soc/codecs/wcd9335.c
index a04a7ce..85737fe 100644
--- a/sound/soc/codecs/wcd9335.c
+++ b/sound/soc/codecs/wcd9335.c
@@ -2734,7 +2734,7 @@ static int wcd9335_codec_enable_dec(struct snd_soc_dapm_widget *w,
 	char *dec;
 	u8 hpf_coff_freq;
 
-	widget_name = kstrndup(w->name, 15, GFP_KERNEL);
+	widget_name = kmemdup_nul(w->name, 15, GFP_KERNEL);
 	if (!widget_name)
 		return -ENOMEM;
 
---
