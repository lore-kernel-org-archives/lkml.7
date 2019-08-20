Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60CB8C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 09:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AB8922CF7
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 09:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="PV+jCn5O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729621AbfHTJqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 05:46:32 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41096 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728426AbfHTJqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 05:46:31 -0400
Received: by mail-wr1-f67.google.com with SMTP id j16so11669304wrr.8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 02:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M8ToaxucjQlogdMowFdkWR4IXJJ6iFaHGB902RHdk/E=;
        b=PV+jCn5O0GP3lMpzRKJ+dTfqwwE4XtQgfuEpI54AC4CvTC850JS4o5NLOct67iouHE
         A32sxWArxSA3FhY7BhgfkbcjaSYOtgPISE1Ote0/9d54jaABzpD9SprjMrMUQtDlOfjs
         D3q/xsgO64/aWwii7jU7JJcfDRwkcKUn65q8BGa3depykDfLotzazu6I8ewvAJUGiFGx
         c3p7WC64jTJCFusWmvl3ubXuFsiuv4xpr3cYbBd9h31/FXEL+5FS4FWNVCK237TZ5KGd
         3KUNzFmXqXrfP9aiK5OxttInGX+2KAGjG54GI4Eb3WWrkxY5DVew94gLB1GavL5SrzWR
         lI9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M8ToaxucjQlogdMowFdkWR4IXJJ6iFaHGB902RHdk/E=;
        b=Yy0UR4ojoOhT40Y+pePqD15+Hn8rIBXe7vKH4cAgUsuM09Jb84O6Vgx4fMZuagHpli
         anIQX01/UX+uEgKIzSUnvNh+c68kocLG+T8CMHxoKk1NfcA+DlWQaYHKl1z5voPETM+s
         27GQfP4JsebNsQvDbmBaOk6BKKXwNGDumCvxtMGOMaDOSPx5Rz97vGFsveNkKllUER4Q
         y5Kby6oBpxpJlPzCdrb1QPWtFLOm4rS8WF2uuaDhClaD5pGrL7vkFLrSYb79CIYZvycN
         HcMM0Y4U61krKhYTjJgmQg8wpe6XISC1N6apNTsK+KQJ2Yjbc/Zd8pp4agJIl6BeZcns
         QwoQ==
X-Gm-Message-State: APjAAAXq+hYJ2ETRoU9acaGB4dnW/0yDcE9UiW6TEEqpoQJJsmZtSBF6
        QuJm8Zve3z4N5T+kSEZSwxE5TA==
X-Google-Smtp-Source: APXvYqwgS/FwkAFLZrPF2zgs8yyNuMS58TcflpUB/WQwtaG9GH2QdJ048e4dmWTG8/aAQ+l5TgI7oA==
X-Received: by 2002:adf:ecc7:: with SMTP id s7mr34218122wro.215.1566294389556;
        Tue, 20 Aug 2019 02:46:29 -0700 (PDT)
Received: from starbuck.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id o17sm15958305wrx.60.2019.08.20.02.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 02:46:29 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] reset: meson-audio-arb: add sm1 support
Date:   Tue, 20 Aug 2019 11:46:23 +0200
Message-Id: <20190820094625.13455-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds the new arb reset lines for the sm1 SoC family

Jerome Brunet (2):
  reset: dt-bindings: meson: update arb bindings for sm1
  reset: meson-audio-arb: add sm1 support

 .../reset/amlogic,meson-axg-audio-arb.txt     |  3 +-
 drivers/reset/reset-meson-audio-arb.c         | 28 +++++++++++++++++--
 .../reset/amlogic,meson-axg-audio-arb.h       |  2 ++
 3 files changed, 29 insertions(+), 4 deletions(-)

-- 
2.21.0

