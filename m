Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 594FBC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 23:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 273682070B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 23:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OZYMgYiB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbfECXIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 19:08:25 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36762 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbfECXIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 19:08:24 -0400
Received: by mail-io1-f67.google.com with SMTP id d19so6578297ioc.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 16:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vfwVmU13mIPCIYdpxEtGI/5zAfnwuEVr+axgRwt2aOs=;
        b=OZYMgYiBy48UTf9kHTJiQosCJNjGq0fvWxH/7gnknxnJFiiXIJ5gONsdgKuPxkAVSq
         xPreisZwcJu4rWUvqJJOTmZ5VPIKJInSKeHDuTXYSUKKjN9LJBmR4sCXvHdldSsXYPpN
         QzRNFHl43M7h9J0OkjNTqOjt/LgXyKK/Po1UU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vfwVmU13mIPCIYdpxEtGI/5zAfnwuEVr+axgRwt2aOs=;
        b=anCq9Pnzg9abd40wbbIBvbeQy+NmAvC8y9T5NIJYNeuSADRekUVpOFCV8eaZ5XFm5S
         P+VvTvZAGs+a2je+amNjy/d5iO9W9F09M+SCTSjmGsDG3T8rCE+5xcV9AhV2sjLLCj4T
         /g89azQIxQvx78GrPr4GjgCNPhWjT5c39aDSTMGWzahZJBpCRDKXmITUMkHnGOg3bttS
         kgTRNmWipmVauwNse4DsAixRMdjcR5wJUOhZUbBn/bQwCOlvQ79n+AN4CHALVkzgjT1X
         HERT8k5ep8OroeqCLKKW7gN+0+QAa7pleUOJKXsSTlV1v3EZrbARpA76ta2IIl1oW7Jw
         EMsw==
X-Gm-Message-State: APjAAAVfqVk0xU/nroX8WOTjjJDNBXeHy2LwYEdq5Lr2YR8qpJx6JkrS
        Tqc3OcIH9HjyKkPOqp9HreWg28SWi+0=
X-Google-Smtp-Source: APXvYqx/gKRjRgj/rjW5FvDEYCIc+405bRHLorCdRdA0W/wjK5lkgiA44Z81EaN2VdwfcRuEpx3FEQ==
X-Received: by 2002:a5d:8cd1:: with SMTP id k17mr8580865iot.287.1556924903390;
        Fri, 03 May 2019 16:08:23 -0700 (PDT)
Received: from localhost ([2620:15c:183:200:33ce:f5cf:f863:d3a6])
        by smtp.gmail.com with ESMTPSA id 19sm1651503itm.6.2019.05.03.16.08.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 May 2019 16:08:22 -0700 (PDT)
From:   Fletcher Woodruff <fletcherw@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Fletcher Woodruff <fletcherw@chromium.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Oder Chiou <oder_chiou@realtek.com>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Subject: [PATCH v4 0/3] Fix jack detection for Chromebook Pixel
Date:   Fri,  3 May 2019 17:07:48 -0600
Message-Id: <20190503230751.168403-1-fletcherw@chromium.org>
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

v4:
  - Fix incorrect void* cast in rt5677_irq() 

v3:
  - Update commit message for patch 1/3 to clarify why we implement
    our own irq_chip.

v2:
  - Split IRQ change into two patches: adding and fixing potential race
  - Change config reading code to try both DT and ACPI style names

Ben Zhang (1):
  ASoC: rt5677: allow multiple interrupt sources

Fletcher Woodruff (2):
  ASoC: rt5677: handle concurrent interrupts
  ASoC: rt5677: fall back to DT prop names on error

 sound/soc/codecs/rt5677.c | 346 ++++++++++++++++++++++++++------------
 sound/soc/codecs/rt5677.h |  14 +-
 2 files changed, 256 insertions(+), 104 deletions(-)

-- 
2.21.0.1020.gf2820cf01a-goog

