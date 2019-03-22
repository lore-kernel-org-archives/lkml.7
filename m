Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6765C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9330E2192D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256041;
	bh=6TUI+EoSpZ+bbaQwIQl1eyvq0e5SOCOG06WRScjhxwU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VUAQDUtPQWawRLIZ0AHe8jMD/Vu/71WNqMIQzOh2LBqLjFVbIQ7081SOcHtz1DFWO
	 Z7Z+Zo/zGL+iJvo258u8cPaFvcX+MST82lxlEzCZk5o017Cv3nLaavRrrDASOOWlUD
	 Qqem6POtkLsvHiNlwww28xyoiQaOhM9ScotAvYlA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388103AbfCVMAk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:00:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:37822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730518AbfCVMAg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:00:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 303092192D;
        Fri, 22 Mar 2019 12:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256035;
        bh=6TUI+EoSpZ+bbaQwIQl1eyvq0e5SOCOG06WRScjhxwU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iidHWp3nDdlgKIXsjHvfbJwX9lPWItfEsgJV1kNvgYbVcJ5sK1sFNXezulUjKXBRv
         5sJX690zBkqDJdHqN6Ff6sROxIFzF9gYxpuFs+Pjl+uAaVYegTuowiCyIhbmmYfln5
         Ca46y7grZaFANsoH0kNffDs7j8ltbbEnn4Ptf2Ms=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 081/280] pinctrl: meson: meson8b: fix the sdxc_a data 1..3 pins
Date:   Fri, 22 Mar 2019 12:13:54 +0100
Message-Id: <20190322111310.934581556@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit c17abcfa93bf0be5e48bb011607d237ac2bfc839 ]

Fix the mismatch between the "sdxc_d13_1_a" pin group definition from
meson8b_cbus_groups and the entry in sdxc_a_groups ("sdxc_d0_13_1_a").
This makes it possible to use "sdxc_d13_1_a" in device-tree files to
route the MMC data 1..3 pins to GPIOX_1..3.

Fixes: 0fefcb6876d0d6 ("pinctrl: Add support for Meson8b")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/meson/pinctrl-meson8b.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/meson/pinctrl-meson8b.c b/drivers/pinctrl/meson/pinctrl-meson8b.c
index 91cffc051055..ead4beb5f55f 100644
--- a/drivers/pinctrl/meson/pinctrl-meson8b.c
+++ b/drivers/pinctrl/meson/pinctrl-meson8b.c
@@ -665,7 +665,7 @@ static const char * const sd_a_groups[] = {
 
 static const char * const sdxc_a_groups[] = {
 	"sdxc_d0_0_a", "sdxc_d13_0_a", "sdxc_d47_a", "sdxc_clk_a",
-	"sdxc_cmd_a", "sdxc_d0_1_a", "sdxc_d0_13_1_a"
+	"sdxc_cmd_a", "sdxc_d0_1_a", "sdxc_d13_1_a"
 };
 
 static const char * const pcm_a_groups[] = {
-- 
2.19.1



