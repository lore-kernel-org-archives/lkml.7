Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6AC0C3A59E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 18:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FDD5206B7
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 18:49:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FEwBv8bt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbfHXStV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 14:49:21 -0400
Received: from mail-pf1-f175.google.com ([209.85.210.175]:41079 "EHLO
        mail-pf1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbfHXStV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 14:49:21 -0400
Received: by mail-pf1-f175.google.com with SMTP id 196so8891450pfz.8;
        Sat, 24 Aug 2019 11:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I5fAoCSunKyneQTnxswt2lZAvNjsVlaAOR0R91zCLtY=;
        b=FEwBv8btTNIYphxJxntCEk1P1gSbJ23VCP2kFlrutJ/W2DM07vIMjMhN01WntGgWWc
         SpTIhC+t9l2Is3kJPeI+6uNFlmLNmTtudjQpw68gcXHJryP1x6LL34+XIapDJg/C5YeZ
         qE9U+O85LEyzbFeZe6FPnr1MEGiyJ8TjYJ/4GDfELJ52filMQTv+20c8H4H8uHar9gK5
         8zWOcOd1XLXF9Lp1Siqa8PWA9m7n5rkzl2Zt8rbf3ztyMlS46DVbMrTWKFtWLU5PdIgR
         awTg7/ArU6pNTVB1d0N6cPAs3fpqoEMaMo95nasUkoeh1slE5dXJDh39BIBgjHR+fooy
         OzYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I5fAoCSunKyneQTnxswt2lZAvNjsVlaAOR0R91zCLtY=;
        b=AKDkPY4nzptzMcZC6bc8vHCRaQmxXj3N4v7U0YX/MTocztrqcSA/zEUF17x9cfV9uL
         aH6I6mFSHlufzmEa/OCo0L2P/YiikcATLWLZF8KSjJ8fhB40J/pCQM1iHXhUuwIavCbk
         QKr22pge4DTiOl9PW8yAYLoQ8JCI90JS0SNn6d2R4EelPyonlv4nTQP7kFpYHve1Jr1U
         CEjFijHcpXAAtp335WX1dSiKJGPjGI466jOHJLNCaupoH0vMGVReupt8Gi0nyRC5frgj
         EtEQRCTDEbQVjV1d1rjVGubNCGJOpYJrhLYrFQEj6FKhyMFKbuEsDmmBUfS1gj/HFRzD
         u6oA==
X-Gm-Message-State: APjAAAVDP1lJWPeUg3zLJTicLk+udTCtRxQmwueIjBWPASNe2JqP/IRN
        0WBrrHVxugfAvdBbCChqzh8=
X-Google-Smtp-Source: APXvYqx9uWXRu5STlTuhhddKk5s+NXsSeIbWWPfxTYTrEsTy7Epo+SsjR8s1Ko1fAa3ulcwtF00Qxw==
X-Received: by 2002:a63:31cc:: with SMTP id x195mr9042601pgx.147.1566672560712;
        Sat, 24 Aug 2019 11:49:20 -0700 (PDT)
Received: from localhost.localdomain ([103.51.74.111])
        by smtp.gmail.com with ESMTPSA id t8sm5519292pji.24.2019.08.24.11.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Aug 2019 11:49:20 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCHv4 0/3] Odroid c2 usb fixs
Date:   Sat, 24 Aug 2019 18:49:09 +0000
Message-Id: <20190824184912.795-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some time ago I had tired to enable usb bus 1 for Odroid C2/C1
but it's look like some more work is needed to u-boot and
usb_phy driver to initialize this port.

Below patches tries to address the issue regarding usb bus 2 (4 port)
while disable the usb bus 1 on this board.

Prevoius patch
[0] https://lkml.org/lkml/2019/1/29/325
I have tried to split the patchs for now.

Anand Moon (3):
  arm64: dts: meson: odroid-c2: p5v0 is the main 5V power input
  arm64: dts: meson: odroid-c2: Add missing linking regulator to usb bus
  arm64: dts: meson: odroid-c2: Disable usb_otg bus to avoid power
    failed warning

 .../boot/dts/amlogic/meson-gxbb-odroidc2.dts  | 20 +++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

-- 
2.23.0

