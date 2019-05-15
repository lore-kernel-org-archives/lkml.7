Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B703FC04AA7
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 06:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8066021473
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 06:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KW5wjEpp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfEOGpM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 02:45:12 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40417 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfEOGpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 02:45:11 -0400
Received: by mail-pf1-f194.google.com with SMTP id u17so835707pfn.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 23:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=awWr7CqE/VI7koIkZm/vLnS/8LIohJ8DzEhbOAp8yVw=;
        b=KW5wjEppeN2Y8sAfrlgDf5wT5zp95JTjyJZv4Ti5fRz7+AKXFFuvLvkkxAonwZ5IE1
         aPgDoMEgXfMN6MrC8UdZnpZkchtLnD6PMFYfXDPskBEv9kAqj4VmoAoHXd4FRSwGmkEy
         BADG/NCWU75fvwFdNtTKlKMKvUmvF/NodtMOzlf59yOonbUgGmP07xNRp30pK68KumuE
         MgGzDYpD67mLxy7RYFiSlCzRZetbS9G2iyXg5C4bIK1Vz11cgj5SwtqXPq2Zry6eOdnB
         6zO1o6LCuz9mb6sWc46rMrN8y/dvWrDYFEgmTAMOPp6Yw84X4sCRsvyIMd4iFht++7f0
         muEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=awWr7CqE/VI7koIkZm/vLnS/8LIohJ8DzEhbOAp8yVw=;
        b=rt2tIwhlN8CbdN7Owks0dLtXp4AwZU2pBoQI9bopqejClo7k2JoRYAp0j+isuj/7lC
         8T3vttm5FH4ul+KIyrFf6NGrhcWARgFybFrLgQHopsEbZbLOyDgjRq/VIsoCUgWEuq/+
         DKk06FbjSH9chJfTrDma+1Ghov8A8b68KchkbPqqFu7Qu/EGm9IdLEOXj+U970lz0R4i
         DIa7j9qTrmDA0uUBCCxlveCcyoeDcTdpU/gJO7OYQJMxp7c781wFZu+QHY6/MLTwLy5R
         Nj4GFnFZF8nJxACw7FcmbhTMEm+x2PqXnfkMpytGOVLqQn+wEJumUSss10TubTS4LhNy
         CxnQ==
X-Gm-Message-State: APjAAAV6+g392NciXvqoQxumBLiDePpQmvywxbZuUnl7xQeeiaN8mDI3
        0dqyLxMhb1oY8vCjhec/zR0zxUpSFFM=
X-Google-Smtp-Source: APXvYqyR+dxNyaEUgow2q49fbaA/GfcdLr+mZH80X+llvwEJ2Tk77sIbLS1pPPX7y6mAFRvDNFv7Xw==
X-Received: by 2002:aa7:8683:: with SMTP id d3mr629082pfo.145.1557902711325;
        Tue, 14 May 2019 23:45:11 -0700 (PDT)
Received: from zhanggen-UX430UQ ([66.42.35.75])
        by smtp.gmail.com with ESMTPSA id u8sm2002289pgl.91.2019.05.14.23.45.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 23:45:10 -0700 (PDT)
Date:   Wed, 15 May 2019 14:44:57 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     rientjes@google.com, iamjoonsoo.kim@lge.com
Cc:     linux-kernel@vger.kernel.org
Subject: [Patch] slub: Fix a missing-check bug in mm/slub.c file of Linux
 5.1.1
Message-ID: <20190515064457.GA29939@zhanggen-UX430UQ>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pointer s is allocated with kmem_cache_zalloc(). And s is used in the 
follwoing codes. However, when kmem_cache_zalloc fails, using s will
cause null pointer dereference and the kernel will go wrong. Thus we 
check whether the kmem_cache_zalloc fails.

Signed-off-by: Gen Zhang <blackgod016574@gmail.com>

---
--- mm/slub.c
+++ mm/slub.c
@@ -4201,6 +4201,8 @@ static struct kmem_cache * __init bootst
 {
 	int node;
 	struct kmem_cache *s = kmem_cache_zalloc(kmem_cache, GFP_NOWAIT);
+	if (!s)
+		return ERR_PTR(-ENOMEM);
 	struct kmem_cache_node *n;
 
 	memcpy(s, static_cache, kmem_cache->object_size);
---
