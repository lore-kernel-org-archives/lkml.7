Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E63C8C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 09:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACC0321743
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 09:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9vlX7kV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbfEUJ3x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 05:29:53 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34931 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbfEUJ3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 05:29:53 -0400
Received: by mail-pf1-f194.google.com with SMTP id t87so8771826pfa.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 02:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ZKWnUydwFd4s05EBLm5iMxF297ZzlKXFCehjvJXWjk8=;
        b=e9vlX7kVoNvwUUcgwDBY5fB667kO9XBHwD8KpydyKQAaX0klw9kT36dKV69vqYcvCS
         19Rgy+GqZF/oC+7GiIO3TAM98YLtCG64As89C8aBihLH5Vpx+9MflgDEvkEvsmVwTgtV
         NjvbORswyRC2C/WqtyIFvWK8aAOSOSYRsWjRTQ6sMmk148bdOCg7hetsaoJX3M58FGIm
         Zi3zSQkuRa2hSqVNTTV/b1bba2R/CV1LJQEE0QG3rDHunOllqDvzmJVKZbi4oYEIrTP0
         xnDEg9BXPC69PnpL1Do6tpOgGBN1xRl7XZOZyWW/YUn8y4KVnrPHgAACJxsBIYWdnxBf
         PPNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ZKWnUydwFd4s05EBLm5iMxF297ZzlKXFCehjvJXWjk8=;
        b=D8Hm8Gs7OsYbeGCg6fiE//5aa1KxyVw3Ci7NjbhzzfdAqqJ3JDFWXYq1ixOwpwsver
         S+WS+xlq1hTX23auK/BSfPyLmqfAUg/Nh1+A+EY2gl6hY0gVzv+0mojmxCH/Zse50WL1
         ocjd1ZfOON686oKlGZ9BkT8o+WpjBKcg1WhGxQlimnqZL0sOCexZs1TGyfaKzzpBCQ+K
         L/uzIRAMET8sfT5+IJKVAXuqWxFTmPdnz3xfNlyn41rYMxV1weiyfx/BKImi6KZtsP67
         0O59VZFCzQld2JzMbEGxTnE9idWzJDMSpqvXcGIarfkT+1PDXNuIdzSKLq0yyLAg7nih
         fH5g==
X-Gm-Message-State: APjAAAUNzAvZTIBnZinK2nm+09SbWjPSymzMFCdvICw/z5KdcBDHWZy/
        K8bzb6FFbRW65vN3BIfTnNFQLNCBJ+A=
X-Google-Smtp-Source: APXvYqzlSQC+YZ+UGNJK8+c6TSAy6P94Vtm61zQ7fh1tJxdmVuDb9fscPci2+HrOD3rmKFf0v/rCwg==
X-Received: by 2002:a63:495e:: with SMTP id y30mr37856765pgk.185.1558430992855;
        Tue, 21 May 2019 02:29:52 -0700 (PDT)
Received: from zhanggen-UX430UQ ([66.42.35.75])
        by smtp.gmail.com with ESMTPSA id s80sm55935631pfs.117.2019.05.21.02.29.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 02:29:52 -0700 (PDT)
Date:   Tue, 21 May 2019 17:29:35 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     keescook@chromium.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] consolemap: Fix a memory leaking bug in
 drivers/tty/vt/consolemap.c
Message-ID: <20190521092935.GA2297@zhanggen-UX430UQ>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function con_insert_unipair(), when allocation for p2 and p1[n]
fails, ENOMEM is returned, but previously allocated p1 is not freed, 
remains as leaking memory. Thus we should free p1 as well when this
allocation fails.

Signed-off-by: Gen Zhang <blackgod016574@gmail.com>

---
diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
index b28aa0d..47fbd73 100644
--- a/drivers/tty/vt/consolemap.c
+++ b/drivers/tty/vt/consolemap.c
@@ -489,7 +489,10 @@ con_insert_unipair(struct uni_pagedir *p, u_short unicode, u_short fontpos)
 	p2 = p1[n = (unicode >> 6) & 0x1f];
 	if (!p2) {
 		p2 = p1[n] = kmalloc_array(64, sizeof(u16), GFP_KERNEL);
-		if (!p2) return -ENOMEM;
+		if (!p2) {
+			kfree(p1);
+			return -ENOMEM;
+		}
 		memset(p2, 0xff, 64*sizeof(u16)); /* No glyphs for the characters (yet) */
 	}
 
