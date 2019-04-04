Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 677A6C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 11:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3576B20820
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 11:17:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="04eKJU8k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729414AbfDDLRq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 07:17:46 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52295 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728888AbfDDLRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 07:17:46 -0400
Received: by mail-wm1-f66.google.com with SMTP id a184so2555047wma.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 04:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Odl+BlHOl89gYqbuLHE+EoC/KYuALb6tw6QfepUIT6M=;
        b=04eKJU8kbtEi4rb3BzhbkVfaLESgNx4lIrBGCYD5MKfK6D6p05j831uZ/o+oK+j9Cu
         tLFBXfttZnVixncynWvQoKYHs7OfWMLGB42AfBrSJzQv6aHWNU8YPkGHh2C5SPMh48w4
         RBHvdnhISSY1RmYDmjpXljZc7FrVIgqbCzU+lBDV74HKN6cuWQ9lteSh6+8sEZEc7WOl
         tn+UOUy11egdtiORRIkuS9HMI1V3GU+qudeok3JDJoX5uOpw0RDDcoFvKHaJQLdfIYRP
         fQw4qdRg7KQ7QIuJ/iwIe3FXs9F4kRb3tHf4qT/sva5gOXDKrPBDnOlUmY4AiUARCNT9
         Jszg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Odl+BlHOl89gYqbuLHE+EoC/KYuALb6tw6QfepUIT6M=;
        b=ZlQOVyy0dCcdGwc9+ak7neOiT+/Xm5SW5fOcOyU0lZfpjk6/LmsFlH+gCNfUXP28/Y
         DlvGkOiMABmBfSsT8ECQSTF5uhTzCvVorTNAYAencwRIfVELRYdc39Bv06s+WLCc9M8D
         03H36z5hCFplqKBfPHvAVZzuGe6lHjj9DLrArEUVviODayh7eH+HXmkRAKm3cMN+eooj
         ljrpEFNzU3Kt5xMaJf7tQVkJj5pKJvg+aVT3GMz6ZeT2fJe9BjJx/6tpzFCsyEa2ZRjF
         CxlrOSx0wB7B36MBFcCzpGTGiQsjxZQooFPj24OqU8DBw9emXUDO2xW1XQpzrWSiHIS2
         MvWQ==
X-Gm-Message-State: APjAAAW2MAbc96VuV+cpwOCxv0h+O10PbjuSrLO/XxNoVjzDoCww4bjf
        AIObg1ye00WXTh9w4XZQG+t+mA==
X-Google-Smtp-Source: APXvYqzhk/y2OvfsCjD7gSTW96CXJ2TGczTmODHjJSN87fBXF9s9EitMGeTGHopwjsoXlilycuyFAA==
X-Received: by 2002:a1c:2dd2:: with SMTP id t201mr3905707wmt.10.1554376664375;
        Thu, 04 Apr 2019 04:17:44 -0700 (PDT)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id z23sm9024771wma.0.2019.04.04.04.17.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 04:17:43 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Maxime Jourdan <mjourdan@baylibre.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
Subject: [PATCH 0/6] ASoC: meson: add g12a SoC family support
Date:   Thu,  4 Apr 2019 13:17:27 +0200
Message-Id: <20190404111733.28705-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Amlogic g12a SoC family audio subsystem derives from the one found
in the axg SoC family.

To add support for the g12a in the existing elements, this patchset deals
with following differences compared to the axg family:
 * fifos must set an initial start address within the buffer.
   The fifo pointer shall be reset to this address on startup.
 * frddrs may now play on up to 3 output interfaces simultaneously.
 * tdmout formatters need a different signal skew offset.

Jerome Brunet (6):
  ASoC: meson: add g12a compatibles
  ASoC: meson: axg-fifo: add g12a support
  ASoC: meson: axg-toddr: add g12a support
  ASoC: meson: axg-frddr: add g12a support
  ASoC: meson: axg-tdm-formatter: rework quirks settings
  ASoC: meson: axg-tdmout: add g12a support

 .../bindings/sound/amlogic,axg-fifo.txt       |   4 +-
 .../bindings/sound/amlogic,axg-pdm.txt        |   3 +-
 .../bindings/sound/amlogic,axg-spdifin.txt    |   3 +-
 .../bindings/sound/amlogic,axg-spdifout.txt   |   3 +-
 .../sound/amlogic,axg-tdm-formatters.txt      |   4 +-
 sound/soc/meson/axg-fifo.c                    |  34 ++++-
 sound/soc/meson/axg-fifo.h                    |   2 +
 sound/soc/meson/axg-frddr.c                   | 143 +++++++++++++++++-
 sound/soc/meson/axg-tdm-formatter.c           |   6 +-
 sound/soc/meson/axg-tdm-formatter.h           |  11 +-
 sound/soc/meson/axg-tdmin.c                   |  16 +-
 sound/soc/meson/axg-tdmout.c                  |  29 +++-
 sound/soc/meson/axg-toddr.c                   |  53 +++++++
 13 files changed, 286 insertions(+), 25 deletions(-)

-- 
2.20.1

