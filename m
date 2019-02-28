Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4BE5C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 22:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67773218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 22:17:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="o2tTkXWP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbfB1WRp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:17:45 -0500
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:54696 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726203AbfB1WRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 17:17:45 -0500
Received: from nis-sj1-27.broadcom.com (nis-sj1-27.lvn.broadcom.net [10.75.144.136])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id 374F130C041;
        Thu, 28 Feb 2019 14:17:43 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com 374F130C041
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1551392263;
        bh=CCd6yypswlM4xGV+ZzfyYO6YjL4Q5DmUlzfNaCiLAP4=;
        h=From:To:Cc:Subject:Date:From;
        b=o2tTkXWPKHcxvhyoHNoKG2buOo0iUTrb+h8Emlj/0JVl7jsSsXAwS6iu9M9BH3qoq
         ECYxiJM+Bu1a4mxl0YK6WGf8iS23+E9CK9XAjljKwNx2vErfZwC+MT27LcT7O5gIm2
         vYK2dVS+VaAoafT9TbQJ4zCOouJNTxo77Aui47e0=
Received: from stbirv-lnx-2.igp.broadcom.net (stbirv-lnx-2.igp.broadcom.net [10.67.48.34])
        by nis-sj1-27.broadcom.com (Postfix) with ESMTP id 87943AC0761;
        Thu, 28 Feb 2019 14:17:43 -0800 (PST)
Received: by stbirv-lnx-2.igp.broadcom.net (Postfix, from userid 47169)
        id 79D1727ECE7; Thu, 28 Feb 2019 14:17:43 -0800 (PST)
From:   justinpopo6@gmail.com
To:     linux-iio@vger.kernel.org
Cc:     linux-gpio@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        f.fainelli@gmail.com, bgolaszewski@baylibre.com,
        linus.walleij@linaro.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-kernel@vger.kernel.org,
        Justin Chen <justinpopo6@gmail.com>
Subject: [PATCH v4 0/2] iio: adc: ads7950: add gpio support
Date:   Thu, 28 Feb 2019 14:16:47 -0800
Message-Id: <1551392209-20004-1-git-send-email-justinpopo6@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Justin Chen <justinpopo6@gmail.com>

Add GPIO support for ads7950.

v4
Split patch into two commits.
Refractored code to capture the state of the adc instead of only the GPIOs.
Added comments to clarify the intend of the code.
Fix improper use of mlock.

Justin Chen (2):
  iio: adc: ti-ads7950: Fix improper use of mlock
  iio: adc: ti-ads7950: add GPIO support

 drivers/iio/adc/ti-ads7950.c | 219 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 209 insertions(+), 10 deletions(-)

-- 
2.7.4

