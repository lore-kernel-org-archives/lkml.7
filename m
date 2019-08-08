Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 998A7C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 08:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65D162173E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 08:55:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="gkdlcrlz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731499AbfHHIz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 04:55:27 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36915 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730777AbfHHIz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 04:55:26 -0400
Received: by mail-wr1-f68.google.com with SMTP id b3so1691384wro.4
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 01:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U7mRPaAFiVltDPu4JSR3Yp6zM4Cf+22qPlOKI/zfYrU=;
        b=gkdlcrlz3L1NcoJFdDDV7X9nMVELcEblkgxcYsF7dUHOi/CeiGmlqx+C+uEn5bFvrr
         iwaBW4qCWbND0XKzks4YF81jkntz3/zVTohZhnNkR4jB/rEdApnvA52KVGCuRp3fR9cf
         L+dZcCwOl7xRI8fbor/W9sQCmMbxqnILRlFifyvyeALYukSSWw/we+sx/gCo+qJIyd68
         7IbOKuPNaENrBcYBsvlmBoBMpedoKtj1Y7bQoNcH3f8Pq+sPxe+gsiaVR8+Cks7WPwc6
         b+p/9pcNvEqy95KahteRW7wyIEdDQZhlMC6RGIAClUAa88O28ygd+HCZJ3drLaBwXnfc
         l62Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U7mRPaAFiVltDPu4JSR3Yp6zM4Cf+22qPlOKI/zfYrU=;
        b=mNVdADbY7lT1B5hSn3FSku5dQNf4LG1ZupQVkHXbplw9pQYqEzfTu2SVbTXUphypn6
         ITpqYIKcRkLsesSP5uYMDCYY8qNYRIH9f49rKqF8nl5/ttpXpgCJZ2V/1f7P00IWruIL
         Z4unMqWmy8QiVRcnsAk3mHZSRF12V4lkyP3D/2nSoygiVMxp3+2RvMvnYH/IH6rstV9p
         ck5RCQUnbLfqlIDGNcsS3s2hq0mkIBYkhfmrL0z3uCHjK0TYwT/JzRWi8KR7mNUS3Hwd
         4muwP9HUySSmdtRhC9228YOysYpFebWFlZ3MEaYnGQkr94sAc8dYnTleNnEmHrxRjIGD
         6I2g==
X-Gm-Message-State: APjAAAVRqLF/R3g+GWJ84nrgsd5/e3YmtJTlSevJ0nQpPzJs2FaQb1UZ
        w5xRSABHO18tTtdP4/O/2djDRA==
X-Google-Smtp-Source: APXvYqzd7NmT/FM1gVCi923HMojL2+NSOYVprF5ZiqEcVi0GIfQIkAt5xkVVtJuUqtq+PdXpXwjLhw==
X-Received: by 2002:adf:8bd1:: with SMTP id w17mr16642922wra.50.1565254524653;
        Thu, 08 Aug 2019 01:55:24 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id i66sm3380649wmi.11.2019.08.08.01.55.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 01:55:23 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     robh+dt@kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] drm/meson: convert bindings to YAML schemas
Date:   Thu,  8 Aug 2019 10:55:19 +0200
Message-Id: <20190808085522.21950-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset converts the existing text bindings to YAML schemas.

Those bindings have a lot of texts, thus is interesting to convert.

All have been tested using :
$ make ARCH=arm64 dtbs_check

Issues with the amlogic arm64 DTs has already been identified thanks
to the validation scripts. The DT fixes will be pushed once these yaml
bindings are acked.

Changes since v2:
- Added review tag on amlogic,meson-dw-hdmi.yaml
- Removed power-domains type from amlogic,meson-vpu.yaml

Neil Armstrong (3):
  dt-bindings: display: amlogic,meson-dw-hdmi: convert to yaml
  dt-bindings: display: amlogic,meson-vpu: convert to yaml
  MAINTAINERS: Update with Amlogic DRM bindings converted as YAML

 .../display/amlogic,meson-dw-hdmi.txt         | 119 --------------
 .../display/amlogic,meson-dw-hdmi.yaml        | 150 ++++++++++++++++++
 .../bindings/display/amlogic,meson-vpu.txt    | 121 --------------
 .../bindings/display/amlogic,meson-vpu.yaml   | 137 ++++++++++++++++
 MAINTAINERS                                   |   4 +-
 5 files changed, 289 insertions(+), 242 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/amlogic,meson-dw-hdmi.txt
 create mode 100644 Documentation/devicetree/bindings/display/amlogic,meson-dw-hdmi.yaml
 delete mode 100644 Documentation/devicetree/bindings/display/amlogic,meson-vpu.txt
 create mode 100644 Documentation/devicetree/bindings/display/amlogic,meson-vpu.yaml

-- 
2.22.0

