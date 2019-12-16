Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C72AC2D0BF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D025A2082E
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576521838;
	bh=4Lf3gHis098dtXzc5tykXbCRtvpKsUq1/PmER3G3/mE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1lFVqPwICr8tiogEg/1k5d5M0naK8l2OhGJb6zOVCzNPYx2VlxEM1R5t4WUi+WjWo
	 mkvLIxIiPGqBPyaWq5Fn1QAhQwuq5gQyZ0XMN2ge0KeLDvoisg4VgD3m0A0oV7naYH
	 4VzLPgJ06eyXlQvDasqq+xA+PnLdMExRKmI4FUR8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728652AbfLPSn6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:43:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:59690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728698AbfLPR7J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 12:59:09 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72F6121582;
        Mon, 16 Dec 2019 17:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576519148;
        bh=4Lf3gHis098dtXzc5tykXbCRtvpKsUq1/PmER3G3/mE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VyR3HnYIwZE6iajeX1iSL/zTscZDdswgIAKxO7s35ETzvdEBS+/Al8OW5u20p4YST
         JlaPl+FMhdTE8PgXbzwpa7MEZDqwCxZKUrZU/cc/1/HeQrfoepRkGRnI2CL5lZAzd0
         lF0f+MHYk8X0m9mTGCY7SfS5jxc/MWtbsgKH2eUs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 4.14 214/267] intel_th: pci: Add Tiger Lake CPU support
Date:   Mon, 16 Dec 2019 18:49:00 +0100
Message-Id: <20191216174914.285099004@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174848.701533383@linuxfoundation.org>
References: <20191216174848.701533383@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Shishkin <alexander.shishkin@linux.intel.com>

commit 6e6c18bcb78c0dc0601ebe216bed12c844492d0c upstream.

This adds support for the Trace Hub in Tiger Lake CPU.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20191120130806.44028-4-alexander.shishkin@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hwtracing/intel_th/pci.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/hwtracing/intel_th/pci.c
+++ b/drivers/hwtracing/intel_th/pci.c
@@ -199,6 +199,11 @@ static const struct pci_device_id intel_
 		.driver_data = (kernel_ulong_t)&intel_th_2x,
 	},
 	{
+		/* Tiger Lake CPU */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x9a33),
+		.driver_data = (kernel_ulong_t)&intel_th_2x,
+	},
+	{
 		/* Tiger Lake PCH */
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0xa0a6),
 		.driver_data = (kernel_ulong_t)&intel_th_2x,


