Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1921C2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD60B22B48
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577642246;
	bh=KCWw5ZJNCOkQVm+N3+JSfKHwZm3xAMyEOrD5iJfmkYQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hG8P2BzEhOcrD/qpwHE0Veqdl4b0pq2rw0mxtuYWrcco26e9O1t4MvLqxOrR7DkOT
	 NWWFjh/q8puaPLNsA5kvTgqaclaYDLuF2zg7gSfGkLfH2I7DPx021tyTIucS2Bfb+i
	 XbylSugBXJqZ3WKAYRwPQG7vgxfgbibY5WeVtLuk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733249AbfL2R5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:57:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:47682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733229AbfL2R5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:57:17 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECD5C227BF;
        Sun, 29 Dec 2019 17:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577642237;
        bh=KCWw5ZJNCOkQVm+N3+JSfKHwZm3xAMyEOrD5iJfmkYQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iwtfb+mL8ZWSz2bydkQoFWOeAeOohGHPD1s4aC7PJiYkVuMlQo3Bc5pHyfbon04Os
         x85KP2Be9lnMXIbMviC6P3usW4ukRJF2MiSSea+bP2LymBIKeWzwWPwMCqmWbZuhTh
         8/SRvSBfo2cx7QbMws9uEj8jzOEFFLl6jV2QgJQI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 5.4 399/434] intel_th: pci: Add Elkhart Lake SOC support
Date:   Sun, 29 Dec 2019 18:27:32 +0100
Message-Id: <20191229172728.965557733@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229172702.393141737@linuxfoundation.org>
References: <20191229172702.393141737@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Shishkin <alexander.shishkin@linux.intel.com>

commit 88385866bab8d5e18c7f45d1023052c783572e03 upstream.

This adds support for Intel Trace Hub in Elkhart Lake.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20191217115527.74383-3-alexander.shishkin@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hwtracing/intel_th/pci.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/hwtracing/intel_th/pci.c
+++ b/drivers/hwtracing/intel_th/pci.c
@@ -234,6 +234,11 @@ static const struct pci_device_id intel_
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x4da6),
 		.driver_data = (kernel_ulong_t)&intel_th_2x,
 	},
+	{
+		/* Elkhart Lake */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x4b26),
+		.driver_data = (kernel_ulong_t)&intel_th_2x,
+	},
 	{ 0 },
 };
 


