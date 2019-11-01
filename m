Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD7C5CA9ED1
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 12:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8384D2067D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 12:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="TKeI5WJ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730940AbfKAMnt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 08:43:49 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38997 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730748AbfKAMmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 08:42:45 -0400
Received: by mail-lj1-f193.google.com with SMTP id y3so10123553ljj.6
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 05:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1C8bi+Glp22eU2mPHcIIhRfHNSQMvhbk1zxbdzRB++Q=;
        b=TKeI5WJ5HApJ0bpDzJiCOE0G53vmWWtXk5nF9C/9USrhBPI9ZALZhnUbAm1tvtRMKW
         OFi9vIGQA9UR1/zZExnDHu6ZCx+LKx8j+FBnKATUCkOxnSdz0vv6wvCHXrsNus7CNMsy
         gBIDN/LX7KNsH7MZ+LmrHTnn4wCNf+69eCkN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1C8bi+Glp22eU2mPHcIIhRfHNSQMvhbk1zxbdzRB++Q=;
        b=HSofSZa6KOl73Xi+CAHnlQbA/LxLFX2CvjY69ksC0NrCEaTSDi0X1X2hrgxofX6Q1x
         YOjkRJrWWoSCxfrYO6uRerEbxblIRv6pJEAnbJ9Ae6R06DabucjWi+C41Nmt2VUYagW1
         vYINC2m6SjBkK4Bv8bEI5brAmY9NFVR/TBXiAcDv8KfkaWuaxMZ/tSkM7sLdEEVG0le7
         Vn4ay8OEBaO/QwOm+FtNcUolTZHppzimM7n/yiP2NEQvG/Ma0m+UWlG40X55RwXVAN3K
         tBwrRiOer1+T6J265W88EX7BoenyuAl9n+ZutRgP6/i/b+C5+v6AXClt6dAtiH2ySQX1
         Aqew==
X-Gm-Message-State: APjAAAUy2JrKPac9KfHr9JjE8JuO0PuixeiJfMO6rs57LGDvGkIVzUcg
        Gdr8DNKWwvg699vDpPXhkVHeDA==
X-Google-Smtp-Source: APXvYqwaR+A8MH7lH/sC0yoJ4mSYgmPfqD0xbkFeC/pa2axliSAcW4VUXOMG3J3WRdSDgDQTi8u32w==
X-Received: by 2002:a2e:898d:: with SMTP id c13mr4497954lji.54.1572612163835;
        Fri, 01 Nov 2019 05:42:43 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id o26sm2458540lfi.57.2019.11.01.05.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 05:42:43 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v3 23/36] soc: fsl: qe: qe_io.c: don't open-code of_parse_phandle()
Date:   Fri,  1 Nov 2019 13:41:57 +0100
Message-Id: <20191101124210.14510-24-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191101124210.14510-1-linux@rasmusvillemoes.dk>
References: <20191018125234.21825-1-linux@rasmusvillemoes.dk>
 <20191101124210.14510-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/soc/fsl/qe/qe_io.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe_io.c b/drivers/soc/fsl/qe/qe_io.c
index f6b10f38b2f4..99aeb01586bd 100644
--- a/drivers/soc/fsl/qe/qe_io.c
+++ b/drivers/soc/fsl/qe/qe_io.c
@@ -141,7 +141,6 @@ EXPORT_SYMBOL(par_io_data_set);
 int par_io_of_config(struct device_node *np)
 {
 	struct device_node *pio;
-	const phandle *ph;
 	int pio_map_len;
 	const unsigned int *pio_map;
 
@@ -150,14 +149,12 @@ int par_io_of_config(struct device_node *np)
 		return -1;
 	}
 
-	ph = of_get_property(np, "pio-handle", NULL);
-	if (ph == NULL) {
+	pio = of_parse_phandle(np, "pio-handle", 0);
+	if (pio == NULL) {
 		printk(KERN_ERR "pio-handle not available\n");
 		return -1;
 	}
 
-	pio = of_find_node_by_phandle(*ph);
-
 	pio_map = of_get_property(pio, "pio-map", &pio_map_len);
 	if (pio_map == NULL) {
 		printk(KERN_ERR "pio-map is not set!\n");
-- 
2.23.0

