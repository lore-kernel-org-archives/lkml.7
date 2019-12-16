Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B49C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6BB320717
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576520187;
	bh=3Qd5hzpmn3rrcoWEHRcr2ign7r0UPPijDyHlYd44t70=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CzzGUE6D+VvkrYNwI49hP03zmX6wAMJHCatTgF+H6/JDca0eBkiby9OxalNOSK/0a
	 5eOtEBxKxZPvpM9gV0g+OlJdMVbWYv7xMHuBeSqCSXlwwIZrmrosViv7O2p6WQv3bV
	 zU4agh8s4BEFVhTv4DWDHueDxhVvnkddEQgmJoeg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731531AbfLPSQ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:16:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:38688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731498AbfLPSQW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:16:22 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8619206EC;
        Mon, 16 Dec 2019 18:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576520181;
        bh=3Qd5hzpmn3rrcoWEHRcr2ign7r0UPPijDyHlYd44t70=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w3BiCqKW7grnV2sfnujT/AEy4IPikejqcZ5Poe5bAbYLimoE1JJqhQT8fVVvaImt0
         gR2NCLRCli14BURJq6VswevTWzRwjIINvBz0wntHX6FExjM2BfQAJvmMYjaYHi+DYv
         S40cSLfQS8F1UWhL4oJXWNU/rx7W98m4j8te7ov0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Robert=20W=C3=B6rle?= <rwoerle@mibtec.de>,
        Beniamin Bia <beniamin.bia@analog.com>, Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 5.4 042/177] iio: adc: ad7606: fix reading unnecessary data from device
Date:   Mon, 16 Dec 2019 18:48:18 +0100
Message-Id: <20191216174829.672720972@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174811.158424118@linuxfoundation.org>
References: <20191216174811.158424118@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Beniamin Bia <beniamin.bia@analog.com>

commit 341826a065660d1b77d89e6335b6095cd654271c upstream.

When a conversion result is being read from ADC, the driver reads the
number of channels + 1 because it thinks that IIO_CHAN_SOFT_TIMESTAMP
is also a physical channel. This patch fixes this issue.

Fixes: 2985a5d88455 ("staging: iio: adc: ad7606: Move out of staging")
Reported-by: Robert Wörle <rwoerle@mibtec.de>
Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iio/adc/ad7606.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -85,7 +85,7 @@ err_unlock:
 
 static int ad7606_read_samples(struct ad7606_state *st)
 {
-	unsigned int num = st->chip_info->num_channels;
+	unsigned int num = st->chip_info->num_channels - 1;
 	u16 *data = st->data;
 	int ret;
 


