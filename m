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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0445FC28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 14:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D238B206C3
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 14:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bvnbWzJ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbfFEOSs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 10:18:48 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42865 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727904AbfFEOSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 10:18:47 -0400
Received: by mail-pf1-f195.google.com with SMTP id q10so4705878pff.9;
        Wed, 05 Jun 2019 07:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=/kbLXj/2o2HvwHqCd08UzWTDA8h4P12DlInHOlJGg0k=;
        b=bvnbWzJ/IuzTHAp+GV7XYne5Np3trktMt24KYENkCeIZBrssGfAVRyqeHmraxxsC1Q
         f/gvwDzfGPHsn7OdUUjjuJex480svivtSn+QlMBOYFaNwl3pCgGVX9IC6G+ufO4xDfIt
         K98LrfRuzeTWTxuYTyYa5clUtIDlo5OiQu7DnLPvGilLyX0C40ORPFH4MMmTbH7ipiHP
         6rx2VbkLIxpMbE4vsq8GVNqV32pemqR7Lz4sB1lkxa0C+JlusxEcvfQymge3IFuOXo7s
         mnZ2QVMbPqfbYS9ECvODdvt75DfkrRAelS7dvfKaZPWyw2qHKHlFRivsU2ggvDd5nQCZ
         vqPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=/kbLXj/2o2HvwHqCd08UzWTDA8h4P12DlInHOlJGg0k=;
        b=kwGk7MwJ5NuWPhaOozVWj4gwwHzNiTscUahKOCVtqfjlH4/EvK38X+hxa3jsKjxgrr
         armegECMtrr8nSfpy1LP99fb2Ks7zQ1m2XzhBSH0VpxSveQ3cxGy4+3hlmfWwP5o9WqJ
         3QZadSl/V1MkffdRdGcAs3vbA6sTM1dDzWFXLJ2MX0szub2Ls5vraDfd4m2nHTQwUIr6
         AiJn1HwzW6++5H/BN0QK1PBxqIc634SxVg6UK9wtzgdy/5TnCPT4NL4Apn73rSz77va3
         EQO+sFyVjqJPvK4UILOO5Y1mTZ1IoOfGDY7lc33dWx8KxjRs46RcoUAUFiZ+lF6HHFLo
         8MXA==
X-Gm-Message-State: APjAAAWAvXMj9ItXHyBw73qhFIZm+ttaS8Wld57NMoMiuwCWpex+0x15
        xqG7hMmmb9+5k6AqREqzUYg=
X-Google-Smtp-Source: APXvYqwXDEYq9kiH2wKwVz0PVnlUNFr+xhEr4Q1C1Je3EEQP3udttWvv1qMXVAHIvoGJuvo52Cv1LQ==
X-Received: by 2002:a17:90a:8982:: with SMTP id v2mr44140003pjn.136.1559744327204;
        Wed, 05 Jun 2019 07:18:47 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.89.153])
        by smtp.gmail.com with ESMTPSA id j2sm26134353pfb.157.2019.06.05.07.18.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 07:18:46 -0700 (PDT)
Date:   Wed, 5 Jun 2019 19:48:42 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Colin Ian King <colin.king@canonical.com>,
        Mukesh Ojha <mojha@codeaurora.org>, Kangjie Lu <kjlu@umn.edu>,
        Jia-Ju Bai <baijiaju1990@gmail.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] usb: host: u132-hcd: remove unneeded variable frame
Message-ID: <20190605141842.GA7212@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes below issue reported by coccicheck

drivers/usb/host/u132-hcd.c:2557:6-11: Unneeded variable: "frame".
Return "0" on line 2560

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/usb/host/u132-hcd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/host/u132-hcd.c b/drivers/usb/host/u132-hcd.c
index 4a5c9b5..400c40b 100644
--- a/drivers/usb/host/u132-hcd.c
+++ b/drivers/usb/host/u132-hcd.c
@@ -2554,10 +2554,9 @@ static int u132_get_frame(struct usb_hcd *hcd)
 		dev_err(&u132->platform_dev->dev, "device is being removed\n");
 		return -ESHUTDOWN;
 	} else {
-		int frame = 0;
 		dev_err(&u132->platform_dev->dev, "TODO: u132_get_frame\n");
 		mdelay(100);
-		return frame;
+		return 0;
 	}
 }
 
-- 
2.7.4

