Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3896CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0CBB218A1
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553258253;
	bh=b1wrWyyCEd7a6QcpsbC0nSFap1TblQIpAt84xfVpd7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wyTxehmky/qN/xqqNMC2zHpu1IuDPCJbc49PrpfpavE4aWLXW3EmU13T+Ma/2jLLq
	 LvJw1xgwL51k7/AUXsF9ZWWJCwMbeMOUDR3NriUQMMIsjASPnYdN7/fHzHOiu8sJ9h
	 l+M4+Eje+2UuqC3ToNMgPcoBn4+y14mpvQLe8ig8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389584AbfCVMhb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:37:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:48466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388934AbfCVMKA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:10:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00FE92192D;
        Fri, 22 Mar 2019 12:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256599;
        bh=b1wrWyyCEd7a6QcpsbC0nSFap1TblQIpAt84xfVpd7E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EuwBYNFmS22gcfa55HcO9qyTOyxJlLEV+d4NPUSTyJCiJb7kFMcadp2G6H09tTgvE
         HYd3fBG+ae9SVR1MY1bWGhZuAxxFTjTmBW2/TvG4chJEu2EA0Dy4ruhYkQEEEoTo/E
         yPC9hIBCqMa832jY7hXEdMWE5yVpdBCMlfTkBRyQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 4.19 238/280] mfd: sm501: Fix potential NULL pointer dereference
Date:   Fri, 22 Mar 2019 12:16:31 +0100
Message-Id: <20190322111338.874085702@linuxfoundation.org>
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

From: Gustavo A. R. Silva <gustavo@embeddedor.com>

commit ae7b8eda27b33b1f688dfdebe4d46f690a8f9162 upstream.

There is a potential NULL pointer dereference in case devm_kzalloc()
fails and returns NULL.

Fix this by adding a NULL check on *lookup*

This bug was detected with the help of Coccinelle.

Fixes: b2e63555592f ("i2c: gpio: Convert to use descriptors")
Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mfd/sm501.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/mfd/sm501.c
+++ b/drivers/mfd/sm501.c
@@ -1145,6 +1145,9 @@ static int sm501_register_gpio_i2c_insta
 	lookup = devm_kzalloc(&pdev->dev,
 			      sizeof(*lookup) + 3 * sizeof(struct gpiod_lookup),
 			      GFP_KERNEL);
+	if (!lookup)
+		return -ENOMEM;
+
 	lookup->dev_id = "i2c-gpio";
 	if (iic->pin_sda < 32)
 		lookup->table[0].chip_label = "SM501-LOW";


