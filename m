Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D24C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 127C620880
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554141649;
	bh=8xEFavklh9mHJYFUeuMKl9znebsYN+LJuax5VOVkffk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oKgYcF9FXcAd8skEuKpfHYIVdU8v2ix79xJgimbQNdF47VquHRs08pmcU4434vor4
	 eBa2PMY0Dm36/yo/r5xU/9TdlfovBRVqnQb2vmsZ/jOwhxEqsNYOebLaBO31bzHE+x
	 cGxfyp2A/pK5MCOZWrnlTVTDkMciShkv/Lofgkak=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731277AbfDASAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 14:00:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:42304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730899AbfDARQs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:16:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 534E920883;
        Mon,  1 Apr 2019 17:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139007;
        bh=8xEFavklh9mHJYFUeuMKl9znebsYN+LJuax5VOVkffk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=11r1RGvg0f6YDwo0wFiIbcdLzUfKkoXvFtJF5LQa248yNXW3G4kH0WOR9hQp8mR4P
         RxmJGm+wXwnhTILF4Xoc3KPfGsOHo8mvG7YRo4eNt1Z0nWjzc8/qlGGYSO1I+MwZzl
         KIqtyrjfPHAWWipmWnf4rBkv/JTqUilNCfblj8bU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aditya Pakki <pakki001@umn.edu>
Subject: [PATCH 4.19 086/134] serial: max310x: Fix to avoid potential NULL pointer dereference
Date:   Mon,  1 Apr 2019 19:02:02 +0200
Message-Id: <20190401170052.337390492@linuxfoundation.org>
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
@@ -1419,6 +1419,8 @@ static int max310x_spi_probe(struct spi_
 	if (spi->dev.of_node) {
 		const struct of_device_id *of_id =
 			of_match_device(max310x_dt_ids, &spi->dev);
+		if (!of_id)
+			return -ENODEV;
 
 		devtype = (struct max310x_devtype *)of_id->data;
 	} else {


