Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC66C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58D082075C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574890956;
	bh=PQFfqQZTJt8OhFGzdF6KtpgMwrzOwM6x4oU3BMvFibs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gmgzXGeNC1lmMJLumLzFGvJTFALU/zWsSZEMPXqCJ2or0IVStDk41NJojCeu5GUFg
	 wmPsSn09b660ifkF/HUdqi9MmXJ+KCdGNmlspoDg72w1a+QnZQWGfoSR37yXtSbTw2
	 KMWT0Zjteozifyv9Bacpf9iVG9pBLvXHvOYZ3OQs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbfK0Vmf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 16:42:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:44574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727269AbfK0UkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:40:07 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C75C21774;
        Wed, 27 Nov 2019 20:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574887206;
        bh=PQFfqQZTJt8OhFGzdF6KtpgMwrzOwM6x4oU3BMvFibs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fsn3t79rZn7CqgFN6W5OZR6mVGwsdqht0c1ieERIhvxIlkmhcew59omYV0S3Bhp/Y
         sx+U1Ev7SObpyrpm7umGdXk+neZymeZ9WA+OyAHmMYi1dBtGmoEpCvQbZ1nfmn3MTn
         UmZdpbkcE+Z2aNHbZPiMlAv5/aS7BNE0lPVFtzzE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Machek <pavel@denx.de>,
        Thierry Reding <treding@nvidia.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 4.9 006/151] gpio: max77620: Fixup debounce delays
Date:   Wed, 27 Nov 2019 21:29:49 +0100
Message-Id: <20191127203004.790459008@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203000.773542911@linuxfoundation.org>
References: <20191127203000.773542911@linuxfoundation.org>
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
@@ -167,13 +167,13 @@ static int max77620_gpio_set_debounce(st
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


