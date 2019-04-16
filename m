Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA59C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8C4220449
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YlcJwSw+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730229AbfDPSdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 14:33:08 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:55415 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729762AbfDPSdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 14:33:07 -0400
Received: by mail-it1-f195.google.com with SMTP id y134so340731itc.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 11:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nXoph5jRY2xpG1/YRS9IXnuugBw2dQDQrE91vbPLrno=;
        b=YlcJwSw+ioCGQ7fX3s9xTovl5nBscV9bWBj0X0cOowZLNR5NEWgKdBM7MFJc4WXNHD
         2t9/Tjwx6k75QU+LOG/9h6RObHMRCJB0hTMcNZ4y75yrtjDBxiVLO+8JYkESR7wpLzoq
         1A8sA+DBifJNIpW2PayDBN/txWAIi2bn2krH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nXoph5jRY2xpG1/YRS9IXnuugBw2dQDQrE91vbPLrno=;
        b=Hk90NvOPsTGDnu2uDLrxhYcbDOB9oVAcwlSxi+lES3FHaY30rIDFKO/Lbj3RpXNezS
         XGwUH/+tUVRI8+5lEjwecC4Ya+wJo7/tgGlOKaaj+Lqu6pCGXIpKqWLyqB4iamYY8LP+
         Xpt/QnW2HJYaB2D28Fejr9IntIdx1WR9L/HeOoNQ5wqEhlTFlIUQRS5JMGIx+Gm5Q5R/
         +WmzF5aJNgpa7QFY4CCqbXN1U9RSwOpOe20SPNrG5jzIlvTaXoMdX3HgBLpmyk1cYiP5
         yHGRrwxQZaHRwidbH/+nV7Te0as2oJ3SDQxDO/4Z/SI343Qtqhpseb+vW5Rnkdvh2n6G
         cYaA==
X-Gm-Message-State: APjAAAU0uBAY5WEDuoykdCNXLs0vcgZ8sr6haSVJ6jBzmXDEWAJWqT5S
        ZbcE6RxTu4yi+OV/hzO3wFJE8Q==
X-Google-Smtp-Source: APXvYqy5ZiiQ9XaLLrhlXaUCHjyrTBPav8uhvcRV/qDUl1cG7uvno0wtEKgBIZdV9PxO2OgOwoq77Q==
X-Received: by 2002:a02:c4c2:: with SMTP id h2mr57740694jaj.86.1555439586291;
        Tue, 16 Apr 2019 11:33:06 -0700 (PDT)
Received: from localhost ([2620:15c:183:0:20b8:dee7:5447:d05])
        by smtp.gmail.com with ESMTPSA id t142sm83539ita.38.2019.04.16.11.33.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 11:33:05 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-mmc@vger.kernel.org, linux-trace-devel@vger.kernel.org
Cc:     djkurtz@chromium.org, zwisler@chromium.org,
        Raul E Rangel <rrangel@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        hongjiefang <hongjiefang@asrmicro.com>,
        Jennifer Dahm <jennifer.dahm@ni.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Kyle Roeschley <kyle.roeschley@ni.com>,
        Avri Altman <avri.altman@wdc.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2 0/4] Add trace events for SD registers.
Date:   Tue, 16 Apr 2019 12:32:53 -0600
Message-Id: <20190416183257.247902-1-rrangel@chromium.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am not able to make a single event class for all these registers. They
all have different struct sizes and different printf formats.

Thanks for the reviews!

Changes in v2:
- Made trace_sd_scr print out flags.
- Add BUILD_BUG_ON to make sure tracing stays in sync with structs.
- memcpy using sizeof(__entry->raw)

Raul E Rangel (4):
  mmc: core: Add trace event for SD SCR response
  mmc: core: Add trace event for SD SSR response
  mmc: core: Add trace event for SD OCR response
  mmc: core: Add trace event for CSD response

 drivers/mmc/core/mmc.c     |   4 +
 drivers/mmc/core/sd.c      |  10 ++
 drivers/mmc/core/sd_ops.c  |   6 ++
 include/trace/events/mmc.h | 204 +++++++++++++++++++++++++++++++++++++
 4 files changed, 224 insertions(+)

-- 
2.21.0.392.gf8f6787159e-goog

