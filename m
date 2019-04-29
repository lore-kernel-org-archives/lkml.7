Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B08DAC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 09:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D9D32147A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 09:48:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ukqWmx3w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbfD2JsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 05:48:00 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:39930 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727368AbfD2JsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 05:48:00 -0400
Received: by mail-wr1-f54.google.com with SMTP id a9so15047157wrp.6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 02:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LrkVzYO8i3GpLatsXL6FS/oqta3++wMs7+5LeRy4XK4=;
        b=ukqWmx3wk3bwzUUQ1iO/jvjVvsc23IEqfUxqjqDjOfpR0kUF144ve+vgR3s5aGxeh3
         k6uyPmHOLatnda/+LtcyvQ8Pr6jtdFGok9hsz9Y+OvxzTt4UejcZWTdPFr6e7/h085Ey
         Ob5UOdSyjGF2QlfDxl4ZOBTzxz6cwKw8GkH7j8JI7VIy7ZJhycPoMMMkgpM//FPZfnHv
         vx96uYQOwuO2dLziGjZJGTp3W3dxTeJIb1hiEmF0lPrJmLV9T3ofbq2Wc25CWmyvXoG/
         SXBHID4/4JQSFL7qMQU9xOh9b9SmLNWtP/AInD0CHc8QWjJ9G+CtkMq43SPy1PHfNrSd
         ROfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LrkVzYO8i3GpLatsXL6FS/oqta3++wMs7+5LeRy4XK4=;
        b=JK35BvTO/YeKpkih5POXQgVS16goMMLB9VgvrXP2Z/+HykZwJ3GA/bvy8/re9ZQbPr
         4SXxhC/mTFCzevm+R70RCD1/ybbgDlN/p8qPrloVLXsAYwEetToUkZX6RozJvKkIjiAR
         8k+jwDi1lid3bGrNmuq38i2EM1UgYLarYmxBT7scEH9GsDxPlXvekaeoGvKgULivL1bd
         izwMf2SXJ8y1lT5O0T0ZRY2HffXNqi3aBk67BeLby0efDFvrBwO9KFRqBMhJk4lVRwkf
         Bkfjj4aHax+637BH0Cc7D1uvRtGNXlzpeCc5CWq71dCYpsEAi07kzTIYqz5x2I5a04xF
         c78A==
X-Gm-Message-State: APjAAAUN5221m/Qi/v05D4zitEuMsQQm9tHQFnxnsfOFEsn1tyL+h9Bi
        4qNOwkhsZlS5CMUe3Hz3PjA/Iw==
X-Google-Smtp-Source: APXvYqw1Y82RfJ3jpeXI3QjGSBtoRy2moIA/+T+GLROcNG/x6qQpL1g5WWqaNo2iN13u4PoSisRA8Q==
X-Received: by 2002:adf:afd1:: with SMTP id y17mr7767686wrd.125.1556531278695;
        Mon, 29 Apr 2019 02:47:58 -0700 (PDT)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id 192sm47987465wme.13.2019.04.29.02.47.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 02:47:57 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, patchwork-bot+notify@kernel.org
Subject: [PATCH 0/2] ASoC: fix hw_params/hw_free validity checks
Date:   Mon, 29 Apr 2019 11:47:48 +0200
Message-Id: <20190429094750.1857-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While working on a codec, I have found an odd situation. The hw_params
callback which was provided by the codec dai was not called as expected.
However, the hw_free callback was called, even if hw_params was skipped.

After debugging, I found out that the dai was considered invalid because
it did not specify any rates, only rate_min and rate_max. That's a first
problem.

If a codec dai is considered invalid, hw_free should probably not be
called either, that's a 2nd issue.

This patchset is meant to solve both issues.

Jerome Brunet (2):
  ASoC: fix valid stream condition
  ASoC: skip hw_free on codec dai for which the stream is invalid

 sound/soc/soc-pcm.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

-- 
2.20.1

