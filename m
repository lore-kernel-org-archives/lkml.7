Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C8B9CA9EBC
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 07:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27EB621906
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 07:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571903317;
	bh=uUZce6/FCDh1pSBIkqEXf1IfLeAbB0U9mXEnQTe/hY4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=WhwH322DKWFwJkmqUZ7GkydHA1lDY1s8+p6wg2KqGldRd1qXJcgy92EN7WZV2p++K
	 rZ4aWXjlbuEoSF6CvMGqZuK0BSSDGFpmnmAXg298+KP6Sgw+lmBNbzHdgvRlwKq+wF
	 wOf2VZsIVWs7TuGqm/h4+qhwkTfQ/RU5HmfV2yO4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408683AbfJXHsg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 03:48:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:54200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404701AbfJXHsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 03:48:36 -0400
Received: from localhost.localdomain (unknown [122.181.210.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A30892084C;
        Thu, 24 Oct 2019 07:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571903315;
        bh=uUZce6/FCDh1pSBIkqEXf1IfLeAbB0U9mXEnQTe/hY4=;
        h=From:To:Cc:Subject:Date:From;
        b=V8Hgu+nhJ8AN8PnF3M3BP3eV0vuhUr207/GinigFFb3p1P3Zryq8haGK0RFN7WsnH
         ncfcm/n3PS62TMFFLSQOOXh3CJ0/BiOwW4DjRfspqwJjA8Jxc2zcbjQ0SOg2q/lLDe
         0tGKgOCRJ0/7HG7BixB/7Nd+wDpA0T5hV5ibYiLo=
From:   Vinod Koul <vkoul@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Evan Green <evgreen@chromium.org>,
        Can Guo <cang@codeaurora.org>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Subhash Jadavani <subhashj@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>
Subject: [PATCH v3 0/3] UFS: Add support for SM8150 UFS
Date:   Thu, 24 Oct 2019 13:17:59 +0530
Message-Id: <20191024074802.26526-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds compatible strings for ufs hc and ufs qmp phy found in
Qualcomm SM8150 SoC. Also update the qmp phy driver with version 4 and
support for ufs phy.

Changes since V2:
 - add review tags received
 - rename registers to QSERDES_V4_COM* and sort them and make these lower
   hex
 - reuse sdm845_ufs_phy_clk_l as it is same

Changes since v1:
 - make the numbers a lower case hex
 - add review tags received

Vinod Koul (3):
  dt-bindings: ufs: Add sm8150 compatible string
  dt-bindings: phy-qcom-qmp: Add sm8150 UFS phy compatible string
  phy: qcom-qmp: Add SM8150 QMP UFS PHY support

 .../devicetree/bindings/phy/qcom-qmp-phy.txt  |   7 +-
 .../devicetree/bindings/ufs/ufshcd-pltfrm.txt |   1 +
 drivers/phy/qualcomm/phy-qcom-qmp.c           | 120 ++++++++++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp.h           |  96 ++++++++++++++
 4 files changed, 223 insertions(+), 1 deletion(-)

-- 
2.20.1

