Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C89D8ECE599
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 21:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A12120872
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 21:07:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HbWz84xC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437398AbfJPVHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 17:07:30 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35909 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437357AbfJPVHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:07:30 -0400
Received: by mail-pg1-f196.google.com with SMTP id 23so15031624pgk.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 14:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k1YZ2IC/LaAdVPwTIsCZRs4W7MYDT3QTncAX2qN9HIc=;
        b=HbWz84xC5v3QclpFX56PCG1zJPkaXDTlwXkIvU1zL+n/YtZHhDR7+Q4PBE5z/1eqHX
         MK9F5kyC91JvcRpvnKivbmH6iS/DrJCR5e0p1pxUZS/QAWVO0msCfP8oMkih8wYSxeKk
         nhDIByJkISa+HihfbTBa/tLS9CpXiCRS0hZdGnNhS3nt7coBrFcTVLVzHdlThpmyCBD+
         YfGOnNtQVUlWs42jfLXiZooPNISIWsZcCJ4QuLX4O9eFtN2T6siog6j60WH2+CTljejs
         ocNpY4GINtD7y8hQpUmOyBBKxDp4Xwl8xbkT5nN7lXuVuD15WgDBqMQLtC33Eov34pjs
         t/Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k1YZ2IC/LaAdVPwTIsCZRs4W7MYDT3QTncAX2qN9HIc=;
        b=dhFWDIEonXOIBS4tSEfBLaLnrAtvtBUGfI6AQHBxP63nUTMVQWvQ76bjbc1jSfLM+B
         U9pS83QSFIEtQVX49LoCJ8jl59c/m2pUdOOZzN00dNq4s3DN4lAxxUD9Leo07c2cLRWe
         jSdnz2B1A1LfcUBKbSkbQ9/Pot3FATU5oVUUHm6Ieut/tW0z7TUuuOhEsaTjNMDdDwYm
         PrdUbHJp/nmWCzeV2RQslHi6M0Og3dkc6J9QvHtg0t5GdAuWkG3W8uvAzXRgZU6rf81v
         U8wxn487aRoI2s+LmNEZUhDt0K7wHcXtTyuoiUL2YlBRpFSFmC3ejiEgcGUpI50z6VVk
         dGRg==
X-Gm-Message-State: APjAAAVWuaxltXh+rowJ+H0YK0iBHTv5RrJzCzR+7NssE5fSDSyEW8u5
        WFWrRCGe5Ihai66JntG55ZA=
X-Google-Smtp-Source: APXvYqw7qsVJab2777RDUwuhKhel8LmfQO1wdIYWXi5k5IbkvYcsOmpPAdEzAJ32puA32rtdUghs2g==
X-Received: by 2002:a17:90a:3702:: with SMTP id u2mr7521299pjb.57.1571260049271;
        Wed, 16 Oct 2019 14:07:29 -0700 (PDT)
Received: from localhost.localdomain (155-97-232-235.usahousing.utah.edu. [155.97.232.235])
        by smtp.googlemail.com with ESMTPSA id x11sm11613226pja.3.2019.10.16.14.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 14:07:28 -0700 (PDT)
From:   Tuowen Zhao <ztuowen@gmail.com>
To:     lee.jones@linaro.org, linux-kernel@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com,
        acelan.kao@canonical.com, mcgrof@kernel.org, davem@davemloft.net,
        Tuowen Zhao <ztuowen@gmail.com>,
        kbuild test robot <lkp@intel.com>
Subject: [PATCH v5 1/4] sparc64: implement ioremap_uc
Date:   Wed, 16 Oct 2019 15:06:27 -0600
Message-Id: <20191016210629.1005086-2-ztuowen@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016210629.1005086-1-ztuowen@gmail.com>
References: <20191016210629.1005086-1-ztuowen@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On sparc64, the whole physical IO address space is accessible using
physically addressed loads and stores. *_uc does nothing like the
others.

Cc: <stable@vger.kernel.org>
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Tuowen Zhao <ztuowen@gmail.com>
---
 arch/sparc/include/asm/io_64.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sparc/include/asm/io_64.h b/arch/sparc/include/asm/io_64.h
index 688911051b44..f4afa301954a 100644
--- a/arch/sparc/include/asm/io_64.h
+++ b/arch/sparc/include/asm/io_64.h
@@ -407,6 +407,7 @@ static inline void __iomem *ioremap(unsigned long offset, unsigned long size)
 }
 
 #define ioremap_nocache(X,Y)		ioremap((X),(Y))
+#define ioremap_uc(X,Y)			ioremap((X),(Y))
 #define ioremap_wc(X,Y)			ioremap((X),(Y))
 #define ioremap_wt(X,Y)			ioremap((X),(Y))
 
-- 
2.23.0

