Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC3F9C10F00
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 20:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83CB82070D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 20:19:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oHzWf0mp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbfDBUTI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 16:19:08 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33619 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbfDBUTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 16:19:08 -0400
Received: by mail-qt1-f196.google.com with SMTP id k14so16918544qtb.0;
        Tue, 02 Apr 2019 13:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=/8GqjM3aW6s7XFPIBnwupG+p/kaAxMERytiVj0ted94=;
        b=oHzWf0mpDBhkHuGHdpjFGRgT2Q0WaWbQqI31CyssCvAr6hhe4KsdMBph5VbKcF5DPe
         pZQWkvfu4l5uYuQe6FK0DzVkB0i1iQoceRaCrj6b9V9myLxWqaeDssSGunKN1yDyncgs
         LR76XuH3zuRURKTSwKkQCGXyFHdrA/ed3gU8xcHV3p5Wru7XGFYu4zl2jaCt1eunm/M3
         4GQ3+wFnHEJgPiv5zRQfN5UZV647+BY+BeWUbZsbGxwuGXV2IrjLprHCetHOrjLzZZKD
         EETmRGYR1MEsg1Y/kfq6nVr5/+aS5vupVmYeH5q1MLOEw90W1hvt5w+BYpBc4ULNjsHC
         PAZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=/8GqjM3aW6s7XFPIBnwupG+p/kaAxMERytiVj0ted94=;
        b=t89AtLyze+LXYwJHC9e5/u2km9d5RYD7+v3YKf3XMcqNfjNmPhnLX90uf+79I/4fsK
         /RynttimN6nLMtOPzVzCO2igt452MIeE5BlDYdZJA2IA9rueCIOtfl9Z4KAKfRmw76F1
         8+PMqXiuiBpsdC2glOS+RNcJrpBMr7zshh0uW/aVOLEitBWx/HHxbDClZ4unYl7fw2de
         CuyNoBrw3M8aIg8fP0FbefUNSy9dpGGgAbh0OHqLm2ljozOGYV0l2NplNAwKNLpZ/g6r
         +EF6qdWL/8i1/gvenqMFj89vr5zZ8rwgqbwpN+4CMxuIb+A+cAcUhWqAPOX+mwdq0eQJ
         CG4g==
X-Gm-Message-State: APjAAAXO5RgPqbY+StFzAocda9eL98KgBdTg2sQgjD0MkNXxIhdahVn4
        fZtdw3aInpkym5mEx+SADmhbNq3jKZA=
X-Google-Smtp-Source: APXvYqxQujGX9k1pm9UKPq6kZwdtr914yb9AcT8HYYZEWPL/GzsCiThWBvip+ofzP5QMV+Fx9FWVFQ==
X-Received: by 2002:ac8:267d:: with SMTP id v58mr46124649qtv.340.1554236347360;
        Tue, 02 Apr 2019 13:19:07 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id g13sm7327967qkm.89.2019.04.02.13.19.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 02 Apr 2019 13:19:06 -0700 (PDT)
Date:   Tue, 2 Apr 2019 17:18:54 -0300
From:   Melissa Wen <melissa.srw@gmail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH] staging: iio: frequency: ad9834: Remove unnecessary
 parentheses
Message-ID: <20190402201854.du6x75rkcm2ijmsc@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unneeded parentheses around the arguments of ||. This reduces
clutter and code behave in the same way. Change suggested by
checkpatch.pl.

CHECK: Unnecessary parentheses around 'st->devid == ID_AD9833'
CHECK: Unnecessary parentheses around 'st->devid == ID_AD9837'

Signed-off-by: Melissa Wen <melissa.srw@gmail.com>
---
 drivers/staging/iio/frequency/ad9834.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
index 0b0287503fb4..9cc6e751b479 100644
--- a/drivers/staging/iio/frequency/ad9834.c
+++ b/drivers/staging/iio/frequency/ad9834.c
@@ -286,7 +286,7 @@ ssize_t ad9834_show_out0_wavetype_available(struct device *dev,
 	struct ad9834_state *st = iio_priv(indio_dev);
 	char *str;
 
-	if ((st->devid == ID_AD9833) || (st->devid == ID_AD9837))
+	if (st->devid == ID_AD9833 || st->devid == ID_AD9837)
 		str = "sine triangle square";
 	else if (st->control & AD9834_OPBITEN)
 		str = "sine";
-- 
2.20.1

