Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 959EBC46460
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7011320851
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558641054;
	bh=YBMr8ol5ddUzuPtejLpdxwDOqyjzDxIYdtVrFGBFFaU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DmHNOa2iQ0BqMqZWvk6ESneG3t92EPN0aL9DOLQOsD7HxsZ6V+4Js4fcUzqpV3uLV
	 15CU9/1ZGPduW8StGECUzw0hPniwNoqzZCKiYkaW+MZxCaTEU1O8ff6jNBGg43ejX3
	 vxfFCgBcT0GmbkhSlQNDzdl8ce3Z4PUdFnY0KCDg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732173AbfEWTJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:09:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:42436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732150AbfEWTJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:09:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65BC8217D7;
        Thu, 23 May 2019 19:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558638562;
        bh=YBMr8ol5ddUzuPtejLpdxwDOqyjzDxIYdtVrFGBFFaU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vpGFrMWPFsd2CRUU0SDe2dkmWnvP8AcvvmNru7+Mx59Us7GVaQowUZw1Ax0XLBMdd
         VMsiGp2DiGNXxS+NsduZbparnpYi2dBpa6WhymoS67BXzwK6nTF/BU5zBrPl0+e5fr
         9tBzOc1/2HwDM9YA/RWzvDvbRxC4s+WNwaqdtlhE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yifeng Li <tomli@tomli.me>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 4.9 35/53] fbdev: sm712fb: fix support for 1024x768-16 mode
Date:   Thu, 23 May 2019 21:05:59 +0200
Message-Id: <20190523181716.386871805@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523181710.981455400@linuxfoundation.org>
References: <20190523181710.981455400@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yifeng Li <tomli@tomli.me>

commit 6053d3a4793e5bde6299ac5388e76a3bf679ff65 upstream.

In order to support the 1024x600 panel on Yeeloong Loongson MIPS
laptop, the original 1024x768-16 table was modified to 1024x600-16,
without leaving the original. It causes problem on x86 laptop as
the 1024x768-16 support was still claimed but not working.

Fix it by introducing the 1024x768-16 mode.

Signed-off-by: Yifeng Li <tomli@tomli.me>
Tested-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Teddy Wang <teddy.wang@siliconmotion.com>
Cc: <stable@vger.kernel.org>  # v4.4+
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/video/fbdev/sm712fb.c |   59 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

--- a/drivers/video/fbdev/sm712fb.c
+++ b/drivers/video/fbdev/sm712fb.c
@@ -530,6 +530,65 @@ static const struct modeinit vgamode[] =
 			0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x15, 0x03,
 		},
 	},
+	{	/*  1024 x 768  16Bpp  60Hz */
+		1024, 768, 16, 60,
+		/*  Init_MISC */
+		0xEB,
+		{	/*  Init_SR0_SR4 */
+			0x03, 0x01, 0x0F, 0x03, 0x0E,
+		},
+		{	/*  Init_SR10_SR24 */
+			0xF3, 0xB6, 0xC0, 0xDD, 0x00, 0x0E, 0x17, 0x2C,
+			0x99, 0x02, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00,
+			0xC4, 0x30, 0x02, 0x01, 0x01,
+		},
+		{	/*  Init_SR30_SR75 */
+			0x38, 0x03, 0x20, 0x09, 0xC0, 0x3A, 0x3A, 0x3A,
+			0x3A, 0x3A, 0x3A, 0x3A, 0x00, 0x00, 0x03, 0xFF,
+			0x00, 0xFC, 0x00, 0x00, 0x20, 0x18, 0x00, 0xFC,
+			0x20, 0x0C, 0x44, 0x20, 0x00, 0x00, 0x00, 0x3A,
+			0x06, 0x68, 0xA7, 0x7F, 0x83, 0x24, 0xFF, 0x03,
+			0x0F, 0x60, 0x59, 0x3A, 0x3A, 0x00, 0x00, 0x3A,
+			0x01, 0x80, 0x7E, 0x1A, 0x1A, 0x00, 0x00, 0x00,
+			0x50, 0x03, 0x74, 0x14, 0x3B, 0x0D, 0x09, 0x02,
+			0x04, 0x45, 0x30, 0x30, 0x40, 0x20,
+		},
+		{	/*  Init_SR80_SR93 */
+			0xFF, 0x07, 0x00, 0xFF, 0xFF, 0xFF, 0xFF, 0x3A,
+			0xF7, 0x00, 0x00, 0x00, 0xFF, 0xFF, 0x3A, 0x3A,
+			0x00, 0x00, 0x00, 0x00,
+		},
+		{	/*  Init_SRA0_SRAF */
+			0x00, 0xFB, 0x9F, 0x01, 0x00, 0xED, 0xED, 0xED,
+			0x7B, 0xFB, 0xFF, 0xFF, 0x97, 0xEF, 0xBF, 0xDF,
+		},
+		{	/*  Init_GR00_GR08 */
+			0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x05, 0x0F,
+			0xFF,
+		},
+		{	/*  Init_AR00_AR14 */
+			0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
+			0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F,
+			0x41, 0x00, 0x0F, 0x00, 0x00,
+		},
+		{	/*  Init_CR00_CR18 */
+			0xA3, 0x7F, 0x7F, 0x00, 0x85, 0x16, 0x24, 0xF5,
+			0x00, 0x60, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+			0x03, 0x09, 0xFF, 0x80, 0x40, 0xFF, 0x00, 0xE3,
+			0xFF,
+		},
+		{	/*  Init_CR30_CR4D */
+			0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0x02, 0x20,
+			0x00, 0x00, 0x00, 0x40, 0x00, 0xFF, 0xBF, 0xFF,
+			0xA3, 0x7F, 0x00, 0x86, 0x15, 0x24, 0xFF, 0x00,
+			0x01, 0x07, 0xE5, 0x20, 0x7F, 0xFF,
+		},
+		{	/*  Init_CR90_CRA7 */
+			0x55, 0xD9, 0x5D, 0xE1, 0x86, 0x1B, 0x8E, 0x26,
+			0xDA, 0x8D, 0xDE, 0x94, 0x00, 0x00, 0x18, 0x00,
+			0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x15, 0x03,
+		},
+	},
 	{	/*  mode#5: 1024 x 768  24Bpp  60Hz */
 		1024, 768, 24, 60,
 		/*  Init_MISC */


