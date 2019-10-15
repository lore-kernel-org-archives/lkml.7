Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 593EDECE588
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 13:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 308BB2064B
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 13:03:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="0Lj58A9x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729716AbfJONDe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 09:03:34 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:10150 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726236AbfJONDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 09:03:33 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9FD19iU028733;
        Tue, 15 Oct 2019 15:03:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=VHS+BxJ9bqoSYa+xH/IlFL4fMa0/Sv3mZVO6EbWq22c=;
 b=0Lj58A9xHYrxKdris99TmusVli4cURzyHTxxKuLM7DKc4aq6Qe/2a5y2kZbCOr/QZwTY
 OPdz2wDm6ziwgXKcppkiWLBH33LxmcGX6nbjkUtd6yS7Hvoywy9xZX12wnd0yxlyyGcR
 dfAzfeLIzRZcvxat5fWjIUqgE3ahLoqEc8WsbWEbWmYJ/MxaAf22DYvrDpSre0WdZ7Fb
 PzHVq1hX780fNsak25CV4sMZnKuiYLzS11o7nSi5rxCiyXn4+eveluM2VK5cEkU5IGta
 xajiHrem7QQCYzcu0eAZ75UyryHND4Opg/FlSSFIYHwDbPsFBbJ0bAr3FJR3E3HXZpga 8A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2vk4a18aw0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Oct 2019 15:03:10 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BCB6F10002A;
        Tue, 15 Oct 2019 15:03:09 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8EA7D206463;
        Tue, 15 Oct 2019 15:03:09 +0200 (CEST)
Received: from localhost (10.75.127.49) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 15 Oct 2019 15:03:09
 +0200
From:   Alain Volmat <alain.volmat@st.com>
To:     <wsa@the-dreams.de>, <robh+dt@kernel.org>
CC:     <mark.rutland@arm.com>, <pierre-yves.mordret@st.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <linux-i2c@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <fabrice.gasnier@st.com>
Subject: [PATCH] i2c: i2c-stm32f7: rework slave_id allocation
Date:   Tue, 15 Oct 2019 15:03:09 +0200
Message-ID: <1571144589-3066-1-git-send-email-alain.volmat@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG5NODE2.st.com (10.75.127.14) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-15_05:2019-10-15,2019-10-15 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IP can handle two slave addresses. One address can either be
7 bits or 10 bits while the other can only be 7 bits.
In order to ensure that a 10 bits address can always be allocated
(assuming there is only one 7 bits address already allocated),
pick up the 7-bits only address slot in priority when performing a 7-bits
address allocation.

Fixes: 60d609f3 ("i2c: i2c-stm32f7: Add slave support")

Signed-off-by: Alain Volmat <alain.volmat@st.com>
---
 drivers/i2c/busses/i2c-stm32f7.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-stm32f7.c b/drivers/i2c/busses/i2c-stm32f7.c
index d36cf08461f7..cfae01b15243 100644
--- a/drivers/i2c/busses/i2c-stm32f7.c
+++ b/drivers/i2c/busses/i2c-stm32f7.c
@@ -1265,7 +1265,7 @@ static int stm32f7_i2c_get_free_slave_id(struct stm32f7_i2c_dev *i2c_dev,
 	 * slave[0] supports 7-bit and 10-bit slave address
 	 * slave[1] supports 7-bit slave address only
 	 */
-	for (i = 0; i < STM32F7_I2C_MAX_SLAVE; i++) {
+	for (i = STM32F7_I2C_MAX_SLAVE - 1; i >= 0; i--) {
 		if (i == 1 && (slave->flags & I2C_CLIENT_PEC))
 			continue;
 		if (!i2c_dev->slave[i]) {
-- 
2.7.4

