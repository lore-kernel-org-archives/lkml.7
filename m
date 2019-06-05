Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46AC9C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 22:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 132892067C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 22:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fwuqB6Ok"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfFEWYk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 18:24:40 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:33166 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbfFEWYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 18:24:39 -0400
Received: by mail-it1-f194.google.com with SMTP id v193so647507itc.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 15:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eg/tHqhTtymCWtVp4klUI5heciNe2OPuOOg9xhW9fd4=;
        b=fwuqB6OkAcQAzt2t1vqjNOoHH8r9rtwoZ/9qB2UzqNTmkPrfoxGvdHxCOd9fLWR5ee
         jgBvK6Stp9bY+Fv8DAzdhvJIy2kYURn+aFJj7t9Xhx+uFGkQIpz1xS9ADd2GTLyWMrac
         RxoRhHsXHEmSYQ3t5vbDQp9UwP8c1gq07g1ok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eg/tHqhTtymCWtVp4klUI5heciNe2OPuOOg9xhW9fd4=;
        b=J2Yz/+KmNb+InE9PjKs49bdC9rABwDsxAyj5qPw47vnNmQsryb4bBFwxBiQ5gAhS3f
         SKrJDahifo9+gIUBwmtIRq4AyP0qga0VMRY9cDmW7oqbwaM2sx+5Vf4UeWAYFPf/L4hc
         Tk92JpXGLxMwZxx0R2ofzjaTU8zR+8JxX/Gk1bfmxgTxscmA1tibUNoXN2yVEjlQ5xD9
         SmXzOPWXsvElchDoV6i0EMmGe3+urwgAt4jFtaaeMNoF1smbySrAv6BOEYE8hzTtGjDG
         yA6IFkbhDlPmzUt2/4nIuoJ4aCvLPe39LKwIaM+eLv0QFAQ1+K3eL7fxzD97Ob+BCciQ
         m2UA==
X-Gm-Message-State: APjAAAUePVlwayOm3yofgZUIacjz/CYuHoSYHOGmxE/b0vUSa5XCVvO3
        lIFfucmXQvgWsqMSjQJBjARqKtpHDnzzJw==
X-Google-Smtp-Source: APXvYqwCuMjfRwW0T7+YoLiD23jxJzgzcbIrrBRdF0nXe44r2Q3l+hqztUJKPTWw6dKjNh8lIRKXsw==
X-Received: by 2002:a24:7f0d:: with SMTP id r13mr26288230itc.28.1559773479042;
        Wed, 05 Jun 2019 15:24:39 -0700 (PDT)
Received: from localhost ([2620:15c:183:200:33ce:f5cf:f863:d3a6])
        by smtp.gmail.com with ESMTPSA id n13sm17120ioa.28.2019.06.05.15.24.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 15:24:38 -0700 (PDT)
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
Subject: [PATCH v6 0/4] Fix jack detection for Chromebook Pixel
Date:   Wed,  5 Jun 2019 16:24:15 -0600
Message-Id: <20190605222419.54479-1-fletcherw@chromium.org>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
In-Reply-To: <20190507220115.90395-1-fletcherw@chromium.org>
References: <20190507220115.90395-1-fletcherw@chromium.org>
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

 sound/soc/codecs/rt5677.c | 317 ++++++++++++++++++++++++++------------
 sound/soc/codecs/rt5677.h |  13 +-
 2 files changed, 234 insertions(+), 96 deletions(-)

-- 
2.22.0.rc1.311.g5d7573a151-goog

