Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9613AC282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 09:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F33C208E3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 09:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="aHexLNXo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfDHJbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 05:31:43 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47]:34326 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfDHJbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 05:31:43 -0400
Received: by mail-wm1-f47.google.com with SMTP id r186so14778263wmf.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 02:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eqWPfOz+T7d3ynKAyEVuUA/TRR+nVEQpGlMKSeGnrsA=;
        b=aHexLNXoHmWkgXhi4+JSf/ri4QB6cAx309BzNLM1Fvcj9n2syx9qxPF0tLC7YHJglW
         naoSdT/cNLRbY5kfnmTfqnIxVXoS2mcnYuyIzHpMpBSwODQN1JVG0KG9tSy6RGlrEu2R
         C70NsQhSbi8fDnuKUOnPS21juTPlh/MC9cW8y+n9yR83i+pbxdt+hk4F/CSCwasg3jrw
         DGB3ijYcTV7s7GqrTYPN7OrLl7bAUoe+teSx96PNWu1kHwkN676Cl0i+iAGfSBL9tWdQ
         iX8zrss1tHGRgFRk+ekQM+zMZIP7gMr0gQBzZaf622b+warHwcHyCYn6GpsQjlP34sqB
         RTsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eqWPfOz+T7d3ynKAyEVuUA/TRR+nVEQpGlMKSeGnrsA=;
        b=efkxkUVYSmCEldP6FKvh7V1NRU7UissEEr05bGLv/ZvkayIfKnwGDXLZqKZyeZSWzT
         rT3IPFQb71S5d6dAlEVJah1q29v6UHm47/rYnItlN9X98f6xDjt+zDXOLEWwEE7IW70u
         IMeCvh/OwxvIQ9rCNbVE8pEGcfcSV8A7kP53/L4nIWNs+kDl2Ulus27X27/FI+XffXkk
         N1pC1wSyifS1+PrQ+0z25uSBZF0lnLa3aRG645jB6bBMcGCm2HduQjXH8lal4qd1/Mts
         tJgmCNMsfxx2WFQNGN29g9cOwPZ0w2JnuBUm6eSWvsZOWt5drYvLTEwV+xecbR53LKsc
         /uEA==
X-Gm-Message-State: APjAAAXHdBVYj5tPAJimlMRVX1ezEEBP2DSDUcndCdWhKB5qumfo7jWt
        1oFhOyYP09HqhZDb0sWtPJA8jg==
X-Google-Smtp-Source: APXvYqyqWO3za6JB7f5eX1xm5uFsTEZV6g5Bs0L24HPSBsybRHhlYhADWMUB0dyP19ttI58eAYxZ+g==
X-Received: by 2002:a1c:4105:: with SMTP id o5mr15916837wma.35.1554715901291;
        Mon, 08 Apr 2019 02:31:41 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id c10sm36777427wru.83.2019.04.08.02.31.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 08 Apr 2019 02:31:40 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] arm64: dts: meson-g12a: Add support for Video Display
Date:   Mon,  8 Apr 2019 11:31:34 +0200
Message-Id: <20190408093139.27161-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds nodes for Video Display support.

Dependencies :
- patch 1: VPU, HDMI & Power Controller bindings to be applied
- patch 2: Depends on AO-CEC-B bindings to be applied
- patch 3, 4, 5: Patch 1

Changes since v1:
- Added support for AO-CEC-B, enabling AO-CEC-B and disabling AO-CEC-A by default

[1] https://lkml.kernel.org/r/20190313141030.5958-1-narmstrong@baylibre.com

Neil Armstrong (5):
  arm64: dts: meson-g12a: Add VPU and HDMI related nodes
  arm64: dts: meson-g12a: Add AO-CEC nodes
  arm64: dts: meson-g12a-x96-max: Add support for Video Display
  arm64: dts: meson-g12a-sei510: Add support for Video Display
  arm64: dts: meson-g12a-u200: Add support for Video Display

 .../boot/dts/amlogic/meson-g12a-sei510.dts    |  53 ++++++
 .../boot/dts/amlogic/meson-g12a-u200.dts      |  54 ++++++
 .../boot/dts/amlogic/meson-g12a-x96-max.dts   |  54 ++++++
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi   | 165 ++++++++++++++++++
 4 files changed, 326 insertions(+)

-- 
2.21.0

