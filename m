Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE59C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 05:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FD7421479
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 05:28:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e4faZ1Tb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731122AbfFSF2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 01:28:19 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44083 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730937AbfFSF1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 01:27:45 -0400
Received: by mail-pf1-f196.google.com with SMTP id t16so9005971pfe.11
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 22:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I9w3vbYRNonfWwiM3GpCHW7GL5rSQ3YHcxXb/k2AGzQ=;
        b=e4faZ1Tb0y/joGNp4jAM/quBbn7kTkp85v5l+MniGlO1En0q9WBorUk9hf9Y97tFTq
         ZdMzPNxuFK3om4VrzJxDvTTRzt46zi9q4ttSLLbDLAywQfbWqn/08QLkj+WEiZnHPsLP
         H+1/yNdsA6HkKlyeH/0OXX5mdjV1VczjnWwa1w93j6VyPefOz/T6Fddk9weT4/FpX1QW
         OUT5roGJtUqo4BCGHC2iW/wfu2UYMok5WSKCl1b7tal3r3rh0SaveusuL2QlB9sHUMj6
         odZayasDNNjgvisog0BcY6wvbTuycgXdCCkvyV6bfm4oAXbFFnuuyD2cAWUbL1uu+DQ6
         nVFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I9w3vbYRNonfWwiM3GpCHW7GL5rSQ3YHcxXb/k2AGzQ=;
        b=Y22pPxOdYNooU3KZTf8Buqa+F3NQGb80FkzVoCQ6yUsQX6RveuhtiGyjv29MYxzJK8
         PP12CJSfJwCOn+ngnKFCN7nOVxAX+hLgV3EpFixAckVMxOR2nHozuZFzYIeUU2Z4eSwD
         MBddpKYo17Q7InZGy1G/cP5tu7VK8zdyTVcjYkvgzxNADw4l+aogz6lERdflYSdUQFmg
         43ONDHW8IkP2ELihDI+1S7LJA8DcKQxYgZkKfDHj1TBErkmapbzmjO9nWmL9hhapk6Vp
         ucFky1SIojyxTSp31pDUEtVTZTN4wXCebS9Zqcuwfur0G42k5+pgUWW10HOiafkkCGHO
         82pg==
X-Gm-Message-State: APjAAAW9604/4rBi7YFP2yaFek4B7M2CQ/yGkfb7Rvj/HSnM0/qjdUZN
        h4erv5dfABN/GwYuKp4P4L8=
X-Google-Smtp-Source: APXvYqz1q735f/rQV+0Af9T5y76kSlcoPs77OeglZPrfHTAGXQwp2lSRMMEYN8SJvQKfZfqtlR3dMw==
X-Received: by 2002:a65:508b:: with SMTP id r11mr5840715pgp.387.1560922064349;
        Tue, 18 Jun 2019 22:27:44 -0700 (PDT)
Received: from localhost.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id l44sm534742pje.29.2019.06.18.22.27.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 22:27:43 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Andrey Gusakov <andrey.gusakov@cogentembedded.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Cory Tusar <cory.tusar@zii.aero>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 08/15] drm/bridge: tc358767: Increase AUX transfer length limit
Date:   Tue, 18 Jun 2019 22:27:09 -0700
Message-Id: <20190619052716.16831-9-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190619052716.16831-1-andrew.smirnov@gmail.com>
References: <20190619052716.16831-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the datasheet tc358767 can transfer up to 16 bytes via
its AUX channel, so the artificial limit of 8 appears to be too
low. However only up to 15-bytes seem to be actually supported and
trying to use 16-byte transfers results in transfers failing
sporadically (with bogus status in case of I2C transfers), so limit it
to 15.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
Cc: Andrzej Hajda <a.hajda@samsung.com>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Andrey Gusakov <andrey.gusakov@cogentembedded.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Cory Tusar <cory.tusar@zii.aero>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/gpu/drm/bridge/tc358767.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index a441e8e66287..bdbf88057946 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -354,7 +354,7 @@ static ssize_t tc_aux_transfer(struct drm_dp_aux *aux,
 			       struct drm_dp_aux_msg *msg)
 {
 	struct tc_data *tc = aux_to_tc(aux);
-	size_t size = min_t(size_t, 8, msg->size);
+	size_t size = min_t(size_t, DP_AUX_MAX_PAYLOAD_BYTES - 1, msg->size);
 	u8 request = msg->request & ~DP_AUX_I2C_MOT;
 	int ret;
 
-- 
2.21.0

