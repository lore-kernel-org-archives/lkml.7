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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 782D9C072A4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 07:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D2342173E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 07:26:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EU9ngI2v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728526AbfEVH0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 03:26:48 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:32803 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbfEVH0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 03:26:47 -0400
Received: by mail-pl1-f193.google.com with SMTP id g21so645137plq.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 00:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LRKYo/Tg41WJvHbOGajmPW4pzDGr3pcsWkrKkayOv50=;
        b=EU9ngI2vI1ZIMuoSPgRt7hDcn2B03I5/FgFeduVwXL2fApn3JCtuo8t0S7QrLOEXYU
         LgqUo8iUNXpEbGZ6fNMdMBDk4hR+Fx9pbnMOKawF2Pju5XMQAKh9+o+QBLQwlmUbWN3P
         rtsCIYie6aJsxeP77p+amfxf/cchNjQCMQvO/B556Sjw0daLpZ5wSIXbVBXJUwYYyRKV
         5v+aSxbyS+yE98GvlYsWutQ3MP+B0smQiVlgQC7HAyd/Yf5VojoewHeEh0/NsyEcMaTF
         7ZSS91vBwLkMcfNI6uXIYoZc5v8qAmqJZYnFKBlmhcma6MqySBbYc0lchqv+El4IUX1w
         OzwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LRKYo/Tg41WJvHbOGajmPW4pzDGr3pcsWkrKkayOv50=;
        b=Jr+kc6qDLBxod5WWZsLuNrLPYlc5RBqkXv2O7EJwp/7nIGET53pQ7awsjSw7bBMEeR
         cDwQPslntNL+v9otJOfQpkf7wDeFr+ngYlJyUlZtzoCfd16R2Yk+00Cs5Wr4vSE45dcB
         8cBHHjQMQjgTK0+A03A6D8J0OGyyRHnfTZhhRj2ZPRogZdiHO/i1OYsYUt3I16zbaWg8
         QLxgwg1mQi0GMfdT6dniGl5+rl5k06N+dqalEb8UP/Bw/8UPX4uGUFFElDLGc+fLOH0c
         nXzRtiKKnY9gRGMZU8ULZlpFeX/6SBurjIZfOyB5Yhfa8qJQqCSAmqF5N3PVygS1MFNj
         5UkQ==
X-Gm-Message-State: APjAAAVmKqOaYriF9wvtPnbSNglicFWPLUH2zYWvL/qoCv5norLAuFvG
        WIHOCn2hs/oqYOF9A56niAU=
X-Google-Smtp-Source: APXvYqw2MhR3PoTL+g0hF0jLP1EoAyuW9jU96hanbaIdcw8WJkax+/N4789K9JnNcayS3JzydIrpYw==
X-Received: by 2002:a17:902:4283:: with SMTP id h3mr66086052pld.214.1558510007281;
        Wed, 22 May 2019 00:26:47 -0700 (PDT)
Received: from zhanggen-UX430UQ ([66.42.35.75])
        by smtp.gmail.com with ESMTPSA id c17sm20734793pfo.114.2019.05.22.00.26.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 00:26:46 -0700 (PDT)
Date:   Wed, 22 May 2019 15:26:36 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     Li Zhijian <zhijianx.li@intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2] initramfs: Fix a missing-check bug in init/initramfs.c
Message-ID: <20190522072636.GA4221@zhanggen-UX430UQ>
References: <20190522010455.GA4093@zhanggen-UX430UQ>
 <2c246472-bb1c-1063-1370-33da04af27d0@cn.fujitsu.com>
 <20190522062944.GA2426@zhanggen-UX430UQ>
 <fd0277b7-a9a1-d2f6-c8bc-d8b8619c647e@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd0277b7-a9a1-d2f6-c8bc-d8b8619c647e@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In dir_add() and do_name(), de->name and vcollected are allocated by
kstrdup(). And de->name and vcollected are dereferenced in the following
codes. However, memory allocation functions such as kstrdup() may fail. 
Dereferencing this null pointer may cause the kernel go wrong. Thus we
should check these two kstrdup() operations.
Further, if kstrdup() returns NULL, we should free de in dir_add().

Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
---
diff --git a/init/initramfs.c b/init/initramfs.c
index 178130f..1421488 100644
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
@@ -340,6 +344,10 @@ static int __init do_name(void)
 				if (body_len)
 					ksys_ftruncate(wfd, body_len);
 				vcollected = kstrdup(collected, GFP_KERNEL);
+				if (!vcollected) {
+					panic("can't allocate vcollected buffer");
+					return 0;
+				}
 				state = CopyFile;
 			}
 		}
