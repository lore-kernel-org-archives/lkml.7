Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B24FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 412D021925
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571263548;
	bh=VzvKXf/eSkh8Hjew72eGtwuYBVG6o2WsuPOtlIZWYAs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Xbb7j3UXCO3UaVazgWl+KWbOe+4FlEkX6K846OV9zsDYaXePybVzNXQuM+l+fNQtY
	 al4sG0QuGfO5aABysvkQVcVgmIAhjvS+sED5DFEKthLviZ8h9UsiR53kbHy0prZD7m
	 PQ/ItwaLCJ8cMhnuwDH8UXmW7QCQXt9MPVqc+//c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406919AbfJPWFo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 18:05:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:52568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438244AbfJPV6o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:58:44 -0400
Received: from localhost (unknown [192.55.54.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2F3C21A49;
        Wed, 16 Oct 2019 21:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571263123;
        bh=VzvKXf/eSkh8Hjew72eGtwuYBVG6o2WsuPOtlIZWYAs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C/f4TB8mMPqjbM7CxuaCC+3eWaSuvcDQZfpVxBoEOHjSr2F5/Xmm6B3r6d4nZXD4k
         7wcEvhwVJL0/opSUtUuJU7LGvwOyA/DAv/w6nJeJzrLzILVS1EpV8z6bXCyUkuzws0
         7Ddhn/BYyqY2Pk0j8vGaR2nYv5YjwFMA/qpJpG6s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>
Subject: [PATCH 5.3 047/112] staging/fbtft: Depend on OF
Date:   Wed, 16 Oct 2019 14:50:39 -0700
Message-Id: <20191016214855.113292089@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016214844.038848564@linuxfoundation.org>
References: <20191016214844.038848564@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Noralf Trønnes <noralf@tronnes.org>

commit 63f2b1677fba11c5bd02089f25c13421948905f5 upstream.

Commit c440eee1a7a1 ("Staging: fbtft: Switch to the gpio descriptor
interface") removed setting gpios via platform data. This means that
fbtft will now only work with Device Tree so set the dependency.

This also prevents a NULL pointer deref on non-DT platform because
fbtftops.request_gpios is not set in that case anymore.

Fixes: c440eee1a7a1 ("Staging: fbtft: Switch to the gpio descriptor interface")
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Noralf Trønnes <noralf@tronnes.org>
Link: https://lore.kernel.org/r/20190917171843.10334-1-noralf@tronnes.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/fbtft/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/staging/fbtft/Kconfig
+++ b/drivers/staging/fbtft/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 menuconfig FB_TFT
 	tristate "Support for small TFT LCD display modules"
-	depends on FB && SPI
+	depends on FB && SPI && OF
 	depends on GPIOLIB || COMPILE_TEST
 	select FB_SYS_FILLRECT
 	select FB_SYS_COPYAREA


