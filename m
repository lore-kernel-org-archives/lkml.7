Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1535BC10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 08:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6B762171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 08:31:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="X1Egy35o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbfDLIbU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 04:31:20 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33753 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727306AbfDLIbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 04:31:16 -0400
Received: by mail-wr1-f65.google.com with SMTP id q1so10848922wrp.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 01:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RNAd7GNGVbL6BOuK6iIVW4N9neq3YiGA4nYoCz6Ftyo=;
        b=X1Egy35o1qqPY3mxP4fqCcI/t5UEFYzzzlCa41uLiDo2NLjCuzy29PS1PWgRETdSYZ
         fNrVUGwLmPvFPXrswGzIab/2OXldSTY0YUN9FTOWUqEyEgAKxeZ5JknLzzsPpHemFBda
         ucfosdgpStlBJuAg1CkavIQiNLMXpGlLFKdKSDVVCrKPgKXvFXuMZV1JiET+8GWRwB8q
         CVNGGmvc3i4Af1nSm+k44VPm04xlwAIeGy8mSPno1EVxafvOOdhll+qtNRyeIwxzzX+3
         Flj6G16aHXqnoHkVJ3loO+BNHynPEQoYIn2MMrjQypTPQXu8gg0BzIf+82dTUK1S13SX
         gjHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RNAd7GNGVbL6BOuK6iIVW4N9neq3YiGA4nYoCz6Ftyo=;
        b=J/sUORUk4G0wyNI03VqboDiaEGm/cbVL0DlHz57HBW70Ne3VMwXviQUaPcKd+H6KUJ
         lOKCyNeAYEMewcFaCTP4w3GFbTfEuLxbqaMvJ1buJjmag10yRw/C+E1BduJYWrMRTAFZ
         aMholdwox3r+ugWC1nCreqR5+7HSDC/FwIj2m9PXVsI9rEfxJo1qrxIl0HnQ1qQzmxej
         nzv1FQutc7NMjksEkq/PYfPFbORiMqj7PJORPJqZ0rnDFpxGi2wWaG/7VMs+fE6IQa4h
         Dwy2qLLgzBANyTnBpmci32XXyvTM67g/k5/J69mxbHrHSq5fDiB0xlQm7aOCwLXsoq0j
         T+Cg==
X-Gm-Message-State: APjAAAXJ89XvA5wCIGg2mWacScd7sVp6HD2zRtVyalHgvPpB4j6E+hEx
        HlWJ+5zfRpXifjUuYzjiuxW65w==
X-Google-Smtp-Source: APXvYqzBr1f0O2SeR1JovrsmOw1CtuqCtoaeZGfOl8eubxwCbcaDF51uZ85tyl/iQk+2MGtTWj9T0Q==
X-Received: by 2002:a5d:4907:: with SMTP id x7mr31589434wrq.133.1555057874477;
        Fri, 12 Apr 2019 01:31:14 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id w11sm116054702wre.15.2019.04.12.01.31.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 12 Apr 2019 01:31:13 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     hverkuil@xs4all.nl, mchehab@kernel.org
Cc:     baylibre-upstreaming@groups.io,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/3] MAINTAINERS: Update AO CEC with ao-cec-g12a driver
Date:   Fri, 12 Apr 2019 10:31:00 +0200
Message-Id: <20190412083100.4070-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190412083100.4070-1-narmstrong@baylibre.com>
References: <20190412083100.4070-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the MAINTAINERS entry with the new AO-CEC driver for G12A.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e17ebf70b548..bbad8f3ee3e8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10046,6 +10046,7 @@ L:	linux-amlogic@lists.infradead.org
 W:	http://linux-meson.com/
 S:	Supported
 F:	drivers/media/platform/meson/ao-cec.c
+F:	drivers/media/platform/meson/ao-cec-g12a.c
 F:	Documentation/devicetree/bindings/media/meson-ao-cec.txt
 T:	git git://linuxtv.org/media_tree.git
 
-- 
2.21.0

