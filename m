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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02461C46460
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 17:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D125320883
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 17:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="he3iEBP4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728820AbfFERLy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 13:11:54 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34876 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728577AbfFERLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 13:11:53 -0400
Received: by mail-pl1-f194.google.com with SMTP id p1so9917913plo.2;
        Wed, 05 Jun 2019 10:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=v+XL33nKKgLzcxRQhQhEGC6TDQvccYp6B7En+erV9hc=;
        b=he3iEBP4RwmWS2hsetYGcIfsHu6mjuFkNE/44bYCJIdQvaLJ5hco7f4N15KuvI7SzQ
         25V3oruilcb3EeYf/ho6mZJ9iD6cz8kqD0+GetH8bQbbWBN5P24cxJeCd7t7/jU36hUY
         MDXKNPnZRKk7pFFlXKbDleNfv1Mw18jufPZqLDyD6LE9H15h1K9PpOsY+lSbK6n2xpal
         MhWAlKKok5LqzYIausi5764vbJYDiQynYgbAttuI+ntxphashbZoxe0QLMIOevq4o9ku
         QG4lcSVhdK16awf7duEkmsxk6iS/fC5xR4UwEkamihST27EwoH9MnjbxiBylEI4d5Yjt
         em1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=v+XL33nKKgLzcxRQhQhEGC6TDQvccYp6B7En+erV9hc=;
        b=kCUjv+mLUJh2DrhnOqp3gsZ6mBOXDtuzoKIHDV5jztvCWLaI9FDQP9cMtUUpyUOKTL
         LVuopVhfzg/zC4XQu9Pc6Y/hrC4TQt9lK4sAhuauyV6dgMXB6rrgTBONgGk9UMbis4Tb
         LRXq63EqDzDlU7HyyQW3r9G3GjyaWgFh9iS+EYr5GMutz3MG/7JYDNg/WRAgJttmZTw+
         8pN8XvDNjkrrrSGG8vjLVyEPyVYc+9Ioe6rZlCxa2ER90MrRk5NWZGq50qrPoIF+MozT
         2NrQo6rR3gPoPPkko/qTVPY4vVskfbdvARyc9sA05N7bY6tWrDL8EsRuchxxM9gX7M+9
         w4WQ==
X-Gm-Message-State: APjAAAVsAfFa5Uu20Xd2CONvAhL8TD6sSV7dNGxBKH6gjp4tBH5xCtnr
        fLv6+dm5KvBZbOBx6Ksxcv8=
X-Google-Smtp-Source: APXvYqwwDdrTNaphEd6GlINLgVtsrsKLUvrt8xyInFHL1cnGX/XoAdjjv8uPV+gD1gxuOOddS/d0Fw==
X-Received: by 2002:a17:902:d916:: with SMTP id c22mr19896662plz.195.1559754713050;
        Wed, 05 Jun 2019 10:11:53 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.89.153])
        by smtp.gmail.com with ESMTPSA id j20sm22027968pfi.138.2019.06.05.10.11.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 10:11:51 -0700 (PDT)
Date:   Wed, 5 Jun 2019 22:41:47 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: gadget: musb: Remove unneeded variable
Message-ID: <20190605171147.GA9558@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix below warning reported by coccicheck

drivers/usb/musb/musb_gadget.c:1088:6-12: Unneeded variable: "status".
Return "0" on line 1121

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/usb/musb/musb_gadget.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index ffe462a..2cb31fc 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -1085,7 +1085,6 @@ static int musb_gadget_disable(struct usb_ep *ep)
 	u8		epnum;
 	struct musb_ep	*musb_ep;
 	void __iomem	*epio;
-	int		status = 0;
 
 	musb_ep = to_musb_ep(ep);
 	musb = musb_ep->musb;
@@ -1118,7 +1117,7 @@ static int musb_gadget_disable(struct usb_ep *ep)
 
 	musb_dbg(musb, "%s", musb_ep->end_point.name);
 
-	return status;
+	return 0;
 }
 
 /*
-- 
2.7.4

