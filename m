Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8DEEC5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 10:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9752C217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 10:49:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="kxBJiJoC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731531AbfKFKtn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 05:49:43 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:32814 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbfKFKtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 05:49:43 -0500
Received: by mail-wr1-f66.google.com with SMTP id w30so2452062wra.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 02:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kl4ziYImo8mxXSUIUzerWcurMfUG2nKE46XW1BkCvlw=;
        b=kxBJiJoCz+uvEjlaoHMgcQr+fPhAS0j2sc8HQCdJjk0eOme7VQHHlm3TDIUwxNStV/
         IAr8TqzToP3BUIwWnA7k3eNZDWdns4KTC1BChbku6s+9vm65UyDEPJIgV4KXwCKpfUHR
         3GqU0MH9ui+CytCItnEbyCTbgcvYV7VjZW0QGrt/jtVusHHPs8WevG+USUqczTgjBlq4
         kD6WEBWIFfNMsOfhxJRESwTtuQfvK5JMtJdJfKFxXFe+hKKplRvMHMUAf5DaA7nMaRw9
         2q24dcf3jUtUASsUuACt6r/sejqO/Dx1+pNfRBy3dce6DwxTECCghcvZySDx55qOM/c5
         OeWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kl4ziYImo8mxXSUIUzerWcurMfUG2nKE46XW1BkCvlw=;
        b=FTeFX6EOFutnI8Hkj3FJc55qIvQVsGkVJjcxxdfhdRgKWfJGBJumEG/HJuVbSXWTEO
         RZSRreotYyEgPyD0OIwte/fyUEj5DX2VGcwaMEiNX8NNLG2Wztj8a/o82EE3pnDwG9uS
         q4Ke2QSgzSOFwKE35qB3XY1+ewIkaRJGrWESvzWJIZFPzl6s2lmAZCzyjX/VolbTpvEi
         VsiMjp/xGayeV458U9q8Pk5lPXlJhWxCo7cVerxWx7g9uLPS0DTsJ4Sg8DQ6bI3m0tg9
         f6H0dTXPVOEGkxJ1D36MdR1GzN2fCMqBORzknRTisuwBuHHAvRaD1J+AR6aOIosIT7kW
         nptA==
X-Gm-Message-State: APjAAAXjZmM1PRlOiLQcjSFEpmUHn+m8HrjG/4oGw19IVa+TTcVZEqu3
        sdPP27tfyIEd92eteiybp+yhftUNdDZYMQ==
X-Google-Smtp-Source: APXvYqzq1lHX4GDEZEPtsCJdyQnYK9ZIjkX+6ml9wEgDrjlLUn4+3HRgIK41WbnzWNEb4WSW+nUPmg==
X-Received: by 2002:a5d:6789:: with SMTP id v9mr1978787wru.344.1573037381252;
        Wed, 06 Nov 2019 02:49:41 -0800 (PST)
Received: from bender.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id b14sm2331695wmj.18.2019.11.06.02.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 02:49:40 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     hverkuil@xs4all.nl, mchehab@kernel.org
Cc:     linux-amlogic@lists.infradead.org, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH] MAINTAINERS: ao-cec: Update path for yaml bindings
Date:   Wed,  6 Nov 2019 11:49:35 +0100
Message-Id: <20191106104935.24307-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the path to the ao-cec bindings after convertion to DT Schemas.

Suggested-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 296de2b51c83..11108701cadf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10581,7 +10581,7 @@ W:	http://linux-meson.com/
 S:	Supported
 F:	drivers/media/platform/meson/ao-cec.c
 F:	drivers/media/platform/meson/ao-cec-g12a.c
-F:	Documentation/devicetree/bindings/media/meson-ao-cec.txt
+F:	Documentation/devicetree/bindings/media/amlogic,meson-gx-ao-cec.yaml
 T:	git git://linuxtv.org/media_tree.git
 
 MESON NAND CONTROLLER DRIVER FOR AMLOGIC SOCS
-- 
2.22.0

