Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D01C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EA0721924
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554138492;
	bh=ZzAkr4Vjac4rRM7jMtRJOEfuiJFFI09SuEMBmXzT3wo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WlkxVGERNR3D+ZKSgjFzP+IhK4/0XGNLOccpnABR+q50NZF8W7wXrptIH7NIyM2PN
	 M/yHiY/YqVPMnJCHu9mtOnxTK9vQk0qn1MhpMKD1aRUthsty3ReKN+BjSjzsa6/nrq
	 7Kicm/+aunhXUAhjoqE0XeTrPnrXFXX4qJSwUTGo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729600AbfDARIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:08:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:54508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729138AbfDARIH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:08:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56F6521924;
        Mon,  1 Apr 2019 17:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138486;
        bh=ZzAkr4Vjac4rRM7jMtRJOEfuiJFFI09SuEMBmXzT3wo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dYVay7Fkstpr0bSjUH6it8O//oB1lQdwDi/rYpsbGumb0xl5B7Oq8Sztv3PFUabTi
         zrHf/T6RhQjLsvdarXH/tarmaIjAYiku9WfNsL98kSs7TYP3FKg5TEI/jNNIGs9rvz
         xbcoBs7PpuV9ykauzgdQUmYckDquwPd2oHjxM/O0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>
Subject: [PATCH 5.0 079/146] tty: mxs-auart: fix a potential NULL pointer dereference
Date:   Mon,  1 Apr 2019 19:01:31 +0200
Message-Id: <20190401170055.550937729@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170048.449559024@linuxfoundation.org>
References: <20190401170048.449559024@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kangjie Lu <kjlu@umn.edu>

commit 6734330654dac550f12e932996b868c6d0dcb421 upstream.

In case ioremap fails, the fix returns -ENOMEM to avoid NULL
pointer dereferences.
Multiple places use port.membase.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serial/mxs-auart.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -1686,6 +1686,10 @@ static int mxs_auart_probe(struct platfo
 
 	s->port.mapbase = r->start;
 	s->port.membase = ioremap(r->start, resource_size(r));
+	if (!s->port.membase) {
+		ret = -ENOMEM;
+		goto out_disable_clks;
+	}
 	s->port.ops = &mxs_auart_ops;
 	s->port.iotype = UPIO_MEM;
 	s->port.fifosize = MXS_AUART_FIFO_SIZE;


