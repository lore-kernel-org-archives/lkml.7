Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB02C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 10:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 124D52133D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 10:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="NRPDcMJM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfDAKak (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 06:30:40 -0400
Received: from onstation.org ([52.200.56.107]:36826 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726163AbfDAKak (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 06:30:40 -0400
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id E508D4570D;
        Mon,  1 Apr 2019 10:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=onstation.org;
        s=default; t=1554114639;
        bh=zhDm/A1dRYIbGV5XJVoToaNSXbVmdHmysIKFk5efA/Y=;
        h=From:To:Cc:Subject:Date:From;
        b=NRPDcMJMLti3ymhOT1Tn0y6QfyZx9v+Y16EqYO4CbxFE05QfV87ivzMYIZ5J5CMJl
         X+L0315lzkmEjFvt72bO8QB/YjfpWQqNT7WTaNCRXLlQzyvP26iZTgF6HWvWFFwEx2
         z3TPH3EjVNM3kEA5vx28Ol1W+MyaP7e1m/mp2rPk=
From:   Brian Masney <masneyb@onstation.org>
To:     lee.jones@linaro.org, daniel.thompson@linaro.org,
        jingoohan1@gmail.com, robh+dt@kernel.org
Cc:     jacek.anaszewski@gmail.com, pavel@ucw.cz, mark.rutland@arm.com,
        b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dmurphy@ti.com, jonathan@marek.ca
Subject: [PATCH v2 0/3] backlight: lm3630a: bug fix and device tree support
Date:   Mon,  1 Apr 2019 06:30:31 -0400
Message-Id: <20190401103034.21062-1-masneyb@onstation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a patch series that fixes a single bug and adds device tree
support to the lm3630a driver. This work was tested on a LG Nexus 5
(hammerhead) phone. My status page at
https://masneyb.github.io/nexus-5-upstream/ describes what is working
so far with the upstream kernel.

Changes since v1 (from November):
- Don't use a trivial binding and expose some of the settings available
  in the platform data.

Sorry for the long delay sending out v2. I got busy with other projects.

Brian Masney (3):
  backlight: lm3630a: return 0 on success in update_status functions
  dt-bindings: backlight: add lm3630a bindings
  backlight: lm3630a: add device tree supprt

 .../leds/backlight/lm3630a-backlight.yaml     | 112 ++++++++++++++++++
 drivers/video/backlight/lm3630a_bl.c          |  73 +++++++++++-
 2 files changed, 183 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml

-- 
2.20.1

