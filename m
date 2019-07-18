Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D092C76192
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2D912053B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563419879;
	bh=kgk7Ue5rId7m2dMEUgqDOMrpm8zUbKkpT7Tr2gHcUq0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2rjj6wB96cSD4genk7ACFlHqQCRiiBdP+5PnOATwuoke/yVbZGPMNoN2oURXALu7G
	 iyUN5ekYAE/5biTGizqzJuSBAiHwZ3Z3h5D4TmSo/z7OZjrVbYe7oa4oAUfg25v72E
	 Nko6V8NgSw6xjzmiXbNywhlOob+ZCG1XcEFSUo3E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391711AbfGRDON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 23:14:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:49716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391671AbfGRDOI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 23:14:08 -0400
Received: from localhost (115.42.148.210.bf.2iij.net [210.148.42.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B6F42173E;
        Thu, 18 Jul 2019 03:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563419647;
        bh=kgk7Ue5rId7m2dMEUgqDOMrpm8zUbKkpT7Tr2gHcUq0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FCaCvmASMsUGfjBT/+U4MgB0+LGoYUQcQh2lg87rbAOC3qbFXf741PfqOFWil9nQB
         OQ3ReCJwYYYE1ESJkJoMV4dKlIGXmnRA/nXw/Ph5AGX00vqyuGT6omZPNfXGMIEEbH
         zvZHE+OcTdHKZk6mdEOxMccDrn1+8jX0iUYWomLo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH 4.9 36/54] staging: comedi: amplc_pci230: fix null pointer deref on interrupt
Date:   Thu, 18 Jul 2019 12:02:06 +0900
Message-Id: <20190718030052.261257680@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190718030048.392549994@linuxfoundation.org>
References: <20190718030048.392549994@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ian Abbott <abbotti@mev.co.uk>

commit 7379e6baeddf580d01feca650ec1ad508b6ea8ee upstream.

The interrupt handler `pci230_interrupt()` causes a null pointer
dereference for a PCI260 card.  There is no analog output subdevice for
a PCI260.  The `dev->write_subdev` subdevice pointer and therefore the
`s_ao` subdevice pointer variable will be `NULL` for a PCI260.  The
following call near the end of the interrupt handler results in the null
pointer dereference for a PCI260:

	comedi_handle_events(dev, s_ao);

Fix it by only calling the above function if `s_ao` is valid.

Note that the other uses of `s_ao` in the calls
`pci230_handle_ao_nofifo(dev, s_ao);` and `pci230_handle_ao_fifo(dev,
s_ao);` will never be reached for a PCI260, so they are safe.

Fixes: 39064f23284c ("staging: comedi: amplc_pci230: use comedi_handle_events()")
Cc: <stable@vger.kernel.org> # v3.19+
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/comedi/drivers/amplc_pci230.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/staging/comedi/drivers/amplc_pci230.c
+++ b/drivers/staging/comedi/drivers/amplc_pci230.c
@@ -2337,7 +2337,8 @@ static irqreturn_t pci230_interrupt(int
 	devpriv->intr_running = false;
 	spin_unlock_irqrestore(&devpriv->isr_spinlock, irqflags);
 
-	comedi_handle_events(dev, s_ao);
+	if (s_ao)
+		comedi_handle_events(dev, s_ao);
 	comedi_handle_events(dev, s_ai);
 
 	return IRQ_HANDLED;


