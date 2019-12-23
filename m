Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEAD5C2D0D6
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 14:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 866F32073A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 14:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577111460;
	bh=+a7Dxz7RAuVm+FbhWjOq9hoUsXhxZzNgbeolx7Tc3Gk=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=f/YqXgV5yONbip9Q7G+CzDH8VfB1sDKIYOU3QUJUGgVAaMBRS3/R6TQfJNYQLCdWQ
	 Z0tuvMSeObG5obFVZ3O2KMR+KM1aqBypJRD/N6nZAmyh9L3OyIZyy7OP/spt8odYhc
	 1rL5vQywK1lJuQ9AP4WCv65peA9MNDlRF8Q3kzL4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfLWOa7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 09:30:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:51312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726840AbfLWOa7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 09:30:59 -0500
Received: from vkoul-mobl.Dlink (unknown [106.51.110.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A02EF20709;
        Mon, 23 Dec 2019 14:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577111459;
        bh=+a7Dxz7RAuVm+FbhWjOq9hoUsXhxZzNgbeolx7Tc3Gk=;
        h=From:To:Cc:Subject:Date:From;
        b=q8I/EKh0XXj/KSQGE0Vehqw5RgAgY15IoaGyK5iS8ONoDiI6HWuuNU16oug4zJIeX
         8ZP+XdgLZtyDCKy9lMoGer+YXF1uP7uG73Txr5famY80uElkNxmCND5PSurID3kTbb
         rh3txh4rsgDsxH9OuWlw5LaA6UzhUYGUjiZIJBiI=
From:   Vinod Koul <vkoul@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Can Guo <cang@codeaurora.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Manu Gautam <mgautam@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] phy: qcom-qmp: Fixes and updates for sm8150
Date:   Mon, 23 Dec 2019 20:00:42 +0530
Message-Id: <20191223143046.3376299-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For SM8150 we need additional SW reset so clear the no_pcs_sw_reset, and add
SW reset register. Along with that remove duplicate powerdown write.

Changes in v3:
 - Drop patch 1 "phy: qcom-qmp: Increase PHY ready timeout" as that is
   applied by Kishon
 - Drop patch "phy: qcom-qmp: Add optional SW reset" as that is no longer
   required
 - Add "phy: qcom-qmp: Add SW reset register"

Changes in v2:
 - Drop patch 1 and pick the one Bjorn had already sent, makes timeout 10ms
 - Fix optional reset write as pointed by Can
 - Fix register define as pointed by Can

Vinod Koul (4):
  phy: qcom-qmp: Use register defines
  phy: qcom-qmp: remove duplicate powerdown write
  phy: qcom-qmp: remove no_pcs_sw_reset for sm8150
  phy: qcom-qmp: Add SW reset register

 drivers/phy/qualcomm/phy-qcom-qmp.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

-- 
2.23.0

