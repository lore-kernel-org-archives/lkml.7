Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99DF4C2D0D2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 10:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C5152467F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 10:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576837059;
	bh=8cdOeBKhZ62/Tum2uJhI+qHIytxi40ciNVfJFG6tW7w=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=CjiEN56jTje4Exs60i4ixwLQesoQvwH7qWE0PFkyfgF+6ciFzPnxhvbwk+dzWhaxk
	 9ul11ZAl6aQWpXWpqGe2/T1xUcLEAtzgV2IJc0hnEgSbvjDRncyguwdg2I0vCjNqmg
	 YcQeCIEwLoXBlU9BV03ye3ktS25AFC2vJUBp+hoI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbfLTKRi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 05:17:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:53004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726210AbfLTKRi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 05:17:38 -0500
Received: from localhost.localdomain (unknown [106.201.107.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8CAA2467F;
        Fri, 20 Dec 2019 10:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576837057;
        bh=8cdOeBKhZ62/Tum2uJhI+qHIytxi40ciNVfJFG6tW7w=;
        h=From:To:Cc:Subject:Date:From;
        b=N9fRNt1f4O/fBnt99HIW2NfMp2SvXH8DyxONKbrvZHK0XlhgICUFmJxcb8aw/BJbn
         zup3D5kEeXIDq+Q4mXs/ciByL91j5DCJsb6q+vKhC4R0NKb3pJOS7WagrK13xH+M8J
         v5rgDUJTsezBQXhwyVU2/xdmZQWJRJdENXHd1/54=
From:   Vinod Koul <vkoul@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Can Guo <cang@codeaurora.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] phy: qcom-qmp: Fixes and updates for sm8150
Date:   Fri, 20 Dec 2019 15:47:14 +0530
Message-Id: <20191220101719.3024693-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5.5-rc1 we have seen regression on UFS phy on 8998 and SM8150. As
suggested by Can, increasing the timeout helps so we increase the phy init
timeout and that fixes the issue for 8998.  The patch 1 should be applied
to fixes for 5.5

For SM8150 we need additional SW reset so add additional SW reset and
configure if flag is defined, while at it do small updates to Use register
defines and remove duplicate powerdown write.

Changes in v2:
 - Drop patch 1 and pick the one Bjorn had already sent, makes timeout 10ms
 - Fix optional reset write as pointed by Can
 - Fix register define as pointed by Can

Bjorn Andersson (1):

  phy: qcom-qmp: Increase PHY ready timeout

Vinod Koul (4):
  phy: qcom-qmp: Use register defines
  phy: qcom-qmp: Add optional SW reset
  phy: qcom-qmp: remove duplicate powerdown write
  phy: qcom-qmp: remove no_pcs_sw_reset for sm8150

 drivers/phy/qualcomm/phy-qcom-qmp.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

-- 
2.23.0

