Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 358ECC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0260120674
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573497866;
	bh=5F3RXUfqErPauLi5jjwhKdWUACwF42uaQ3V/aKUi9d4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OJtUumakrAMaci0X82I+N9AcHwFjiWEXMgg12itBdusBFgi966cIBHF1j+C5JybaS
	 t+KASfRgK3Oqd2vzGebWe/UglXggJ7xKYNExuimtice9sQjU/XjIbFWpfcumYhY2bF
	 Yvvo1blpE+zTCL6MI9OZXd2VYUQumKAcZ1Ijtxig=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728781AbfKKSoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 13:44:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:35988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729715AbfKKSoW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:44:22 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38E1620659;
        Mon, 11 Nov 2019 18:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573497861;
        bh=5F3RXUfqErPauLi5jjwhKdWUACwF42uaQ3V/aKUi9d4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RwMkg173g4Rsodl0u9aOfoKMBkvq+TT0SEc7a4t8MItQ8Zmms0ZCuSId3l7bZFd2/
         Ln9E9V+JWZrD0RhqhSq7NxKZMLEzkL5fSrDfbGpzKeF1TohWj+IZcW+kNhtfIi/6gz
         nlA3GduoeJLM+jToljpbFHF5dSYm1iJ6K1wb93kM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 4.19 040/125] intel_th: pci: Add Jasper Lake PCH support
Date:   Mon, 11 Nov 2019 19:27:59 +0100
Message-Id: <20191111181445.775402434@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191111181438.945353076@linuxfoundation.org>
References: <20191111181438.945353076@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Shishkin <alexander.shishkin@linux.intel.com>

commit 9d55499d8da49e9261e95a490f3fda41d955f505 upstream.

This adds support for Intel TH on Jasper Lake PCH.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20191028070651.9770-8-alexander.shishkin@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hwtracing/intel_th/pci.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/hwtracing/intel_th/pci.c
+++ b/drivers/hwtracing/intel_th/pci.c
@@ -190,6 +190,11 @@ static const struct pci_device_id intel_
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0xa0a6),
 		.driver_data = (kernel_ulong_t)&intel_th_2x,
 	},
+	{
+		/* Jasper Lake PCH */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x4da6),
+		.driver_data = (kernel_ulong_t)&intel_th_2x,
+	},
 	{ 0 },
 };
 


