Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6389DC432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 23:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 375DE21D7B
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 23:42:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gNJujOSQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732266AbfIYXmb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 19:42:31 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39067 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728856AbfIYXma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 19:42:30 -0400
Received: by mail-pl1-f194.google.com with SMTP id s17so396803plp.6
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 16:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=FWq12v0l25/25NHMUK4x2Bta04DqoQNuL8vSuCdOZpk=;
        b=gNJujOSQp9rC6EBCot02UBfTX6szLQqPNSCL8LnBSnoJCNczdvFcwNsTJVle7vT4Y5
         NMnaxxBxuFqZ+56NgxwpggTKzYoN/5Rg/Pqp5BJ3Tq3+RsW6jq3zXsP8/se7U9orjbSX
         9f0+d6YL8zW+yzEFVzJ3gsBVtouSXL1YeE+K0N3XAjLIHiC2vOnKJSaz+jJHLkL81abs
         po5FQOPWG3C79YXEPAdy20G94bIm/ch/FEldpAFsu2HXMwtAAOZTEb7Yv/5mXvqvbWmS
         kgnQtJxFUmofT3KLeJqhXiyy+4MSxzl68WqCkB7r4qK+83ytYYIucWf2yxMkzuaP+oO9
         veFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FWq12v0l25/25NHMUK4x2Bta04DqoQNuL8vSuCdOZpk=;
        b=FQdSU49jwO9f6CxFPECl5lVKGhh7Dd9pBlDjI2BjDjy0rbFW2ocQ/TvEj+9WP/NWmL
         sr9cjttIbiWeoKUOjA+AqAN9d49Gtu1r2cwb9Tg7B+yRVehD1ytRkS7NDQFGbANL96HJ
         9q5eBkWtvPoosFn6RyIf4kLZTbb35Qt0eS5he5IcjPKtcFzwkdXwKPkrLE20dsorafrX
         XK4pLLLFYb/X2yxO/kl8K7zcA15rgGYU/lj8EBIzqUZePx6Pqv77WlWz1hRm0Fcrs9UH
         vABmj1GpBJhPr8/qroCsCeUNAjIlMmyz/W18bHs8H6GWMNNXIfaBqzQm9RLnUBx5kf5t
         qabQ==
X-Gm-Message-State: APjAAAUIXxRCq8ijwCD+eXW0Dc3e9DMRftq/h4DDxOPnbDBfp/2UtPJF
        cIJQX8m+xS8b7aihzfnwKHbRZY61hsU=
X-Google-Smtp-Source: APXvYqwmyQNpRkoi+PIX6YyGFxcPt01EWCgLGoSA83cTmN2ppk/KQEiIQ2Ddl5rsamhhyyDC7ie73Q==
X-Received: by 2002:a17:902:8d98:: with SMTP id v24mr687990plo.265.1569454949571;
        Wed, 25 Sep 2019 16:42:29 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id d1sm131127pfc.98.2019.09.25.16.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 16:42:28 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Yu Chen <chenyu56@huawei.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org
Subject: [RFC][PATCH 0/5] dwc3: Changes for HiKey960 support
Date:   Wed, 25 Sep 2019 23:42:19 +0000
Message-Id: <20190925234224.95216-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've been carrying for awhile some patches that Yu Chen was
previously pushing upstream to enable USB on the HiKey960 board
and I wanted to try to nudge them forward as I'm not sure as to
what his plans are.

I've reviewed some of the feedback from his last series, and
tried to clean things up a little bit. However, there are still
some dt binding bits between the misc switch driver and how it
interacts with the rt1711 and dwc3 driver that I'm unsure of.

However, there were some simpler parts of the patch set that I
wanted to send out to see if we could make some progress on
those parts while I continue to work on the more complex bits.

You can find the full set of changes to get USB working on the
board here:
 https://git.linaro.org/people/john.stultz/android-dev.git/log/?id=e2f983603b4d89c021929842142ca7c3370422cf 

This series is just the more trivial changes, along with some
missing binding documentation that I've added.

I'd greatly appreciate any review or feedback on this series!

thanks
-john

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Felipe Balbi <balbi@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Yu Chen <chenyu56@huawei.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: linux-usb@vger.kernel.org
Cc: devicetree@vger.kernel.org

John Stultz (2):
  dt-bindings: usb: dwc3: Add a property to do a CGTL soft reset on mode
    switching
  dt-bindings: usb: dwc3: of-simple: add compatible for HiSi

Yu Chen (3):
  usb: dwc3: Execute GCTL Core Soft Reset while switch mode for
    Hisilicon Kirin Soc
  usb: dwc3: Increase timeout for CmdAct cleared by device controller
  usb: dwc3: dwc3-of-simple: Add support for dwc3 of Hisilicon Soc
    Platform

 .../devicetree/bindings/usb/dwc3.txt          |  2 +
 .../devicetree/bindings/usb/hisi,dwc3.txt     | 52 +++++++++++++++++++
 drivers/usb/dwc3/core.c                       | 20 +++++++
 drivers/usb/dwc3/core.h                       |  3 ++
 drivers/usb/dwc3/dwc3-of-simple.c             |  4 +-
 drivers/usb/dwc3/gadget.c                     |  2 +-
 6 files changed, 81 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/hisi,dwc3.txt

-- 
2.17.1

