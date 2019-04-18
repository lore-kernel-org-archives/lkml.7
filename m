Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C19C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 15:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A859D20674
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 15:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="FiepB7iY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389573AbfDRPMQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 11:12:16 -0400
Received: from onstation.org ([52.200.56.107]:46730 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389489AbfDRPMP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 11:12:15 -0400
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 4A0673E8E1;
        Thu, 18 Apr 2019 15:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=onstation.org;
        s=default; t=1555600334;
        bh=bPC3dr0e2z6BN8XsbQt/6j9bG784tW6d9p6BmnF81Rw=;
        h=From:To:Cc:Subject:Date:From;
        b=FiepB7iYW7EM+8/6gb0NZLbbdidNcVC38eB0X7f5xwOj61hUvsXUeycuuELaWOwhd
         bf7TBdl5Fy13poekRcHpIq3vwz/bv8UC+qAkeNoTqhcai0b/Q/ySt+WrO5LsT+YzVJ
         HsEwdMWyP++QMfTru6VjjWsPpNhGiKht42Du6vvY=
From:   Brian Masney <masneyb@onstation.org>
To:     lee.jones@linaro.org, daniel.thompson@linaro.org,
        jingoohan1@gmail.com, robh+dt@kernel.org
Cc:     jacek.anaszewski@gmail.com, pavel@ucw.cz, mark.rutland@arm.com,
        b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dmurphy@ti.com, jonathan@marek.ca
Subject: [PATCH v5 0/3] backlight: lm3630a: bug fix and fwnode support
Date:   Thu, 18 Apr 2019 11:11:40 -0400
Message-Id: <20190418151143.26068-1-masneyb@onstation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a patch series that fixes a single bug and adds fwnode support
to the lm3630a driver. This work was tested on a LG Nexus 5 (hammerhead)
phone. My status page at https://masneyb.github.io/nexus-5-upstream/
describes what is working so far with the upstream kernel.

See the individual patches for the changelog.

Brian Masney (3):
  backlight: lm3630a: return 0 on success in update_status functions
  dt-bindings: backlight: add lm3630a bindings
  backlight: lm3630a: add firmware node support

 .../leds/backlight/lm3630a-backlight.yaml     | 129 +++++++++++++++
 drivers/video/backlight/lm3630a_bl.c          | 153 +++++++++++++++++-
 include/linux/platform_data/lm3630a_bl.h      |   4 +
 3 files changed, 279 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml

-- 
2.20.1

