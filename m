Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A78C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 10:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F5CF20857
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 10:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="f4W+7bdI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbfCSKLv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 06:11:51 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41063 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbfCSKLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 06:11:51 -0400
Received: by mail-wr1-f68.google.com with SMTP id p1so20310588wrs.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 03:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g9yVsy2U2fQ4Cv8Ug3KJAXrZHWOeSYhR24THaUMb+SU=;
        b=f4W+7bdIgNoZq0rZHqyA/sC5BffDx76TnmSUfoDj7qkRuRN0K7RqRUaCWvCQNtBZ9y
         zx3LIprSg46eGLEdOcz1DvCoRPpoQtbB21YeAUBo8EugzK3ZNDcgiFGEBXbSPV1VJ/yx
         Xs8pSxV17+j8qCLuUuma2ytDBPxdpPEf7vuRZm2vCQVBQhvyIgw3qToihZDzMehgxaPo
         BX1JKcpJJDemAsqhBrwYvtrDh+uNUYYJvSV/Yb+mO/doinahf/dBPp7EZv69vcd24ZbP
         Oe43s63SbpWrB6kGpYdVqX6TAGFcNQQc9YogSb82RX+/MPE0kw3LSkCGG5RZwI76r9hn
         hkWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g9yVsy2U2fQ4Cv8Ug3KJAXrZHWOeSYhR24THaUMb+SU=;
        b=YU9k6h03Dk6Ox+p41JeyexWODyCNMLl2M0WYx6ZqnHGRfwT770/ygdY2exwugF+xN/
         fysHNmeA92F2EZn4K2Y4R8CvOBkORnnAn1Tihyi3BYuJpvLhtJuiB60eKbmbQl92EAA7
         Uo/cqt1L2UO7c5f5T7VKqjpWwDDIWMdsdGFZ1KKtiNjw9kk4vZgYjRVD4ybghzIbhjbI
         IZSOWhFSD1iPKZdNDM1JXivlDo8pf5d4O9eY88R70DIXpIqc1/LkXkU7fyRn9D5s3H9D
         UmaapFCatbKwD+1aa8iXWlulf4pngOlx9wOqiP/fSRpkGiY1sOL8EJNz3FWUIngjj1pe
         FrPA==
X-Gm-Message-State: APjAAAVtLeNeU9jvRDPwUl2seAvwbgo/+tAlbYmIu+EgEMKQustV1h4O
        fjSuFj+gTrV2HNCqsvSrlyhFWg==
X-Google-Smtp-Source: APXvYqwUo0KR5WJ6K06wtK6h6lPQCRijNUkBdsnpPrGkb3yrcmLzg9qRjTKRdOGOzouxoqyfqL3hjA==
X-Received: by 2002:a5d:428c:: with SMTP id k12mr7833647wrq.279.1552990309225;
        Tue, 19 Mar 2019 03:11:49 -0700 (PDT)
Received: from mjourdan-pc.numericable.fr (abo-99-183-68.mtp.modulonet.fr. [85.68.183.99])
        by smtp.gmail.com with ESMTPSA id h10sm3911245wmf.2.2019.03.19.03.11.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 03:11:48 -0700 (PDT)
From:   Maxime Jourdan <mjourdan@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Cc:     Maxime Jourdan <mjourdan@baylibre.com>, linux-clk@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] clk: meson: add video decoder clocks for G12A
Date:   Tue, 19 Mar 2019 11:11:36 +0100
Message-Id: <20190319101138.27520-1-mjourdan@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds the clocks related to the video decoder on G12A:
VDEC_1, VDEC_HEVC and VDEC_HEVCF.

As to not conflict with the IDs, this patch series is based on Neil's
last unmerged patch series: "clk: meson: add support for PCIE PLL" [0]

Changes since v1 [1]:
 - Apply ROUND_CLOSEST to the dividers in addition to the muxes

[0] https://patchwork.kernel.org/cover/10842969/
[1] https://patchwork.kernel.org/cover/10859115/

Maxime Jourdan (2):
  dt-bindings: clk: g12a-clkc: add VDEC clock IDs
  clk: meson-g12a: add video decoder clocks

 drivers/clk/meson/g12a.c              | 163 ++++++++++++++++++++++++++
 drivers/clk/meson/g12a.h              |   8 +-
 include/dt-bindings/clock/g12a-clkc.h |   3 +
 3 files changed, 173 insertions(+), 1 deletion(-)

-- 
2.21.0

