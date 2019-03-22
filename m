Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA79EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAA802192C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553257202;
	bh=fuSDPetSOGewCljphC0bRdZ5gWGxB4BQ8dRXT+btwRk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BrQ0OvCZJ1XqzpjavFP3U5WBA7pxrT+YHITTzFB1ZKQD5dsfngqoNKDZgEviHiXlQ
	 BJG/lmFAy8J5NX8RsL5eCLSgYtMn2Jk9mfsEmV9gOfufZThOrcD5rDHXbvfQ0jzg+2
	 NOZIYhJ4KSEnI+VUsrpiyWztBj8ilejM9jnyzyd4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389598AbfCVMUB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:20:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:58884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389943AbfCVMTx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:19:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C19721900;
        Fri, 22 Mar 2019 12:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553257192;
        bh=fuSDPetSOGewCljphC0bRdZ5gWGxB4BQ8dRXT+btwRk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZPpuF32goIxR0oaTTMMy43C+nmS5BD18KlV/6W5mxxuxX8zbm5imYoeCdU1HLbCc7
         yEd03qrPnJ9O7ePFpacczl1rF8rO9SIT35U/HRIyrW9krNhOanKw++kKYsUz45+fzU
         +CVF3R1qIxVjeSDdGlGF2BIBb1Z0rprfadX52rmc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>
Subject: [PATCH 5.0 129/238] PCI: qcom: Dont deassert reset GPIO during probe
Date:   Fri, 22 Mar 2019 12:15:48 +0100
Message-Id: <20190322111306.106804580@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bjorn Andersson <bjorn.andersson@linaro.org>

commit 02b485e31d98265189b91f3e69c43df2ed50610c upstream.

Acquiring the reset GPIO low means that reset is being deasserted, this
is followed almost immediately with qcom_pcie_host_init() asserting it,
initializing it and then finally deasserting it again, for the link to
come up.

Some PCIe devices requires a minimum time between the initial deassert
and subsequent reset cycles. In a platform that boots with the reset
GPIO asserted this requirement is being violated by this deassert/assert
pulse.

Acquire the reset GPIO high to prevent this situation by matching the
state to the subsequent asserted state.

Fixes: 82a823833f4e ("PCI: qcom: Add Qualcomm PCIe controller driver")
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
[lorenzo.pieralisi@arm.com: updated commit log]
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Acked-by: Stanimir Varbanov <svarbanov@mm-sol.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/controller/dwc/pcie-qcom.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1228,7 +1228,7 @@ static int qcom_pcie_probe(struct platfo
 
 	pcie->ops = of_device_get_match_data(dev);
 
-	pcie->reset = devm_gpiod_get_optional(dev, "perst", GPIOD_OUT_LOW);
+	pcie->reset = devm_gpiod_get_optional(dev, "perst", GPIOD_OUT_HIGH);
 	if (IS_ERR(pcie->reset)) {
 		ret = PTR_ERR(pcie->reset);
 		goto err_pm_runtime_put;


