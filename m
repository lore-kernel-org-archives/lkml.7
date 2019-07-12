Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E99C742BA
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 295D6216C8
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562934250;
	bh=vaXuefLnQVX1WIZfUStZejGF9m9Z62dsxQs1bUacwK8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fhkYlPoj47KPpcXaPMavBe/MAcKb2DBCmFCyQ3VU4v21rv6k75ab6B1l47ybwe2os
	 GSnuAPQ4yrVor23kgNS3njtHf5Ngkwg/G4v7064XbxJLpG+uO3N1ZKC/hHW5PGAf++
	 Cf9bBru9e5SZ2qgvG2D//uVTyIHdZ7lYD7KdD8ZE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbfGLMYH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 08:24:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:60060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727980AbfGLMXz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 08:23:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A73122166E;
        Fri, 12 Jul 2019 12:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562934234;
        bh=vaXuefLnQVX1WIZfUStZejGF9m9Z62dsxQs1bUacwK8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CUQwncYpbZwDQFDUQK+yfVKx9FuqGlp/uOidx6/jNTw2n0ualSHts9AzmNfzdBPtI
         h09AfRfZq0Ys0y4ZMPVfEhRKj3FZPVtUR8KqOOU+J3FMHN0V/p1K55EZBn+gFILw0r
         d2mInNu7c+GkhmQmBzGH0mAJuVKKjb6oi/163nBs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH 4.19 79/91] staging: comedi: amplc_pci230: fix null pointer deref on interrupt
Date:   Fri, 12 Jul 2019 14:19:22 +0200
Message-Id: <20190712121626.037573937@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190712121621.422224300@linuxfoundation.org>
References: <20190712121621.422224300@linuxfoundation.org>
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
@@ -2330,7 +2330,8 @@ static irqreturn_t pci230_interrupt(int
 	devpriv->intr_running = false;
 	spin_unlock_irqrestore(&devpriv->isr_spinlock, irqflags);
 
-	comedi_handle_events(dev, s_ao);
+	if (s_ao)
+		comedi_handle_events(dev, s_ao);
 	comedi_handle_events(dev, s_ai);
 
 	return IRQ_HANDLED;


