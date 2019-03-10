Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F02FC10F03
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 17:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44AD920657
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 17:46:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YW+PNz9w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfCJRqF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 13:46:05 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39635 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbfCJRqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 13:46:04 -0400
Received: by mail-qt1-f194.google.com with SMTP id i14so2647044qtp.6;
        Sun, 10 Mar 2019 10:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=1dWlSdF/VUs9/9K5esBtgLKSgLb9YgXrY3lBZ+V781M=;
        b=YW+PNz9wMKDGle/+pZjLroqEbxn/1SdTfz5xkyN7+ow/sTRRpsH8frIkLB0g9MDxGk
         K6dIaHg5T6ICn7SRDy3aD4fT0Nkvnc8mdglrp1TfhM7BzGFGPMbCJL4ddDVPepCchT9/
         xXDy9mTOGp/RcYj+zSXEi607qMDlHTOViyCq0lp/2d0GDrAIYvFAtVVczw/6hCUYWocZ
         QfrWvl7PyEdH2FvudxImS35G6gTLpNhw0evveK8bI7mIREi8Ys3HQXWl49DaqdHauLKw
         YwWRByOLulYx44MRNTqhgB/kVfGR6I/Yqv0gSQfT82hEQj1U5SbbBOv3uhGcwNB7Z6LV
         N3aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=1dWlSdF/VUs9/9K5esBtgLKSgLb9YgXrY3lBZ+V781M=;
        b=e9qDVQXyi1yhkbMjLhHHKCQDWDmXEXoT1+OfqwgwA6JdmaBVDChiNM80QkX8Qus4oi
         zSS79sm3vPOxkATN7ITRnfK4WC9UBllsNtpjluHVQRrYYIA2sO2SqsC59O0WKf+n6qlz
         DHF7b7EbGtH7qSo49Qp9AW+7caPMlnXbmz0GmQ+PlwU184UtsYF+sLR1hsOs8gerQHm5
         lsE36sIdiPdho0Q4/19l48/DVKxWbDb9YIpxtoz1ZRs9psmM1TTdCYqxrZNBEZQwuhgA
         jfjqKkdOGLpJnfW7CFAcTQroWpVSH/UftcVS4n73jagfMfnlt0Et5ImzqWknvuTj69XR
         FK1A==
X-Gm-Message-State: APjAAAVigsEnt0Uku1IeltOij0qVBao9bdv8xrw+Nrq9PnFlhglw3e3j
        TsB3Xi6qOlLeMw3YQTbn7XE=
X-Google-Smtp-Source: APXvYqwE/4WvCwW5YFbzOqni0L6BSw+OV8ZnH7yYKbSnCpzunCQdnpo/3s74B7YiEIGhFAr8TeBfiA==
X-Received: by 2002:ac8:2392:: with SMTP id q18mr22657620qtq.11.1552239963470;
        Sun, 10 Mar 2019 10:46:03 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id l36sm1957319qte.82.2019.03.10.10.46.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 10 Mar 2019 10:46:03 -0700 (PDT)
Date:   Sun, 10 Mar 2019 14:45:59 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com
Subject: [PATCH v3 4/7] staging: iio: ad5933: change help rule message
Message-ID: <20190310174559.dq33lxdg4omdvhmg@smtp.gmail.com>
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

