Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09EE4C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7FB5217F9
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:44:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="GffHTXGu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733088AbfDQUoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 16:44:08 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33739 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732543AbfDQUoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 16:44:08 -0400
Received: by mail-wr1-f66.google.com with SMTP id q1so124677wrp.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 13:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Rh/NLrobqB5mwi5oJdqhmcZ7w624es9RRpYu13HpzFU=;
        b=GffHTXGuyf7ylUhUSCeiE7D3EbMZ4p1+TeB1Krnur7r6ACKxhJym6b4jW25nB4Fywh
         alDs9gVwPRI5pkxvhxzXmdBFwN5/yFlDvKBa9mQCnlpgIAPspg2mbGoYQi2szm/1n4MN
         POYEL4poD3mqYsaywnENjHmw3o50QRbJNXA0Qi3gRLOhXjHOqUhZBqNVOA/YNbbsLHSf
         ZQeGArIs2T0YmhakQdwHartrqIYbAvVOuWjv+e8JALeKz18w5T8KecavBU4ssfiipUv/
         VerqXbFRuQd+YbjPSF86Rhqlu7iqr9/cL3hW5EzEt/AHN+9UoX1lCzzZoVOjpkk9iAAU
         8bAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Rh/NLrobqB5mwi5oJdqhmcZ7w624es9RRpYu13HpzFU=;
        b=Ob8elT3fy128Gx/YfZmrcqbDnTdfB+VqDV4zN8d2KY0py0i7/7BqN26DZX/F5duxIV
         pbGJrnFyholkhsfn0sut3qTEkwbLHWthO0/UU7BkuI3jnHpNqyFb7H+gZ/y1BsSImCjP
         4lOF62RQ9ebRWtSzRtW2u86qongFWR6q+0hI3uYN/v55qnPzw6VH5T2k31HpGnpyvXxb
         B37DhDsU1qfIdKjdVX32WggtEtj+7ns30fkCm7Cnb1CdpnfnxLzLo9rcKMF5EPzgkHO0
         Usk+lq/3v+ZO/KXZlSH4QuzwRpDMgDwjMmJ0oltHagImFgJkrtYzaADNcrRIdBl8Cg2e
         Acqw==
X-Gm-Message-State: APjAAAWwlqt0mJnzC4QR6KoO4RFHIVe/Fw9ykPR5UqmpxtPNKuMq8AUG
        uFXpNjOr6ge8faSh/s+6ggyxug==
X-Google-Smtp-Source: APXvYqzOraSx9954Y4LC4wyRGq61aX3Tq/cVz7PeIAzfh3Jpu6mKgYSU35zEueo/7GiRrxKYDi3j+Q==
X-Received: by 2002:adf:f803:: with SMTP id s3mr38690686wrp.54.1555533846081;
        Wed, 17 Apr 2019 13:44:06 -0700 (PDT)
Received: from boomer.lan (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.googlemail.com with ESMTPSA id c20sm98716866wre.28.2019.04.17.13.44.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 13:44:05 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, linux-mmc@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] mmc: meson-gx: clean up and tuning update
Date:   Wed, 17 Apr 2019 22:43:48 +0200
Message-Id: <20190417204355.469-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The purpose of this series is too improve reliability of the amlogic mmc
driver on new (g12a) and old ones (axg, gxl, gxbb, etc...)

* The 3 first patches are just harmless clean ups.
* Patch 4 makes sure HS400 can't be enabled, we still have not been able
  to crack this modes.
* Patch 5 removes some clock glitches when switching to DDR modes
* Patch 6 and 7 changes the tuning method from Rx phase to signal
  resampling. It could have been done in a single patch but the unified
  diff was extremely ugly. The change has been split in two patches to
  ease review.

The last tuning update that went through was meant to improve the axg
support. Since then, it was reported to break some other boards, like the
s912 vim2.

Also with the current tuning method, it was impossible to find phase
settings which would work on all the SoC, including the new ones.

After redoing all the tests from scratch, it appeared that Rx phase made
(strangely) almost no difference, especially on g12a and axg.
It is important to have a phase shift between the Core and Tx clock, 180
works best.

I discussed the test results with Amlogic. They suggested to use 180/0 or
0/180 for the Core and Tx phase. For tuning, they suggested to use
signal resampling.

So far, so good ... here the platform and modes tested:

NanoPi-K2 (S905): SD UHS SDR50/DDR50, SDIO HS
Odroid-C2 (S905): SD UHS SDR50/DDR50, eMMC DDR52/HS200
Khadas Vim (S905X): SD HS, SDIO HS, eMMC HS200
Libretech CC (S905X): SD HS, eMMC HS200
Khadas Vim2 (S912): SD HS, SDIO HS, eMMC HS200
S400 (A113D): SDIO UHS SDR104, eMMC DDR52/HS200
U200 (S905D2): SD HS, eMMC DDR52/HS200
SEI510 (S905X2): SD HS, eMMC DDR52/HS200

Jerome Brunet (7):
  mmc: meson-gx: remove open coded read with timeout
  mmc: meson-gx: ack only raised irq
  mmc: meson-gx: irq is not shared
  mmc: meson-gx: disable HS400
  mmc: meson-gx: avoid clock glitch when switching to DDR modes
  mmc: meson-gx: remove Rx phase tuning
  mmc: meson-gx: add signal resampling tuning

 drivers/mmc/host/meson-gx-mmc.c | 418 +++++++++-----------------------
 1 file changed, 113 insertions(+), 305 deletions(-)

-- 
2.20.1

