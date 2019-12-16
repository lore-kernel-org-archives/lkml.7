Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E2ACC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E08BF206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576519861;
	bh=Fi9MqeJn/edf57ZfbwwXeapzu7tQitxP9+pq34aPEzU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mUR/ZYwqbdZbeYR1XnKs8aEgfQntyQXkCNwJdFP5btUO7RPah8U38vvBPSKIFhTEz
	 s3HtSLLX8SAoOfJwlQOnjz/ez+KL+P9KXNk1Tc7NJaMmytiHTtOpOcG8vRPiQW6lZm
	 FU69Ec18Ynb2tXrZI1Ca5g36HTP3PA/t8LT931Yw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730701AbfLPSLA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:11:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:54490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730693AbfLPSK5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:10:57 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B490B207FF;
        Mon, 16 Dec 2019 18:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576519857;
        bh=Fi9MqeJn/edf57ZfbwwXeapzu7tQitxP9+pq34aPEzU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C4Tuu6hUKABAu7r9WtHjDu76xgbqEBio+IlNZweJXUxpajrfRvkY0Wl+sh/NrdmW/
         1iOcpUVCV01ZctVgRTC6BINLsPfOCnW4c/CPxRsAvFdMwiD26nVtgfyyXmzYQ6S4AZ
         KZty2vEyptxPfbA8XmNpL8wMywKuVxtpk/MHj1Wk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 5.3 097/180] intel_th: pci: Add Ice Lake CPU support
Date:   Mon, 16 Dec 2019 18:48:57 +0100
Message-Id: <20191216174835.561619676@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174806.018988360@linuxfoundation.org>
References: <20191216174806.018988360@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Shishkin <alexander.shishkin@linux.intel.com>

commit 6a1743422a7c0fda26764a544136cac13e5ae486 upstream.

This adds support for the Trace Hub in Ice Lake CPU.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20191120130806.44028-3-alexander.shishkin@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hwtracing/intel_th/pci.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/hwtracing/intel_th/pci.c
+++ b/drivers/hwtracing/intel_th/pci.c
@@ -210,6 +210,11 @@ static const struct pci_device_id intel_
 		.driver_data = (kernel_ulong_t)&intel_th_2x,
 	},
 	{
+		/* Ice Lake CPU */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x8a29),
+		.driver_data = (kernel_ulong_t)&intel_th_2x,
+	},
+	{
 		/* Tiger Lake PCH */
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0xa0a6),
 		.driver_data = (kernel_ulong_t)&intel_th_2x,


