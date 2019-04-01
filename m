Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D98FCC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EAEF2133D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139015;
	bh=7NqkNI4AcQpNFXY3aakXB5bpLZ6h6NJGrmyBj3btLB0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CAHgTC9ntmBOJUxq/CFaEF4ZsHL9XqqdaHuf+/m1fOvYi4QSXgjKPHAOZnQLhTwRi
	 zdt8LDSz1d2wQXIGl5Hl6ZvqXumb5S6y5FxYofbk4U2c9YSc8zrdwg3uDqYpnWmlam
	 KtqMtLxubwWH/UJGKXleu4AGLhT9bWOoTRPURvjw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731088AbfDARQy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:16:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:42368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730894AbfDARQv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:16:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBF6120856;
        Mon,  1 Apr 2019 17:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139010;
        bh=7NqkNI4AcQpNFXY3aakXB5bpLZ6h6NJGrmyBj3btLB0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LLuJr46NLoaVlNqAgrgM4xGIghhn2jGu1yk6n/GLOlBW52P222tdFmFiLNJ+8DdJ2
         73amY36qAlRQjoe+6oygYQixSrVIlFgOdGFJXatH+YlK7W6L7JVtvny1xS8ra+e/fp
         x/jVtgeW37hWVg8AOwq0dWYcA8gaUUiVvIHEgLAo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aditya Pakki <pakki001@umn.edu>
Subject: [PATCH 4.19 087/134] serial: mvebu-uart: Fix to avoid a potential NULL pointer dereference
Date:   Mon,  1 Apr 2019 19:02:03 +0200
Message-Id: <20190401170052.427588347@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170044.243719205@linuxfoundation.org>
References: <20190401170044.243719205@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aditya Pakki <pakki001@umn.edu>

commit 32f47179833b63de72427131169809065db6745e upstream.

of_match_device on failure to find a matching device can return a NULL
pointer. The patch checks for such a scenrio and passes the error upstream.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serial/mvebu-uart.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/tty/serial/mvebu-uart.c
+++ b/drivers/tty/serial/mvebu-uart.c
@@ -799,6 +799,9 @@ static int mvebu_uart_probe(struct platf
 		return -EINVAL;
 	}
 
+	if (!match)
+		return -ENODEV;
+
 	/* Assume that all UART ports have a DT alias or none has */
 	id = of_alias_get_id(pdev->dev.of_node, "serial");
 	if (!pdev->dev.of_node || id < 0)


