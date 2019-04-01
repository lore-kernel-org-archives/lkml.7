Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32CD8C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 14:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED66A208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 14:37:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UdlEE5hb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbfDAOhQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 10:37:16 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41207 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728629AbfDAOhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 10:37:16 -0400
Received: by mail-qt1-f193.google.com with SMTP id w30so10812011qta.8;
        Mon, 01 Apr 2019 07:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Zqti8G91y3BMM+COakyXEchnXkd+28NLMRCPgka8P5M=;
        b=UdlEE5hbg5z7+KGBaBgQCtDyUN8k0vVEmRrQJ3QFymEzMoEHqli9pi7V6hpYMMRHFE
         jIkf1V2iYO6Eqc2+v5qfkR0X4f3T9xjC7mpRN0Mb+HwMdBUMrHvX00ZlqC9btoYZTFkF
         HuwtNz0v1e+dq4o/tYXB95nMpXDH+4Wkteo+i5w/xJNI+K29kk40YIKlSVgQTqm5nyV8
         2t8yMTvABMULJVKGxnUkQi9NY7EE2MGzgpLJ87UZTxUg4IAENJ2WXoogKhtWhQT7CfHy
         MTcZyiFg10yddbtEWcFNK0h/TD+x2RKnTArX2/A2ZNVsD02zYn/NkfvFViomfmqEZkTh
         YoYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Zqti8G91y3BMM+COakyXEchnXkd+28NLMRCPgka8P5M=;
        b=ixwzW9KCazEOaIbTdR7MIk4H6NySwjri359q93ovSn9FGyzY6iUlsm9ivGMY1aRto+
         dHPEZN7Bmn5TddflmETRRWghX/RHh32ga21ZRLTTX9u78vkKVxr6CM25dYjpwU2KvBj5
         0TI0Eaq2dEpV9n1qYtY1B2wlC0OvuANZ3YwZ61jHXPTZ9V2v2npjLnF60XSEXOwEVQc0
         MTl6r3kJGSbrTKcgbSzTm5CP9ddZQrXw6+EcKsdbYqLFofsrYud9aunQ9pR9x8vhpzyu
         l2vfwPkoxDRhP+B1bzH7FA0QPCYsePS4+9GZJLYxGYkVv6a38kw9IoBU++CEsMLC1ooc
         QKow==
X-Gm-Message-State: APjAAAVVb9y60yYc58OFD7JCkGCJHuNKf9Nb1l8841jCYE24fCwwF6qT
        wPCu+sI75toVyK/9mqdzk/4=
X-Google-Smtp-Source: APXvYqyrC/0E9fn/v/wbUEyG0zqo/oM1a1szPtbvbe/qzdGlAidVQqyrGScjbzUd2crTiilWx+rnvQ==
X-Received: by 2002:a0c:9945:: with SMTP id i5mr42470806qvd.159.1554129435298;
        Mon, 01 Apr 2019 07:37:15 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id d21sm6754283qtc.91.2019.04.01.07.37.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 01 Apr 2019 07:37:15 -0700 (PDT)
Date:   Mon, 1 Apr 2019 11:37:10 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com,
        stefan.popa@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH 1/4] staging: iio: ad9832: organize includes
Message-ID: <20190401143710.ruubi2knbjsjzdm7@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Organize includes to list them in lexicographic order.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
---
 drivers/staging/iio/frequency/ad9832.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index a3ce50427724..50a583020072 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -6,22 +6,24 @@
  * Licensed under the GPL-2.
  */
 
+#include <asm/div64.h>
+
 #include <linux/device.h>
+#include <linux/err.h>
 #include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/regulator/consumer.h>
 #include <linux/slab.h>
-#include <linux/sysfs.h>
 #include <linux/spi/spi.h>
-#include <linux/regulator/consumer.h>
-#include <linux/err.h>
-#include <linux/module.h>
-#include <asm/div64.h>
+#include <linux/sysfs.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
-#include "dds.h"
 
 #include "ad9832.h"
 
+#include "dds.h"
+
 /* Registers */
 
 #define AD9832_FREQ0LL		0x0
-- 
2.20.1

