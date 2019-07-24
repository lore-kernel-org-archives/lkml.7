Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ADD6C76191
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6085B2081B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563999888;
	bh=hdPiwWOIh86sapnLw0u7XiSoH7Kj3zi5jtTPZLDP9H0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vBpRvJvktGELrmTQmF7m5851xw39zuEeyyX2jsMfsFKRrRK3E9yb0JaTcfCkGXAKF
	 KBnBKyVtDRkSQ5FE8OAuHcxYZIB3KFuxqqwwG1A+FlOpaV5bitUWbDDabt0UNLzAx7
	 sz205E5ZuIxQQpWlf6HARgFPu7KQ8O/wEyKY2bhc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390029AbfGXTkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:40:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:41740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390010AbfGXTka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:40:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDD1B20665;
        Wed, 24 Jul 2019 19:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563997229;
        bh=hdPiwWOIh86sapnLw0u7XiSoH7Kj3zi5jtTPZLDP9H0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xqwklLOxfDDk/iHBwunCY4qXfr5pSJ5H8U4s08P2JE5j5ObzASVNwKDQcQE/WGGa0
         KjY/AzSP2AhpRO2+LnFJEckupQx2u0TDXCECH5asUCLKUTy3A/VBOoNnLGo9v76TF4
         zH7FrK/Sykg3rcEVC8fDrFPcnkG7Img8DXvbdAOg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Niklas Cassel <niklas.cassel@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>
Subject: [PATCH 5.2 366/413] PCI: qcom: Ensure that PERST is asserted for at least 100 ms
Date:   Wed, 24 Jul 2019 21:20:57 +0200
Message-Id: <20190724191801.598390481@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191735.096702571@linuxfoundation.org>
References: <20190724191735.096702571@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Niklas Cassel <niklas.cassel@linaro.org>

commit 64adde31c8e996a6db6f7a1a4131180e363aa9f2 upstream.

Currently, there is only a 1 ms sleep after asserting PERST.

Reading the datasheets for different endpoints, some require PERST to be
asserted for 10 ms in order for the endpoint to perform a reset, others
require it to be asserted for 50 ms.

Several SoCs using this driver uses PCIe Mini Card, where we don't know
what endpoint will be plugged in.

The PCI Express Card Electromechanical Specification r2.0, section
2.2, "PERST# Signal" specifies:

"On power up, the deassertion of PERST# is delayed 100 ms (TPVPERL) from
the power rails achieving specified operating limits."

Add a sleep of 100 ms before deasserting PERST, in order to ensure that
we are compliant with the spec.

Fixes: 82a823833f4e ("PCI: qcom: Add Qualcomm PCIe controller driver")
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Acked-by: Stanimir Varbanov <svarbanov@mm-sol.com>
Cc: stable@vger.kernel.org # 4.5+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/controller/dwc/pcie-qcom.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -178,6 +178,8 @@ static void qcom_ep_reset_assert(struct
 
 static void qcom_ep_reset_deassert(struct qcom_pcie *pcie)
 {
+	/* Ensure that PERST has been asserted for at least 100 ms */
+	msleep(100);
 	gpiod_set_value_cansleep(pcie->reset, 0);
 	usleep_range(PERST_DELAY_US, PERST_DELAY_US + 500);
 }


