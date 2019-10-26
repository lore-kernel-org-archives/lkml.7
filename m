Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16825CA9EB9
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 13:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2407222BD
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 13:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572096209;
	bh=cXhWVoe8l7SesCfbvpKHyaadgu/BrM44Hjki1zDwezM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mUItyHLv4RcaEWNi5DfOwadMcW6BsuSInFOFJo/aw1dpw1e1NIGZaAaxsu7IjuO9Y
	 hGefeBDCE54K0EcWzf5PYL+R5/DWDiOn+HakJ4F2tsWaCJ5RS948dYX8aeK2+q7v0C
	 7O3G4ITv8U8cH/R4zZQcouZUA3mZBGCxuc/8jsQE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729822AbfJZNX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 09:23:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:45142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726162AbfJZNXW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 09:23:22 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FB6F21E6F;
        Sat, 26 Oct 2019 13:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572096202;
        bh=cXhWVoe8l7SesCfbvpKHyaadgu/BrM44Hjki1zDwezM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HghgRM5UOQNcJzXF93ri6TaFE474iwQAA8aE3L4UWv5pwUsQ2ys6K5EcA+cLv6AQV
         N7gQHLYg95mmXhPsj8BAYfBQhWfbSZnCQ8L9MgeKHzLXRsEaNbhTzEfXQWHBq5j5DT
         hPS2Y6P43MZo5axuHUtQM0u8V8LIDB3QYlQTS80Y=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Antonio Borneo <antonio.borneo@st.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 08/17] net: stmmac: fix length of PTP clock's name string
Date:   Sat, 26 Oct 2019 09:22:52 -0400
Message-Id: <20191026132302.4622-8-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191026132302.4622-1-sashal@kernel.org>
References: <20191026132302.4622-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Antonio Borneo <antonio.borneo@st.com>

[ Upstream commit 5da202c88f8c355ad79bc2e8eb582e6d433060e7 ]

The field "name" in struct ptp_clock_info has a fixed size of 16
chars and is used as zero terminated string by clock_name_show()
in drivers/ptp/ptp_sysfs.c
The current initialization value requires 17 chars to fit also the
null termination, and this causes overflow to the next bytes in
the struct when the string is read as null terminated:
	hexdump -C /sys/class/ptp/ptp0/clock_name
	00000000  73 74 6d 6d 61 63 5f 70  74 70 5f 63 6c 6f 63 6b  |stmmac_ptp_clock|
	00000010  a0 ac b9 03 0a                                    |.....|
where the extra 4 bytes (excluding the newline) after the string
represent the integer 0x03b9aca0 = 62500000 assigned to the field
"max_adj" that follows "name" in the same struct.

There is no strict requirement for the "name" content and in the
comment in ptp_clock_kernel.h it's reported it should just be 'A
short "friendly name" to identify the clock'.
Replace it with "stmmac ptp".

Signed-off-by: Antonio Borneo <antonio.borneo@st.com>
Fixes: 92ba6888510c ("stmmac: add the support for PTP hw clock driver")
Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
index 170a18b61281d..147c9f8cee7f7 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
@@ -157,7 +157,7 @@ static int stmmac_enable(struct ptp_clock_info *ptp,
 /* structure describing a PTP hardware clock */
 static struct ptp_clock_info stmmac_ptp_clock_ops = {
 	.owner = THIS_MODULE,
-	.name = "stmmac_ptp_clock",
+	.name = "stmmac ptp",
 	.max_adj = 62500000,
 	.n_alarm = 0,
 	.n_ext_ts = 0,
-- 
2.20.1

