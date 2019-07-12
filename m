Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99DBDC742BA
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62CD52080A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562935054;
	bh=BVaPzCcCRxog7PRN36yt9WFA3YWErUvntYn/2BoLlTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qxLx91sPV7X3UXSDZpqloG/dcuoAmZgaTwW+wN50i1zJD/HesKmG7gSYHwDcmzuHo
	 mXkzpSfn5HYTGAN+C0aSNN2len/kr6guHtFitrOk6N9JZ/ZFSSdzoNZatWUuJ+NgJm
	 EHrOzcwmKPLoGzOBn+dTroO7IhSJyguBbc1O4fKo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729276AbfGLMbB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 08:31:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:47220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729254AbfGLMa6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 08:30:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7AAEE216B7;
        Fri, 12 Jul 2019 12:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562934658;
        bh=BVaPzCcCRxog7PRN36yt9WFA3YWErUvntYn/2BoLlTk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=grK3Np1HVn2KVm2SxF4T9YxiAgabd3ZZZ0LhfttirmVOiiGx+rIl7O5oaPQ6GNQMs
         MncJ6Z//sqiBWWFsskmEV+wq9GujGZIPCsva9NDTVehAj73HihaOt7LiJCOY9sTKBE
         MfOArHVaQujNXpaokN8sxM86sZFmsUGOwqWssJJc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ajay Singh <ajay.kathat@microchip.com>
Subject: [PATCH 5.1 120/138] staging: wilc1000: fix error path cleanup in wilc_wlan_initialize()
Date:   Fri, 12 Jul 2019 14:19:44 +0200
Message-Id: <20190712121633.348340719@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190712121628.731888964@linuxfoundation.org>
References: <20190712121628.731888964@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

commit 6419f818ababebc1116fb2d0e220bd4fe835d0e3 upstream.

For the error path in wilc_wlan_initialize(), the resources are not
cleanup in the correct order. Reverted the previous changes and use the
correct order to free during error condition.

Fixes: b46d68825c2d ("staging: wilc1000: remove COMPLEMENT_BOOT")
Cc: <stable@vger.kernel.org>
Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/wilc1000/wilc_netdev.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- a/drivers/staging/wilc1000/wilc_netdev.c
+++ b/drivers/staging/wilc1000/wilc_netdev.c
@@ -530,17 +530,17 @@ static int wilc_wlan_initialize(struct n
 			goto fail_locks;
 		}
 
-		if (wl->gpio_irq && init_irq(dev)) {
-			ret = -EIO;
-			goto fail_locks;
-		}
-
 		ret = wlan_initialize_threads(dev);
 		if (ret < 0) {
 			ret = -EIO;
 			goto fail_wilc_wlan;
 		}
 
+		if (wl->gpio_irq && init_irq(dev)) {
+			ret = -EIO;
+			goto fail_threads;
+		}
+
 		if (!wl->dev_irq_num &&
 		    wl->hif_func->enable_interrupt &&
 		    wl->hif_func->enable_interrupt(wl)) {
@@ -596,7 +596,7 @@ fail_irq_enable:
 fail_irq_init:
 		if (wl->dev_irq_num)
 			deinit_irq(dev);
-
+fail_threads:
 		wlan_deinitialize_threads(dev);
 fail_wilc_wlan:
 		wilc_wlan_cleanup(dev);


