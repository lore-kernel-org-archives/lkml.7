Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F7AC3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3879208E4
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567621346;
	bh=Jm/m4caFgQ2a7ortrK8Zzy+WsfxLIPCafK0O0I0TJjo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cevmTXiCNaaqoPG3lcVBxMWjSV4dd5CtKAyUmIUvj0V2CEjEaalr6OYBhxTfpcsxd
	 vMGSxBrQyTHeX1OkHMwCetRjwXcsLnIVyUKAkJLxkMapQxEeY40vqaPY6blrEaEqtx
	 chtUHOVAgAaw9kOAG39PuT8w6KfHZ+DKIYiMYZrg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389135AbfIDSEp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 14:04:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:45850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732312AbfIDSEl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 14:04:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D969A233FF;
        Wed,  4 Sep 2019 18:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567620281;
        bh=Jm/m4caFgQ2a7ortrK8Zzy+WsfxLIPCafK0O0I0TJjo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NZrzvHxrNh+PG223lxJFXzmzj9nPH9yxxqv8JZUFmpJKmDzuNE0pKPH6dKonFFYXr
         blymOypDHP3440YNfcJ400fXzuJ/1BWWZRvzYKmhd517q8WSvWkL9fAVq6WMHerjCA
         yGaOqziJ7AtUNCP8NURn0svpQPO9R/0w6hV2gphU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH 4.14 43/57] intel_th: pci: Add Tiger Lake support
Date:   Wed,  4 Sep 2019 19:54:11 +0200
Message-Id: <20190904175306.304199267@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190904175301.777414715@linuxfoundation.org>
References: <20190904175301.777414715@linuxfoundation.org>
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
@@ -188,6 +188,11 @@ static const struct pci_device_id intel_
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
 


