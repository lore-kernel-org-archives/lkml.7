Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F82ACA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 18:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A25D20862
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 18:13:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aXOPdyC7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404348AbfJ1SNP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 14:13:15 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35478 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730690AbfJ1SNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 14:13:14 -0400
Received: by mail-pg1-f196.google.com with SMTP id c8so7429906pgb.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 11:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=KooIewZwbvjOkWEaBdb5ogJ6e+TbvWJNeEYKOS8P4w0=;
        b=aXOPdyC7AweFFSfB2Js2hABhLVh569kDj2ZgxMqXyvHOioQ44WsxywP8Nq31GJ6cKv
         YUa5fMowMfM7tx0PM80F+R8UHmwYIQKqUE3grO68emWgJqvBb99ab3Ctd1d8hAFxcME2
         oER/fc54s77GQl3EKM+ZwgA/pJux/e2Z2KOd9119hrzSUIbsrFBs7ndjLvbQ4iSWhN0s
         dDcGwgVs491Pbv0m9/hJpBkU6yTXVPf/eELu2doKVz5UNWHQYh3nlbVpOjSYS4I6V1Tq
         HJPDbnBscNga+uPSi5aaQU73/uKcDNSw1erHBde1yMu7Qaijq6V+uwHCZnxJLjAtJm3w
         f07w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=KooIewZwbvjOkWEaBdb5ogJ6e+TbvWJNeEYKOS8P4w0=;
        b=ghQfmcSkwVopfPth3NSe6ovrRIexxcgWbIT+TJR5cE8bRgq1AY0EpeSvvbTEy1RLal
         ijgdnObuFWe6NcAM8zIAnQy9W12IautG3kpOqsJISPit8mchIP6jXPwgD+Sc+AoxBuu/
         AXErHkDbGvZ0Ixbs/a8kN4hYFr1iK1wyVl1pBDf0vOczXrqQhVW+vRhapI5oJrTk1c81
         HJTuB/PYENWwPpQrzvnWyAEM3ypJo/kFxwp9krWDc1wJ7WMz88BQUTIMKmqBM5fU1oPb
         /aLiMJQPBg0slK0H7q1dLSVmhSMfsmmxYysNul6smw9E+QoMfOfvKoFQ3rNRJSbJ3GvX
         0Qvg==
X-Gm-Message-State: APjAAAVF525DmMBQOI1Utz2UzEENuqjQPYgPCWVpQccx3y5sG8rVQhWd
        BTC8Fi0lRxI37YkHeybAELY=
X-Google-Smtp-Source: APXvYqzHPPHColxTNgsQHdD5XILpojNAlx6D2TKkfWzX4v+PiR9dJvyKzns3v8vgG8I/ERhrikrQ0g==
X-Received: by 2002:a17:90a:2369:: with SMTP id f96mr664908pje.127.1572286393809;
        Mon, 28 Oct 2019 11:13:13 -0700 (PDT)
Received: from saurav ([27.62.167.137])
        by smtp.gmail.com with ESMTPSA id g38sm17039156pgb.27.2019.10.28.11.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 11:13:13 -0700 (PDT)
Date:   Mon, 28 Oct 2019 23:43:01 +0530
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     joern@lazybastard.org, dwmw2@infradead.org,
        computersforpeace@gmail.com, marek.vasut@gmail.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH] mtd: devices: phram.c: Fix multiple kfree statement from
 phram_setup
Message-ID: <20191028181300.GA26250@saurav>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove multiple kfree statement from phram_setup() in phram.c

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---
 drivers/mtd/devices/phram.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/devices/phram.c b/drivers/mtd/devices/phram.c
index c467286ca007..38f95a1517ac 100644
--- a/drivers/mtd/devices/phram.c
+++ b/drivers/mtd/devices/phram.c
@@ -243,22 +243,22 @@ static int phram_setup(const char *val)
 
 	ret = parse_num64(&start, token[1]);
 	if (ret) {
-		kfree(name);
 		parse_err("illegal start address\n");
+		goto free_nam;
 	}
 
 	ret = parse_num64(&len, token[2]);
 	if (ret) {
-		kfree(name);
 		parse_err("illegal device length\n");
+		goto free_nam;
 	}
 
 	ret = register_device(name, start, len);
 	if (!ret)
 		pr_info("%s device: %#llx at %#llx\n", name, len, start);
-	else
-		kfree(name);
 
+free_nam:
+	kfree(name);
 	return ret;
 }
 
-- 
2.20.1

