Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F9BC5B578
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 03:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D0A42086D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 03:39:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Qn7AHdhR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbfGADj1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Jun 2019 23:39:27 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60172 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbfGADj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jun 2019 23:39:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WmShzI9iFuKGxmB8xLb0p4KOmNmec9AETrO7/tG34T0=; b=Qn7AHdhRQFyigFqNMTVizzZAh
        Hj1RMvU2sMlXLkyWgMj2cs6q9Szx7vdGU9yu9gioYef22lNmR+J/sSdAGE/a9kJ7jDVEzh2TvlX8S
        w4lQZqPLfIN9OrKs1wcdZfEtFVlS/qKdMDbabY8NP11WGPzugE6MPTCKjQPvvw2gTOlJu0Cd4fbC5
        28HpYaANDX9JJyU5Z06cEFF4awRRUdiBd3rPlAG7ywv4wyFkgMZM2N2bs2qf2N540acZkpYW06R5/
        12BcK9+TFp3iMWKrw0cJtcEMk/4LllcBxMcUJ6NURE27oul16kBfEmLW+tR6bf8MIdwPT59iYyqwu
        2+Pw6KL3Q==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hhnA2-0005HP-JY; Mon, 01 Jul 2019 03:39:22 +0000
To:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Inki Dae <inki.dae@samsung.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] drm: bridge: DRM_SIL_SII8620 should depend on, not select
 INPUT
Message-ID: <8baa25c0-498b-d321-4e6a-fe987a4989ba@infradead.org>
Date:   Sun, 30 Jun 2019 20:39:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

A single driver should not enable (select) an entire subsystem,
such as INPUT, so change the 'select' to "depends on".

Fixes: d6abe6df706c ("drm/bridge: sil_sii8620: do not have a dependency of RC_CORE")

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Inki Dae <inki.dae@samsung.com>
Cc: Andrzej Hajda <a.hajda@samsung.com>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org
---
Linus has written this a couple of times in the last 15 years or so,
but my search fu cannot find it.  And there are a few drivers in the
kernel tree that do this, but we shouldn't be adding more that do so.

 drivers/gpu/drm/bridge/Kconfig |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- lnx-52-rc7.orig/drivers/gpu/drm/bridge/Kconfig
+++ lnx-52-rc7/drivers/gpu/drm/bridge/Kconfig
@@ -83,10 +83,9 @@ config DRM_PARADE_PS8622
 
 config DRM_SIL_SII8620
 	tristate "Silicon Image SII8620 HDMI/MHL bridge"
-	depends on OF
+	depends on OF && INPUT
 	select DRM_KMS_HELPER
 	imply EXTCON
-	select INPUT
 	select RC_CORE
 	help
 	  Silicon Image SII8620 HDMI/MHL bridge chip driver.


