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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 494E3C072A4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 06:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A84F20863
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 06:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MzdlEZUI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbfEVG3z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 02:29:55 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45659 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfEVG3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 02:29:55 -0400
Received: by mail-pl1-f195.google.com with SMTP id a5so547911pls.12
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 23:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=cQiIPUlB7ACWsXP2z9kL2RhqPg0t69bBsZhfc20z8tk=;
        b=MzdlEZUIA4bW/VNgKX8bYIWVswe44H52d2Ue+bTuSHtnV13vteDtKUDy4f4EMtDIJy
         v+gk7pTxjQ19SA7viHeGLm30b/7DMJSTZL0xDYm/zywhY9Eg/kjDtpu17YCGmZ1xn2mG
         d84y3fMRz60hbItxugkp0PNYKgJtrl2VBK27CFvZHy/aN7mAauPs0JPW1wQSJPkKLnuV
         SAiDNCJJp2CJnSvF3ryRWKGxxdKHgWIjp5DLKHeLR2g9WoHk3ZiTF3I6Oer6PufmhLFJ
         cZEJY0e5Z0ObBqldhpKs5Qs9B5/AjjTOrqLgsf7WTMB/U5sOxfidMmbZXiJSCE0kZfJ3
         ZaDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=cQiIPUlB7ACWsXP2z9kL2RhqPg0t69bBsZhfc20z8tk=;
        b=SB7QrGpqfl84mQFa39NZd1EDWF4tHm/C1SYNyljtRm21cRAT6enukhN7kX2UXTuej0
         zFJypEQi5uPzWwJXSH0Ax8YGHgwePvxk5ISu+LM41Xwd55y9mE96MC7Xh/o02wwKANKx
         qjk8+zqyIdZE+M5t6JMvMwCc9TGVvZPb2cF3PYOmSXfrvIWU5HD+5PkDfPZE81S2kDBM
         OiL9cWt7M6ahs/9MtXsYy5A4O3znuxTr1SY7AaXmmZRAR4es+pc/yXe/tLapeGaEqRPI
         evZ+BudNuzdyEs6offZ2QaWH61Q/A/EoJ91WF+0NiDBUlhSGXbv5ploRM2+GNEvr8+xf
         U28g==
X-Gm-Message-State: APjAAAUqXCILypR04ZCVAlWrQx7SYmjAArpN5l6gHFtKQoow5EnCJKSf
        QN8iB4Bl2d+8YvICy3umaOG84T1AQxU=
X-Google-Smtp-Source: APXvYqx7K2kl79qwrVy0EYMihkougrqvLc3ewyjzx4QBcs3X8icDIWku99+r6/YKZ8AxRm9VV3ofNw==
X-Received: by 2002:a17:902:9a07:: with SMTP id v7mr89327193plp.180.1558506594683;
        Tue, 21 May 2019 23:29:54 -0700 (PDT)
Received: from zhanggen-UX430UQ ([66.42.35.75])
        by smtp.gmail.com with ESMTPSA id 12sm2545012pfs.106.2019.05.21.23.29.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 23:29:53 -0700 (PDT)
Date:   Wed, 22 May 2019 14:29:44 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     Li Zhijian <lizhijian@cn.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] initramfs: Fix a missing-check bug in init/initramfs.c
Message-ID: <20190522062944.GA2426@zhanggen-UX430UQ>
References: <20190522010455.GA4093@zhanggen-UX430UQ>
 <2c246472-bb1c-1063-1370-33da04af27d0@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2c246472-bb1c-1063-1370-33da04af27d0@cn.fujitsu.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 10:00:37AM +0800, Li Zhijian wrote:
> Looks good
> 
> but the following place should be considered as well i think
> 342                                 vcollected = kstrdup(collected, GFP_KERNEL);
> 343                                 state = CopyFile;
> 
> 
> Thanks
> Zhijian
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
