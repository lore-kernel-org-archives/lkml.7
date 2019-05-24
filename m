Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD2BDC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 03:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 808ED2184B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 03:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558668667;
	bh=CUoB1/lohw4IFNZnQRxH8vK9OnSsYAl12HWN/ZrYLFw=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Ds3m477kgqVkJ7Y/j+2R2Dre97KQ+hP3qUV5MTijr+hjmpZcgtyWOqlMDVKCrl49n
	 h1YvlrnBnNoXqF6J4n22qay+9myNzaDYfw/keCSbLcLKuTvRt3YizfWcCQ4jDqoa0M
	 77QebMHGZin/nXyNgSsYnkBnLu5srAsHNRYJQHhA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388836AbfEXDbG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 23:31:06 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:33160 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387559AbfEXDbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 23:31:05 -0400
Received: by mail-io1-f66.google.com with SMTP id z4so6690838iol.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 20:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4IMXeSPz07H/1FS+L5wog9k24C98hcuyfvlIBRrFToQ=;
        b=JuooVbNFZqVGK0ePviE0+zQb5HLSPgmBhi22D2BkiE/7yFc3PTJNQPFhzTnHXwXDO/
         JweFIXmAX8zk6C7iGGlZ8FZ3K7jJswX+d2yJ+56Yho3vHWhkyP2jP4CFjXXhQCbbZTk6
         tn1Y3UpMIIKQI6eOHSBeOwAZuvY9AONqt+uic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4IMXeSPz07H/1FS+L5wog9k24C98hcuyfvlIBRrFToQ=;
        b=IJbbo0iCnDbKZN7xdhwmENMpk2rkmaYalC5qF6+h1gaLdVFJ8aFEzTL1OVOFAncSbt
         dR566k583wvdqggaMJjFVnKbBjR/s0XY6LUY3eCEP0zLthLaUujcvO9xzj+eDLmlEoBl
         KybtnRkmukH7vdDt5XLN20G1hSRHQFBLIOiEEBFQ+hWWa0pnj90w8iNNUpiXJI2e79W9
         ZdyrSYcC/eb/WhYrrxuyFZKHfGyAbDn9v/yz83YIR4oi+U+oJ1UDJGZDDb8Z4rwph/9M
         qEpkCyUhcoT+25zoThcZ06YIXskBwtR1kqwPGiAbnjnTekMe6UTRh4IA+22HtW+xTZTK
         g6xg==
X-Gm-Message-State: APjAAAUpXThY1JNHnvft+5DT0NC71UNAKJ1CcQ3qDR+F9pnevwTUGwUq
        dj8tP7xX7FssHiS+xeKDUCx0QLsk29o=
X-Google-Smtp-Source: APXvYqw5FmID+PmO0aMdsdSEbVeSQErU4FoC610/wj0wuiUVHLFvpKEsMgkeFn5w6ac6DAfyipIrXQ==
X-Received: by 2002:a6b:4408:: with SMTP id r8mr3147213ioa.103.1558668664632;
        Thu, 23 May 2019 20:31:04 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id h185sm794380itb.16.2019.05.23.20.31.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 20:31:04 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        helen.koike@collabora.com
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Use Media Dev Allocator to fix vimc dev lifetime bugs
Date:   Thu, 23 May 2019 21:31:00 -0600
Message-Id: <cover.1558667245.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

media_device is embedded in struct vimc_device and when vimc is removed
vimc_device and the embedded media_device goes with it, while the active
stream and vimc_capture continue to access it.

Fix the media_device lifetime problem by changing vimc to create shared
media_device using Media Device Allocator API and vimc_capture getting
a reference to vimc module. With this change, vimc module can be removed
only when the references are gone. vimc can be removed after vimc_capture
is removed.

Media Device Allocator API supports just USB devices. Enhance it
adding a genetic device allocate interface to support other media
drivers.

The new interface takes pointer to struct device instead and creates
media device. This interface allows a group of drivers that have a
common root device to share media device resource and ensure media
device doesn't get deleted as long as one of the drivers holds its
reference.

The new interface has been tested with vimc component driver to fix
panics when vimc module is removed while streaming is in progress.

Shuah Khan (2):
  media: add generic device allocate interface to media-dev-allocator
  vimc: fix BUG: unable to handle kernel NULL pointer dereference

 drivers/media/Makefile                     |  4 +-
 drivers/media/media-dev-allocator.c        | 39 ++++++++++++++
 drivers/media/platform/vimc/vimc-capture.c | 17 +++++-
 drivers/media/platform/vimc/vimc-core.c    | 60 ++++++++++++----------
 include/media/media-dev-allocator.h        | 46 ++++++++++++++---
 5 files changed, 130 insertions(+), 36 deletions(-)

-- 
2.17.1

