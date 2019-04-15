Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E2F7C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 199A220854
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A+EBWeKb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbfDOTqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:46:34 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:52483 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728305AbfDOTqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:46:34 -0400
Received: by mail-it1-f196.google.com with SMTP id x132so29131338itf.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 12:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4iW/IfYRBaGq2VnKD56KAQLInNU4BydNaULyz/6KFMI=;
        b=A+EBWeKb1lYdshJNbQ5pxM9s/kAqtGN3aTEeXIqqr5jh9eCQLYEj4RVJYWVUuNoN3I
         g9uG1NQe1oiuFEC7cAJese2mLP+f5I5hq5AWsA1olP1J6fn7nphNCUPg0+2a/zKbkJFx
         5OTICq1zlH7lCYcppa+2ipKIp5o6plXMTBTOE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4iW/IfYRBaGq2VnKD56KAQLInNU4BydNaULyz/6KFMI=;
        b=tTgMCiMVszTG3mDmDp/iWgfUD3hEerp01K17jVd3FKUzlebdbEteKVHWpwNRCa84Gl
         3pAx9tacjXHG64Wv35OoNEcI/rcrt5bzvZ2wnkFl6nrYNjDcZIC8bBB4vpKEQ462x/4i
         Gj0dgknQy4+4HpKYIi+ZHXy3bWydUPM0HWgETr3DWHMQcNneiGm37Jxg/1pTJ0nIm1iS
         5FtFEnkLMZzN+r98495CSw7RuABEvoAptwoZb4nyVDI9OZPzW9BvbpHg+uwmPL6Tqq9I
         +wCLfAP4A/1i1m4i7mf2CtNcJ+3GB3oWdPiF/kRqgXX12EjL1YlvYCkjxBXQuesWJS6p
         DJhQ==
X-Gm-Message-State: APjAAAVH9QK6qtc9crw3dVOiwHmaXFMtLNz4Y4HjKj7sLrlj2Md+h3fI
        J1il06jw61Ds+a/lN1wi1FYS519BmJM=
X-Google-Smtp-Source: APXvYqx3dQSL2cL/5Zui7JHgbgKwjPDeJZhaZvdVOkUkWK4RhfryZsy75wYmRk0iDUFX/bwnDTIYPA==
X-Received: by 2002:a24:6c84:: with SMTP id w126mr22286717itb.35.1555357593532;
        Mon, 15 Apr 2019 12:46:33 -0700 (PDT)
Received: from localhost ([2620:15c:183:200:70a8:812a:cdeb:6e0])
        by smtp.gmail.com with ESMTPSA id u13sm18517329iog.80.2019.04.15.12.46.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 12:46:32 -0700 (PDT)
From:   Fletcher Woodruff <fletcherw@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Fletcher Woodruff <fletcherw@chromium.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Oder Chiou <oder_chiou@realtek.com>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Subject: [PATCH v3 0/3] Fix jack detection for Chromebook Pixel
Date:   Mon, 15 Apr 2019 13:45:56 -0600
Message-Id: <20190415194557.9182-1-fletcherw@chromium.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
In-Reply-To: <20190405204257.87095-4-fletcherw@chromium.org>
References: <20190405204257.87095-4-fletcherw@chromium.org>
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

 sound/soc/codecs/rt5677.c | 347 +++++++++++++++++++++++++++-----------
 sound/soc/codecs/rt5677.h |  14 +-
 2 files changed, 257 insertions(+), 104 deletions(-)

-- 
2.21.0.392.gf8f6787159e-goog

