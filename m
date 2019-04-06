Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C27C10F06
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 12:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46F7D218D4
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 12:30:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fEnmlIr3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbfDFM3T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 08:29:19 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34926 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbfDFM3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 08:29:19 -0400
Received: by mail-pg1-f193.google.com with SMTP id g8so4546893pgf.2
        for <linux-kernel@vger.kernel.org>; Sat, 06 Apr 2019 05:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ljzmLp/Rx5JDdQ7QJt3O5yVx/BQTjqg+OOYMyi0keYg=;
        b=fEnmlIr3h70+VFRqNP9aGzq6oA0lKrThXiQwpVePWZc8qpjcKWQGdcGuQp7AlmdNaV
         F1OaiDPLdSvR4RPfeRetnNbVGyvK9wBXFT2pXGmG0j8Bph7qoT2OZbgRWHGbAgGBKihj
         fpU2lK/o3ds4MSsnahRL06aWsfRlATLq8zMVeXx4Aidu89S1hsxfNKEnq8CGD4EGTi/0
         h/Sow9VxQnJAyhQXmTN6O7AAprKsH0O2K0hUCBsGtrI07WRlx8mkmWl5nLjEWTkXOJ45
         IKqc3f03tyRUZhMm8hX+1NVv7r4LFN1LqjY4hdbn2ufIIiD/q5oDJqjbUwwd75wW+cbx
         LWqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ljzmLp/Rx5JDdQ7QJt3O5yVx/BQTjqg+OOYMyi0keYg=;
        b=RhYmVMxFzp/rrx1dnvu6qR0XjazjTDoTnGIe1AOIRg7xJ8ffMM/i01K+bOTXDRxmyj
         xyWg45Q3CwfUT/HT57ogIuAg9oQfhPIXxi0gbPncG9d/K00pWZSpZvEwQUg+bz7z/5cq
         beNWUm+mDaopu5ZevHR0PP9Ga/tjJIyqNWpAA8sV8BDbz5eWeyAkJ+03vHNFQYqUJXAX
         5Hl9PX1ZNCjXBwnF9VTJjDnWk7IGUrOhP+Zy/XaKJpE6P2poJbaO7fDlpHucpsKAWdUL
         jHgTc9MttKBxPZ+zNfYyhwCIYghoxtOn6XdaTltNd7NdD09d/uXIb58OhOgNd9PB4tw8
         PF2Q==
X-Gm-Message-State: APjAAAUrfmMgyk2FrF88hDX0zU05cYzb6dMzbRbEFDWWjVUx4mGBN2Iq
        bLmtqA0ZxTI6BmhzILv7ktI=
X-Google-Smtp-Source: APXvYqw9p2AA/ltbvwYWi/8jsyrP065X209+CvNUUi4Dt86kiURYSrIPz2Fqz5h5iz/8b3lchZTemw==
X-Received: by 2002:a63:7152:: with SMTP id b18mr17486324pgn.186.1554553758151;
        Sat, 06 Apr 2019 05:29:18 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.91.90])
        by smtp.gmail.com with ESMTPSA id p26sm55201245pfa.49.2019.04.06.05.29.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 05:29:17 -0700 (PDT)
Date:   Sat, 6 Apr 2019 17:59:12 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Subject: [PATCH] xen: xen-pciback: fix warning Using plain integer as NULL
 pointer
Message-ID: <20190406122912.GA403@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes passing function argument 0 to NULL to avoid below sparse
warning

 CHECK   drivers/xen/xen-pciback/xenbus.c
drivers/xen/xen-pciback/xenbus.c:700:51: warning: Using plain integer as
NULL pointer

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/xen/xen-pciback/xenbus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/xen/xen-pciback/xenbus.c b/drivers/xen/xen-pciback/xenbus.c
index 23f7f6e..833b2d2 100644
--- a/drivers/xen/xen-pciback/xenbus.c
+++ b/drivers/xen/xen-pciback/xenbus.c
@@ -697,7 +697,7 @@ static int xen_pcibk_xenbus_probe(struct xenbus_device *dev,
 	/* We need to force a call to our callback here in case
 	 * xend already configured us!
 	 */
-	xen_pcibk_be_watch(&pdev->be_watch, NULL, 0);
+	xen_pcibk_be_watch(&pdev->be_watch, NULL, NULL);
 
 out:
 	return err;
-- 
2.7.4

