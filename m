Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0689C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 824222087E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567620466;
	bh=fyoZrpQHZFS00Ygl8BYSNLC9aDmddV8bmy4l2EgzoYI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qF2vtkxZbtwC3P5PVbG5wS/QQn722O/Bv15rmTa6Oj4hjdOnTyKuepUxR4Fi5HaN5
	 FJEZuvcCpEqsdvz42NdZqnff/jhvGiuPQvc2a59sCEaCEVuSPu3/gq0+/WbXmAo6Xi
	 5GenFt7czJnxqIsNiIJ1zH5geieuwOvB6vh0s6vM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389658AbfIDSHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 14:07:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:50250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389652AbfIDSHm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 14:07:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87D1D206B8;
        Wed,  4 Sep 2019 18:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567620462;
        bh=fyoZrpQHZFS00Ygl8BYSNLC9aDmddV8bmy4l2EgzoYI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PeSPhWchS4g328NOUoaXed/YDNTAXXyt/StTqOwViSfuPan1rcETWBSJSAv2ee+ld
         +bMTTy8wnOMjVoOrwP0mrHcibYQNKNfE/eTBOMMLaKGMZcAfHGFnJkWPhskB2tcMOw
         WqLaOYnGjTjFSniqWgqyJFROjoIr4ET6vtGRvO+0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH 4.19 67/93] intel_th: pci: Add Tiger Lake support
Date:   Wed,  4 Sep 2019 19:54:09 +0200
Message-Id: <20190904175308.799569790@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190904175302.845828956@linuxfoundation.org>
References: <20190904175302.845828956@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Shishkin <alexander.shishkin@linux.intel.com>

commit 9c78255fdde45c6b9a1ee30f652f7b34c727f5c7 upstream.

This adds support for the Trace Hub in Tiger Lake PCH.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: stable@vger.kernel.org # v4.14+
Link: https://lore.kernel.org/r/20190821074955.3925-5-alexander.shishkin@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hwtracing/intel_th/pci.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/hwtracing/intel_th/pci.c
+++ b/drivers/hwtracing/intel_th/pci.c
@@ -180,6 +180,11 @@ static const struct pci_device_id intel_
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x45c5),
 		.driver_data = (kernel_ulong_t)&intel_th_2x,
 	},
+	{
+		/* Tiger Lake PCH */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0xa0a6),
+		.driver_data = (kernel_ulong_t)&intel_th_2x,
+	},
 	{ 0 },
 };
 


