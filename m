Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A2FC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F25F2064A
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127717;
	bh=gCkHpOctk/WUdczzryLIL04UsbE+Ek5H+CnF+htfF8s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=J2Q4CHWf/5YGn13A/sUPL5+fV5pJGBfxiurt9jhP/8nKJuAbP7QgAOTFE8OQAK0hq
	 g+48j9PXzUYZRuV5Pp6+1O9r23ekqN33KcX6cmGZypwNj9N+cMkuid7PTPv39JD5gX
	 FkHPaZo0D0BP1O7XQVvpgO03iWd5ZEnI4LqaHveM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403885AbfDXRgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:36:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:35148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730651AbfDXRgO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:36:14 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6217021905;
        Wed, 24 Apr 2019 17:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127373;
        bh=gCkHpOctk/WUdczzryLIL04UsbE+Ek5H+CnF+htfF8s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NSBlt2dHab4tec6G9ztRP9NqNJYrICLM9Qw+iMFe9i00JoMya7ZY7ELlx40xrlqzv
         KEKe524mBkEehwy3CXMEKbroNVUbTxZoMzeHWK44sbljhOPOz0a8p5kwImbgNdstYI
         6b27jNcAaVmxDRzrOstRwJhY4Xy/cDlbT1HzRrjg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christian Gromm <christian.gromm@microchip.com>
Subject: [PATCH 5.0 065/115] staging: most: core: use device description as name
Date:   Wed, 24 Apr 2019 19:10:01 +0200
Message-Id: <20190424170928.899196197@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170924.797924502@linuxfoundation.org>
References: <20190424170924.797924502@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Gromm <christian.gromm@microchip.com>

commit 131ac62253dba79daf4a6d83ab12293d2b9863d3 upstream.

This patch uses the device description to clearly identity a device
attached to the bus. It is needed as the currently useed mdevX
notation is not sufficiant in case more than one network
interface controller is being used at the same time.

Cc: stable@vger.kernel.org
Signed-off-by: Christian Gromm <christian.gromm@microchip.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/most/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/staging/most/core.c
+++ b/drivers/staging/most/core.c
@@ -1431,7 +1431,7 @@ int most_register_interface(struct most_
 
 	INIT_LIST_HEAD(&iface->p->channel_list);
 	iface->p->dev_id = id;
-	snprintf(iface->p->name, STRING_SIZE, "mdev%d", id);
+	strcpy(iface->p->name, iface->description);
 	iface->dev.init_name = iface->p->name;
 	iface->dev.bus = &mc.bus;
 	iface->dev.parent = &mc.dev;


