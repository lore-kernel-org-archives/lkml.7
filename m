Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9399C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDEF120830
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570124516;
	bh=nbgbhwOlk/LuTh2Jiw/PsDh+mAGYreruz68vM9Rfhvw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ULV5tO4j5NkYhLwj8Z8CvKmodE5MV1Jqv3Oeca0tFCZqVI6swZ9b+V4HA7PDqdugu
	 x3M39z3/vcStjQCCHzsT17qTtr/1kRVlRHe6HX/tNSyec2zPQW8ft/deyZR01w8kMC
	 1P+Fga1hibUQrub2jgAWCiSm8oNDom7gawCchn9s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390255AbfJCRlz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 13:41:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:40394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731045AbfJCP5t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 11:57:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38D5C20830;
        Thu,  3 Oct 2019 15:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570118268;
        bh=nbgbhwOlk/LuTh2Jiw/PsDh+mAGYreruz68vM9Rfhvw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oimJiwqcl2PQKGc6JemESW8OSa/7jgQjaecd/zl1HBIIv2D/21fn5tNRDYOAgj8RQ
         FWNazzlvlOPrpPDrkiCYHsDouhYJqFYGWwoRaQy3Jq8LJU8rS4vJj/Ab2uR/djzLCg
         hKbL+EiFKj9G/N4DHk3DjH2cBmsF5Np/LpiKs3Eg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiaofei Tan <tanxiaofei@huawei.com>,
        James Morse <james.morse@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 51/99] efi: cper: print AER info of PCIe fatal error
Date:   Thu,  3 Oct 2019 17:53:14 +0200
Message-Id: <20191003154320.334572430@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154252.297991283@linuxfoundation.org>
References: <20191003154252.297991283@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaofei Tan <tanxiaofei@huawei.com>

[ Upstream commit b194a77fcc4001dc40aecdd15d249648e8a436d1 ]

AER info of PCIe fatal error is not printed in the current driver.
Because APEI driver will panic directly for fatal error, and can't
run to the place of printing AER info.

An example log is as following:
{763}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 11
{763}[Hardware Error]: event severity: fatal
{763}[Hardware Error]:  Error 0, type: fatal
{763}[Hardware Error]:   section_type: PCIe error
{763}[Hardware Error]:   port_type: 0, PCIe end point
{763}[Hardware Error]:   version: 4.0
{763}[Hardware Error]:   command: 0x0000, status: 0x0010
{763}[Hardware Error]:   device_id: 0000:82:00.0
{763}[Hardware Error]:   slot: 0
{763}[Hardware Error]:   secondary_bus: 0x00
{763}[Hardware Error]:   vendor_id: 0x8086, device_id: 0x10fb
{763}[Hardware Error]:   class_code: 000002
Kernel panic - not syncing: Fatal hardware error!

This issue was imported by the patch, '37448adfc7ce ("aerdrv: Move
cper_print_aer() call out of interrupt context")'. To fix this issue,
this patch adds print of AER info in cper_print_pcie() for fatal error.

Here is the example log after this patch applied:
{24}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 10
{24}[Hardware Error]: event severity: fatal
{24}[Hardware Error]:  Error 0, type: fatal
{24}[Hardware Error]:   section_type: PCIe error
{24}[Hardware Error]:   port_type: 0, PCIe end point
{24}[Hardware Error]:   version: 4.0
{24}[Hardware Error]:   command: 0x0546, status: 0x4010
{24}[Hardware Error]:   device_id: 0000:01:00.0
{24}[Hardware Error]:   slot: 0
{24}[Hardware Error]:   secondary_bus: 0x00
{24}[Hardware Error]:   vendor_id: 0x15b3, device_id: 0x1019
{24}[Hardware Error]:   class_code: 000002
{24}[Hardware Error]:   aer_uncor_status: 0x00040000, aer_uncor_mask: 0x00000000
{24}[Hardware Error]:   aer_uncor_severity: 0x00062010
{24}[Hardware Error]:   TLP Header: 000000c0 01010000 00000001 00000000
Kernel panic - not syncing: Fatal hardware error!

Fixes: 37448adfc7ce ("aerdrv: Move cper_print_aer() call out of interrupt context")
Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
Reviewed-by: James Morse <james.morse@arm.com>
[ardb: put parens around terms of && operator]
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/efi/cper.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index d425374254384..f40f7df4b7344 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -384,6 +384,21 @@ static void cper_print_pcie(const char *pfx, const struct cper_sec_pcie *pcie,
 		printk(
 	"%s""bridge: secondary_status: 0x%04x, control: 0x%04x\n",
 	pfx, pcie->bridge.secondary_status, pcie->bridge.control);
+
+	/* Fatal errors call __ghes_panic() before AER handler prints this */
+	if ((pcie->validation_bits & CPER_PCIE_VALID_AER_INFO) &&
+	    (gdata->error_severity & CPER_SEV_FATAL)) {
+		struct aer_capability_regs *aer;
+
+		aer = (struct aer_capability_regs *)pcie->aer_info;
+		printk("%saer_uncor_status: 0x%08x, aer_uncor_mask: 0x%08x\n",
+		       pfx, aer->uncor_status, aer->uncor_mask);
+		printk("%saer_uncor_severity: 0x%08x\n",
+		       pfx, aer->uncor_severity);
+		printk("%sTLP Header: %08x %08x %08x %08x\n", pfx,
+		       aer->header_log.dw0, aer->header_log.dw1,
+		       aer->header_log.dw2, aer->header_log.dw3);
+	}
 }
 
 static void cper_estatus_print_section(
-- 
2.20.1



