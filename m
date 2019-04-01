Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7DA9C4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C9F720663
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554142071;
	bh=NbgTteSypkoUAKJqN/F8UT9jPs0WjHSLWp4PJliR8l4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fulQJlV4MFz4M+29DgrjVWdJyEUzRhHuMOL5QEw3qpOwt9tkr8k3Pbfm8hBwh8Bq9
	 LUr2soHgreUowXPjLXDzqPunjSBTivORNzuJlUmYmT1HRvPPTxCgbmpvy3TXE6wWiW
	 7qq788bJ5Fg0HGV15F8uSgj692/VPxY1ZyGMHdGQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730081AbfDARK6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:10:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:59008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729485AbfDARKx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:10:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8047821934;
        Mon,  1 Apr 2019 17:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138653;
        bh=NbgTteSypkoUAKJqN/F8UT9jPs0WjHSLWp4PJliR8l4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N4m2ftx4KRPSUoyo/ZLV2ZERie12M1AVIXcdGgr/8v21jl2Iod88fEbMp0f3udvT6
         IfGrhl6zI8sl89SyMDpDCqeeOV1nRBAfHGxfgq1MstOYt8XvbE6xzISA5bqEUvv8yG
         qc8fHMbldON5cQr/cTkqaxctiLaAXbYi3Frcol7U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aditya Pakki <pakki001@umn.edu>
Subject: [PATCH 5.0 090/146] serial: max310x: Fix to avoid potential NULL pointer dereference
Date:   Mon,  1 Apr 2019 19:01:42 +0200
Message-Id: <20190401170056.420849609@linuxfoundation.org>
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

From: Aditya Pakki <pakki001@umn.edu>

commit 3a10e3dd52e80b9a97a3346020024d17b2c272d6 upstream.

of_match_device can return a NULL pointer when matching device is not
found. This patch avoids a scenario causing NULL pointer derefernce.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serial/max310x.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -1416,6 +1416,8 @@ static int max310x_spi_probe(struct spi_
 	if (spi->dev.of_node) {
 		const struct of_device_id *of_id =
 			of_match_device(max310x_dt_ids, &spi->dev);
+		if (!of_id)
+			return -ENODEV;
 
 		devtype = (struct max310x_devtype *)of_id->data;
 	} else {


