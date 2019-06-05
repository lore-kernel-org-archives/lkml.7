Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC86C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 12:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BE812067C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 12:04:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u4sQgWBW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727636AbfFEMEd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 08:04:33 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34256 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfFEMEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 08:04:32 -0400
Received: by mail-pf1-f195.google.com with SMTP id c85so5926859pfc.1;
        Wed, 05 Jun 2019 05:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=S+XpAYVTNEx0HO/g/90uUe+i0p6WBLVE9iQHDtvUdEM=;
        b=u4sQgWBWTKkH+kT7wbqPOjkD7r12dH61vE0NijxUqFrKerrNHKD8CuocovAOw+e7UC
         uUrvMY2dSpoo3zCcYpPhkiRuv+3qIntnyg4CH8l1bDSi8P+SRcLYByOVFbzsbgsIlla2
         YhlDA6CnOZWtLmYvXKS3WOpsGwr1r/qpD7EOxuazGPxUyzzhHiXZF+QJjCZ5okscTaQn
         8AmOEXowuYaa8VwZcZioE0CGuana8UyNq+vK5pP2T9V7gs10NqED5slesaicfXyqST/i
         HXS2VRex+r+vIDW3w8N1REl+cqoYhxhliPewyVqkh0uDEWG+VYAq9y3K35vz7yYR+bIP
         jfew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=S+XpAYVTNEx0HO/g/90uUe+i0p6WBLVE9iQHDtvUdEM=;
        b=WCatRfWu01gaexEyhMzkBe2jRW6VXZ4fnEPFLS34Akr1DiuIJi7KwFCstsYufsbJa9
         X7AvuSk7jHKz9w4MoYvS1+SbggjxNmWlqjOHSXCTF0qgjyXiv9Eb98d+I26sCUZbB5rN
         uZ3nqpN4u4YjfuSCrH14CLIV5moOMYFyBuxxIS52hUx+KxflId4lBE7Kj/zw6jWTqTex
         55JONL0+FI3SBJzjyzxJPbTGVs3hTxH/sEk9js7PWB9m2xKzrji4cSF28EZtcrX5ONpQ
         6IlvEFhrb3cddsrSZ44bY7G/8+Cmwx7M5L5K0vWjykvxLI/d3/2kx4rx00M5Ea7t5Phs
         hOkw==
X-Gm-Message-State: APjAAAVt0N2u+eJTBOIiYH0mkjHA9NbA5LvBxqK35TEvl8O5yXZeK8Zy
        UDSGIG83T0NLywCccbETJC0=
X-Google-Smtp-Source: APXvYqwdDbBf+Zzh7fseqzt+LXp8OuJI9Pty2uvRNXsxW0sbxqQ4IwerZVHmOnqFq8HdhiVQlPFi5Q==
X-Received: by 2002:a63:fc61:: with SMTP id r33mr3815637pgk.294.1559736271942;
        Wed, 05 Jun 2019 05:04:31 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.89.153])
        by smtp.gmail.com with ESMTPSA id l1sm20407719pgj.67.2019.06.05.05.04.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 05:04:30 -0700 (PDT)
Date:   Wed, 5 Jun 2019 17:34:25 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] USB: omap_udc: Remove unneeded variable
Message-ID: <20190605120425.GA4375@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the current implementation omap_udc_stop is always
returning -ENODEV.

Added changes to return 0 and remove variable status.

Issue identified with coccicheck
drivers/usb/gadget/udc/omap_udc.c:2106:6-12:
Unneeded variable: "status". Return "- ENODEV" on line 2128

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/usb/gadget/udc/omap_udc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/udc/omap_udc.c b/drivers/usb/gadget/udc/omap_udc.c
index fcf13ef..f36f073 100644
--- a/drivers/usb/gadget/udc/omap_udc.c
+++ b/drivers/usb/gadget/udc/omap_udc.c
@@ -2103,7 +2103,6 @@ static int omap_udc_start(struct usb_gadget *g,
 static int omap_udc_stop(struct usb_gadget *g)
 {
 	unsigned long	flags;
-	int		status = -ENODEV;
 
 	if (udc->dc_clk != NULL)
 		omap_udc_enable_clock(1);
@@ -2125,7 +2124,7 @@ static int omap_udc_stop(struct usb_gadget *g)
 	if (udc->dc_clk != NULL)
 		omap_udc_enable_clock(0);
 
-	return status;
+	return 0;
 }
 
 /*-------------------------------------------------------------------------*/
-- 
2.7.4

