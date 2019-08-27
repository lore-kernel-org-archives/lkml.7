Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A7AFC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 505642184D
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566893065;
	bh=bS5fJU6Q5vs0dVw3qx7MQAt99UORwMPBakMMNkqV5kM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z6PtRAqMmggfV/I1nsdXjQMDzyfT8BDbyHj0LIdiuYSJxkO5sA42b7kYAQTHUNs0O
	 4vCg+KvfWT1MQUASgZiMRUbbtmz1oNkLg0j8cJS5uFPphEs0C9AZtGYWDDBLcMiJV8
	 8CV/34+KGon+Id88cULeLrnKj4H1WUFRNBfsJF50=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732539AbfH0IEY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 04:04:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:33790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731737AbfH0IEW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 04:04:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE6582184D;
        Tue, 27 Aug 2019 08:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566893061;
        bh=bS5fJU6Q5vs0dVw3qx7MQAt99UORwMPBakMMNkqV5kM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CKMLqski7fYhdYe4pyuLjgRGVK+Q0zt3nj2ck38Emw8UA2ZOmV+M8FZTa8i4dHhIE
         iJlpnFmYkDvQkhOlycWLnckJmpbLJwz3BQQpSDFBsflyoC1suh8Bfjkcnz95pKpTio
         vUjHde79qDLIYv/FleSh1Rex65EChnVBNb4/fQrM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 065/162] spi: pxa2xx: Add support for Intel Tiger Lake
Date:   Tue, 27 Aug 2019 09:49:53 +0200
Message-Id: <20190827072740.418385720@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190827072738.093683223@linuxfoundation.org>
References: <20190827072738.093683223@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit a4127952859a869cf3fc5a49547dbe2ffa2eac89 ]

Intel Tiger Lake -LP LPSS SPI controller is otherwise similar than
Cannon Lake but has more controllers and up to two chip selects per
controller.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Link: https://lore.kernel.org/r/20190801134901.12635-1-jarkko.nikula@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-pxa2xx.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index c1af8887d9186..1f32c9e3ca65c 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1453,6 +1453,14 @@ static const struct pci_device_id pxa2xx_spi_pci_compound_match[] = {
 	{ PCI_VDEVICE(INTEL, 0x02aa), LPSS_CNL_SSP },
 	{ PCI_VDEVICE(INTEL, 0x02ab), LPSS_CNL_SSP },
 	{ PCI_VDEVICE(INTEL, 0x02fb), LPSS_CNL_SSP },
+	/* TGL-LP */
+	{ PCI_VDEVICE(INTEL, 0xa0aa), LPSS_CNL_SSP },
+	{ PCI_VDEVICE(INTEL, 0xa0ab), LPSS_CNL_SSP },
+	{ PCI_VDEVICE(INTEL, 0xa0de), LPSS_CNL_SSP },
+	{ PCI_VDEVICE(INTEL, 0xa0df), LPSS_CNL_SSP },
+	{ PCI_VDEVICE(INTEL, 0xa0fb), LPSS_CNL_SSP },
+	{ PCI_VDEVICE(INTEL, 0xa0fd), LPSS_CNL_SSP },
+	{ PCI_VDEVICE(INTEL, 0xa0fe), LPSS_CNL_SSP },
 	{ },
 };
 
-- 
2.20.1



