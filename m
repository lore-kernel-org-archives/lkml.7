Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 539DAC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2523C2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564428689;
	bh=V0QIT3xgiUBXBdk8pO598YLrn/Tq24itzRdA2fbWN/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qPAH5Z/DBwFuKtisDoQZDjm45xHVsdGuNONdKSTj6clfiQnrSmLj61V5EWinZeGtP
	 r0Sl6fpBOW/+nLdGQ0xCbCF5+7o5L2G6zL+hvxJcNW6H7hnuMKRQp0l3oe4duaVhT0
	 TbvCJ1hktb78bqajs1y03+NEfvSwyKFQyNa7NI1M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730168AbfG2Tb1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:31:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:44286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730159AbfG2TbZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:31:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A182F217F4;
        Mon, 29 Jul 2019 19:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564428685;
        bh=V0QIT3xgiUBXBdk8pO598YLrn/Tq24itzRdA2fbWN/w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h2GxgTD7of8XVfF6cmq/3MEAkcI+wK4SBG1KAgO+aY131x+2i+NNQ+WB9FY4Y345W
         +i40DOaKnAgaNTkyJRToUL9WAjTVZl5eCHo4zy+bRgASrwzjBIxj7f82H+aRttro4O
         DBygahzk0xxXrPxpHNyoDT7kTIcBJowfhT4P7a6c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 4.14 155/293] intel_th: pci: Add Ice Lake NNPI support
Date:   Mon, 29 Jul 2019 21:20:46 +0200
Message-Id: <20190729190836.445841183@linuxfoundation.org>
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

From: Alexander Shishkin <alexander.shishkin@linux.intel.com>

commit 4aa5aed2b6f267592705a526f57518a5d715b769 upstream.

This adds Ice Lake NNPI support to the Intel(R) Trace Hub.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: stable <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20190621161930.60785-5-alexander.shishkin@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hwtracing/intel_th/pci.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/hwtracing/intel_th/pci.c
+++ b/drivers/hwtracing/intel_th/pci.c
@@ -178,6 +178,11 @@ static const struct pci_device_id intel_
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x02a6),
 		.driver_data = (kernel_ulong_t)&intel_th_2x,
 	},
+	{
+		/* Ice Lake NNPI */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x45c5),
+		.driver_data = (kernel_ulong_t)&intel_th_2x,
+	},
 	{ 0 },
 };
 


