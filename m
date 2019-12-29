Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F160C2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37F86206CB
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577641046;
	bh=HFP4vL8iybakiwZfFyRg9rVwOzOkJwaGh6Oc9CU6aw0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EUqr2ZVIvuOHau3QoCtzjsxH+PEumS+CXWqCNCO/b/IPsmOjCFvVass3RLhg85swi
	 fsQcBXXiynI4H3ZJxIm0rypUDYASv3d5mc8UmJxEwKFrLvomFhEovZ8Ccq/611/+8t
	 RZ5oFlkOMKWAeRjWeV6V40dZgh/30cBXYjGLBz5s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729933AbfL2Rfp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:35:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:40318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729922AbfL2Rfm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:35:42 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40EF3206DB;
        Sun, 29 Dec 2019 17:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577640941;
        bh=HFP4vL8iybakiwZfFyRg9rVwOzOkJwaGh6Oc9CU6aw0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nb3v5ywoHD9nYkh/gCQmLxHMmT2QYxm/6xSQYfjCPcWE7iuMihdnfU918syzu5m7g
         +0g4A6cPg+KqhRccHmnTKztjSEMbaFMSSEe1/QFC+aJzNWoKGUfvfN0yFxyfAnvcaA
         Br+4SVfCqzwhDRN9pWP5B4gwn6z7ato/y4ZKZqaQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 4.19 201/219] intel_th: pci: Add Comet Lake PCH-V support
Date:   Sun, 29 Dec 2019 18:20:03 +0100
Message-Id: <20191229162540.166112564@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229162508.458551679@linuxfoundation.org>
References: <20191229162508.458551679@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Shishkin <alexander.shishkin@linux.intel.com>

commit e4de2a5d51f97a6e720a1c0911f93e2d8c2f1c08 upstream.

This adds Intel(R) Trace Hub PCI ID for Comet Lake PCH-V.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20191217115527.74383-2-alexander.shishkin@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hwtracing/intel_th/pci.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/hwtracing/intel_th/pci.c
+++ b/drivers/hwtracing/intel_th/pci.c
@@ -181,6 +181,11 @@ static const struct pci_device_id intel_
 		.driver_data = (kernel_ulong_t)&intel_th_2x,
 	},
 	{
+		/* Comet Lake PCH-V */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0xa3a6),
+		.driver_data = (kernel_ulong_t)&intel_th_2x,
+	},
+	{
 		/* Ice Lake NNPI */
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x45c5),
 		.driver_data = (kernel_ulong_t)&intel_th_2x,


