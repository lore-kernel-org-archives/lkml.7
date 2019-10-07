Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A281ECE58E
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 17:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6391920684
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 17:56:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h1As562v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729423AbfJGR4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 13:56:01 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40847 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728545AbfJGR4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 13:56:00 -0400
Received: by mail-pf1-f195.google.com with SMTP id x127so9118477pfb.7
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 10:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=egboN5LspnsxlOmbUEUbW8zbZDOgKxSBdf9tJPyXXRs=;
        b=h1As562vjET1VzrndYwZlyOz+8bP+Z6B7xHScJN8GN0dXK88R+2cHCxeADlO92XjUQ
         bp+k3fsyOVMKU2H8C5DhtAir11Pp95AfQwX9dBU1Q00hP05/wNahVY35KhVta3r9FF9X
         pEmUBcyVKz579Ru6T16W/hzUbOal04Ygcxw/JOPYxnD/YP7g1rbcHTkXsNIRNCbBO3jX
         lll53Au/bZ9ilssKtkuGjChBP9xXL9Lz0ShEdID0ZabgSrB1y7mVM4oY1C0qAnGK2RIv
         1dnwOO0g0TbkftARF6KvWBcBTVuvOFhXHqsZw6+8qfho08c1qfxOW3+ggttMw5KH1YGT
         Mclg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=egboN5LspnsxlOmbUEUbW8zbZDOgKxSBdf9tJPyXXRs=;
        b=Q+FqFhMiw39//TlH/EOqpwI2H61pmS2FHAiDzbA0+dZLCMS+HH5KN3LCk16rYIvgi3
         g/dAXUUNhDqqNDpZy7WexEPWF4MJmJOu5Bhq0x7m+DKAn3IxS7hqRBw3ASrcFBTLIlnv
         gy8n+sXcSgJmyrwmY88iiWmavZSAq8K0/4KSwLzzLh3uBFz5Yxqu4i58TFxtA/qV+BeS
         QP4TkBuMLs2dlTG2TzTMPZ2aKv+xXBx8s4iOAU8s65f/e5wZERAOlIrVjscknXwQOeVV
         QeXkQNVlO533/7Cw7kFgvzhXrkAAVKYm0zyF8BCjDUxh2BEQI90R5zSt0Od5MPSUFKdZ
         0eKg==
X-Gm-Message-State: APjAAAWvtWIXubQ7B1wr8szTtLHkoXgZTRCt7klNji80t1GPGBuIfSUj
        QkgB2D+Bbtm4uZw0CQCjDYE0yuJTPT8=
X-Google-Smtp-Source: APXvYqxlGxe94guiFCzVkK5f+pR1M2fVMTgZtKZPLcP1Jxldh/nvUB2WLt7G/TlrrY7TC5wnTetyzQ==
X-Received: by 2002:a63:d250:: with SMTP id t16mr3884089pgi.278.1570470958745;
        Mon, 07 Oct 2019 10:55:58 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id k15sm3820096pgt.25.2019.10.07.10.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 10:55:57 -0700 (PDT)
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
Subject: [RFC][PATCH v2 0/5] dwc3: Changes for HiKey960 support
Date:   Mon,  7 Oct 2019 17:55:48 +0000
Message-Id: <20191007175553.66940-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've been carrying for awhile some patches that Yu Chen was
previously pushing upstream to enable USB on the HiKey960 board
and I wanted to try to nudge them forward as I'm not sure as to
what his plans are.

This series is just the simpler parts of the patch set that I
wanted to send out to see if we could make some progress on
while I continue to work on the more complex bits.

You can find the full set of changes to get USB working on the
board here:
  https://git.linaro.org/people/john.stultz/android-dev.git/log/?id=ef858be80f202b7bffb7d03c168ee72457a0ef3e

This series is just the more trivial changes, along with some
missing binding documentation that I've added.

I'd greatly appreciate any review or feedback on this series!

thanks
-john

New in v2:
* Tweaked binding clock name as clk_usb3phy_ref didn't seem right.

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
  usb: dwc3: Execute GCTL Core Soft Reset while switch mdoe for
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

