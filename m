Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 935BEC43215
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 18:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 755C2215E5
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 18:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbfLBSWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 13:22:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:35890 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727671AbfLBSWP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 13:22:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 98844AD98;
        Mon,  2 Dec 2019 18:22:13 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        James Tai <james.tai@realtek.com>
Subject: [PATCH 00/14] ARM: dts: realtek: Introduce syscon
Date:   Mon,  2 Dec 2019 19:21:50 +0100
Message-Id: <20191202182205.14629-1-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patch series factors out system controller multi-function device nodes
for CRT, Iso, Misc, SB2 and SCPU Wrapper IP blocks.

It was inspired by my SoC info RFC, as discussed in its cover letter [1].

Goal of DT is to describe the hardware, and in previous patches we've already
introduced Realtek's r-bus as node layer. The next step here is to model
multi-function blocks as nodes. In order to cope with 80-character line limit,
child nodes are added via reference rather than in-place.

Also included is a patch adding a reset constant for the SB2 block added.
We may need to follow up with bindings adding compatibles, clocks and resets.

This series is based on my RTD1195 v4 [2] (except for reset, rebased here),
my RTD1395 v2 [3] and James' modified RTD1619 v3 [4].

The irq mux series v5 [5] has been rebased onto this series, v6 to be sent.
The SoC info RFC series [1] is still being updated, v2 to be posted later.

Latest experimental patches at:
https://github.com/afaerber/linux/commits/rtd1295-next

Have a lot of fun!

Cheers,
Andreas

[1] https://patchwork.kernel.org/cover/11224261/
[2] https://patchwork.kernel.org/cover/11258949/
[3] https://patchwork.kernel.org/cover/11268955/
[4] https://patchwork.kernel.org/patch/11239697/
[5] https://patchwork.kernel.org/cover/11255291/

Cc: devicetree@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>
Cc: James Tai <james.tai@realtek.com>

Andreas Färber (14):
  ARM: dts: rtd1195: Introduce iso and misc syscon
  arm64: dts: realtek: rtd129x: Introduce CRT, iso and misc syscon
  arm64: dts: realtek: rtd139x: Introduce CRT, iso and misc syscon
  arm64: dts: realtek: rtd16xx: Introduce iso and misc syscon
  ARM: dts: rtd1195: Add CRT syscon node
  dt-bindings: reset: Add Realtek RTD1195
  ARM: dts: rtd1195: Add reset nodes
  ARM: dts: rtd1195: Add UART resets
  arm64: dts: realtek: rtd16xx: Add CRT syscon node
  ARM: dts: rtd1195: Add SB2 and SCPU Wrapper syscon nodes
  arm64: dts: realtek: rtd129x: Add SB2 and SCPU Wrapper syscon nodes
  arm64: dts: realtek: rtd139x: Add SB2 and SCPU Wrapper syscon nodes
  arm64: dts: realtek: rtd16xx: Add SB2 and SCPU Wrapper syscon nodes
  dt-bindings: reset: rtd1295: Add SB2 reset

 arch/arm/boot/dts/rtd1195.dtsi              | 110 ++++++++++++++++---
 arch/arm64/boot/dts/realtek/rtd129x.dtsi    | 157 ++++++++++++++++++----------
 arch/arm64/boot/dts/realtek/rtd139x.dtsi    | 157 ++++++++++++++++++----------
 arch/arm64/boot/dts/realtek/rtd16xx.dtsi    |  91 ++++++++++++----
 include/dt-bindings/reset/realtek,rtd1195.h |  74 +++++++++++++
 include/dt-bindings/reset/realtek,rtd1295.h |   3 +
 6 files changed, 449 insertions(+), 143 deletions(-)
 create mode 100644 include/dt-bindings/reset/realtek,rtd1195.h

-- 
2.16.4

