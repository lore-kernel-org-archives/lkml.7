Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56599C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 19:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32E62214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 19:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564601721;
	bh=867OUzln7GhWrLMUC3n4gWxWiO1HRR+R7GIa/eq+nZQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=NB2W3SQ1SWK2RKkUgcd1yyW7z/TFOADcxPKBjlZahojwN0UIGrQTa9E/SchgOA2nU
	 JjwtZxJUcYIJhTVuAKprDbPhA5N0jm5wB7UpQ6w7L7g6HbAmVVnPiIpr7mQe2DthxK
	 Sw8FrKP2kwX81FoF1V8Yo1KS4QpEXFfkAHcMfnP0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730969AbfGaTfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 15:35:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:34830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726096AbfGaTfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 15:35:19 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA3B2208E4;
        Wed, 31 Jul 2019 19:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564601718;
        bh=867OUzln7GhWrLMUC3n4gWxWiO1HRR+R7GIa/eq+nZQ=;
        h=From:To:Cc:Subject:Date:From;
        b=liiuHA+zxTUp+WIevzgmLVqnrcAJr6XI2mBLkNB1NM8Gwl8DmO0+J8GikjLrrlMeU
         I6zQBdQz4i9VUgiBzmtkudV3fJvViVW+SS3f+WcPk0BTP1MFJDWddif0id1o+jIYOV
         K5znVGypnlCK3b/koNRVWJ69GoD8ALddyqdS2v+M=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        Barry Song <Baohua.Song@csr.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Chunyan Zhang <zhang.chunyan@linaro.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        Guo Zeng <Guo.Zeng@csr.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Roger Quadros <rogerq@ti.com>, Taniya Das <tdas@codeaurora.org>
Subject: [PATCH 0/9] Make clk_hw::init NULL after clk registration
Date:   Wed, 31 Jul 2019 12:35:08 -0700
Message-Id: <20190731193517.237136-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't want clk provider drivers using the init member of struct
clk_hw after the clk is registered. It isn't guaranteed to be a valid
pointer and all the necessary information inside the structure is copied
over into struct clk_core anyway. This patch series fixes up the handful
of users that do this and then overwrites the pointer to NULL within the
clk registration path.

Stephen Boyd (9):
  clk: actions: Don't reference clk_init_data after registration
  clk: lochnagar: Don't reference clk_init_data after registration
  clk: meson: axg-audio: Don't reference clk_init_data after
    registration
  clk: qcom: Don't reference clk_init_data after registration
  clk: sirf: Don't reference clk_init_data after registration
  clk: socfpga: Don't reference clk_init_data after registration
  clk: sprd: Don't reference clk_init_data after registration
  phy: ti: am654-serdes: Don't reference clk_init_data after
    registration
  clk: Overwrite clk_hw::init with NULL during clk_register()

Cc: Andy Gross <agross@kernel.org>
Cc: Baolin Wang <baolin.wang@linaro.org>
Cc: Barry Song <Baohua.Song@csr.com>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Chunyan Zhang <zhang.chunyan@linaro.org>
Cc: Dinh Nguyen <dinguyen@kernel.org>
Cc: Doug Anderson <dianders@chromium.org>
Cc: Guo Zeng <Guo.Zeng@csr.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Cc: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: Roger Quadros <rogerq@ti.com>
Cc: Taniya Das <tdas@codeaurora.org>

 drivers/clk/actions/owl-common.c     |  3 ++-
 drivers/clk/clk-lochnagar.c          |  2 +-
 drivers/clk/clk.c                    | 24 ++++++++++++++++--------
 drivers/clk/meson/axg-audio.c        |  7 +++++--
 drivers/clk/qcom/clk-rpmh.c          |  4 ++--
 drivers/clk/sirf/clk-common.c        | 12 ++++++++----
 drivers/clk/socfpga/clk-gate.c       | 21 +++++++++++----------
 drivers/clk/socfpga/clk-periph-a10.c |  7 ++++---
 drivers/clk/sprd/common.c            |  5 +++--
 drivers/phy/ti/phy-am654-serdes.c    |  4 ++--
 include/linux/clk-provider.h         |  3 ++-
 11 files changed, 56 insertions(+), 36 deletions(-)


base-commit: 5f9e832c137075045d15cd6899ab0505cfb2ca4b
-- 
Sent by a computer through tubes

