Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 108C3C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 19:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB6A5217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 19:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AIQG4mZQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbfFNTs7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 15:48:59 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:44489 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbfFNTs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 15:48:59 -0400
Received: by mail-io1-f66.google.com with SMTP id s7so8252808iob.11
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 12:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5kBsnIJ7NqL+VBYhjfKTuJEIg2r/RGqZAAl6Deg+qXM=;
        b=AIQG4mZQBLBL0joUtzflM8CrmnXp77fhWpM8leg6gHb/3/vSIh0cokbNOjLKO1ltzz
         KXkyRtytvFQx+6OKl7AeLX+GopRpszVVM+t7CIQFJoPoCT98LvhtFEPwHleDbTwCp5Yd
         oc6uygi+tEOurlekSWQwt5ei9eq83eOdo5+vA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5kBsnIJ7NqL+VBYhjfKTuJEIg2r/RGqZAAl6Deg+qXM=;
        b=tSRE88CLrSMQdm3VADJwqSzJuJMDcTnE0xZMO7Bcft725pZKBHyP0nLEMBG98F3G+u
         C6MoT59o5MTeMHQdNkdHQUlYuctUp4qVeCZTXwU1YWJBWzW9q6Q+EU1pRYwE7cC+d+XF
         9VXpSwVinV94GsiZF1jHnHytMLvaN/hh/rXj7dI+OHwAW5e2seZlG0xWA4kqPENgGMNf
         7MB0Zutj6BG/9bvKDfX4D9TohCHy2ezLaColoGnZ+6dBgSV7JYrMvUHazrgOgDpHbpRt
         rKrLQVojGM+bBxJTD+DmzY0dtJYgm88ytXiYfINypfrBaaoAw0dPRwyoZ48WT501e3a6
         Yzow==
X-Gm-Message-State: APjAAAVVjnfSzVkDuWZ0l7SNgwgkcwsqJSmvJBFg6HgWHWlwsn2+Nkaa
        ViPuU45s9g94Ez73WI3WRb6XUZQTANUkIw==
X-Google-Smtp-Source: APXvYqwZ0QGSQITrHvnL18bpJqSZpsG5/kxnGjtC5GEiUg1zQH3SEmE5ItsYqnIY8mPijv5NvlC42Q==
X-Received: by 2002:a5e:c705:: with SMTP id f5mr66655255iop.113.1560541738017;
        Fri, 14 Jun 2019 12:48:58 -0700 (PDT)
Received: from localhost ([2620:15c:183:200:33ce:f5cf:f863:d3a6])
        by smtp.gmail.com with ESMTPSA id c1sm2739459ioc.43.2019.06.14.12.48.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 12:48:57 -0700 (PDT)
From:   Fletcher Woodruff <fletcherw@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Fletcher Woodruff <fletcherw@chromium.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Oder Chiou <oder_chiou@realtek.com>,
        Takashi Iwai <tiwai@suse.com>,
        Curtis Malainey <cujomalainey@chromium.org>,
        Ross Zwisler <zwisler@chromium.org>,
        alsa-devel@alsa-project.org
Subject: [PATCH v7 0/4] Fix jack detection for Chromebook Pixel
Date:   Fri, 14 Jun 2019 13:48:50 -0600
Message-Id: <20190614194854.208436-1-fletcherw@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
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

v7:
  - Rebase onto for-next branch of broonie/sound.git 

v6:
  - Move refactoring into its own patch
  - Reorder patches so that DT property names patch is first
  - Clarify commit message for patch which implements irq handler
  - Remove unused work struct 
  - Make IRQ function return IRQ_HANDLED only if IRQs actually fire

v5:
  - Fix void* parameter to devm_request_threaded_irq

v4:
  - Fix incorrect void* cast in rt5677_irq() 

v3:
  - Update commit message for patch 1/3 to clarify why we implement
    our own irq_chip.

v2:
  - Split IRQ change into two patches: adding and fixing potential race
  - Change config reading code to try both DT and ACPI style names

Ben Zhang (2):
  ASoC: rt5677: clear interrupts by polarity flip
  ASoC: rt5677: handle concurrent interrupts

Fletcher Woodruff (2):
  ASoC: rt5677: fall back to DT prop names on error
  ASoC: rt5677: move jack-detect init to i2c probe

 sound/soc/codecs/rt5677.c | 319 ++++++++++++++++++++++++++------------
 sound/soc/codecs/rt5677.h |  13 +-
 2 files changed, 236 insertions(+), 96 deletions(-)

-- 
2.22.0.410.gd8fdbe21b5-goog

