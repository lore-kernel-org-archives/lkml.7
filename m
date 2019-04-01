Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9AD9C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 14:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8401A2082C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 14:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="usfbQ3i/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728551AbfDAOWG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 10:22:06 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:55157 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbfDAOWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 10:22:06 -0400
Received: by mail-it1-f194.google.com with SMTP id n78so4500191itb.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 07:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=mp2FODHPtsPr+xXlREXn/JBUMHiessxnoejS51YsnzE=;
        b=usfbQ3i/Xml5mYi4h3lCr9MRt+04E+MQn+5aOYcOkmypKgcA6SUIgms+siFtr5MhUB
         OWXO97sWD0jNbUGeM/EzjzJKC0ianel+QiZLygasCXqwCbTfZ7MjvJ0dHCx86XsOc+Mo
         OqyrPRSxyTm1NSMXfmtmCV5VF2rOoqNP2BGNU1mxnWIlFeXs4yNuET0f68jGa/CLJwha
         yJ37dMI9WcSy4uVIzpVVP0rblJ122lAmkx1zCQPlZa7vm63rnBGVB9zmNMnK4Bp7nG0k
         LipNWvSBffHYcVA823FAeHxNSUnvp5dh1WCSFPkH+5r5eQ59MNkyd9EHKU1OaQ6XCaRy
         gzxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=mp2FODHPtsPr+xXlREXn/JBUMHiessxnoejS51YsnzE=;
        b=XeBLyuJj3Ardx1xKmfs79jmGafY5KIY16W/BII4w/hX3guRmR6oso+27JWFG2Zo83S
         2gdjktSlMDUQ1vMdJUcum2Eh+jOahmPA7dYKfgUaURCAdyzE9BG5pgIh8TgVfmqWiwQz
         gTgPCwOVs5vo3tO7KfdYjJ6Swp7GWXRs966/tISJ7dTwnYUQ8qL/+bq5VtsO2iUY4fa4
         ZCRCC0OQTyJ0+4PlE4MYo0RI/RQueIW54YQDyg05x1Cpgq1MaOnrHiWqjLS8nSr57+Vh
         nnJGIarC+LrmqeNy34h5FtS/xMehjPmIxwDIOwHH8iwdd7Cp8Rx3NsnKvhUYZH94qywE
         gVEg==
X-Gm-Message-State: APjAAAVVhTt4i8np+Dnnok1M44YgoRGkZ1Nice89b67a5xyB5obMGQSU
        NJ4/JXhnGJEe6sU6rWTbQLZkLyyPW7N3f0v1
X-Google-Smtp-Source: APXvYqyPnHyBGuJoh+NJ+3pT6ASbBj6PtoxndENiQzIgCCr3QXFJ79RIQGRTD/vhecBrvTaC6VhV8Q==
X-Received: by 2002:a24:454e:: with SMTP id y75mr5624571ita.5.1554128525415;
        Mon, 01 Apr 2019 07:22:05 -0700 (PDT)
Received: from titus.pi.local ([66.97.27.10])
        by smtp.gmail.com with ESMTPSA id m137sm5466730itb.27.2019.04.01.07.22.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 07:22:04 -0700 (PDT)
Date:   Mon, 1 Apr 2019 10:22:08 -0400
From:   Will Cunningham <wjcunningham7@gmail.com>
To:     johan@kernel.org
Cc:     elder@kernel.org, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        joe@perches.com, elder@linaro.org
Subject: [PATCH v2] Staging: greybus: usb: Fixed a coding style error
Message-ID: <20190401142208.GA12744@titus.pi.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Line was >80 characters.

Signed-off-by: Will Cunningham <wjcunningham7@gmail.com>
---
Changes in v2:
 - Created a tmp variable to shorten line length.
---
 drivers/staging/greybus/usb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/greybus/usb.c b/drivers/staging/greybus/usb.c
index 1c246c73a085..c09793b48850 100644
--- a/drivers/staging/greybus/usb.c
+++ b/drivers/staging/greybus/usb.c
@@ -163,14 +163,14 @@ static int gb_usb_probe(struct gbphy_device *gbphy_dev,
 	struct gb_usb_device *gb_usb_dev;
 	struct usb_hcd *hcd;
 	int retval;
+	u16 tmp;
 
 	hcd = usb_create_hcd(&usb_gb_hc_driver, dev, dev_name(dev));
 	if (!hcd)
 		return -ENOMEM;
 
-	connection = gb_connection_create(gbphy_dev->bundle,
-					  le16_to_cpu(gbphy_dev->cport_desc->id),
-					  NULL);
+	tmp = le16_to_cpu(gbphy_dev->cport_desc->id);
+	connection = gb_connection_create(gbphy_dev->bundle, tmp, NULL);
 	if (IS_ERR(connection)) {
 		retval = PTR_ERR(connection);
 		goto exit_usb_put;
-- 
2.19.2

