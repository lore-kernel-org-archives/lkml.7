Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6919AFC6194
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33037206A3
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573214208;
	bh=fTe/6jv6vp2P2ZrGxFtNky6NeEAfIueFoy7sJP/UR2c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wpMlqKWBBCq9jL+521BFVoCtZT83aoxUCyEoqCNU8Ky9UiKuXZE8xxVpL18JF7nse
	 AD/17oT38Hi2u7hSJGaNBRcolsK0KiSc178Q3CKRrWSC9d240h/WiaP1/Agd3GRXZf
	 hR+X7HHI9iKqZfjh9aa4g4cbtmS4C5V3DiQt1W0k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733171AbfKHLp1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 06:45:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:60652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391088AbfKHLpV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:45:21 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76AD4222D4;
        Fri,  8 Nov 2019 11:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573213520;
        bh=fTe/6jv6vp2P2ZrGxFtNky6NeEAfIueFoy7sJP/UR2c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wU/vzSC/oupknt7grS1umDVHtpp3MCvzouOJjkfIXKFgrtuVIgeQiXdTk3GLVfXm6
         quYGU1gkcTATqwyi6xgSGzc+9dW/FMbPWTY0NfVb7BwxpZuPyn8dBZKjkIDh8v9EY8
         UzAhdQ66XwAWAhxVLItOqGTgGN2HCU+W2438Hhvs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Niklas Cassel <niklas.cassel@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-arm-msm@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 088/103] soc: qcom: wcnss_ctrl: Avoid string overflow
Date:   Fri,  8 Nov 2019 06:42:53 -0500
Message-Id: <20191108114310.14363-88-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108114310.14363-1-sashal@kernel.org>
References: <20191108114310.14363-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Niklas Cassel <niklas.cassel@linaro.org>

[ Upstream commit 4c96ed170d658d8826d94edec8ac93ee777981a2 ]

'chinfo.name' is used as a NUL-terminated string, but using strncpy() with
the length equal to the buffer size may result in lack of the termination:

drivers//soc/qcom/wcnss_ctrl.c: In function 'qcom_wcnss_open_channel':
drivers//soc/qcom/wcnss_ctrl.c:284:2: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]
  strncpy(chinfo.name, name, sizeof(chinfo.name));
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This changes it to use the safer strscpy() instead.

Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Andy Gross <andy.gross@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/qcom/wcnss_ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/wcnss_ctrl.c b/drivers/soc/qcom/wcnss_ctrl.c
index df3ccb30bc2dd..373400dd816d6 100644
--- a/drivers/soc/qcom/wcnss_ctrl.c
+++ b/drivers/soc/qcom/wcnss_ctrl.c
@@ -281,7 +281,7 @@ struct rpmsg_endpoint *qcom_wcnss_open_channel(void *wcnss, const char *name, rp
 	struct rpmsg_channel_info chinfo;
 	struct wcnss_ctrl *_wcnss = wcnss;
 
-	strncpy(chinfo.name, name, sizeof(chinfo.name));
+	strscpy(chinfo.name, name, sizeof(chinfo.name));
 	chinfo.src = RPMSG_ADDR_ANY;
 	chinfo.dst = RPMSG_ADDR_ANY;
 
-- 
2.20.1

