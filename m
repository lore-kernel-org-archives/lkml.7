Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83928C2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 10:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56B3E21655
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 10:02:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XUFS/11/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbgABKCy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 05:02:54 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38090 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728017AbgABKCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 05:02:53 -0500
Received: by mail-wm1-f65.google.com with SMTP id u2so5150230wmc.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jan 2020 02:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zpVrjWu9aDwxR+gFK4Bj/HRMRoCvr4WMHyXpeXsUZuI=;
        b=XUFS/11/wVNM+/r+f1Vd8xJZWbXqdYDFXoUsCi/mHVhJ2kU96cF9Z0riPvkbtgPWj3
         0lH9gaoXnNQ+wnIlKP/y9N9hcGkLde/8gYk8ikvBA52s4eWyoYK1Eb0UwgfWWvhblYhS
         DVXdgr17dnovrWtGu2yUIjWMhenQkIXA+/K5JkEPuEho7KHrCuz5DO/pE8Q79PTdBcZv
         xX4fKjNTMU7J4Z5fpB/8XQL1AoV97PNicKaDlNji5EGPFTgEOwEOxAevUoLrfBfixvdk
         LvVWWDWgAD+hP3sn/TWVT+Bqd1V1Ns/J92em8pAuluCRSxc91RLuvdrZoFpAVv13Vo2L
         bq/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zpVrjWu9aDwxR+gFK4Bj/HRMRoCvr4WMHyXpeXsUZuI=;
        b=Durfm8Stf7LzQy0Goipr1hZoynzlGpJDKU2LBeenXLtT3Fe4F9iljyvrDAqqK9JdTu
         +VuTtL0kAe/t5rVMkxzwRtTHbtaFojx0XJX0r6WlVUS2l5TCfAt7noGhjO6blvse40i+
         R8HVB2qKsq7EvvHkjxcI4ZKmzb4hfgEnIp/NeJDPsWO9rlBc7n3W3/3A5SECSv0ZSBb8
         gVT2boM4BXmbhnYsgKy0KKmg1yFYRSzR9tQ3mdwPFpxLpto/xKdTT3d/la0tQKPY9UQT
         dY/RpgapTPaPVowpORii63PSt5Vuts1tyncpVk/X3nZ8hRQhzvlSP90NGt/Z13Uvtf25
         SkTw==
X-Gm-Message-State: APjAAAVfMy0yM0H7prwFd7UtsWgIvGWNOxysS5phA7ue0B1/1hfwWRJd
        pPEsRpBcwkQnBEbPk5cTNzRvK2lge7A=
X-Google-Smtp-Source: APXvYqylD8GwBP3d6yFUKkkJNL3QNwwyoYcJUzEPpB2RvAj973nYeo/AuM9KHExhcF+1SgfwUwNTwQ==
X-Received: by 2002:a1c:5f41:: with SMTP id t62mr14472812wmb.42.1577959370957;
        Thu, 02 Jan 2020 02:02:50 -0800 (PST)
Received: from localhost.localdomain (62-178-82-229.cable.dynamic.surfer.at. [62.178.82.229])
        by smtp.gmail.com with ESMTPSA id r6sm55418683wrq.92.2020.01.02.02.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 02:02:50 -0800 (PST)
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Christian Gmeiner <christian.gmeiner@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 4/6] drm/etnaviv: update gc7000 chip identity entry
Date:   Thu,  2 Jan 2020 11:02:18 +0100
Message-Id: <20200102100230.420009-5-christian.gmeiner@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102100230.420009-1-christian.gmeiner@gmail.com>
References: <20200102100230.420009-1-christian.gmeiner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use ~0U as marker for 'I do not care'. I am not sure what
GC7000 based devices are in the wild and I do not want to
break them. In the near future we should extend the hwdb.

Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
---
 drivers/gpu/drm/etnaviv/etnaviv_hwdb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c b/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
index 39b463db76c9..eb0f3eb87ced 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
@@ -9,6 +9,9 @@ static const struct etnaviv_chip_identity etnaviv_chip_identities[] = {
 	{
 		.model = 0x7000,
 		.revision = 0x6214,
+		.product_id = ~0U,
+		.customer_id = ~0U,
+		.eco_id = ~0U,
 		.stream_count = 16,
 		.register_max = 64,
 		.thread_count = 1024,
-- 
2.24.1

