Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A77C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 18:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 598CB206BA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 18:11:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UdfppBST"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbfCDSLD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 13:11:03 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34173 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfCDSLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 13:11:03 -0500
Received: by mail-pf1-f193.google.com with SMTP id u9so3584036pfn.1;
        Mon, 04 Mar 2019 10:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=USr+8DchtgQAKvqC+vx72J7v5ABxyQfinPP+jg8upbo=;
        b=UdfppBSTftpQThDN1KeH0N4jgR/qKwu8jrqAeyrbVakzRUmexzGiJA1rjSVaVZ7/DT
         5zSo33W/lSjGG/gqsWgOSPumidEQDa2zSAO/HOTu+AA3K5FEigX0Tu7w1rqnQYbYzjJN
         8PxcODm8kwdPaAWo8f1k//aXlGl2kJaQ5m7kP/bMguBktqTEH6sKQzsVBJqtkXDMa5rJ
         l0UDssYdbf1R7722yKbivIWuzCcqXByG3LFLILNH9t4ccHgJ7YLzFW9goTH9tNcAXP1g
         2wWQGAc8db3MFUFvTd0u1ooLF5zskLz+TiCA4Mw6pjspgog3yOv2gwtqN+d/P6YXdWeh
         AHHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=USr+8DchtgQAKvqC+vx72J7v5ABxyQfinPP+jg8upbo=;
        b=d5XqW/Y8iXP7uWyrZGAg4EiBVMOcymqAd4ugd1UTNJ8fNJyXLFLPxbik/rrfsxG/Qh
         rF0UCJc30mWy9CFUoAJ9c3PvcPCIgLXBtSgwlUF69RVp1BCunYv2vpLtR+eY+jKaGC5Y
         HfK2wWwks4ts0hHzV/r9C+JuGFi7JDaKwUm/Wd4j/s2GrQBhqIxF+OAP/1mJms/ZEM7k
         dH0w+5OuQ1XKLhbwTzoQNimW7WAY5UBAWQC3Uju8dZ4xjwVWS0aEpfExjFq54eTFN2+n
         Qq1IGMVz/LpwZxj2IwbYhygrbdiJBycn+NPSSg98RsLd6Mv6v7y+3s3NpIO/iNBp+BjR
         rNKQ==
X-Gm-Message-State: APjAAAXwkZrRxR5WKQNWyxoSXcu4dnnTFAzeZZcSlaLTj/ttcoJJxVg7
        UJwoLL0nT98L7NLdd6fAmp0=
X-Google-Smtp-Source: APXvYqwGfoNYymMtTFG/ojdAgfkL1CGXEiw5Mdpi703Y5o+LFzKcCTVaAHF0YKzWp1BcTC5R44FmNw==
X-Received: by 2002:a17:902:2884:: with SMTP id f4mr21587316plb.203.1551723062481;
        Mon, 04 Mar 2019 10:11:02 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([106.51.18.146])
        by smtp.gmail.com with ESMTPSA id f193sm10153676pgc.3.2019.03.04.10.11.00
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Mar 2019 10:11:01 -0800 (PST)
Date:   Mon, 4 Mar 2019 23:45:29 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     bamv2005@gmail.com, shuah@kernel.org
Cc:     linux-gpio@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, sabyasachi.linux@gmail.com
Subject: [PATCH] selftest/gpio: Remove duplicate header
Message-ID: <20190304181529.GA6500@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove duplicate header which are included twice.

Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 tools/testing/selftests/gpio/gpio-mockup-chardev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/gpio/gpio-mockup-chardev.c b/tools/testing/selftests/gpio/gpio-mockup-chardev.c
index aaa1e9f..d587c81 100644
--- a/tools/testing/selftests/gpio/gpio-mockup-chardev.c
+++ b/tools/testing/selftests/gpio/gpio-mockup-chardev.c
@@ -12,7 +12,6 @@
 #include <unistd.h>
 #include <stdio.h>
 #include <stdlib.h>
-#include <stdio.h>
 #include <errno.h>
 #include <string.h>
 #include <fcntl.h>
-- 
1.9.1

