Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B2C5C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CC1721841
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:20:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="xYIZPGmc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732259AbfDAIUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 04:20:10 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38490 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732241AbfDAIUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 04:20:08 -0400
Received: by mail-wr1-f67.google.com with SMTP id k11so10738223wro.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 01:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RNAd7GNGVbL6BOuK6iIVW4N9neq3YiGA4nYoCz6Ftyo=;
        b=xYIZPGmcOPsx7XltBlBvQqo4aj3zrDHZsgpYJMUWKPcVGo/kHCMfsDAJXpsoa57UQz
         H8IlQlLh2XzwmXEkqTeur3CW+s6LEzySJ91njN24UFYfSJ+i6mOuHcGzxG/BQG/DmtMZ
         dvpVUg34ai1IEcyIh1Q3ONJq3jz7szJSGA84px6hwK4yJ8i2FWAthA3DjN7l8noIufbr
         bBMCsFxwOIthRq6WRyO9rPCEIn6qP0cGwV//CeBETxRpDfRkIilGb5OsroIFfAI0XoG2
         ktrbQ8aaioxMishErHDn0fMLpp3+GsDa/WqaOIaL2Dt4e3QgGl2Mws2sHz1HKm8+Mw93
         kFlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RNAd7GNGVbL6BOuK6iIVW4N9neq3YiGA4nYoCz6Ftyo=;
        b=Hyd/bfFb4w3fKzlYHMYRCFoYFf0SKpTO0RUMpKgGKZhP/LKJM95GiSDnjckUeq/v7i
         4idJNi5AhT0x9pSQ1M1sDzcR9cnnr13GOA5W5wyAM4JcZGIlpRPGEpGpbWNtMfwjEHBB
         QljippzJUJCNiHKluLVKUwJWdj0bup0ElXvypV7dqbso2d2ieEd68s3CvHjBHPJ3uln6
         42NJuD74U0bTo8qA13DlISSxHjFPZGECNRAyvp152FQggS9USSqcxlcihszQ/JGw69L+
         CvmKeDGmR1wL26y+14JPEUtZ9uQ59wS57ENiumLdpFeq/3kkkvOSICltexXaVhKfeCe0
         W3uQ==
X-Gm-Message-State: APjAAAVZk44rb0g7mvSAiXzAuBU5SnetjKOty5XMiFH01+amVnSbRbBM
        +f3jVPkm6fE8XM5ndxR6IPSF/A==
X-Google-Smtp-Source: APXvYqzIW+q2+FLKqh6tWh31Ax8luv8fcduyKnCHPA0UgJM2fP6G5fzjKZ5xrEvKhHgto5EzpQRN8A==
X-Received: by 2002:adf:fa86:: with SMTP id h6mr32694410wrr.67.1554106806327;
        Mon, 01 Apr 2019 01:20:06 -0700 (PDT)
Received: from localhost.localdomain (176-150-251-154.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id r196sm10053534wmf.22.2019.04.01.01.20.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 01 Apr 2019 01:20:05 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     hverkuil@xs4all.nl, mchehab@kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] MAINTAINERS: Update AO CEC with ao-cec-g12a driver
Date:   Mon,  1 Apr 2019 10:19:59 +0200
Message-Id: <20190401081959.16474-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401081959.16474-1-narmstrong@baylibre.com>
References: <20190401081959.16474-1-narmstrong@baylibre.com>
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

