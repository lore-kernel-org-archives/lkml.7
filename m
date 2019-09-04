Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7652C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8826208E4
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567620462;
	bh=NAGu2uXx3izH6nY+ZY+vsnuDgYMEGTjhht2lnU6uQfM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Vl5ko9nKMxGiXzb9F43ljTrtK1y4ZU04QHi2GjbKTVj+BDF5Y4/R/GU6uhyqelH1R
	 8gbBGZozNSNu7EblCYywz9CUpnrPbwbjz6s8DCOCPp35pRU6PGKqmmx+E3HBTT3qT+
	 K4pK3rD4QtNqjebDD0+VL1Gtx5lkCqcKKP7jJUM8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389504AbfIDSHl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 14:07:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:50190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389470AbfIDSHj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 14:07:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9E14206B8;
        Wed,  4 Sep 2019 18:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567620459;
        bh=NAGu2uXx3izH6nY+ZY+vsnuDgYMEGTjhht2lnU6uQfM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RWmdkToDKY5wVJG+aZSJ7M7zz3BP1qcdKn1jgSNQ5hSgzH/BbhhPV4q41thQNYamE
         j77cb3DxT7zjjAinOICJGOqClGvMG3GsJGHVNYneUrsA+iYVAXsEi60jw5paxOfNRc
         fT1f3o3tzOnN6ecUxtPhaLE2ZAa+klmvl+ttTZIU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH 4.19 66/93] intel_th: pci: Add support for another Lewisburg PCH
Date:   Wed,  4 Sep 2019 19:54:08 +0200
Message-Id: <20190904175308.704253201@linuxfoundation.org>
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

commit 164eb56e3b64f3a816238d410c9efec7567a82ef upstream.

Add support for the Trace Hub in another Lewisburg PCH.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: stable@vger.kernel.org # v4.14+
Link: https://lore.kernel.org/r/20190821074955.3925-4-alexander.shishkin@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hwtracing/intel_th/pci.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/hwtracing/intel_th/pci.c
+++ b/drivers/hwtracing/intel_th/pci.c
@@ -141,6 +141,11 @@ static const struct pci_device_id intel_
 		.driver_data = (kernel_ulong_t)0,
 	},
 	{
+		/* Lewisburg PCH */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0xa226),
+		.driver_data = (kernel_ulong_t)0,
+	},
+	{
 		/* Gemini Lake */
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x318e),
 		.driver_data = (kernel_ulong_t)&intel_th_2x,


