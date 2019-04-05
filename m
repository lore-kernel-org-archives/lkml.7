Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8845C282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 20:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84A71206BA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 20:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NDhr3zbq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfDEUn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 16:43:57 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:54552 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725967AbfDEUn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 16:43:56 -0400
Received: by mail-it1-f196.google.com with SMTP id a190so11626980ite.4
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 13:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Es5san3RpuuLQIOr2CbZ7NBduDkAnwJE8tKqqHDxe5c=;
        b=NDhr3zbqz336j49ZyWmzl2vA0rsCKok+7P4R0dJvzWqpXoZbxiqE88xMxiTau2siRH
         dNmvFJ1MPWLwIdiNSSB4zwEcrlxDBMU4cWj3TtnC+Q+zP8gOTwWAbLNFC8jD0uyWRTdz
         7q+q/7x9OwbsktrKd2d0nVHS61HQYfGbs/JUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Es5san3RpuuLQIOr2CbZ7NBduDkAnwJE8tKqqHDxe5c=;
        b=QIGKOyHMH10RhKKlStaeNsrKWDp3nwXZWFuCQBuNXwjsKBk2cMpDKRUEeMPC3mC1wW
         X1me4U0/qMteY+cDxaiENAkmE9q+hWXW2uvXdNfv5dmZ0FUppwcKwZonaeuO5iVNwAcH
         9ogNqYC8koFvLh91C/Ne9aSsQYPOWHk2Sxk34pIQNhi59c3jA1B9aTDvtVfPQTBcNZyy
         kHfttRJMuI9E/oDtr7SUZqB4akmNJXRuJKZ0TM27iinZ/Q3DqJQQf6Q94oBcmROd05Eb
         ZM6kH5wA3Rat5kSX/inxYCaxEQCdp+LQkDNakZM4uTiUg9MZzaqs5L5MVFcGB9X4gE9K
         9Yxw==
X-Gm-Message-State: APjAAAWFXrgegiHJGFTVA4c9FsLDtdlnpzdQcp7PzPnnpeqgfP/PFrVF
        23Ji4nuI4NGvPjXzkp0o7+/CHGLoah+E4Q==
X-Google-Smtp-Source: APXvYqyiPxFo6ehU9+aWqpGtsXLXTtjWidpsMYD3XfInHQsyYcCdaK0vLyriASnoqik6L5bIztmN0Q==
X-Received: by 2002:a24:68d:: with SMTP id 135mr10758423itv.53.1554497035877;
        Fri, 05 Apr 2019 13:43:55 -0700 (PDT)
Received: from localhost ([2620:15c:183:200:70a8:812a:cdeb:6e0])
        by smtp.gmail.com with ESMTPSA id o141sm1582777ito.21.2019.04.05.13.43.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 13:43:55 -0700 (PDT)
From:   Fletcher Woodruff <fletcherw@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Fletcher Woodruff <fletcherw@chromium.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Oder Chiou <oder_chiou@realtek.com>,
        Takashi Iwai <tiwai@suse.com>,
        Curtis Malainey <cujomalainey@chromium.org>,
        Ross Zwisler <zwisler@google.com>, alsa-devel@alsa-project.org
Subject: [PATCH v2 0/3] Fix jack detection for Chromebook Pixel
Date:   Fri,  5 Apr 2019 14:42:54 -0600
Message-Id: <20190405204257.87095-1-fletcherw@chromium.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
In-Reply-To: <20190401205519.34023-2-fletcherw@chromium.org>
References: <20190401205519.34023-2-fletcherw@chromium.org>
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

v2:
  - Split IRQ change into two patches: adding and fixing potential race
  - Change config reading code to try both DT and ACPI style names

Ben Zhang (2):
  ASoC: rt5677: allow multiple interrupt sources
  ASoC: rt5677: handle concurrent interrupts

Fletcher Woodruff (1):
  ASoC: rt5677: fall back to DT prop names on error

 sound/soc/codecs/rt5677.c | 347 +++++++++++++++++++++++++++-----------
 sound/soc/codecs/rt5677.h |  14 +-
 2 files changed, 257 insertions(+), 104 deletions(-)

-- 
2.21.0.392.gf8f6787159e-goog

