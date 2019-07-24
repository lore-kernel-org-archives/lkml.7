Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFDC1C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6E4E22C97
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563998342;
	bh=H0O5cm5UBcai8xG9md4SjBkoFGGKexpbFnby6BmK+gs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P/AymO4XgesGi1pxic39uoZBXCLwef0lqyqxLNWkhBjIpnQZyJc9EvZ4Ho7VdfQKP
	 pqPIIBi39zPCtA7tok2tikQScuu921GJD3BsqteoGDvs88jU0btf/GyFLGVX7urcb5
	 4lLWYOYyx4SZuKq2C/d0wUXT4EX21Rqktq07iKWM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405110AbfGXT7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:59:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:45948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404346AbfGXT66 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:58:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99A3820665;
        Wed, 24 Jul 2019 19:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563998337;
        bh=H0O5cm5UBcai8xG9md4SjBkoFGGKexpbFnby6BmK+gs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GW8e9jQBQouLQDvAkYzTHgY3uYTWS80APP/52Uxd/VzkepHicvEfZsDKUIiW/jlMW
         M1E+OWQCuGT4ulfyaAbgSLEKCqIfckv+QwUgnQ7zWRCnkcwKzvgcDkhLRQ0KEyGyHw
         DKj7F9OXCoX70Y8wfDjootcyOni+RfNJhxE5TYzI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 5.1 329/371] intel_th: pci: Add Ice Lake NNPI support
Date:   Wed, 24 Jul 2019 21:21:21 +0200
Message-Id: <20190724191748.573255382@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191724.382593077@linuxfoundation.org>
References: <20190724191724.382593077@linuxfoundation.org>
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
@@ -170,6 +170,11 @@ static const struct pci_device_id intel_
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
 


