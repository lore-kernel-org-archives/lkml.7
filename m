Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2830BC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF8FD21741
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574888235;
	bh=WajqnPq4dsx7I+SPiCmzJ+aTu8m7lvldsvZsRlaltAs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AYVKIvqHjESx9m0mmq/ngOxO6tK/IAm88zAVhMby0C8DQ2nC4eN8yX4+2E4Ht+FPb
	 /BvjDmZ0g1+mlswhaHhpBfNNrabNeuwWRKQlSA7llclo7fJcnCNn9/JcGOuZ3lf2f9
	 2WoeTNy0Wzs0KetSAGlE0ovN01uZxqei1J4KW+cQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731157AbfK0U5N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:57:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:48104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730235AbfK0U5L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:57:11 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CD962084D;
        Wed, 27 Nov 2019 20:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574888230;
        bh=WajqnPq4dsx7I+SPiCmzJ+aTu8m7lvldsvZsRlaltAs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xW781Gt0eDdyP2tr6/9zIIfphv/BUWL7FneqZFCMLWH/Lc7yQzuQNrHcUw1K6M4yh
         sKOsyL26PKjjdA//+aQEoOuGIWlZ68oFcf3Gu1xpdaDYdFCuhEChoT626N7UKigPE5
         btUIOTFV+Z2FQDg9IhzgnGnJKUKLpl4zZaNwOGK0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Machek <pavel@denx.de>,
        Thierry Reding <treding@nvidia.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 4.19 012/306] gpio: max77620: Fixup debounce delays
Date:   Wed, 27 Nov 2019 21:27:42 +0100
Message-Id: <20191127203115.617058049@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203114.766709977@linuxfoundation.org>
References: <20191127203114.766709977@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

commit b0391479ae04dfcbd208b9571c375064caad9a57 upstream.

When converting milliseconds to microseconds in commit fffa6af94894
("gpio: max77620: Use correct unit for debounce times") some ~1 ms gaps
were introduced between the various ranges supported by the controller.
Fix this by changing the start of each range to the value immediately
following the end of the previous range. This way a debounce time of,
say 8250 us will translate into 16 ms instead of returning an -EINVAL
error.

Typically the debounce delay is only ever set through device tree and
specified in milliseconds, so we can never really hit this issue because
debounce times are always a multiple of 1000 us.

The only notable exception for this is drivers/mmc/host/mmc-spi.c where
the CD GPIO is requested, which passes a 1 us debounce time. According
to a comment preceeding that code this should actually be 1 ms (i.e.
1000 us).

Reported-by: Pavel Machek <pavel@denx.de>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Acked-by: Pavel Machek <pavel@denx.de>
Cc: <stable@vger.kernel.org>
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpio/gpio-max77620.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/gpio/gpio-max77620.c
+++ b/drivers/gpio/gpio-max77620.c
@@ -163,13 +163,13 @@ static int max77620_gpio_set_debounce(st
 	case 0:
 		val = MAX77620_CNFG_GPIO_DBNC_None;
 		break;
-	case 1000 ... 8000:
+	case 1 ... 8000:
 		val = MAX77620_CNFG_GPIO_DBNC_8ms;
 		break;
-	case 9000 ... 16000:
+	case 8001 ... 16000:
 		val = MAX77620_CNFG_GPIO_DBNC_16ms;
 		break;
-	case 17000 ... 32000:
+	case 16001 ... 32000:
 		val = MAX77620_CNFG_GPIO_DBNC_32ms;
 		break;
 	default:


