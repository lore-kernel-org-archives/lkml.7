Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F81C3A5A3
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 02:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33FD720674
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 02:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="agEbRe70"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbfH1CRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 22:17:53 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41143 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbfH1CRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 22:17:52 -0400
Received: by mail-pf1-f193.google.com with SMTP id 196so618679pfz.8;
        Tue, 27 Aug 2019 19:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ME3wO/9v2at3HWePbC02aNBPfV17xnOv4AE/KalXLkQ=;
        b=agEbRe70eEOAoV9YiDsgOViWppGehXERpHKcHVeF41mbZ/S/BwBWFURiSVabwSP6k1
         4/NGCkD9RS9d6BuIDkoiv0wMwBKBNKYRVZFg4gfH7sF4ZJpNiunZ/WYIRqzbaD5J18eg
         kkOXApacU+R6ELKjbYDfZrCs+DC02q0ZsxawhOkrgJDcS7Udasz31h4FxR/PMrqVCBhb
         KTVPu8wSbEKtLMDhlNV5LQEZyZq5uJK/rOClEGKtupI9K1OWUK+kw1Nenvi06UDf0K4l
         Oecbwe5D4vpA2Mg4Xh66nKgkjqswt2krvaiKd03wt+ZLdQpcakmeBAt0S6xa4+fMdk0h
         rPpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ME3wO/9v2at3HWePbC02aNBPfV17xnOv4AE/KalXLkQ=;
        b=NllRaQ9bt9LPuc+YTQJsWPw6YL0t+0O2Lovk+OHekZKPZF/CMtUy0Zy1pwCyvti8Ud
         mJL5a7wJdWF0ZqIjKU2CuLmTOx+uwu/885IHuFaT6MbCwFyonYW9qtVl9atN3iveUuAr
         zd0gJwcamJznLdAv98kxzwpycbx4mb2Lls+JWv86cs52ONQI48iBpwvQqNy3suQ2VvAA
         OwkYh/VRB4eoxoZX22IicdSZZBzXcRA8VtpfkCXzt/E1Eo9FTfaCf9ZdeEoAsybm/Cxc
         NWUrOywM5VPpqfbIyPPCwpT1bwxD55edwcKYv8S4cMbhX9riZFUg1cRSJQJ1kdRHguUN
         aIjQ==
X-Gm-Message-State: APjAAAWOVzdikCQiNNglmPiGldMhx/esgTYfq7RwiaNHiPkqp6KbZAqM
        vCzJxvYOz6AlRI9buIYlQlk=
X-Google-Smtp-Source: APXvYqwCyMHHYOU61NQBLGSTEds+GGJiCFwurDNNaYoBJdFI2T5xOtjSENBvXeh3WMNDAREQHp3OSg==
X-Received: by 2002:a63:124a:: with SMTP id 10mr1371712pgs.254.1566958672069;
        Tue, 27 Aug 2019 19:17:52 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id b18sm673249pfi.160.2019.08.27.19.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 19:17:51 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH v2 0/5] a few fixes for sprd's sd host controller
Date:   Wed, 28 Aug 2019 10:17:31 +0800
Message-Id: <20190828021736.22049-1-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With this patch-set, both sd card and mmc can be setup.  This patch-set was
verified on Unisoc's Whale2 and another mobile phone platform SC9863A.

Changes from v1:
- Added Reviewed-by and Tested-by of Baolin;
- Added fixes tag for all patches in this series.

Chunyan Zhang (5):
  mmc: sdhci-sprd: fixed incorrect clock divider
  mmc: sdhci-sprd: add get_ro hook function
  mmc: sdhci-sprd: add SDHCI_QUIRK2_PRESET_VALUE_BROKEN
  mms: sdhci-sprd: add SDHCI_QUIRK_BROKEN_CARD_DETECTION
  mmc: sdhci-sprd: clear the UHS-I modes read from registers

 drivers/mmc/host/sdhci-sprd.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

-- 
2.20.1

