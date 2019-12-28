Return-Path: <SRS0=tgXE=2S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A7EC2D0C3
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 00:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7A77208C4
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 00:38:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jmgCNUS5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfL1Aio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 19:38:44 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38768 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbfL1Ain (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 19:38:43 -0500
Received: by mail-qk1-f196.google.com with SMTP id k6so22633726qki.5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Dec 2019 16:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=JokR98mpMX2t19KA/jRz5XKT2QWfvS7MbhYAnmjFc1g=;
        b=jmgCNUS5CIBG4UBhnZqxjWdm/0ndqIQ1fis+IpWTsE+raxFCwTkr9QyZz6rSoCr1ZI
         AmCnv/vrPiU5sSM+FC6AU0/ZRxx/pcz3rctfAEvBUxN7Qb0HdivLO4AbBJ80PQbtZXFz
         2kgFu/K1upl3kYXDCG/og3JKeWPdQECMytfPXd1SYKF9DtEs9lBn3/k3areyq7wjtZB2
         0iATf96O4liYC7HfVu8h85y940oheFHVTMvoMZF06Z9Quo20bgMSqDtj5jQ+ZJvhTw5n
         Eug7GO6m0hDObeic7dXdfNKIUwENSqqKkadcD/ok42zwuv/HMfjt7e1cjOrN6dxQGlbn
         UdjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=JokR98mpMX2t19KA/jRz5XKT2QWfvS7MbhYAnmjFc1g=;
        b=jShyJ9ZjLV3UZYrS1sY1ynN9Iu9afkTpoyFrpjwTtIzI99+cWYzaisZbHkg2pQZagm
         ATKzvbqui7yf8h8JKd5vpsEIBCNzOu52or70qLye6zGQMvEiMNKZNZyxuFvtYXRtc3jy
         lnsAGH26OVT0p1Jjho62Y7hCw04u66ogwVrUmcUNHXgntax0cgejAbjg/kZUG9ypKxbH
         vr3aOVIyflOVMYnMVWsWLI/5TLmNkD4i6fDa96ei7UJQkgo5uhdZibMIovO+wMfiRA1y
         HEhJ9vVwUamKUjtx/3BixouJMUivW4H/ZHW6/MKfVlvyE7SllWAIGAUYQCY+FwCEmNx6
         GNeg==
X-Gm-Message-State: APjAAAXFh1FgkPhkZ/7gkXMPEAmgzaV0nHbEsK8+1AVXQ+cXegvEyb39
        Xe/Gn7FMqeqIMf1ONm2v9Qc=
X-Google-Smtp-Source: APXvYqyX9Z0x7UmNaQO5kVWzPsy4PjlEEEjioKxgKqVqUdp41hAGvb037wOoai/sVZF5R8RmVghnNw==
X-Received: by 2002:a05:620a:8cc:: with SMTP id z12mr42143135qkz.48.1577493522901;
        Fri, 27 Dec 2019 16:38:42 -0800 (PST)
Received: from mandalore.localdomain (pool-71-244-100-50.phlapa.fios.verizon.net. [71.244.100.50])
        by smtp.gmail.com with ESMTPSA id l85sm10153378qke.103.2019.12.27.16.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2019 16:38:42 -0800 (PST)
Date:   Fri, 27 Dec 2019 19:38:24 -0500
From:   Matthew Hanzelik <mrhanzelik@gmail.com>
To:     jerome.pouiller@silabs.com, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCH v2] Staging: wfx: Fix style issues with hif_rx.c
Message-ID: <20191228003818.mmcf4aasks5mqcnr@mandalore.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the 80 character line limit warning on line 79 of hif_rx.c.

Also fixes the missing blank line warning on line 305 of hif_rx.c after
the declaration of size_t len.

Signed-off-by: Matthew Hanzelik <mrhanzelik@gmail.com>
---
Changes in v2:
 - Make the commit message less vague.

 drivers/staging/wfx/hif_rx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/wfx/hif_rx.c b/drivers/staging/wfx/hif_rx.c
index 820de216be0c..1da9a153dda0 100644
--- a/drivers/staging/wfx/hif_rx.c
+++ b/drivers/staging/wfx/hif_rx.c
@@ -76,7 +76,8 @@ static int hif_multi_tx_confirm(struct wfx_dev *wdev, struct hif_msg *hif,
 				void *buf)
 {
 	struct hif_cnf_multi_transmit *body = buf;
-	struct hif_cnf_tx *buf_loc = (struct hif_cnf_tx *) &body->tx_conf_payload;
+	struct hif_cnf_tx *buf_loc = (struct hif_cnf_tx *)
+				      &body->tx_conf_payload;
 	struct wfx_vif *wvif = wdev_to_wvif(wdev, hif->interface);
 	int count = body->num_tx_confs;
 	int i;
@@ -302,6 +303,7 @@ static int hif_exception_indication(struct wfx_dev *wdev,
 				    struct hif_msg *hif, void *buf)
 {
 	size_t len = hif->len - 4; // drop header
+
 	dev_err(wdev->dev, "firmware exception\n");
 	print_hex_dump_bytes("Dump: ", DUMP_PREFIX_NONE, buf, len);
 	wdev->chip_frozen = 1;
--
2.24.1

