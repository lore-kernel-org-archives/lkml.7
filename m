Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC2FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 17:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A7DA205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 17:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="sQMq7KvH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730049AbfCYRfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 13:35:17 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33711 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729473AbfCYRfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 13:35:10 -0400
Received: by mail-wm1-f67.google.com with SMTP id z6so500242wmi.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 10:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RNAd7GNGVbL6BOuK6iIVW4N9neq3YiGA4nYoCz6Ftyo=;
        b=sQMq7KvHn3sMMcaQxOtmi2qTduUxd1RA57Va8ms9P59Ij4z2j7vv9tojf5j5J7fwq5
         MWeR9J/qyEsPkHOC2+Z585l5+F0Zh4fnjif2CkIHbojMWXQqNzPEabUXw5+MAMTmZ4lo
         PphuzAZFa1rj5FmA61v0O1zDJksjcDbYmzGIuzFA/F0Yqbls7t8GIQpGs9BdlgJc5oLU
         nNPo4FK7+aUEmKw0HcSTcB7CnE96kLiRMa4LpcfIihVO90vMbURwXCxnlSv4JLXw2t+2
         b1CP4WjVH0z7g3uG7gXzlG/FrPKwSZZTM43OYREd7tpx2RbNW/6dRmPknA6K1UI8MjMM
         7tLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RNAd7GNGVbL6BOuK6iIVW4N9neq3YiGA4nYoCz6Ftyo=;
        b=k66qimNyxaocQv3DBRoCRQWU4KPEIk7q7l4n40M5dsIDvv9Z87JSETARETqq4TPqte
         UaQ1vsoH8XbpTiePUJMbrCQZWDFDjc6adCUtiPXcYvNlOBNo7UqpcT89dv9n2feUH5Gi
         vT/EnFG63kPcYncPAPWjPV2qUJNKaadXChPZWLeMLQkslb9uNbdKgQyUXhtdz3Ylcu41
         njIf0rr65A8g42naY0hA6pp6diwskJMs3PkVkEP4yXbBCzzJ1tk14HEzPtm6UKhBLYp1
         BjbCSu3bZz5/ahIqxTO18JkqbJLLFsEf5O+0RUjKLgbcEXm2KqUMbhwwtCuw0scIuyr2
         9yeQ==
X-Gm-Message-State: APjAAAU8q9tkmbfAo/vLUCWuoz/F1PKTO+pY8IGd7sbUODQHSw5h831j
        53mwcs4qbQrtrJCM6j3PFpm4wA==
X-Google-Smtp-Source: APXvYqydrU9CNZBNoLuQ6RGOoM2DitzwKBc12fZmJ92ZUTM0/6LOx3lDvo2mrQWVye2ijcj3pbT5Nw==
X-Received: by 2002:a1c:6c08:: with SMTP id h8mr6169561wmc.146.1553535308427;
        Mon, 25 Mar 2019 10:35:08 -0700 (PDT)
Received: from localhost.localdomain (176-150-251-154.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id o15sm16003227wrj.59.2019.03.25.10.35.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Mar 2019 10:35:06 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     hverkuil@xs4all.nl, mchehab@kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] MAINTAINERS: Update AO CEC with ao-cec-g12a driver
Date:   Mon, 25 Mar 2019 18:35:01 +0100
Message-Id: <20190325173501.22863-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190325173501.22863-1-narmstrong@baylibre.com>
References: <20190325173501.22863-1-narmstrong@baylibre.com>
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

