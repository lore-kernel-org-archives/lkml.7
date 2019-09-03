Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6778C3A5A8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 06:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CB5B217D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 06:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z4AVnwpG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbfICG7h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 02:59:37 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40871 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbfICG7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 02:59:37 -0400
Received: by mail-pg1-f195.google.com with SMTP id w10so8590533pgj.7
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 23:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Qa2NPAU3nUxhMhka8HdV81hTcVfR5ad6LZDKEEK+E8I=;
        b=Z4AVnwpG4rHHCb7eTykmNN4YGIgNaMlnQTD+N+iPSXwRNBG+coPsaxg9Nwq3x3Wkte
         JCHjLySZ867EN8Z2AeH8mah4+X/bfHodXgETIrb6E8bFU1qOSlzBzdGA8su+8NqyXJ7K
         /3jFMSUF+Ifu0X4x6KC8cd0sWy/R5HQfish+yqAxdg6g9mILJfKfcYRmZoaR6kqKl2NE
         OAxL+RStVT3/50mXjXBmVm15Ds7yLg6B6JGku8l830FhcL2s/SO460iHPmeT6QEDd3hk
         UsjMoNdmj54+trhaGlxTcXQjdM4m3hp2R+nCJCBGUvoipZrokyX7GzGL3xTvz9OMoDDD
         uabg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Qa2NPAU3nUxhMhka8HdV81hTcVfR5ad6LZDKEEK+E8I=;
        b=OIxTg3H7Bytr3ELIiqndDP2mDyWLIFFkXALHLrwMolMxH98px7sXqUoNFg6pgK3CYE
         n4CFIgZZXutqo3VOgLZRcSSpSz8k69d92NHPSwA8LYSpSoJuYk4ayNPYmEkanISMe6Jy
         7C98Ak7mkq4luMPMVphPVQHF2LOkH55kA+xWKHcoie4d/9xr/oOAIVYzAyZ/Zjv8mUO4
         +eSqU+ate0ZspxV9EmzfCHOftxNxyvJ/yr8NDPRO0CqW0/KphZexwAmFXPlrrrDWhd5r
         euNvRnoghtyP4pN10Q9+1HzVdCmaqmxzd+cm9PjkU/82sl+/pGXc/H9UaEx5TqIbtL8n
         AV4w==
X-Gm-Message-State: APjAAAWM+IBIWq3qxLc2VDVceDCmECl32qtmZeHir6zR/S6RX60yWJLZ
        cog1sbH3au9pdL15TxPqI0wYnA==
X-Google-Smtp-Source: APXvYqy06dfUmL6YeJyX0gzRHXOV+gw16shOwg0WfImzMkX6z1TQmab0bN6NRdoWpCgaaX3XisBOAw==
X-Received: by 2002:a63:8dc9:: with SMTP id z192mr28152038pgd.151.1567493976851;
        Mon, 02 Sep 2019 23:59:36 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id b18sm18820190pfi.160.2019.09.02.23.59.33
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 02 Sep 2019 23:59:36 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     stable@vger.kernel.org, linus.walleij@linaro.org,
        natechancellor@gmail.com
Cc:     linux-gpio@vger.kernel.org, arnd@arndb.de, baolin.wang@linaro.org,
        orsonzhai@gmail.com, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org
Subject: [BACKPORT 4.14.y 5/8] pinctrl: sprd: Use define directive for sprd_pinconf_params values
Date:   Tue,  3 Sep 2019 14:59:11 +0800
Message-Id: <8c7e95c293e81412a1dadc3c4376bafb45fefeeb.1567492316.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1567492316.git.baolin.wang@linaro.org>
References: <cover.1567492316.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

Clang warns when one enumerated type is implicitly converted to another:

drivers/pinctrl/sprd/pinctrl-sprd.c:845:19: warning: implicit conversion
from enumeration type 'enum sprd_pinconf_params' to different
enumeration type 'enum pin_config_param' [-Wenum-conversion]
        {"sprd,control", SPRD_PIN_CONFIG_CONTROL, 0},
        ~                ^~~~~~~~~~~~~~~~~~~~~~~
drivers/pinctrl/sprd/pinctrl-sprd.c:846:22: warning: implicit conversion
from enumeration type 'enum sprd_pinconf_params' to different
enumeration type 'enum pin_config_param' [-Wenum-conversion]
        {"sprd,sleep-mode", SPRD_PIN_CONFIG_SLEEP_MODE, 0},
        ~                   ^~~~~~~~~~~~~~~~~~~~~~~~~~

It is expected that pinctrl drivers can extend pin_config_param because
of the gap between PIN_CONFIG_END and PIN_CONFIG_MAX so this conversion
isn't an issue. Most drivers that take advantage of this define the
PIN_CONFIG variables as constants, rather than enumerated values. Do the
same thing here so that Clang no longer warns.

Link: https://github.com/ClangBuiltLinux/linux/issues/138
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Reviewed-by: Baolin Wang <baolin.wang@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/pinctrl/sprd/pinctrl-sprd.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/sprd/pinctrl-sprd.c b/drivers/pinctrl/sprd/pinctrl-sprd.c
index 6352991..83958bd 100644
--- a/drivers/pinctrl/sprd/pinctrl-sprd.c
+++ b/drivers/pinctrl/sprd/pinctrl-sprd.c
@@ -159,10 +159,8 @@ struct sprd_pinctrl {
 	struct sprd_pinctrl_soc_info *info;
 };
 
-enum sprd_pinconf_params {
-	SPRD_PIN_CONFIG_CONTROL = PIN_CONFIG_END + 1,
-	SPRD_PIN_CONFIG_SLEEP_MODE = PIN_CONFIG_END + 2,
-};
+#define SPRD_PIN_CONFIG_CONTROL		(PIN_CONFIG_END + 1)
+#define SPRD_PIN_CONFIG_SLEEP_MODE	(PIN_CONFIG_END + 2)
 
 static int sprd_pinctrl_get_id_by_name(struct sprd_pinctrl *sprd_pctl,
 				       const char *name)
-- 
1.7.9.5

