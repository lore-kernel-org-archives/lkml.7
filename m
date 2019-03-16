Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F14C4360F
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 15:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5496B218E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 15:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aVStcTXf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbfCPPHY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 11:07:24 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37775 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbfCPPHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 11:07:23 -0400
Received: by mail-qt1-f194.google.com with SMTP id z17so13395878qtn.4;
        Sat, 16 Mar 2019 08:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=1dWlSdF/VUs9/9K5esBtgLKSgLb9YgXrY3lBZ+V781M=;
        b=aVStcTXfRFOtIitxJBmh9/c0oFo8swTRvIb168aqAhp4nqlR8WbtGM0h3GLeuQH0Se
         GiufrL6Yep7FgfBCcb7o3BhRmfjQK7Ow1YqtZLm+kJvdCdhi6uvzkCKsDLvzqLybBQTy
         AXw3l4iqk0qKoShzTLseNRkr1gT3hho4poJaW1LiC8dY1hNZnphYuLJIXCzTH/sdISgC
         W8E4oVz6ZZRw5SVTXBMN3sgq+FMI+3Z3ZSAcat5xVLD+rFP2MdVYHS71WzQORBywpEdF
         +Qj8qMG3ttVzyXzdjQZhpRqfjVjXp6QjRqa1vI5k8bDoI6C/cKM/xJFYigdTx015aRDP
         of7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=1dWlSdF/VUs9/9K5esBtgLKSgLb9YgXrY3lBZ+V781M=;
        b=QwvDQi0xr33FuLxyOZALJsFOE6lKFMtWoQKCbqL6AxScPsDQ9jnV425shBXBlnhEiR
         iK2bnMW/8PzklMCfITdhmjsGdLgY0hvdfVVIOd0Zf5jJDavcp0RtA38BorOliY+VZCno
         prQ2TiIwHe4TBkocNLgjkTcnrfipjNWOASoXwaFooPcMbcWVlrGR26zER+gtuxowwGwB
         J4TELDWWvAfHTOBQizIHNEXJ6+od7H0bdLW30zg7T7w59awbNbfUfMiMqfLzZY1Z+nYg
         tZbkmnZEiSmoL6f46WQEadoE6zPfOroQ0ISgzN0ICFUVeCXuiMzCMHLJJomquUWOLZRU
         sOWg==
X-Gm-Message-State: APjAAAVLRn/TejHlCwzGe0lXqTiEoZgd4WPs6wpOd2/x/z8VBikJ6NGX
        vICo4MwAiNe/q/VjAgOV5KM=
X-Google-Smtp-Source: APXvYqzGBjUqoR56Kdgr+abVQOcBBgk5bl/OXDV7hcyyNIBqoUDd60D743oqTD6boIwuEJDHXgvgYA==
X-Received: by 2002:ac8:325c:: with SMTP id y28mr1642288qta.40.1552748842600;
        Sat, 16 Mar 2019 08:07:22 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id f6sm3606968qtf.66.2019.03.16.08.07.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 16 Mar 2019 08:07:22 -0700 (PDT)
Date:   Sat, 16 Mar 2019 12:07:18 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com
Subject: [PATCH v4 4/7] staging: iio: ad5933: change help rule message
Message-ID: <20190316150718.kl27r5vqendxj3mw@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the previous comment about direct access via sysfs which would
lead one think ad5933 driver has limitations it actually doesn't.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
---
 drivers/staging/iio/impedance-analyzer/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/impedance-analyzer/Kconfig b/drivers/staging/iio/impedance-analyzer/Kconfig
index dd97b6bb3fd0..b9a679cdd146 100644
--- a/drivers/staging/iio/impedance-analyzer/Kconfig
+++ b/drivers/staging/iio/impedance-analyzer/Kconfig
@@ -10,7 +10,7 @@ config AD5933
 	select IIO_KFIFO_BUF
 	help
 	  Say yes here to build support for Analog Devices Impedance Converter,
-	  Network Analyzer, AD5933/4, provides direct access via sysfs.
+	  Network Analyzer, AD5933/4.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad5933.
-- 
2.20.1

