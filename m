Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C36DC432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 08:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 530BC218AC
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 08:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575276998;
	bh=Us2LR83sqTpDDxH+Vob/8vFqXsuJSQfz1IXYJRDcCJ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mM8hZx+1zNMzy6QdXM9b86haDj5swq1Xwrw1OKzX7hW9YoogcDYpb97wQX8G07ean
	 UJI4J63OxXd0czTVj0GuNS/3IxDusxu5yACdaAsTCQhEi5wUA3qtgFy3vgSog/RudI
	 rKOGxgHY2uuf5MyAKNycEZSPXDwZkRUqmh4k0D1k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbfLBI4h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 03:56:37 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41828 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727317AbfLBI42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 03:56:28 -0500
Received: by mail-lj1-f194.google.com with SMTP id h23so2637139ljc.8;
        Mon, 02 Dec 2019 00:56:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rl1LB5EX7oIVC0mGuDqRbEVhDWig1nq2VNrs1gvJuaw=;
        b=kDfrdNrV69JnxKk5VeEvumOB732tK3kzSsItKiSnUbUJjEGHKZO3ArJNYnTMrkp2JT
         H0PptM9nHy1CnKT3dFiB6TRTByW9L0bREUEfhg0kPppvELM1sZACdrGVtBTcghz2bec8
         qA3vaEX8ei9XsmJ54F6Ia5Wn0lSPLnBU+p9lzpU+4CYdqZGSucxmqixio1hZoJOs8snc
         l4xivmL9FeYm41SPHXpOUsY7OJw50vyRT9ndI/DbDIg74X3OlaFhZhLVNThuSpv4add6
         4iSEzbZY2oSJC3HwWoT3CenAVAEYOkygaSX5VERr/D6EMUFQIdQUsd88LO6a7g3gIV/a
         GzAg==
X-Gm-Message-State: APjAAAVD5QjlyDQRJVaOn7VnJrqMCkozowceARVmyrXLVEeQoVS4WEcr
        iWx9JVRqPSnZ2tzGOzWU4PQ=
X-Google-Smtp-Source: APXvYqwRd3xGb/t3PETM2Lts/w4SDIabwmc7fZxPHq77jLNKOyGJUZSpLoQaby/lNY6m6qnLrIP48A==
X-Received: by 2002:a2e:970e:: with SMTP id r14mr44042644lji.57.1575276985866;
        Mon, 02 Dec 2019 00:56:25 -0800 (PST)
Received: from xi.terra (c-14b8e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.184.20])
        by smtp.gmail.com with ESMTPSA id z26sm2582160lfq.69.2019.12.02.00.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 00:56:24 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@xi.terra>)
        id 1ibhVM-0003K5-1e; Mon, 02 Dec 2019 09:56:28 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        stable <stable@vger.kernel.org>, Tilman Schmidt <tilman@imap.cc>
Subject: [PATCH v2 2/3] staging: gigaset: fix illegal free on probe errors
Date:   Mon,  2 Dec 2019 09:56:09 +0100
Message-Id: <20191202085610.12719-3-johan@kernel.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191202085610.12719-1-johan@kernel.org>
References: <20191202085610.12719-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver failed to initialise its receive-buffer pointer, something
which could lead to an illegal free on late probe errors.

Fix this by making sure to clear all driver data at allocation.

Fixes: 2032e2c2309d ("usb_gigaset: code cleanup")
Cc: stable <stable@vger.kernel.org>     # 2.6.33
Cc: Tilman Schmidt <tilman@imap.cc>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/staging/isdn/gigaset/usb-gigaset.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/staging/isdn/gigaset/usb-gigaset.c b/drivers/staging/isdn/gigaset/usb-gigaset.c
index 5e393e7dde45..a84722d83bc6 100644
--- a/drivers/staging/isdn/gigaset/usb-gigaset.c
+++ b/drivers/staging/isdn/gigaset/usb-gigaset.c
@@ -571,8 +571,7 @@ static int gigaset_initcshw(struct cardstate *cs)
 {
 	struct usb_cardstate *ucs;
 
-	cs->hw.usb = ucs =
-		kmalloc(sizeof(struct usb_cardstate), GFP_KERNEL);
+	cs->hw.usb = ucs = kzalloc(sizeof(struct usb_cardstate), GFP_KERNEL);
 	if (!ucs) {
 		pr_err("out of memory\n");
 		return -ENOMEM;
@@ -584,9 +583,6 @@ static int gigaset_initcshw(struct cardstate *cs)
 	ucs->bchars[3] = 0;
 	ucs->bchars[4] = 0x11;
 	ucs->bchars[5] = 0x13;
-	ucs->bulk_out_buffer = NULL;
-	ucs->bulk_out_urb = NULL;
-	ucs->read_urb = NULL;
 	tasklet_init(&cs->write_tasklet,
 		     gigaset_modem_fill, (unsigned long) cs);
 
-- 
2.24.0

