Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0048C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C4552341B
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566494787;
	bh=RbF1Tg2tziz9dmCtWqOavdiHCF66LTP2TB/j+pbgwhM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IlwKTm6CXwmlrH9l9opvXREfOY6/lGFFt2resErn9pkGWwYeaepuaCTiAanCqz+pw
	 YTDcckpu7IoMEp1SuKvmfMzXXlAnaFOz4dEbakFGlXDZT5mv2DXZNX8AZGHd7fj63F
	 7oPXgRRbo8LKxVNWXJgbQJRDUi9x870tugdrWqcI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404729AbfHVR00 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:26:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:48392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404364AbfHVRZR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:25:17 -0400
Received: from localhost (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5EDF2341B;
        Thu, 22 Aug 2019 17:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566494716;
        bh=RbF1Tg2tziz9dmCtWqOavdiHCF66LTP2TB/j+pbgwhM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WBXj+jfds8Ta8EfsWYlcXDkUBKXCoBwwxnl9FqVWkPvYKPmqBwd0BpZzoK9nIMRUn
         cGgsXRWfEUIynTH/0zppaV8EN0IuEDqeKsVw3iwPEwpjN9DOWsBX79a21f8r9Ao2RP
         33h97kFpy7Cung1njKKyqieFW8pnB9csOQ78VE5Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4.14 45/71] iio: adc: max9611: Fix temperature reading in probe
Date:   Thu, 22 Aug 2019 10:19:20 -0700
Message-Id: <20190822171729.822713666@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190822171726.131957995@linuxfoundation.org>
References: <20190822171726.131957995@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacopo Mondi <jacopo+renesas@jmondi.org>

commit b9ddd5091160793ee9fac10da765cf3f53d2aaf0 upstream.

The max9611 driver reads the die temperature at probe time to validate
the communication channel. Use the actual read value to perform the test
instead of the read function return value, which was mistakenly used so
far.

The temperature reading test was only successful because the 0 return
value is in the range of supported temperatures.

Fixes: 69780a3bbc0b ("iio: adc: Add Maxim max9611 ADC driver")
Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iio/adc/max9611.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/iio/adc/max9611.c
+++ b/drivers/iio/adc/max9611.c
@@ -484,7 +484,7 @@ static int max9611_init(struct max9611_d
 	if (ret)
 		return ret;
 
-	regval = ret & MAX9611_TEMP_MASK;
+	regval &= MAX9611_TEMP_MASK;
 
 	if ((regval > MAX9611_TEMP_MAX_POS &&
 	     regval < MAX9611_TEMP_MIN_NEG) ||


