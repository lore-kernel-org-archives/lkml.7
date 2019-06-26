Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCBE5C48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 13:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 939CC205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 13:36:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="VHEsNntS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbfFZNgf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 09:36:35 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56307 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbfFZNge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 09:36:34 -0400
Received: by mail-wm1-f68.google.com with SMTP id a15so2139810wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 06:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4FQg0smS+mfYMsusPPdodpkb22WraUSysEIqfJJV0yM=;
        b=VHEsNntS0B4pEO3c7fwECuQ4V7xeuFnooK6MO9IMX978YagrBVIBsBiTY/LeigduXr
         hEbi1aImDb5PmCDtCL69RpPzO091ws2GrWX+YPTWXyBl39/QnErn31JHaEHU3SibngUj
         FNNYMAXWu1Tqgnw5sz2ykr2xgdx7q4KTMKiPYaaQ3KGcDx/koVCST9+xzBl5+BtWNtFP
         5p9Zdc76EobXrkOX18uFkB+3jY53S8T2F5N8v1f5SFftwAhZPOnZY1ma88QRv2JP5rfh
         Tx4fBaWB37o2j1YJ6zOKCb4gZpNh05B4LnMrZroeTsw6Y75HgPdAiFYDfOektVxiXGer
         IPfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4FQg0smS+mfYMsusPPdodpkb22WraUSysEIqfJJV0yM=;
        b=kmOdLsUvj7hvHR7Catb09Zn1X7JvlPs38G/7xoyPZjC3jf+CwvPHHRh0awOV4NoMHE
         XNnnQWa/+xLfNc9S0Nvm64JcyxWqnQEG8k5Op8svYKGO1jJDHCI9Wc8Ggw+4xU86ZvR9
         +ClBsIu/xd4xPYLOyFVbjz5mBQVV74NCUVCujg8koYTNZqR0COxgxLZpHjCnhP+gl98x
         dU2YHXVZe2+OawMFXT91tZJK/SQBXC2nMdpp+fFyD9Ue1cBSEIxwk9WObfETszvfE7vJ
         t8KrfwPvpnBP1aSJQMvmr2FqLWwMIAx1lGEriQ5g7XTxvMnkr0WMYu8Rnqv3aw4m3x14
         sRSA==
X-Gm-Message-State: APjAAAVB4yzrl3LrTrlAT5J+5o6RmLQkN3Mkb2/ewJ1GR+5/elk15y4q
        CpcmYyhbaH9a+RnP/Rs8ybpwSw==
X-Google-Smtp-Source: APXvYqysws+jQlqShYlTKNd5YEBpxaojbCsgdCSKH4ZtXxVfdbxFbdzZ7FYDDAUJSCKD6wEDIJmj7g==
X-Received: by 2002:a1c:3:: with SMTP id 3mr2866435wma.6.1561556192208;
        Wed, 26 Jun 2019 06:36:32 -0700 (PDT)
Received: from starbuck.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id w185sm2877880wma.39.2019.06.26.06.36.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 06:36:31 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH 0/2] ASoC: soc-core: update dai_link init
Date:   Wed, 26 Jun 2019 15:36:15 +0200
Message-Id: <20190626133617.25959-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My initial goal with this patchset was to allow a dai_link to have no
no platform component, instead of having dummy by default.

However, when rebasing, I discovered that Kuninori Morimoto had recently
done that in a different way :)

I am still submitting my change since it should allow multiple platform
components on a dai_link, which is one of the FIXME note in soc-core.

I have also added a check on the codecs component availability to align
on what was done for platforms and cpus

Jerome Brunet (2):
  ASoC: soc-core: defer card registration if codec component is missing
  ASoC: soc-core: support dai_link with platforms_num != 1

 include/sound/soc.h  |  6 ++++
 sound/soc/soc-core.c | 72 +++++++++++++++++++++-----------------------
 2 files changed, 41 insertions(+), 37 deletions(-)

-- 
2.21.0

