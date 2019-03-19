Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5FB3C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 08:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AF642133D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 08:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="H3XUO09m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbfCSIux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 04:50:53 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42491 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726916AbfCSIuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 04:50:52 -0400
Received: by mail-wr1-f65.google.com with SMTP id n9so15944293wrr.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 01:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mTg1vloqFMMJ8QwUD+aqjv6FfZlYnVseq+YEtYp0RWo=;
        b=H3XUO09mg8XnByAzQhDw7fx5uCElfq64oTB9iOi2WRFCLioc8X3uVvLVxIoIzdV6XY
         XmCN65foiQLWLsVqHtCrifVByU75br9d0ieAlPk0umaHhBWFTJUFh5M+HdgCzFP4od6W
         mHBWQkZpT4vnEP3D+yJNbc7JaJn6RFIfHp2pFtW6SLw8D4vEV8gnJaCNe4KMQG9I+4bc
         lRImh5ljKNXNdJ8dH6WwR9xuZ/0TB1BfObQxOR6Wsbw0Oe14q2m82PMGBWDG4Jp8Fa80
         Pq7cRn0KYWH2bcdkjBhcmeKvzZBRJQ4I9poBGnddwgTrpe+Fld4zbRtade+/NI0Yu8Dy
         XiHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mTg1vloqFMMJ8QwUD+aqjv6FfZlYnVseq+YEtYp0RWo=;
        b=OLclXSGm2KOiDHTcMZwCdeBcMXpfGerelpGUQKMnpH/IVhKAvcs89Z9fe6mvhXd4FR
         zYnSW0fmh7xw4PlTrAslFcvsL7H1QnEXzMyahdkdIfp87qA7yASLDk48URsTdy/0mRVG
         Ge6zxZyKTUKiLuAw16raa92IKnU8NjxKgBabuupdFxWX4I75UhBnukfvRGukLvYU/qsz
         HZg4J4a3+9iuP578yKlbZlM/ryHozQq75KDdLj5zxTpc9NGIQJr3G1F5cquI4Se4KDEd
         8vp9ZEUzBLzih69RqL/pma9IjrZ8yJNmofKidgtfFVJk9RW5EH6iDvL+OQHUeCrjlf3i
         jjrQ==
X-Gm-Message-State: APjAAAX7Agz0NW6IrbDVxABAyycxn2zGskSZG7o0z7kfTFN51y6UwYRo
        Dk//DjALeSioX2a2ikAwQ/Hy8w==
X-Google-Smtp-Source: APXvYqx2PL0gMKAR/SMA+Wmdxf8KEE1HQO+g1Z6xi11rQwmzHNtsTNIVTDdaYlUSNImb9hXzjTHe3g==
X-Received: by 2002:adf:dd8c:: with SMTP id x12mr7204479wrl.262.1552985451124;
        Tue, 19 Mar 2019 01:50:51 -0700 (PDT)
Received: from mjourdan-pc.numericable.fr (abo-99-183-68.mtp.modulonet.fr. [85.68.183.99])
        by smtp.gmail.com with ESMTPSA id n4sm9411047wrx.39.2019.03.19.01.50.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 01:50:50 -0700 (PDT)
From:   Maxime Jourdan <mjourdan@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Cc:     Maxime Jourdan <mjourdan@baylibre.com>, linux-clk@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] clk: meson: add video decoder clocks for G12A
Date:   Tue, 19 Mar 2019 09:50:42 +0100
Message-Id: <20190319085044.8581-1-mjourdan@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As to not conflict with the IDs, this patch series is based on Neil's
last unmerged patch series: "clk: meson: add support for PCIE PLL"

Clocks are mostly the same as meson-gx, except for VDEC_HEVC which is
now split in two, HEVC and HEVCF.

Maxime Jourdan (2):
  dt-bindings: clk: g12a-clkc: add VDEC clock IDs
  clk: meson-g12a: add video decoder clocks

 drivers/clk/meson/g12a.c              | 160 ++++++++++++++++++++++++++
 drivers/clk/meson/g12a.h              |   8 +-
 include/dt-bindings/clock/g12a-clkc.h |   3 +
 3 files changed, 170 insertions(+), 1 deletion(-)

-- 
2.21.0

