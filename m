Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE49C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 10:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E26B8206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 10:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="scgDvIvY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728880AbfH0KDN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 06:03:13 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54558 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbfH0KDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 06:03:13 -0400
Received: by mail-wm1-f65.google.com with SMTP id p74so2408905wme.4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 03:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dfpmBSGlcGs38lFamRyhz8Fa4xFl9r4NMSFw+nilf+4=;
        b=scgDvIvYRNMAtfMsmF6Kh5SAZnT0KCRLs+0S/9i8oDKab6se5Z5PPJmdgM3hUyWwGg
         oNRzD2ab73hMIsdjPOhvy4BfuCYiK8X+yPGeNIdkDm9M/x70PxQshaNZDT+G+vDhcOqA
         Sbs+LOEBKDPBuAoicHDF1b1lMFVhvFxYBwUZFhKOLEYmWgOa40f7sR+Q9M/Fn1A5MkOL
         ItsxIMys3gGfraHcxeYWYf0RW3cuF2b4GnrvbBfV7AJgK1W8JmZMKJ7porS1vak4FIBV
         w1XS3t8Fey0CM3EXuWJ5D9MaSppcUh/au6vtXwF1eb9vqJ89JtMhN9nh5qXLRwBkSrw6
         zujw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dfpmBSGlcGs38lFamRyhz8Fa4xFl9r4NMSFw+nilf+4=;
        b=W0zJNU8I7aNvf7qmBZF80Cuf0Cq3jgx34k9pQ63sggyA3s7VVMJI+m8/5gYF7QjN6Q
         aY1voKy2aBp4ajkd77EvmT+Ls3Ek+uXYEU0odoLJt7XN7f0UMfHP5nl2LCLhLV9iU/uD
         0/+xyhicTYCrKyT6KqO9XAFRO8yrsFIpnCCQBAk/ua4KsVwHz9bjPlgEW3fknb0qnxcN
         W/DgPq+1mCBZFRRsYWGj+m1/bgtuyR1rmN012u7TRrePibLRAZO/5a8a1Z0bmhSExZEW
         FoeqKvPsOUQBGorV1AJCN7clOoEjQ7ZwhxcIWiJa5YhUl2A0rwf1x64XnU+alra02ZS6
         cwEg==
X-Gm-Message-State: APjAAAVmOvQSU36k0HvMVK+lmqegF7pIKRwEdu7QpzSQs/HVEwp+ALR3
        3nR2SuoDI37coOlDLpv8qzrk8zk7CT/GrQ==
X-Google-Smtp-Source: APXvYqwSlvXctj1/5N+lx0316n3C/TFLI2SVBe9G3fCjk/sXsHm1IWI8Id8tmjD/QhJB0i02kSVDGA==
X-Received: by 2002:a1c:a481:: with SMTP id n123mr25414549wme.123.1566900190939;
        Tue, 27 Aug 2019 03:03:10 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id o25sm1816289wmc.36.2019.08.27.03.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 03:03:10 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 0/3] arm64: dts: meson-g12: specify suspend OPP
Date:   Tue, 27 Aug 2019 12:03:04 +0200
Message-Id: <20190827100307.21661-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tag the 1,2GHz OPP as suspend OPP to be set before going in suspend mode,
for the G12A, G12B and SM1 SoCs.

It has been reported that using various OPPs can lead to error or
resume with a different OPP from the ROM, thus use this safe OPP as
it is the default OPP used by the BL2 boot firmware.

Neil Armstrong (3):
  arm64: dts: meson-g12a: specify suspend OPP
  arm64: dts: meson-sm1: specify suspend OPP
  arm64: dts: meson-g12b: specify suspend OPP

 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi       | 1 +
 arch/arm64/boot/dts/amlogic/meson-g12b-a311d.dtsi | 2 ++
 arch/arm64/boot/dts/amlogic/meson-g12b-s922x.dtsi | 2 ++
 arch/arm64/boot/dts/amlogic/meson-sm1.dtsi        | 1 +
 4 files changed, 6 insertions(+)

-- 
2.22.0

