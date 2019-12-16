Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA9BC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 764B1207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576521507;
	bh=140WJj6EyLddBXjufsKxRaq1jtOvqlNrf61LR1W3RG4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CQSGGHQr9PQug5AGWHKZqIXF+OkDtP8L9BrcEnfQZdDfffBVRxPnBMINMi3Q/T2ly
	 q3lkyzfPj/h79rov8JNgTDBo8pKzPnpczIOeXIxVQOJGOcUSF3w9ijdpFSeH9UGzGN
	 ZbUrEHqWuFxy/D0v15Xll+gkf49yTEyldDg/+X5o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729927AbfLPSiZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:38:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:42592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729368AbfLPSEz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:04:55 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 501002072D;
        Mon, 16 Dec 2019 18:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576519494;
        bh=140WJj6EyLddBXjufsKxRaq1jtOvqlNrf61LR1W3RG4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cbO4/E4Gpzg9RONqQzOl6ngNuWFoVyzQOfB0iDhWcFNOwP8dZuWCNQMRaGNDCgJVG
         Dpj+D6PmiPawzFCfy3PRp8ov+xq6RLqSDJW0Jt2FrfyY+DCl67ufx+2FkzAluBHpTL
         yj+xxPJsYBUWQ3+nIvRkFXfNSBsOhD99h2PdAS5U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
        Greg Kurz <groug@kaod.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.19 087/140] powerpc/xive: Prevent page fault issues in the machine crash handler
Date:   Mon, 16 Dec 2019 18:49:15 +0100
Message-Id: <20191216174810.764407091@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174747.111154704@linuxfoundation.org>
References: <20191216174747.111154704@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cédric Le Goater <clg@kaod.org>

commit 1ca3dec2b2dff9d286ce6cd64108bda0e98f9710 upstream.

When the machine crash handler is invoked, all interrupts are masked
but interrupts which have not been started yet do not have an ESB page
mapped in the Linux address space. This crashes the 'crash kexec'
sequence on sPAPR guests.

To fix, force the mapping of the ESB page when an interrupt is being
mapped in the Linux IRQ number space. This is done by setting the
initial state of the interrupt to OFF which is not necessarily the
case on PowerNV.

Fixes: 243e25112d06 ("powerpc/xive: Native exploitation of the XIVE interrupt controller")
Cc: stable@vger.kernel.org # v4.12+
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20191031063100.3864-1-clg@kaod.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/sysdev/xive/common.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/arch/powerpc/sysdev/xive/common.c
+++ b/arch/powerpc/sysdev/xive/common.c
@@ -968,6 +968,15 @@ static int xive_irq_alloc_data(unsigned
 	xd->target = XIVE_INVALID_TARGET;
 	irq_set_handler_data(virq, xd);
 
+	/*
+	 * Turn OFF by default the interrupt being mapped. A side
+	 * effect of this check is the mapping the ESB page of the
+	 * interrupt in the Linux address space. This prevents page
+	 * fault issues in the crash handler which masks all
+	 * interrupts.
+	 */
+	xive_esb_read(xd, XIVE_ESB_SET_PQ_01);
+
 	return 0;
 }
 


