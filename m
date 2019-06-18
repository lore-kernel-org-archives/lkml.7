Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA42CC31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 18:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3C1C2063F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 18:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MiXxaK17"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730246AbfFRSEh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 14:04:37 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35217 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729337AbfFRSEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 14:04:36 -0400
Received: by mail-pg1-f195.google.com with SMTP id s27so8122529pgl.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 11:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=rVGH4kgsuXcbNSFNao8ZqGI4Q+bUa7JZsKDeO5LRYIs=;
        b=MiXxaK17hq9pXQesf9RsuWynYdoYHHjZ2W/JdW138tleLdBC4mmTA3+/yunFt4ayVZ
         oeOwYHUKbl7zjyBR7iFNBu2xBJ3B2SApRa5/F0DXE+ZVBBQ5rHjUuLKa72A0GdqgJDX7
         JPYjj15VN3QBaRuvMP1wLt2KmOkYbKeIRHuNfm8P+aW5EIh8UYC7EAm7aa8ibq+wf/Hu
         Bo65TKZksIGrLHsyrRJIecdgwD3fR/QHteGkyBKCjzF8zjuyYyxJNkiVJgqbfelWgYSG
         XYE28LVx9ONz6B/lkm6Y3Hq3CdMl/oFKK3HmrAWrzmr6FphFO70oDEYJ2cgRTwUjKN0W
         ZtLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=rVGH4kgsuXcbNSFNao8ZqGI4Q+bUa7JZsKDeO5LRYIs=;
        b=Vc0KPAZ5ywSWMYhJglPJCXe97azC+RbXsg/sYFExjkk1lfK+O9sMKTGbeN60+IBAHx
         ACjVA8xt/KJfdytPcGYKloDlJZ63SalzWHAI7te2QE9bklfR+DAqwSn5cOHb8zAY7iTy
         slS80QRlPslf5XXhCczq50Q9m7zvYXBMpP0Y+qdcSwpHykGDvFRvzDGJrqYVAN+xYDLJ
         zwN7PJG6dvsMR0W4sh2wiSkY6Kng6zk/N/qwK4VYXRsc983KZgiP+esjYYJeq3fosha+
         TO0oKtEt+wVszx2gdavOFyNMRzaso4wZcW5djNBkfGpF6lcBpABf+GbchrTEalr4O5Js
         TFaA==
X-Gm-Message-State: APjAAAXEjmlw2ygMoBwcFYPzJwV7V+DbT1va5WgDjuYUFlGSdzlONc/G
        QDsRQKOgNO5+qThaa+WyT38=
X-Google-Smtp-Source: APXvYqz60yQaQy3v3ZXhj+ZHQTnweDWQmBL4BSJBEMSd8o5KCzxSFi7nodT+mID0fTbLSMjz35cprw==
X-Received: by 2002:a17:90a:a09:: with SMTP id o9mr6429751pjo.95.1560881076294;
        Tue, 18 Jun 2019 11:04:36 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.187])
        by smtp.gmail.com with ESMTPSA id v185sm6789458pfb.14.2019.06.18.11.04.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 11:04:35 -0700 (PDT)
Date:   Tue, 18 Jun 2019 23:34:31 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hildo Guillardi =?iso-8859-1?Q?J=FAnior?= <hildogjr@gmail.com>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8192e: rtllib_module: Remove redundant memset
Message-ID: <20190618180431.GA8170@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

alloc_etherdev function internally calls kvzalloc . So we may not need
explicit memset after this call.

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/staging/rtl8192e/rtllib_module.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtllib_module.c b/drivers/staging/rtl8192e/rtllib_module.c
index bb13b1d..64d9fee 100644
--- a/drivers/staging/rtl8192e/rtllib_module.c
+++ b/drivers/staging/rtl8192e/rtllib_module.c
@@ -83,7 +83,6 @@ struct net_device *alloc_rtllib(int sizeof_priv)
 		return NULL;
 	}
 	ieee = (struct rtllib_device *)netdev_priv_rsl(dev);
-	memset(ieee, 0, sizeof(struct rtllib_device) + sizeof_priv);
 	ieee->dev = dev;
 
 	err = rtllib_networks_allocate(ieee);
-- 
2.7.4

