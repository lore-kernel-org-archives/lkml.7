Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82118C2D0D1
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 18:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E4C9207E0
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 18:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577643262;
	bh=I2fkFA/QpkMldfkl3YYRS7NfGdQeEDamEhl0A2SUYTo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=f8RwuOje/8Olxkvn6lLWj+AAH2djthOa6qq5ATdrMbkUVZaKoyqxYx0Ff96UKkrH9
	 IsZUnWml/CTqn751IR6QkvezGPfjklvWCgqyXDmnymwTQRtQcY1tOLfE+S6oJQR08P
	 wqXcqKaXgyQZQpnoPWzVvif0KZxOya3dDLU+w8Pw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbfL2R06 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:26:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:48588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728303AbfL2R0y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:26:54 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65D1420409;
        Sun, 29 Dec 2019 17:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577640413;
        bh=I2fkFA/QpkMldfkl3YYRS7NfGdQeEDamEhl0A2SUYTo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=weRgg9Tb6qh9XC4Z5Eky7XaFzSGTi8Kcgt90ZYTiCerD5rXMODYtC9b+yYqWIvHut
         EaRnMOzofg07beVC9JjB8wJm+3skDI9eyRWF+OSJvqlot42AQvbTxJnA4sEnaux3Fo
         sgwhG1nfNK/DgErACsb8yk8rUo0IeZqyvuGgTt+Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 4.14 148/161] intel_th: pci: Add Elkhart Lake SOC support
Date:   Sun, 29 Dec 2019 18:19:56 +0100
Message-Id: <20191229162445.902837887@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229162355.500086350@linuxfoundation.org>
References: <20191229162355.500086350@linuxfoundation.org>
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
@@ -218,6 +218,11 @@ static const struct pci_device_id intel_
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
 


