Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BFC4C04AA6
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 12:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 091A52075E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 12:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556625841;
	bh=qmySqOgGAWXl1qA4wBmbdzy9gaa7gjJVIfqEMiXeztg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IuEIp+7kTn8qNNTket19ijT2p0WylPM6j2Y1hR1KPdtBARV0cYFpI5n4FNdsRmhpv
	 8GclpQM/ERIruCS+0fq1y9IteX2V4BNggvjrrHVFsWEYNDoxcLLp/3UHfucUBoJ66v
	 VMyTqq84Ba4TVmgYhwvdNaJrPNmf66TDDpNJrDQ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729791AbfD3LnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 07:43:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:52870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729728AbfD3LnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 07:43:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6922921670;
        Tue, 30 Apr 2019 11:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556624582;
        bh=qmySqOgGAWXl1qA4wBmbdzy9gaa7gjJVIfqEMiXeztg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iO8rGcVE+SNufRozShs9/ejlcFkVmNHAyw4KZpSyf38vB2n2rU+VjWACbOhxztRg9
         FlU6KLup4i9xY9tAwNFdlN27D7ivbTdpRsj8nM8J5+BU27fqy4H0K34F+ManQVtLVK
         6XxBIgwH18ld45iSbLFhG1vvC6kAizriKS7AZdAQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Su Bao Cheng <baocheng.su@siemens.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 49/53] stmmac: pci: Adjust IOT2000 matching
Date:   Tue, 30 Apr 2019 13:38:56 +0200
Message-Id: <20190430113559.236031545@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190430113549.400132183@linuxfoundation.org>
References: <20190430113549.400132183@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Su Bao Cheng <baocheng.su@siemens.com>

[ Upstream commit e0c1d14a1a3211dccf0540a6703ffbd5d2a75bdb ]

Since there are more IOT2040 variants with identical hardware but
different asset tags, the asset tag matching should be adjusted to
support them.

For the board name "SIMATIC IOT2000", currently there are 2 types of
hardware, IOT2020 and IOT2040. The IOT2020 is identified by its unique
asset tag. Match on it first. If we then match on the board name only,
we will catch all IOT2040 variants. In the future there will be no other
devices with the "SIMATIC IOT2000" DMI board name but different
hardware.

Signed-off-by: Su Bao Cheng <baocheng.su@siemens.com>
Reviewed-by: Jan Kiszka <jan.kiszka@siemens.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
@@ -159,6 +159,12 @@ static const struct dmi_system_id quark_
 		},
 		.driver_data = (void *)&galileo_stmmac_dmi_data,
 	},
+	/*
+	 * There are 2 types of SIMATIC IOT2000: IOT20202 and IOT2040.
+	 * The asset tag "6ES7647-0AA00-0YA2" is only for IOT2020 which
+	 * has only one pci network device while other asset tags are
+	 * for IOT2040 which has two.
+	 */
 	{
 		.matches = {
 			DMI_EXACT_MATCH(DMI_BOARD_NAME, "SIMATIC IOT2000"),
@@ -170,8 +176,6 @@ static const struct dmi_system_id quark_
 	{
 		.matches = {
 			DMI_EXACT_MATCH(DMI_BOARD_NAME, "SIMATIC IOT2000"),
-			DMI_EXACT_MATCH(DMI_BOARD_ASSET_TAG,
-					"6ES7647-0AA00-1YA2"),
 		},
 		.driver_data = (void *)&iot2040_stmmac_dmi_data,
 	},


