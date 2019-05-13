Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CADECC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 14:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B1742146F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 14:19:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YhJhEZZF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730173AbfEMOTj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 10:19:39 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38991 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728867AbfEMOTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 10:19:39 -0400
Received: by mail-pf1-f196.google.com with SMTP id z26so7302070pfg.6
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 07:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=awWr7CqE/VI7koIkZm/vLnS/8LIohJ8DzEhbOAp8yVw=;
        b=YhJhEZZFYzK8XrLCBR7QP0KcHYkAuOejGc2vAR+p/yDUiI91M/U/3U6IMsgfeHDpC5
         lGb5YJw1eKXj9ujYsOZAcoPWhDZh5rL/TwHHAnbaTHC1ai7zzyoQlgD8Ot9oUaBVwQwh
         bvWq89sDRgn8BzFN11K90Ihj/6Pv/HaI9jfZo0JLcC7RKDqTBaBddjcV07UDs5HX7HH+
         q+UdWb1tSqk3J71c9RnSuWdR+aOiUDrY3HURn9p0PBvnZlnsf9Cj8NRxr9RDqXAV7XgO
         kwnVdxFi4YPVsdF09GWLheBH12yz+7Wrd4IRRcCc6tueU6F16tVSse9GbLefeY97/aAk
         Pc+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=awWr7CqE/VI7koIkZm/vLnS/8LIohJ8DzEhbOAp8yVw=;
        b=kcOeOFJFIqjAqrMlBc5K3K2Uv1sJPTDvsIaqKFQLwCfX0HL/m537wG+4snineRrTWc
         9eJHJa8CNjf6jUAbgZgJcknT2flXb1/GHvwQdY9ZrI+RNakP8giRrSlFQ9bYvQa1xg22
         BgVUMdPNDYoCJJhMfFrInL5ApM4oWDBiHi9flguwYhNW/kEsGGPuP6YuK9qC/UvN210j
         p/oNneCV8vo6yG4Ew9SsToyU1LjlR0cKhX8BrRwrzJqA0pVk9r+OAPiDkX7IlZmoGQx7
         lJdLtxOonjEFstpZG8d0dTenc8wANc4hXd41j5/fmkPm0zKsWG30lDlH+3W2qA2MkNwQ
         om6g==
X-Gm-Message-State: APjAAAXKh+VXETkc1TmXC543NDra95Z6uclQ2wN+oaLfZoHh1Zrtxk1g
        dqvb3M7dAo9aspECM+F1aodbRhrK0Ww=
X-Google-Smtp-Source: APXvYqzlc6WpBu1ovDt5qLotSI3ZHAMwdNn46iz3VXhpG/lJ6WuCWBqKjbbjNsFWauntYagcfC7rDg==
X-Received: by 2002:a65:6559:: with SMTP id a25mr7534897pgw.33.1557757178744;
        Mon, 13 May 2019 07:19:38 -0700 (PDT)
Received: from zhanggen-UX430UQ ([66.42.35.75])
        by smtp.gmail.com with ESMTPSA id p2sm16907604pgd.63.2019.05.13.07.19.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 07:19:38 -0700 (PDT)
Date:   Mon, 13 May 2019 22:18:31 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     cl@linux.com, penberg@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [Patch] slub: Fix a missing-check bug in mm/slub.c file of Linux
 5.1.1
Message-ID: <20190513141831.GA9502@zhanggen-UX430UQ>
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
