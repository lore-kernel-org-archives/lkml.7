Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B13D7CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 14:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8186E2084C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 14:25:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UE+ptBGu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729126AbfJUOZq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 10:25:46 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43058 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbfJUOZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 10:25:44 -0400
Received: by mail-pl1-f193.google.com with SMTP id v5so1973326ply.10;
        Mon, 21 Oct 2019 07:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e/Nu6479wT4lgFB7uIBv0K2t4SV9aOlrpNohdOcDVIw=;
        b=UE+ptBGuF36dUk+oxh8MXCI+giWh/w0w+on8Lqd5WOhhBDm/zVyf/S2TuxVtVjIupk
         6F8urq+AKinKfTiQHiDUHMStVtfnU636yId8CI4a6ZLCFiR8QU3TU5Xz+DGzrmJqPt4C
         /Vka0WtFyHfzjAhnh0GUJRxD1HnLOQlk4mVxgQUqHyHAalfe+f4MCMz4z5yNdklRCBbH
         jfR+T08hWdA0Y9hQXyqAk9rVgqYtZ0wnLgiyV52UH19yi00hpqG4OEhh7IXUfCLoDnZl
         K+OMshItQ0Ill+DMg9pFjDhGJrkgvYrPYiMP6KQWHubmsbo1yP4qDtslZvbbrPzspZ8r
         GXZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e/Nu6479wT4lgFB7uIBv0K2t4SV9aOlrpNohdOcDVIw=;
        b=e/nMFGrxO8aY5PMMySz8JaWYNl/+ishpKJBzhLETehp2rpBWK0rCZVT+E6ypaIKc6/
         e9hV1ZjMApU4PwPVbAYmOXMxbnRiF5zqNQk2F8CaKldLP17Rql3FojU01hFAoUk8BSaK
         OO1sOV85kcywXpcZ24V4Zp4dFPPSbuh3XF+HUJnMHNngfOTGcUtZXfjeBreO+APDGpx5
         uOzKfPgiWAXLOJWiHDJZH4IRZVhaWB1nfm+3jgugXOKZ3hWxMxw+SD7qFlKSsxrbGa00
         ZfsCfNUR1+CxqErMrlU+MKtunBStZltRa0b3/z+r+dtNPAc/ZYA5Iun1Sba8fCvrCnF8
         jUmA==
X-Gm-Message-State: APjAAAWmy8BRXByDt64sVb69Now3WK824QPcl1omYzQ/CMjhoTVkd7T8
        /kxcgMMpL+sWFKaPD/B3Bxw=
X-Google-Smtp-Source: APXvYqzRDnyYrg1W73jjsfHxGfiqD4rr/5X6cnpVrN9dgI/xjXSzFfKyKjil3fD302ms6kaMF82xdA==
X-Received: by 2002:a17:902:8691:: with SMTP id g17mr23774191plo.231.1571667942442;
        Mon, 21 Oct 2019 07:25:42 -0700 (PDT)
Received: from localhost.localdomain ([221.155.202.134])
        by smtp.gmail.com with ESMTPSA id k15sm14214176pgt.25.2019.10.21.07.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 07:25:42 -0700 (PDT)
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     shuah@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        julia.lawall@lip6.fr, valentina.manea.m@gmail.com,
        Suwan Kim <suwan.kim027@gmail.com>,
        kbuild test robot <lkp@intel.com>
Subject: [PATCH] =?UTF-8?q?usbip:=C2=A0Fix=20free=20of=20unallocated=20mem?= =?UTF-8?q?ory=20in=20vhci=20tx?=
Date:   Mon, 21 Oct 2019 23:24:14 +0900
Message-Id: <20191021142414.27164-1-suwan.kim027@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

iso_buffer should be set to NULL after use and free in the while loop.
In the case of isochronous URB in the while loop, iso_buffer is
allocated and after sending it to server, buffer is deallocated. And
then, if the next URB in the while loop is not a isochronous pipe,
iso_buffer still holds the previously deallocated buffer address and
kfree tries to free wrong buffer address.

Fixes: ea44d190764b (“usbip: Implement SG support to vhci-hcd and stub driver”)
Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Julia Lawall <julia.lawall@lip6.fr>
Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>
---
 drivers/usb/usbip/vhci_tx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/usbip/vhci_tx.c b/drivers/usb/usbip/vhci_tx.c
index c3803785f6ef..b290e810d11b 100644
--- a/drivers/usb/usbip/vhci_tx.c
+++ b/drivers/usb/usbip/vhci_tx.c
@@ -73,6 +73,7 @@ static int vhci_send_cmd_submit(struct vhci_device *vdev)
 		memset(&pdu_header, 0, sizeof(pdu_header));
 		memset(&msg, 0, sizeof(msg));
 		memset(&iov, 0, sizeof(iov));
+		iso_buffer = NULL;
 
 		usbip_dbg_vhci_tx("setup txdata urb seqnum %lu\n",
 				  priv->seqnum);
-- 
2.21.0

