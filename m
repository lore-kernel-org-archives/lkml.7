Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDAC7C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92BDE206BF
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566893111;
	bh=6/LSERst0QCgem5FWEXCFqLvc3K/txrFkPNguJrGEq8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CDeSGo+gLNEqfTCaIjj2y2gLuw6eEqCS/wcWyTRpd9VnzhJAYsQYWv95r691nJTIx
	 5nX9mgVvP7jseiN8xjVc831Yf5zbj1HCxETMOd19q3sA+ynGL/9zkYDdT3KW5ygnds
	 Vxq1ZwQWUDCulcY1l4E5dPY9I8wMdHxhgHMfBgD8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732711AbfH0IFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 04:05:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:34680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731504AbfH0IFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 04:05:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A755E206BF;
        Tue, 27 Aug 2019 08:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566893103;
        bh=6/LSERst0QCgem5FWEXCFqLvc3K/txrFkPNguJrGEq8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NlCqGaMLUJMVeRYbbi/jKoffDLj0c6UVUAVOoAyFCp3Q3vjIn+CbY61FXO14/Xi/J
         QidZ8fB9BS4uBn39xI56gFCRw99Ge11uYXY+1HRrIfc84eD0tKgAzMCqEq2lAZJx+9
         kcpm7g5HfmfOgLIFAw2Gy9gcOvIZXB3YlauW/JVY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 5.2 122/162] gpiolib: never report open-drain/source lines as input to user-space
Date:   Tue, 27 Aug 2019 09:50:50 +0200
Message-Id: <20190827072742.714900074@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190827072738.093683223@linuxfoundation.org>
References: <20190827072738.093683223@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

commit 2c60e6b5c9241b24b8b523fefd3e44fb85622cda upstream.

If the driver doesn't support open-drain/source config options, we
emulate this behavior when setting the direction by calling
gpiod_direction_input() if the default value is 0 (open-source) or
1 (open-drain), thus not actively driving the line in those cases.

This however clears the FLAG_IS_OUT bit for the GPIO line descriptor
and makes the LINEINFO ioctl() incorrectly report this line's mode as
'input' to user-space.

This commit modifies the ioctl() to always set the GPIOLINE_FLAG_IS_OUT
bit in the lineinfo structure's flags field. Since it's impossible to
use the input mode and open-drain/source options at the same time, we
can be sure the reported information will be correct.

Fixes: 521a2ad6f862 ("gpio: add userspace ABI for GPIO line information")
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Link: https://lore.kernel.org/r/20190806114151.17652-1-brgl@bgdev.pl
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpio/gpiolib.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1091,9 +1091,11 @@ static long gpio_ioctl(struct file *filp
 		if (test_bit(FLAG_ACTIVE_LOW, &desc->flags))
 			lineinfo.flags |= GPIOLINE_FLAG_ACTIVE_LOW;
 		if (test_bit(FLAG_OPEN_DRAIN, &desc->flags))
-			lineinfo.flags |= GPIOLINE_FLAG_OPEN_DRAIN;
+			lineinfo.flags |= (GPIOLINE_FLAG_OPEN_DRAIN |
+					   GPIOLINE_FLAG_IS_OUT);
 		if (test_bit(FLAG_OPEN_SOURCE, &desc->flags))
-			lineinfo.flags |= GPIOLINE_FLAG_OPEN_SOURCE;
+			lineinfo.flags |= (GPIOLINE_FLAG_OPEN_SOURCE |
+					   GPIOLINE_FLAG_IS_OUT);
 
 		if (copy_to_user(ip, &lineinfo, sizeof(lineinfo)))
 			return -EFAULT;


