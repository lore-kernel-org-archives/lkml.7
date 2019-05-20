Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF6A3C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C6B220863
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:56:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="V4AXEIv0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfETR4O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 13:56:14 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38413 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbfETR4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 13:56:12 -0400
Received: by mail-pg1-f193.google.com with SMTP id j26so7141489pgl.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 10:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=52yco9VK5RzDzN0Ze4QU/l0MYwJs+5CquMz8VBL6VQk=;
        b=V4AXEIv08AJKozp2k60l6WH+FbxePpO4LTwIjjxSxtuTTGQq9J6Z94lUGUst3qQJQ0
         gzqVaxKuD9EsnXxGRIJAA19oBZ5ie2qAalS6DvszK5vEF1nkOTgi0UW+OK0Eg3doRcqb
         waYM/YGAhtSg0UmYZ5Z0OQJoZBrMBmKMhqCY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=52yco9VK5RzDzN0Ze4QU/l0MYwJs+5CquMz8VBL6VQk=;
        b=ZSVEHwulw0ASCsCT+60tLUTHnbiqi9pWaNdmlLtggAF0jUwak0FZlfVZfPb6oX9Jq5
         pxqF2ZSciWO6/Vl0W5U9OXRg2ncGzvc9n1FjQxWDu1LHlNMEfGMc2kZXwdsDetq9P2Dw
         +7+1qTHB3Qs+aH9EyTdc0VG5JIfInmvCVljn+OibplndVguWrVoBzsIdF7FbQI2srTDt
         +Mq6I+FQZTUG5CSbdUKWne9Aaow+CiAa/kPF8gV1Q5jrnO863rOfCHk/NdiZ6gtpbaR9
         ITHlaHO2XD4DvaO11Z9Gh3QA3uitiQIrooFlqMrUQ3PbeRr5n7CpUJLNMzzwnI5cXM4q
         EEQg==
X-Gm-Message-State: APjAAAWvxf2YnNA7xx1oM10UutcJ/G/3g5JQFiqNKjgR14hQHn6wQyd1
        UtkgpuIHtUxeU3POJdzHbxusBA==
X-Google-Smtp-Source: APXvYqzZDvPhaLQndJXX3Bt+sreJ+zs8jKeG3JkAK89Y9xuYz8Uqg1m2gbKwuR3Bid5ZcOye6FcIpw==
X-Received: by 2002:a62:b40a:: with SMTP id h10mr74507778pfn.216.1558374971504;
        Mon, 20 May 2019 10:56:11 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id o2sm16852723pgq.1.2019.05.20.10.56.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 10:56:10 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Minas Harutyunyan <hminas@synopsys.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>, heiko@sntech.de
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Artur Petrosyan <Arthur.Petrosyan@synopsys.com>,
        amstan@chromium.org, linux-rockchip@lists.infradead.org,
        William Wu <william.wu@rock-chips.com>,
        linux-usb@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>,
        Randy Li <ayaka@soulik.info>, zyw@rock-chips.com,
        mka@chromium.org, ryandcase@chromium.org,
        Amelie Delaunay <amelie.delaunay@st.com>, jwerner@chromium.org,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 0/3] USB: dwc2: Allow wakeup from suspend; enable for rk3288-veyron
Date:   Mon, 20 May 2019 10:56:02 -0700
Message-Id: <20190520175605.2405-1-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a re-post of the last 3 patches of a series I posted earlier
at:
  https://lkml.kernel.org/r/20190418001356.124334-1-dianders@chromium.org

The first two patches were applied but the last three weren't because
they didn't apply at the time.  They apply fine now so are ready to
land.

Patch #2 has a slight difference in v3 here to fix build robot
reported error.

Changes in v3:
- Fixed kbuild test robot error.

Changes in v2:
- Rebased to mainline atop rk3288 remote wake quirk series.
- rk3288-veyron dts patch new for v2.

Douglas Anderson (3):
  Documentation: dt-bindings: Add snps,need-phy-for-wake for dwc2 USB
  USB: dwc2: Don't turn off the usbphy in suspend if wakeup is enabled
  ARM: dts: rockchip: Allow wakeup from rk3288-veyron's dwc2 USB ports

 .../devicetree/bindings/usb/dwc2.txt          |  3 +++
 arch/arm/boot/dts/rk3288-veyron.dtsi          |  2 ++
 drivers/usb/dwc2/core.h                       |  8 +++++++
 drivers/usb/dwc2/hcd.c                        | 19 +++++++++++++++
 drivers/usb/dwc2/platform.c                   | 23 ++++++++++++++++---
 5 files changed, 52 insertions(+), 3 deletions(-)

-- 
2.21.0.1020.gf2820cf01a-goog

