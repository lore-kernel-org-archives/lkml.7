Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7458EC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 22:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E427206A3
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 22:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MtLFGoue"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbfEGWBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 18:01:21 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:39965 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbfEGWBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 18:01:21 -0400
Received: by mail-it1-f193.google.com with SMTP id g71so703277ita.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 15:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xYc0JESinzI2iwWzUMb1V/Hdw0SX6rpr4LLne8uyVks=;
        b=MtLFGoueRtD3/ObzBu30iA+pfZ50NmYRCiskzTCJNKhaklKx3iHSqVK0qkMPJ3jipg
         Z9VgV7dUp1+EmERR6VdzS88+gxm4TQG0p2L+lJo9HHp+yqjBLwtdRRivXgDLEoz6xDca
         bNl4jFRZCGJThqHpA6eoohDPBXxuic3g7XCvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xYc0JESinzI2iwWzUMb1V/Hdw0SX6rpr4LLne8uyVks=;
        b=k16tqEPOtw8MMduuP1g0Mbmi738q+kuzjJ3GI5LHCYAEYQ76ffMgNqJ2lfOH6T7Siu
         7vF4RFRkFFQZu+WFNAaY5MJaAlTAsviJPRqcjyhbZ8kjg2NhJ0exxJJW/KNUhzv/41su
         Xbc+qa1qcSfkvcXN1Rnyo4qOh/d92GjZCjFG4b23wkb6rWxkw7ACfdqAqMxy8JhL6y1L
         GUVAdyWIkAst4o/PtHszGcowgd11ExRJIa29QTT+iVoHsdn40dKWlI2YYixIvGKct6Uy
         yRA25in0z40jc2BBFdJvCJ6MVmgmduHduMCF16Mi8PeeQmUudEWDkRhGGuWGACTqOGwc
         Gl1g==
X-Gm-Message-State: APjAAAWQ4goBOXKl/fPXlRJdGwe6UHPG5aBfig7RSjRwJna6IMvlEDgi
        Yt8dsyC19QchjVhoxXLfC4u2rQgRgH0=
X-Google-Smtp-Source: APXvYqxqxFroiAP8mWouVz4mtsAHLB+q/Lok8532r2squfRx3L112Mt9CLwW+fkwrqgO6ixxyFT8jA==
X-Received: by 2002:a24:398d:: with SMTP id l135mr624053ita.79.1557266480307;
        Tue, 07 May 2019 15:01:20 -0700 (PDT)
Received: from localhost ([2620:15c:183:200:33ce:f5cf:f863:d3a6])
        by smtp.gmail.com with ESMTPSA id u13sm3028527iof.22.2019.05.07.15.01.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 15:01:19 -0700 (PDT)
From:   Fletcher Woodruff <fletcherw@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Fletcher Woodruff <fletcherw@chromium.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Oder Chiou <oder_chiou@realtek.com>,
        Takashi Iwai <tiwai@suse.com>,
        Curtis Malainey <cujomalainey@chromium.org>,
        alsa-devel@alsa-project.org
Subject: [PATCH v5 0/3] Fix jack detection for Chromebook Pixel
Date:   Tue,  7 May 2019 16:01:12 -0600
Message-Id: <20190507220115.90395-1-fletcherw@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Headphone/mic jack detection doesn't work on the Chromebook Pixel 2015.

This patch changes the irq implementation to support polarity flipping
and fixes the configuration code so that correct GPIO pins are read
from ACPI.

With this series, plugging and unplugging the headphone jack switches
between headphones and speakers automatically, and headset microphones 
are also detected.

v5:
  - Fix void* parameter to devm_request_threaded_irq
  - Correct authorship for patch 2/3

v4:
  - Fix incorrect void* cast in rt5677_irq() 

v3:
  - Update commit message for patch 1/3 to clarify why we implement
    our own irq_chip.

v2:
  - Split IRQ change into two patches: adding and fixing potential race
  - Change config reading code to try both DT and ACPI style names


Ben Zhang (2):
  ASoC: rt5677: allow multiple interrupt sources
  ASoC: rt5677: handle concurrent interrupts

Fletcher Woodruff (1):
  ASoC: rt5677: fall back to DT prop names on error

 sound/soc/codecs/rt5677.c | 346 ++++++++++++++++++++++++++------------
 sound/soc/codecs/rt5677.h |  14 +-
 2 files changed, 256 insertions(+), 104 deletions(-)

-- 
2.21.0.1020.gf2820cf01a-goog

