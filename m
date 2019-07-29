Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 006DDC76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C498E21655
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564428693;
	bh=MELHc7NeFRTV+Rr8aDeE6buDLVahjTTMClWcgX8JTqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wQo7LhpUb1AHMCX2X1cm7iBYyU+qq5bdWwvR6Y8ZfJXebpH5KFoDMH6pe8KwthygB
	 UWQGO78+ZAjnapZ3X8gOJ3uxz/MBs9EQSP4n9VJxyDF7TeyLEl3RGAB1JdlpSDBxQn
	 yEf2tLv+7yCyl/v1LClg9JuU46QFJjP/ABLApKmA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730173AbfG2Tbc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:31:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:44394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728305AbfG2Tba (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:31:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE87221655;
        Mon, 29 Jul 2019 19:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564428689;
        bh=MELHc7NeFRTV+Rr8aDeE6buDLVahjTTMClWcgX8JTqg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YLP78uNVXsStvz1o44Q4dbqMO9PLvrs2CdG45to1tnhjD8+FFkd9BjwPSV5sdpDxr
         7+8rKe4tssc/PGXkkehyduZwPZpQtb2mCZjQZP98o/dwcPw1q15nxq/NgiT2kBvgZn
         BHjpGEMNF+N8d8iUGU+aJhZjtMOJXedRavpA8Ndw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.14 156/293] PCI: Do not poll for PME if the device is in D3cold
Date:   Mon, 29 Jul 2019 21:20:47 +0200
Message-Id: <20190729190836.511681268@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729190820.321094988@linuxfoundation.org>
References: <20190729190820.321094988@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mika Westerberg <mika.westerberg@linux.intel.com>

commit 000dd5316e1c756a1c028f22e01d06a38249dd4d upstream.

PME polling does not take into account that a device that is directly
connected to the host bridge may go into D3cold as well. This leads to a
situation where the PME poll thread reads from a config space of a
device that is in D3cold and gets incorrect information because the
config space is not accessible.

Here is an example from Intel Ice Lake system where two PCIe root ports
are in D3cold (I've instrumented the kernel to log the PMCSR register
contents):

  [   62.971442] pcieport 0000:00:07.1: Check PME status, PMCSR=0xffff
  [   62.971504] pcieport 0000:00:07.0: Check PME status, PMCSR=0xffff

Since 0xffff is interpreted so that PME is pending, the root ports will
be runtime resumed. This repeats over and over again essentially
blocking all runtime power management.

Prevent this from happening by checking whether the device is in D3cold
before its PME status is read.

Fixes: 71a83bd727cc ("PCI/PM: add runtime PM support to PCIe port")
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Lukas Wunner <lukas@wunner.de>
Cc: 3.6+ <stable@vger.kernel.org> # v3.6+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/pci.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1786,6 +1786,13 @@ static void pci_pme_list_scan(struct wor
 			 */
 			if (bridge && bridge->current_state != PCI_D0)
 				continue;
+			/*
+			 * If the device is in D3cold it should not be
+			 * polled either.
+			 */
+			if (pme_dev->dev->current_state == PCI_D3cold)
+				continue;
+
 			pci_pme_wakeup(pme_dev->dev, NULL);
 		} else {
 			list_del(&pme_dev->list);


