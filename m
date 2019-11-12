Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8070C17440
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 13:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A135220818
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 13:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="DUMIM24I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfKLNUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 08:20:18 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39849 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfKLNUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 08:20:18 -0500
Received: by mail-lf1-f67.google.com with SMTP id j14so4219376lfk.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 05:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0pZeHJXrkcOE52JT+BLqoRf59jEWL/uBcfxLoGjjwKQ=;
        b=DUMIM24ILNaW7JrnAwsV7kKLEPHiTz/bkIaUMXL4XqBJHjuXVhmATdQWCeqUl5qDbI
         DAujvN5K84e2xlLvUUPHplVV0UMkPQ/36Bw4nTkvDua5kXv8zQBupu0HgUApQbTJ17nw
         +00cRK0IBB3mWLN4xaktL/eZB4w40NTQYYGXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0pZeHJXrkcOE52JT+BLqoRf59jEWL/uBcfxLoGjjwKQ=;
        b=oAN5I7COQ75Lh9tXUPh0vLwiZ0JDv/BXcVocMwGfBEIKxBYCkoVhfY2OEVbXnnEi/J
         Wdo/SFUpIpS5x+y/XEHvO01yvLqFfpqsXMZV/tjx1HjDdeFBEnAdAxMQn387gKKIZ1eQ
         glX3yNGTvCuOet/T8Uyn4kSqafVROuIl8XKS/mU9sK2tK3ULkPlWEL56R4cK6qYhgltF
         Bz6sJ8Veb+UtRuHWT/TFw8Mcg2CJsY6b8TY2EX7/Dnr7MNzUigGBmKbrRlONMGfOgCgA
         EFMCBrtQmZQv0s8znM+kfWpPiSlJq8aRjmSUC3KynPqWZEUfIfJF8cIwQh8Ow5UBPZix
         D0lQ==
X-Gm-Message-State: APjAAAWcylZ7sucrd5h3h0Il8RgNzuJp6Wo/QAqD/QpZymhzxqEKLEhk
        wZZCqU1seaw74HJywRjGDd3w9g==
X-Google-Smtp-Source: APXvYqzxHffr4e1+dAJjjPz5zrGyAj/4YB2n45y1G8UEWMUh280NYl3CkA9jXpQXK6Xr81MsFj7yfA==
X-Received: by 2002:a19:5e0e:: with SMTP id s14mr19338765lfb.30.1573564814637;
        Tue, 12 Nov 2019 05:20:14 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id f20sm869050lfc.75.2019.11.12.05.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 05:20:14 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Vladimir Oltean <olteanv@gmail.com>, Marc Zyngier <maz@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 0/2] ARM: dts: ls1021a: define and use external interrupt lines
Date:   Tue, 12 Nov 2019 14:20:08 +0100
Message-Id: <20191112132010.18274-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A device tree binding documentation as well as a driver implementing
support for the external interrupt lines on the ls1021a has been
merged into irqchip-next, so will very likely appear in v5.5. See

87cd38dfd9e6 dt/bindings: Add bindings for Layerscape external irqs
0dcd9f872769 irqchip: Add support for Layerscape external interrupt lines

present in next-20191112.

These patches simply add the extirq node to the ls1021a.dtsi and make
use of it on the LS1021A-TSN board. I hope these can be picked up so
they also land in v5.5, so we don't have to wait a full extra release
cycle.

Rasmus Villemoes (1):
  ARM: dts: ls1021a: add node describing external interrupt lines

Vladimir Oltean (1):
  ARM: dts: ls1021a-tsn: Use interrupts for the SGMII PHYs

 arch/arm/boot/dts/ls1021a-tsn.dts |  4 ++++
 arch/arm/boot/dts/ls1021a.dtsi    | 19 +++++++++++++++++++
 2 files changed, 23 insertions(+)

-- 
2.23.0

