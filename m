Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B033C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0836D21780
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574887520;
	bh=qkcHWKlRtF1/qcHYJTTYuGs+u4eqtFyxk5IsGJNI5b0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0y8I/r2cqLb2TeI7G6Xpovb42e23heRbQKCsfS+Y5kfTkqXWNYUfKWIqpuBRdDYuV
	 8Ivum/m29eBBXRtnPlhcowSgrQ9gBS6TXqJkLOraEszF7ipZ4t4aCrTSxtDwch2VAy
	 b6lljn6O1IdMu8hDKCG56BkEe6/hYKrhYaZGwJ3I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729235AbfK0UpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:45:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:55752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729056AbfK0UpO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:45:14 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 061D6217C3;
        Wed, 27 Nov 2019 20:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574887514;
        bh=qkcHWKlRtF1/qcHYJTTYuGs+u4eqtFyxk5IsGJNI5b0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gjRNoipIHdniHfMRpcZGxqk5vVlbIZdcODL6LKCFxuoHFA8cBpLE61rMPoCEmpgNE
         h6Eco0sikv5k2d2msCCE4U0LLTiaj4XysTjE1AKi34DbY2YlCmvO5q048rbZLgZ6F+
         qDwW+yX0S0M5e3dcQPdhcrIgjOESr/hBNx7dclAQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Joel Jennings <joel.jennings@makeitlabs.com>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.9 140/151] usb-serial: cp201x: support Mark-10 digital force gauge
Date:   Wed, 27 Nov 2019 21:32:03 +0100
Message-Id: <20191127203047.040494839@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203000.773542911@linuxfoundation.org>
References: <20191127203000.773542911@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit 347bc8cb26388791c5881a3775cb14a3f765a674 upstream.

Add support for the Mark-10 digital force gauge device to the cp201x
driver.

Based on a report and a larger patch from Joel Jennings

Reported-by: Joel Jennings <joel.jennings@makeitlabs.com>
Cc: stable <stable@vger.kernel.org>
Acked-by: Johan Hovold <johan@kernel.org>
Link: https://lore.kernel.org/r/20191118092119.GA153852@kroah.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/serial/cp210x.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -122,6 +122,7 @@ static const struct usb_device_id id_tab
 	{ USB_DEVICE(0x10C4, 0x8341) }, /* Siemens MC35PU GPRS Modem */
 	{ USB_DEVICE(0x10C4, 0x8382) }, /* Cygnal Integrated Products, Inc. */
 	{ USB_DEVICE(0x10C4, 0x83A8) }, /* Amber Wireless AMB2560 */
+	{ USB_DEVICE(0x10C4, 0x83AA) }, /* Mark-10 Digital Force Gauge */
 	{ USB_DEVICE(0x10C4, 0x83D8) }, /* DekTec DTA Plus VHF/UHF Booster/Attenuator */
 	{ USB_DEVICE(0x10C4, 0x8411) }, /* Kyocera GPS Module */
 	{ USB_DEVICE(0x10C4, 0x8418) }, /* IRZ Automation Teleport SG-10 GSM/GPRS Modem */


