Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6AA1C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83D7120652
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="kfRE5JQa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729886AbfDPPAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 11:00:16 -0400
Received: from mout.gmx.net ([212.227.17.21]:40237 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729757AbfDPPAP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 11:00:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1555426747;
        bh=pcJAMSHaGKiJI6KSUD3hEKb9sK2GFtvAIGMGKiVUKso=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=kfRE5JQai8/J691Nx/isdN/K/idxtja0/KzeNvwpHir0LBHEVst8iJWYrcXIOqzJe
         rGiVFc3EdYDEasROflaaEFJrS8n1+VruQmS2oqdOkgl0cD1n/DEJmGa2bmM/LxLbvf
         sUDlsELNuegU0MgXPPXAZPcW6l4PEdFCsJwCOXAc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([185.53.43.193]) by mail.gmx.com
 (mrgmx102 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0LnUna-1geKdY37RG-00hb6u; Tue, 16 Apr 2019 16:59:06 +0200
From:   Frank Wunderlich <frank-w@public-files.de>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, chunhui dai <chunhui.dai@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>
Cc:     Frank Wunderlich <frank-w@public-files.de>
Subject: [PATCH v1 0/4] make hdmi work on bananapi-r2
Date:   Tue, 16 Apr 2019 16:58:44 +0200
Message-Id: <20190416145848.11932-1-frank-w@public-files.de>
X-Mailer: git-send-email 2.17.1
X-Provags-ID: V03:K1:y3G40aoY7xjqhsvxergXK4s8Xni1M/9JVBJrnXSYzgfwZhQDb20
 g6oRBl2zn/mSESG9Bczv5ciFZZOgdrZHYA5kNdYNxLjrK3ZVkrYWpL5wKKMf6Pu6pVPSwGh
 q/nBcrIMj3t7sW8TOCWlh5HMlfSOG7cMyff62HsJXZDZTGJ0sS9DOk1uuRpEbeea/44GrQH
 6IkI08piAQvH/I28xbVrQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aKUwJe6mVUc=:Hy9BAeeVSnnDGXN7I1mYQA
 7BkpMzmI5vU1c7SeTpaanoEQVVAcIx4bf7S9xw225LptxF/84cvTJ9VnbqV9bLq94fTq6IaVt
 yAgGlQrjHQAxOTnnAQvC8sef7fOvxsFoK4vFZx2mVxu6sG5bbh0ktL9ylVDpXEN6igIkVQDpX
 QujH8KQ7gmt9Qcua7fdYqMxjqts6MYQARlTMeam7jMRaERWtEJG8u7mk2VRvnMjZ23fwsQU2E
 kuCUJ12tk9QyiYabMk3xwiEGa/84HGiEMDzOjBGYVJQrIrkDOHHtKgXS1RfRXDC+N4jIVVXuZ
 nY8Lz8e9kyrNfwcbEMwi8pjOdFdnqyK4OuQ4z3XinOZGion/2MoCYV/Oq4MfQFtX6OSHN0H+H
 WNv/niP/OBPJhy6eVyPdt1H1USXbmJZEwwTUAWlPcwo+Ir2r98haLO++j8mIb0SGgd0uTyzWo
 z7xmjBlE1ZRb36uO7D8zAcwpukXOCwjBA09eIfsxrhqU6Cq8APSNSsoiKEREZNNxVGUMyiZRo
 Dcg4k1jy+OFgsCkhh1ke8LCwA68mBIS0zn4rsYF4CHMBUmg3Htk1+vFNQ9+IDPZOc+Qw86DIj
 PhBtK7zOurMtndpdG8t3zF1cRrtRllWrkr70sGFoRHStHhhbDge9g4DqS8/C+YDNoh5p39gSn
 ESLJ9o7lbr73/9XFTqytthGBpjj95mB5/MW/bJYy/gSmPHnDuS9v35W5gJbd9x76keX1LhU5W
 AHw3HSxdr10qVM7IxEBfP+00rZ9XptxbmOyMCHOjfDby9q0HbIaF/Qq0TaWqU6/J0sYzl6B5v
 kp8O63imsa2SRBvkK2bUQM+YYCfUZr4g41Le6NDmBdKMAo9Mb9LFzk2pvN+y5DJ/yfvb8PT3y
 XjFauB4BE1+WoXmi9xttANYw6e7/BlNkB5aws03D9ZWebb/xMYhfTGgWmEzJet
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This Patch-Series adds missing Patches/Bugfixes to get hdmi working on BPI=
-R2

first 2 Patches were already posted, but not yet merged into mainline
i found no hint why
- config component output by device node port
  https://patchwork.kernel.org/patch/10609007/
- add display subsystem related device nodes (resend)
  https://patchwork.kernel.org/patch/10588951/

Bibby Hsieh (1):
  drm/mediatek: config component output by device node port

Ryder Lee (2):
  arm: dts: mt7623: add display subsystem related device nodes
  drm/mediatek: fix possible_crtcs

chunhui dai (1):
  drm/mediatek: fix boot up for 720 and 480 but 1080

 arch/arm/boot/dts/mt7623.dtsi                 | 177 ++++++++++++++++++
 arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts |  85 +++++++++
 arch/arm/boot/dts/mt7623n-rfb-emmc.dts        |  85 +++++++++
 drivers/gpu/drm/mediatek/mtk_dpi.c            |   2 +-
 drivers/gpu/drm/mediatek/mtk_drm_drv.c        |  41 +++-
 drivers/gpu/drm/mediatek/mtk_drm_drv.h        |   4 +-
 drivers/gpu/drm/mediatek/mtk_hdmi_phy.c       |   3 +
 drivers/gpu/drm/mediatek/mtk_hdmi_phy.h       |   1 +
 .../gpu/drm/mediatek/mtk_mt2701_hdmi_phy.c    |   1 +
 9 files changed, 390 insertions(+), 9 deletions(-)

=2D-
2.17.1

