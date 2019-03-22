Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7974DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 404882196F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255106;
	bh=743B7Wqi1GpJdeUYvcOU9/K6xq7RMxworIr76ZzQu4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=s7063mPYwVZVLx2pFHPNn7Pazuzq28s3PgxS5UUNapRfYKGSz6Laykj46emfzEdWc
	 gXUMrq49IVIkUSaoNRPC64ZhLlOm7zMb6uVVThRI5ThvR6w/i5uROCs0pei5dN93BC
	 19DDxu0nL3wd/yNfEcc8dgiiPlGEF5uPcEvYi8+Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731916AbfCVLpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:45:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:48148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731332AbfCVLpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:45:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D02D2195D;
        Fri, 22 Mar 2019 11:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255103;
        bh=743B7Wqi1GpJdeUYvcOU9/K6xq7RMxworIr76ZzQu4w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I+GaRO1KtCHaFUG1DcIQQybUAqYeBhyMRGP/OPy6l8SmL84FoPSNLY9Nn7uhvMfIP
         7tPapFfWdgQfU5HSgSaJwcyol+EoBKvnRkzDiBbOtu7CB/6+QANbPj2kQBr82AKH8q
         wYLQLKFjrreG9Xy74Ea2+BHx+gK0d6f1aPlB7Vvk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Angelo Butti <buttiangelo@gmail.com>
Subject: [PATCH 4.9 088/118] 8250: FIX Fourth port offset of Pericom PI7C9X7954 boards
Date:   Fri, 22 Mar 2019 12:16:00 +0100
Message-Id: <20190322111222.841689365@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111215.873964544@linuxfoundation.org>
References: <20190322111215.873964544@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Angelo Butti <buttiangelo@gmail.com>

commit 5c31ef91c06db7800ad573174bd92be4df34ecb2 upstream.

Hi,
below patch to fix Fourth port offset of Percom PI7C9X7954 boards.

I had a problem using Fourth port on a pci express serial board based on Pericom
PI7C9X7954. Reading datasheet I notice a "special" offset assign to this port
when used in I/O mode.

Offset 0x0 ->  UART 0
Offset 0x8 ->  UART 1
Offset 0x10 ->  UART 2
Offset 0x38 ->  UART 3  <<---- This don't follow a logical sequence

This patch add a different init to last port, to have right offset.

I check also Pericom 7952 and 7958 but that devices follow logical sequence,
so they are ok.

Regards,
Angelo

Signed-off-by: Angelo Butti <buttiangelo@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serial/8250/8250_pci.c |   34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1330,6 +1330,30 @@ static int pci_default_setup(struct seri
 	return setup_port(priv, port, bar, offset, board->reg_shift);
 }
 
+static int pci_pericom_setup(struct serial_private *priv,
+		  const struct pciserial_board *board,
+		  struct uart_8250_port *port, int idx)
+{
+	unsigned int bar, offset = board->first_offset, maxnr;
+
+	bar = FL_GET_BASE(board->flags);
+	if (board->flags & FL_BASE_BARS)
+		bar += idx;
+	else
+		offset += idx * board->uart_offset;
+
+	if (idx==3)
+		offset = 0x38;
+
+	maxnr = (pci_resource_len(priv->dev, bar) - board->first_offset) >>
+		(board->reg_shift + 3);
+
+	if (board->flags & FL_REGION_SZ_CAP && idx >= maxnr)
+		return 1;
+
+	return setup_port(priv, port, bar, offset, board->reg_shift);
+}
+
 static int
 ce4100_serial_setup(struct serial_private *priv,
 		  const struct pciserial_board *board,
@@ -2097,6 +2121,16 @@ static struct pci_serial_quirk pci_seria
 		.exit		= pci_plx9050_exit,
 	},
 	/*
+	 * Pericom (Only 7954 - It have a offset jump for port 4)
+	 */
+	{
+		.vendor		= PCI_VENDOR_ID_PERICOM,
+		.device		= PCI_DEVICE_ID_PERICOM_PI7C9X7954,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.setup		= pci_pericom_setup,
+	},
+	/*
 	 * PLX
 	 */
 	{


