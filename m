Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 515E1C072B5
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 01:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26B8721479
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 01:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g9TWTCtZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbfEVBFN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 21:05:13 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44398 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727466AbfEVBFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 21:05:13 -0400
Received: by mail-pf1-f193.google.com with SMTP id g9so351694pfo.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 18:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=1GsqKRYlwofaep/lI4l9vkLa2KfO9O6nBfblo2Qq5qU=;
        b=g9TWTCtZvFmF3D6JJSRgbsjOAc6S4dR/Zw6rCdDyCFm+9I6nYUvz55M3Ml+s+aGkFJ
         t4FAkL1HK9s7wAxS5oAgWp+hzLuyIj6bfiiykX4cTK77szpO3e8HPMR+Qahnis5MuwDu
         kE2uaVFW1eX09YBRJS+4PBu9SMF+7k1GYCFS3R3FOKK11W/0dLpKIgsOfD3gVD+Gq9yB
         btVRcF9/siIKyAauat6GiVKT441xdMiJnpSlS8+Lh+TxTvCVnxm0sbgp+XHpE1pjuf/O
         SnfgNoqb+ZHe0TnzvT4ldCXiHIH4H+/TrjSpActNkB941GOjo1qijSF7eA2p2dRTkoQl
         lIHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=1GsqKRYlwofaep/lI4l9vkLa2KfO9O6nBfblo2Qq5qU=;
        b=OwU5i3PB3zM8oMEun/dCBN20gnQb+z2BaYk71H7gOEuna59Cr+Oq3csgnC74b9RUO0
         YT6D0GdzxBDWuLXWL4KFZJGWDjt5KkuJlkuxylSQZ8RcI2zphHbkqMY+3SvT1s+M6KG3
         Y9hkwH8eu6H3Pb7x07J4PHXWaNccx/LSywhDRHSEoW7SUZia7+JLfdIZwgbspr2+0Igz
         JRsrogzGx2lY5VpFebWI/XIkTWtbScvlMElF/Nvi58A5lJbcWv8i5R6BoeVWYKm3EI3m
         NCcsCJzWNjrQR9jpwnQhBw0nbr0/RaYjfVgc++XKHmOLFI2ZJSH5epi8QJHKkrgccnfz
         hi2w==
X-Gm-Message-State: APjAAAWVjVTOSJPzH4ddwk5zo0zYyF7FUe3NLgcBJMwVJ06gm2Q67ETA
        6U92MSo6F1Id/7FJe0Z8D5mohgG25bc=
X-Google-Smtp-Source: APXvYqw9+BIU0oNEw2h6rJmaehxZz3k8pFMr8M2nAyZSMJwZ4uf+LQOFh7bnfRSc4IwgrF5hCOQEzg==
X-Received: by 2002:a62:1a51:: with SMTP id a78mr90897504pfa.133.1558487112414;
        Tue, 21 May 2019 18:05:12 -0700 (PDT)
Received: from zhanggen-UX430UQ ([66.42.35.75])
        by smtp.gmail.com with ESMTPSA id a15sm5041869pgv.4.2019.05.21.18.05.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 18:05:11 -0700 (PDT)
Date:   Wed, 22 May 2019 09:04:55 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     lizhijian@cn.fujitsu.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] initramfs: Fix a missing-check bug in init/initramfs.c
Message-ID: <20190522010455.GA4093@zhanggen-UX430UQ>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In dir_add(), de and de->name are allocated by kmalloc() and kstrdup().
And de->name is dereferenced in the following codes. However, memory
allocation functions such as kmalloc() and kstrdup() may fail.
Dereferencing this de->name null pointer may cause the kernel go wrong.
Thus we should check this allocation.
Further, if kstrdup() returns NULL, we should free de and panic().

Signed-off-by: Gen Zhang <blackgod016574@gmail.com>

---
diff --git a/init/initramfs.c b/init/initramfs.c
index 178130f..dc8063f 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -125,6 +125,10 @@ static void __init dir_add(const char *name, time64_t mtime)
 		panic("can't allocate dir_entry buffer");
 	INIT_LIST_HEAD(&de->list);
 	de->name = kstrdup(name, GFP_KERNEL);
+	if (!de->name) {
+		kfree(de);
+		panic("can't allocate dir_entry name buffer");
+	}
 	de->mtime = mtime;
 	list_add(&de->list, &dir_list);
 }
