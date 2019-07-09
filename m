Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 460F4C73C56
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 18:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 253E420665
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 18:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sOurpNYC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfGISWB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 14:22:01 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36498 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfGISWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 14:22:00 -0400
Received: by mail-pl1-f193.google.com with SMTP id k8so10529442plt.3;
        Tue, 09 Jul 2019 11:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/7SeunipKTPZ/+kbJegCG+IF0p5px4U+K64a01qXtbE=;
        b=sOurpNYCJgDeWdvGkMj8ayoABPRE6fc/4zOsZC7FyTAo8Tr+q1gjS4BcBv72AAs3a8
         UtGvCQrz7Z8RYFwMSpWwIz0cfoq5O82WShkcOmdIWpkjsWgSpNcDvNEiafl7UO/6CfP1
         W58CGB/DxmA52/5HglaJeRUzcXaCg231oj4dvcutHMlW+6WgWebC/cRRpE08FE0ChO2U
         cQ3T/gEQtah4pCv/pmweD6I1gkA37bNO0Al1gScGvbVoqNkPtg2zCLOfeRsVUkf7a8xD
         LkjUGWca7W4+mB9/BBjp/mdmeuf2ScqDH2yB96txiYab9HzIyqE+v9HhNcoFkntQkhvq
         Tmow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/7SeunipKTPZ/+kbJegCG+IF0p5px4U+K64a01qXtbE=;
        b=qDprZY5/ehuPgkQIppB2ORnA0vCgiznjjyhrzzUgE1l2qd0XL6V2I1ffzXl3yNMP1x
         +AlolWtUKVyWGOM35xt8B4Zv0iZywMrzpAw1qmrIRhN/mZ7AjpNgkIB6wnRcfgJXsx/H
         EiZNaKvqo2v8l9j/H6VRPm7sRys6aV7Vr9RN4QTvrdda6hn1AQvbj756+Bf5pb+14kSl
         pXS1aa8Y50XvSQxIXBeEa+jf19GM4qshNLIhE3geMG6s1ZvLnS1vcoqjAy86kHC1Gj+6
         71+py1ICtGmVCf87Os+UNRxn+FQfsOgzK4b8vVdy8BFhx5TgiJYpTvpLs2+zgK8/Ak0z
         1HKw==
X-Gm-Message-State: APjAAAUWKU34bTrVXo6F3OYARaAIjNaSYs1Ogj3DYnu7th1v274gzbGp
        85g2+a6LTxOs6NgQpdBTnPnidoWxvOee7A==
X-Google-Smtp-Source: APXvYqypFlpEDviSy2ejpUywzPdVRNwYyo/yvYMiyCSTuDOWShCdGVsakrtlrPCv8wbj+TvDK+OTfA==
X-Received: by 2002:a17:902:86:: with SMTP id a6mr34117842pla.244.1562696519377;
        Tue, 09 Jul 2019 11:21:59 -0700 (PDT)
Received: from localhost.localdomain ([2001:19f0:7001:2668:5400:1ff:fe62:2bbd])
        by smtp.gmail.com with ESMTPSA id m69sm21008639pga.11.2019.07.09.11.21.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Jul 2019 11:21:58 -0700 (PDT)
From:   Chuanhong Guo <gch981213@gmail.com>
To:     linux-clk@vger.kernel.org (open list:COMMON CLK FRAMEWORK),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list),
        linux-mips@vger.kernel.org (open list:MIPS),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM)
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        John Crispin <john@phrozen.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Weijie Gao <hackpascal@gmail.com>, NeilBrown <neil@brown.name>,
        Chuanhong Guo <gch981213@gmail.com>
Subject: [PATCH 0/5] MIPS: ralink: add CPU clock detection for MT7621
Date:   Wed, 10 Jul 2019 02:20:13 +0800
Message-Id: <20190709182018.23193-1-gch981213@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset ports CPU clock detection for MT7621 from OpenWrt.

Last time I sent this, I forgot to add an binding include which
caused a compile error and the patch doesn't stay in linux-next.

This patchset resent the first two commits and also added binding
documentation for mt7621-pll and used it in mt7621-dts at
drivers/staging.

BTW: What should I do with such a patchset that touches multiple
parts in kernel?
Is it correct to send the entire patchset to lists of all involved
subsystems?

Chuanhong Guo (5):
  MIPS: ralink: add dt binding header for mt7621-pll
  MIPS: ralink: fix cpu clock of mt7621 and add dt clk devices
  dt: bindings: add mt7621-pll dt binding documentation
  staging: mt7621-dts: add dt nodes for mt7621-pll
  staging: mt7621-dts: fix register range of memc node in mt7621.dtsi

 .../bindings/clock/mediatek,mt7621-pll.txt    |  19 ++++
 arch/mips/include/asm/mach-ralink/mt7621.h    |  20 ++++
 arch/mips/ralink/mt7621.c                     | 102 ++++++++++++------
 arch/mips/ralink/timer-gic.c                  |   4 +-
 drivers/staging/mt7621-dts/mt7621.dtsi        |  17 ++-
 include/dt-bindings/clock/mt7621-clk.h        |  14 +++
 6 files changed, 134 insertions(+), 42 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt7621-pll.txt
 create mode 100644 include/dt-bindings/clock/mt7621-clk.h

-- 
2.21.0

