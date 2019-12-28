Return-Path: <SRS0=tgXE=2S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E80ACC2D0C8
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 20:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE405218AC
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 20:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=globallogic.com header.i=@globallogic.com header.b="Av9foxRe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfL1U2x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Dec 2019 15:28:53 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42440 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbfL1U2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Dec 2019 15:28:52 -0500
Received: by mail-pl1-f195.google.com with SMTP id p9so13103190plk.9
        for <linux-kernel@vger.kernel.org>; Sat, 28 Dec 2019 12:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=globallogic.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KOo3X0X88vmmzo/eTEi6Meu4cmZqVttPr6kyKScWgTk=;
        b=Av9foxReTwVBkrERfdI7jObfw7XU7uwXaEfaCXIqfLHdVEXqrCSYJ39gOZKjlp2kes
         0xFAmV9nUD99y/X+MHgPFTebv83wZASZYC7z1eBXvo4wftRBJPOECX12nkf2h0LN/jQc
         QNd7ypLlyARjjLmKnVPpnzk9FUDoq6IRH5r5Pu/+DV35NkLCfa35cq6oEtkARtRKH1pI
         UmMV7yiR6GAqqAnteEQLEErxIMlqV7ysoaokTvMUMgm9/vg1IrI6PKjq/OjkztjUHf8E
         C5ej8G1xJ/lzDUgd63jscyelh8JhuB9rPoHnZGODxNPlZRIo0pSfVW8Iq2QQZ9UJZEEW
         W10w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KOo3X0X88vmmzo/eTEi6Meu4cmZqVttPr6kyKScWgTk=;
        b=jR+ZhQMJqOIXN4HWwpzNyhbNFxHbiZv0Qj3X+nHmRLr+j4OkqrbvblrNDKZQgDuLCs
         hEMOgRW30YbDkDxw0lgAg4K5dUCP3ugYb9uFZnCc4X4iqBJDOY4/BFUt3BvjTwRfT45M
         7zP2bgN1OLlnoEI2DBGJgUCgJ5G9vCzPqRH7o1OrbWT14mCxetG7LM0FqLug2ENzFvVt
         yWLjHk7tGcrFaJVxPVI9Gddz/y1ryBjR4fmOfZzXQJ5GHoGv5VlZTd0jWkf9RqqomE6T
         Yclmdqj/JbVEpjUOW+BL3FdTlJUCncNeDM/YM5zHsDfmFh9aup7oVqUxGzSJWsPMdFkm
         itmg==
X-Gm-Message-State: APjAAAVa/W/Yh5HnDXZuzI96oDIhpV3HVeNn4cGbnDDDiKG1affnGrBS
        QSVbhsR364GihG9/GBTeOkAWFQ==
X-Google-Smtp-Source: APXvYqy26/nSwCXwDQ5FV/Q/JeyaQxDibPHagpFbTwkrpyLRDOjoMJfa0xhhgtqgIqdL3EaJKpEQIQ==
X-Received: by 2002:a17:90a:b392:: with SMTP id e18mr35842386pjr.118.1577564931719;
        Sat, 28 Dec 2019 12:28:51 -0800 (PST)
Received: from virtualhost-PowerEdge-R810.synapse.com ([195.238.92.107])
        by smtp.gmail.com with ESMTPSA id i68sm46771169pfe.173.2019.12.28.12.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Dec 2019 12:28:51 -0800 (PST)
From:   roman.stratiienko@globallogic.com
To:     mripard@kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jernej.skrabec@siol.net
Cc:     Roman Stratiienko <roman.stratiienko@globallogic.com>
Subject: [RFC 4/4] drm/sun4i: Update mixer's internal registers after initialization
Date:   Sat, 28 Dec 2019 22:28:18 +0200
Message-Id: <20191228202818.69908-5-roman.stratiienko@globallogic.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191228202818.69908-1-roman.stratiienko@globallogic.com>
References: <20191228202818.69908-1-roman.stratiienko@globallogic.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Stratiienko <roman.stratiienko@globallogic.com>

At system start blink of u-boot ghost framebuffer can be observed.
Fix it.

Signed-off-by: Roman Stratiienko <roman.stratiienko@globallogic.com>
---
 drivers/gpu/drm/sun4i/sun8i_mixer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
index da84fccf7784..b906b8cc464e 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -588,6 +588,9 @@ static int sun8i_mixer_bind(struct device *dev, struct device *master,
 	regmap_update_bits(mixer->engine.regs, SUN8I_MIXER_BLEND_PIPE_CTL(base),
 			   SUN8I_MIXER_BLEND_PIPE_CTL_EN_MSK, 0);
 
+	regmap_write(mixer->engine.regs, SUN8I_MIXER_GLOBAL_DBUFF,
+		     SUN8I_MIXER_GLOBAL_DBUFF_ENABLE);
+
 	return 0;
 
 err_disable_bus_clk:
-- 
2.17.1

