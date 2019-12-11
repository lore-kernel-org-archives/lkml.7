Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 040B0C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 20:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C63D72077B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 20:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PF8au3HQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbfLKUe1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 15:34:27 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55329 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbfLKUe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 15:34:27 -0500
Received: by mail-wm1-f65.google.com with SMTP id q9so8681593wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 12:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ay3f3rT2lIE/YLLclQUtZpfeBy9nlJ24/EEgRhfGiC0=;
        b=PF8au3HQR1eqluFaFL53LckQ0Bb8b63nBLP6nikHTHqJDuxe+HOW4KYt4zwoujaqN7
         4w2WsVnVazgnTClmMmFzNVeTUZjybaGKYCKUnNxQ6EZ3cVn6z2Wx022vhVpZWYhb20kr
         bemICY4xER1Fu4E7h5VldEUJT7GM6KwZG2sk5PmVmzk4FeKh0omelxjLQDQizS8eH+zW
         t1qdAHk2ucKD8l9QFqah8j30a5uH6fTtFMQsJIh0GCpDc2ZGPCL/xlCjMfXeVoC6b9Zx
         2BKcBDKVNAk+aPF8Ob+45EiTqTCoYM+ceBHhmlmA9aygTeTbg6j4XrsyRuX/WoU+v+sG
         XXEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ay3f3rT2lIE/YLLclQUtZpfeBy9nlJ24/EEgRhfGiC0=;
        b=eK8Dr7+OoDZe/y8ym8SQS6vWbb6mSjrokV2vqs1FC0jZzo7QI9UvxftecNyQoa+WGo
         0mHl2xHd21gK5roTVbDHNOiR/rtVadBCC6Iycj199E96m7KFs/soJ+tgjv+gVrlSvfuM
         CfPZQNd2yE1hL2QUq72SwYSXkI0nxXMFj0oJew/C53EvKMwrBUev9ncHaxnjnGT78LRS
         tIM0coBz2qDCJ0u3AxXE0PFVG4GyNsCKZu5X2mE/kgHo0sA5LU2iMwzQFZ+4yk0WHQu/
         LootEoC37oZmWSqzvizh1vOLvw7L7BgSldv3i4wB2Jt/nNmgpB1iTCLzgqMwtnUlFkd+
         neKw==
X-Gm-Message-State: APjAAAWC4U9HY61S8d/HBbvwSkHFjQte8vdX9bUscK9uxjIPosQoAToN
        TMrq9tkGvMSTVDP1ebI5ZxQ=
X-Google-Smtp-Source: APXvYqzhm9FQTbLSQdyxkyTBzlLdW76xtMpj86Wjh0eyAQfZbUY8wn2OHCfgKaSsdbWAdCAMLy04HQ==
X-Received: by 2002:a7b:ca4e:: with SMTP id m14mr1816757wml.120.1576096465412;
        Wed, 11 Dec 2019 12:34:25 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id z6sm3661709wrw.36.2019.12.11.12.34.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Dec 2019 12:34:24 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     hjc@rock-chips.com, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm: rockchip: rk3066_hdmi: set edid fifo address
Date:   Wed, 11 Dec 2019 21:34:17 +0100
Message-Id: <20191211203417.19448-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nickey Yang <nickey.yang@rock-chips.com>

Fix edid reading error when edid's block > 2.

Signed-off-by: Nickey Yang <nickey.yang@rock-chips.com>
Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 drivers/gpu/drm/rockchip/rk3066_hdmi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rk3066_hdmi.c b/drivers/gpu/drm/rockchip/rk3066_hdmi.c
index cdb401f42..945126948 100644
--- a/drivers/gpu/drm/rockchip/rk3066_hdmi.c
+++ b/drivers/gpu/drm/rockchip/rk3066_hdmi.c
@@ -640,6 +640,9 @@ static int rk3066_hdmi_i2c_write(struct rk3066_hdmi *hdmi, struct i2c_msg *msgs)
 	if (msgs->addr == DDC_ADDR)
 		hdmi->i2c->ddc_addr = msgs->buf[0];
 
+	/* Set edid fifo first address. */
+	hdmi_writeb(hdmi, HDMI_EDID_FIFO_ADDR, 0x00);
+
 	/* Set edid word address 0x00/0x80. */
 	hdmi_writeb(hdmi, HDMI_EDID_WORD_ADDR, hdmi->i2c->ddc_addr);
 
-- 
2.11.0

