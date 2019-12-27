Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B007BC2D0C3
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 20:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 745D320740
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 20:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DpwHAEhh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfL0URS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 15:17:18 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36574 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbfL0URR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 15:17:17 -0500
Received: by mail-qk1-f195.google.com with SMTP id a203so22640460qkc.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Dec 2019 12:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=BWyuL8rMvPGveHbNWJIB/Df4e7UkYcywBoUb4DokUKQ=;
        b=DpwHAEhh6E0bmfwYkaHmBcV7RjNn3jctEXNY+dtWAvNF/3bQZ9vb8KbaMPufI+ceeW
         9UbgeD5DlUM0FSw55Vz3fCq051WE4BTCUFrm5fTc4BaEn92EDCyr6Jo6rlO6j3wKHNye
         MDXxol0R33a3oVphykSGgg15856HwQ0Eb26dBXJyfG3Wf1IG78BGVhpzzV6PTTETWZH1
         GRNavpguYVJVKOnjClQVQO7yYMFpIenz2R7QljJMhYo7eCz81Ym4h0F2De6oi3/nMOzm
         FIeTyHKMIC8Ue3LvmyMNj8MTiksIMhWRzoJg1zYM5IgHwFeGqV9S4y4kkrD/i8vZ/jJF
         KQTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=BWyuL8rMvPGveHbNWJIB/Df4e7UkYcywBoUb4DokUKQ=;
        b=M9g3OwHLk9bEjhc9xc0fv4IAVLabH7uSy2FXNY+2PUp2ZsTmdLc7yHBnhLn/7Qmael
         Cfm5ikqhkyT25L7TSDp1vlRpgumoCCxPqNqBcapW2smsmdMvP+Y/HGbchDJhlFN8joh9
         /BF/HTHHf1iXR95VO3P2ulgVw4DUP58zt6MdAccXnAPCn+nSCfmQPvcv2J/pQ8joVJ3v
         Nllh+Pv8S+d/j2dgN8Gz8J9ySK0/idQcITOI7cdUJPej6LBpl67PNukMkQ7A43J/3Lat
         OlttwNb3dkb8fNjKRImU8DRkccdRTDNh8W8CkXQreMUJyRWRTO+/H8CZ+vHB56MADtHI
         cmTg==
X-Gm-Message-State: APjAAAUQY61cULTV1fv9QUrfOWDcrqGcJx/jzyXkTD1XgTdGWvLhJ4B4
        GiBj0va2IAn7YiA/CkLeva0zevpW
X-Google-Smtp-Source: APXvYqyMUSvUCcQFJGLHfp0FVMQuuW0lDVISBgDTDGX/4SJ+6V251sy5BTN6yySpXPWN2niidSyr+Q==
X-Received: by 2002:a37:b783:: with SMTP id h125mr43101894qkf.75.1577477836754;
        Fri, 27 Dec 2019 12:17:16 -0800 (PST)
Received: from mandalore.localdomain (pool-71-244-100-50.phlapa.fios.verizon.net. [71.244.100.50])
        by smtp.gmail.com with ESMTPSA id t2sm9957370qkc.31.2019.12.27.12.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2019 12:17:16 -0800 (PST)
Date:   Fri, 27 Dec 2019 15:16:56 -0500
From:   Matthew Hanzelik <mrhanzelik@gmail.com>
To:     jerome.pouiller@silabs.com, gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Staging: wfx: Fix style issues with hif_rx.c
Message-ID: <20191227201656.3g426wagfubit5zy@mandalore.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes style issues with hif_rx.c.

Signed-off-by: Matthew Hanzelik <mrhanzelik@gmail.com>
---
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

