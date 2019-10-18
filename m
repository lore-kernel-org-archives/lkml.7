Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 791F1CA9EA1
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 12:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DF7B21835
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 12:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FHn4bQGU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408046AbfJRM3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 08:29:05 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33936 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389585AbfJRM3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 08:29:02 -0400
Received: by mail-wr1-f66.google.com with SMTP id t16so929676wrr.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 05:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JOGbCAX9wvou6ywsxAyjFayUMg5QkjoPiWUMNf49UP4=;
        b=FHn4bQGUrrme8bhdcuqbKlKd4iJXjl0H680Dwdil6m5suU5dWL94Fgcyp/05VQzwrM
         IpHa8A90edNgbxCwOirUmCs3KMllZWamn0ZPjdUit+YGXPGCn/AtWY/S0v2uCdwJBAFH
         U/vk2d8CtrJgbBYDu7xAQgLbdcILRIy9qqgMYzbHvLjL8pcImeWmPwFTEuku/0jxQsGY
         Om6RbYNvZZP5ddmrJKbFgHvMnAnM0XF12HW2K71fIqtA9pF8DXdf/MXGzkGXYgxn0M4j
         GYj7PJ0cCmn6SZJSBAAwc0eBtAuEgQIBBtX95N7/SJWTIJag3z7yfa+pa8tQrRyNwHH6
         bn0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JOGbCAX9wvou6ywsxAyjFayUMg5QkjoPiWUMNf49UP4=;
        b=EA93BMhjkTyVprhItGEGwO92D7f6vVmS+tcZI9gkDHTMm8vxkT1Yz2gIskyUrkgT2+
         zTQGwJ8GzkwUbQF8w0Y7xaot9zh0KBPAHZHvzZoFus14hKDQ7F02o/pxya+eZmXB5Xvl
         5IkICRRXCgQ6pfFwHznXLXqdcvdY5tApPybtn3xYSLL2Vx/R8ljuCWQq8AkzXlCf9RUK
         Q077IzL3KC2pm3i9eiOJt1a6MVNt8jfxeR0oFrSscwS8z4as/D9GdqfxCpSSqg8ajiAd
         0tyul5Pl3V64DTsMO5tQSUpuQVOubuJQwryKQJKxNeCJVtRb8RivudxDNBQg2dGRXThC
         oqEg==
X-Gm-Message-State: APjAAAUkucyulXzRS/BD9iCzZMeBdqtYOf1lnHrCt8t+V5ylANlhCqTg
        +6nU4MUE9k1Ry1MqHsF1w2rL8w==
X-Google-Smtp-Source: APXvYqxhqYisy4iiE3UsQz9L4d23eqq/hgE36QscL1/8FgBQ17hh2NLS5RjkL0/X2RyHXS88imp4Xg==
X-Received: by 2002:a5d:522f:: with SMTP id i15mr7209770wra.257.1571401739165;
        Fri, 18 Oct 2019 05:28:59 -0700 (PDT)
Received: from localhost.localdomain ([95.149.164.47])
        by smtp.gmail.com with ESMTPSA id e3sm5033820wme.39.2019.10.18.05.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 05:28:58 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org, linus.walleij@linaro.org,
        daniel.thompson@linaro.org, arnd@arndb.de
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        baohua@kernel.org, stephan@gerhold.net,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 2/2] mfd: mfd-core: Honour Device Tree's request to disable a child-device
Date:   Fri, 18 Oct 2019 13:26:47 +0100
Message-Id: <20191018122647.3849-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191018122647.3849-1-lee.jones@linaro.org>
References: <20191018122647.3849-1-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Until now, MFD has assumed all child devices passed to it (via
mfd_cells) are to be registered.  It does not take into account
requests from Device Tree and the like to disable child devices
on a per-platform basis.

Well now it does.

Reported-by: Barry Song <Baohua.Song@csr.com>
Reported-by: Stephan Gerhold <stephan@gerhold.net>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/mfd-core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index eafdadd58e8b..24c139633524 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -182,6 +182,11 @@ static int mfd_add_device(struct device *parent, int id,
 	if (parent->of_node && cell->of_compatible) {
 		for_each_child_of_node(parent->of_node, np) {
 			if (of_device_is_compatible(np, cell->of_compatible)) {
+				if (!of_device_is_available(np)) {
+					/* Ignore disabled devices error free */
+					ret = 0;
+					goto fail_alias;
+				}
 				pdev->dev.of_node = np;
 				pdev->dev.fwnode = &np->fwnode;
 				break;
-- 
2.17.1

