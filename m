Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A236CC2D0C0
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 22:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 696E420748
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 22:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AEzg80a4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfL2WcE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 17:32:04 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34290 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbfL2WcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 17:32:03 -0500
Received: by mail-qt1-f195.google.com with SMTP id 5so28602224qtz.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Dec 2019 14:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=f0XyFhJxaSBsnLc48u6S2zxUb8AEk9qkcHvQljdmaTU=;
        b=AEzg80a4E/lCAAF6qfluK2eflndpb9glCkRlugCIji4phnCLE+0W2wIJ02plJqYent
         Jo6nvfIBtX6sJO1WlPmf25BoARnvJL02Y85423L9EGtRGWEDnlpvSXe4Qv7cgt3Lw8tb
         82/+A/IdCZ4gizrtBYmbcDFzOhBAEOfrfgpL4VaehSFZ9IRtyV36xLGGmBKYR71S3C6F
         qawZPxmfhLWHkS32iBgCDhRk2X5MvyIpj4ta1qCmN8XIQaxy/d1FD1q/IfmWBzYdXRHh
         HCiO7xWpa3o5KE/7+NFlC6Mt1mJF6RsMbcedZxgMGbG5khDb6s7nowKOcYxT+6cWHTAj
         tscQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=f0XyFhJxaSBsnLc48u6S2zxUb8AEk9qkcHvQljdmaTU=;
        b=iITUdNYTHyKszP2vuCyhK03KJKtNX3EYrI6zL6WnaX/N9Zo8Lsi6gtFV3lTfQ4wfqj
         wG4S4cueoX5QC7U8eZLGj1OqEy7Y2bsGvk4WbWWKRxNszWKQCF+WP8w2tDz5O0/WnGuz
         nvgMXJCVAtRbb0HAwC9JZ9lywNHumrKw/NIYSUSqGTbL0prs0JKNzj5x7yne/wBzU9us
         cidqEpTx8OmKhC67edjmLstmWyUlmRF7lYDsabsDAvHYTj8Fxj6cmcOSpnDPDHuOfBcd
         YJaxup5MlhErm8McaaZ5qDU95Y9PZAKPOb/Vkj03/KovtxiLaNX+a4SWkMuEiRCBSdN2
         7VVA==
X-Gm-Message-State: APjAAAXEDqDm/8GB0Q/50YcLsSZ0VP12bqTa7z8wXIbXyrteUexeuUtB
        fScAqNmPNvl+0uZvPsRjZQ8=
X-Google-Smtp-Source: APXvYqxpO+UY6xVlvhzPdiabPUnPbh8CPhFUncrdCpDDSKhobmLc9XNWrPctZmFvwn7U0eUKlvgoCg==
X-Received: by 2002:ac8:32ec:: with SMTP id a41mr47149306qtb.235.1577658723029;
        Sun, 29 Dec 2019 14:32:03 -0800 (PST)
Received: from mandalore.localdomain (pool-71-244-100-50.phlapa.fios.verizon.net. [71.244.100.50])
        by smtp.gmail.com with ESMTPSA id p185sm11897433qkd.126.2019.12.29.14.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Dec 2019 14:32:02 -0800 (PST)
Date:   Sun, 29 Dec 2019 17:31:42 -0500
From:   Matthew Hanzelik <mrhanzelik@gmail.com>
To:     jerome.pouiller@silabs.com, gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] Staging: wfx: Fix style issues with hif_rx.c
Message-ID: <20191229223142.5pxmmu7sfwdtcn7d@mandalore.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the 80 line limit warning on line 79 of hif_rx.c.

Also fixes the missing blank line warning on line 305 of hif_rx.c after
the declaration of size_t len.

Signed-off-by: Matthew Hanzelik <mrhanzelik@gmail.com>
---
Changes in v2
 - Make the commit message less vague.

Changes in v3
 - Place the break after the cast operator instead of breaking the line up.

 drivers/staging/wfx/hif_rx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/wfx/hif_rx.c b/drivers/staging/wfx/hif_rx.c
index 820de216be0c..b31ef02ea5d4 100644
--- a/drivers/staging/wfx/hif_rx.c
+++ b/drivers/staging/wfx/hif_rx.c
@@ -76,7 +76,8 @@ static int hif_multi_tx_confirm(struct wfx_dev *wdev, struct hif_msg *hif,
 				void *buf)
 {
 	struct hif_cnf_multi_transmit *body = buf;
-	struct hif_cnf_tx *buf_loc = (struct hif_cnf_tx *) &body->tx_conf_payload;
+	struct hif_cnf_tx *buf_loc =
+		(struct hif_cnf_tx *) &body->tx_conf_payload;
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

