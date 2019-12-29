Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E851C3F68F
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 16:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6BE8207FD
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 16:28:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=globallogic.com header.i=@globallogic.com header.b="Pm/R6mA0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbfL2Q2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 11:28:46 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33624 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbfL2Q2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 11:28:43 -0500
Received: by mail-lj1-f196.google.com with SMTP id y6so23210329lji.0
        for <linux-kernel@vger.kernel.org>; Sun, 29 Dec 2019 08:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=globallogic.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=obMh8XTaHYb/hrwA03bev5cmgIzHacNi7+oYmLrptLw=;
        b=Pm/R6mA0jYabAm6zVxMJIumdUmGH3EQ2cKoUF+Vd2dBswWtQP5bPl1Dm/puplwwbKh
         GEzGix3Z8uQnJdN4ru6pdafLRRrJ6cQ0NQnle23pXKAPmMznIzBYb+STJ5GcNApvJ+5n
         gEgmy8rgYiFeNJRra7bYbDP8A5qflq9AGp61r3vV911nqvzjhr0Crx/SKVBNpKbXROyU
         g32X0PIZeoma0NwQ7puSO/iMqQCRqRhE0fcoO1FFBAskyIJfIhEm2d2oLDxn/17wh7ii
         tfgvNcauleCqWi6weDLypTiO9TcL2a6bVHYGClq5ssHNMWgh+E34pXMTXJcaGk8ewBlQ
         qk6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=obMh8XTaHYb/hrwA03bev5cmgIzHacNi7+oYmLrptLw=;
        b=KTP8vJ3o63J6X/X3wZ76kqp5kvqTjLIOUdAzACarbLstt9d5E65OcBHR1wrbHvoPXU
         27T6vyN508Fv5JtxhnNgi+vtDfZxp94c0dYTQPpzHBBkvBNuBTTPJa7q/9HKQXWzM86v
         8dMK00JvhSJZbI7w/glE7vnMFw6qrOBvfshKnNyaHDbV479AE1C0XG9BJQBGiEtTtKGE
         Ie1FR3DFDA6Fe0WNdqPkYuhyQMncizAGRNwGRM6uyXq/4fLUdZLa1qynxJqrwpVxKpmq
         z5S4XEvfJVnyj1Vq/0Dmz20zhrWZFg0ODqqhCXnpAD6kd4FbmzS6Vm8MzGzTjVHC5jf4
         g2BQ==
X-Gm-Message-State: APjAAAXqJhed4VGuZ/LqknRxVk/UPcCqFgvjvjM7YjbDMWXp+XqKMZfv
        LLJYKflyOk286TzJB3abSEPNxQ==
X-Google-Smtp-Source: APXvYqyk/Z+wI5g5MjHiImymXWVQkPbDZjOPP2utmy1NOg+UkAkIEmkBDnQDeNrAMncBwarAH7oF3Q==
X-Received: by 2002:a2e:9999:: with SMTP id w25mr25471407lji.142.1577636921176;
        Sun, 29 Dec 2019 08:28:41 -0800 (PST)
Received: from virtualhost-PowerEdge-R810.synapse.com ([195.238.92.107])
        by smtp.gmail.com with ESMTPSA id u13sm17284858lfq.19.2019.12.29.08.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Dec 2019 08:28:40 -0800 (PST)
From:   roman.stratiienko@globallogic.com
To:     mripard@kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jernej.skrabec@siol.net
Cc:     Roman Stratiienko <roman.stratiienko@globallogic.com>
Subject: [PATCH v2 4/4] drm/sun4i: Update mixer's internal registers after initialization
Date:   Sun, 29 Dec 2019 18:28:28 +0200
Message-Id: <20191229162828.3326-4-roman.stratiienko@globallogic.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191229162828.3326-1-roman.stratiienko@globallogic.com>
References: <20191229162828.3326-1-roman.stratiienko@globallogic.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Stratiienko <roman.stratiienko@globallogic.com>

At system start blink of u-boot ghost framebuffer can be observed.
Fix it.

Fixes: 9d75b8c0b999 ("drm/sun4i: add support for Allwinner DE2 mixers")
Signed-off-by: Roman Stratiienko <roman.stratiienko@globallogic.com>
Reviewed-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
v2:
- Picked 'Reviewed-by' line
- Added 'Fixes' line
---
 drivers/gpu/drm/sun4i/sun8i_mixer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
index 5d90a95ff855..86711d8a9c84 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -576,6 +576,9 @@ static int sun8i_mixer_bind(struct device *dev, struct device *master,
 	regmap_update_bits(mixer->engine.regs, SUN8I_MIXER_BLEND_PIPE_CTL(base),
 			   SUN8I_MIXER_BLEND_PIPE_CTL_EN_MSK, 0);
 
+	regmap_write(mixer->engine.regs, SUN8I_MIXER_GLOBAL_DBUFF,
+		     SUN8I_MIXER_GLOBAL_DBUFF_ENABLE);
+
 	return 0;
 
 err_disable_bus_clk:
-- 
2.17.1

