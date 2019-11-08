Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A802FC5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 751E0215EA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573239854;
	bh=JDr0T7LlkJ8UHSj7zH/ZxVkHytUH/XKb4qVDCm8HdCU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FPEIo1i1Me+gKyfeex4kxBV2NNzqgSmAR93ODQuH4QSgkDVoFMhlUNnXrAnB0kT+M
	 dHOIbVcQi+aAYORs1yz+7f7/sisXaMfgpGwFNkDZqMP7c6CTkwaFMJCy+BmvrTvmeW
	 oSvaahPi/5vsdZ2QYkTzf8TzZGNtitKNC/d2DIGE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390977AbfKHTEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 14:04:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:34064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389590AbfKHTEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 14:04:12 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2D48214DB;
        Fri,  8 Nov 2019 19:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573239851;
        bh=JDr0T7LlkJ8UHSj7zH/ZxVkHytUH/XKb4qVDCm8HdCU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S85JyLQADN/dMbavdHJdwbcWMEX3GhAQbtAsti80SqPTs7fvUZENZqF/4Y/plhjBS
         mQJgwRIDd/IxCROToPZhSsa4fINVre7JECJcFM5MlJ4izQCDaE3yDFLLzhhOfdPCMn
         8mzHYMTlGAtV6gxcm331SvtP+GIOkx/W+NaRYZLg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Fabrice Gasnier <fabrice.gasnier@st.com>,
        Pierre-Yves MORDRET <pierre-yves.mordret@st.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 31/79] i2c: stm32f7: fix first byte to send in slave mode
Date:   Fri,  8 Nov 2019 19:50:11 +0100
Message-Id: <20191108174802.672637977@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191108174745.495640141@linuxfoundation.org>
References: <20191108174745.495640141@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabrice Gasnier <fabrice.gasnier@st.com>

[ Upstream commit 02e64276c6dbcc4c5f39844f33d18180832a58f3 ]

The slave-interface documentation [1] states "the bus driver should
transmit the first byte" upon I2C_SLAVE_READ_REQUESTED slave event:
- 'val': backend returns first byte to be sent
The driver currently ignores the 1st byte to send on this event.

[1] https://www.kernel.org/doc/Documentation/i2c/slave-interface

Fixes: 60d609f30de2 ("i2c: i2c-stm32f7: Add slave support")
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Reviewed-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-stm32f7.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/i2c/busses/i2c-stm32f7.c b/drivers/i2c/busses/i2c-stm32f7.c
index ac9c9486b834c..48521bc8a4d23 100644
--- a/drivers/i2c/busses/i2c-stm32f7.c
+++ b/drivers/i2c/busses/i2c-stm32f7.c
@@ -1177,6 +1177,8 @@ static void stm32f7_i2c_slave_start(struct stm32f7_i2c_dev *i2c_dev)
 			STM32F7_I2C_CR1_TXIE;
 		stm32f7_i2c_set_bits(base + STM32F7_I2C_CR1, mask);
 
+		/* Write 1st data byte */
+		writel_relaxed(value, base + STM32F7_I2C_TXDR);
 	} else {
 		/* Notify i2c slave that new write transfer is starting */
 		i2c_slave_event(slave, I2C_SLAVE_WRITE_REQUESTED, &value);
-- 
2.20.1



