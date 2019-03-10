Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2ED6C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 13:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2C9E2084D
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 13:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cdiWmcAK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbfCJNfk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 09:35:40 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:41143 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbfCJNfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 09:35:40 -0400
Received: by mail-wr1-f44.google.com with SMTP id n2so2198473wrw.8
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2019 06:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=dJ+izyAvBoNsJoCYKxWa+TqdQdOvtC1yiWpCu+r5xaY=;
        b=cdiWmcAKtwYN4DjMSnilvEMUH+e0Z33aolBWcwE3SvY+JFlC4XNII5IWuLAjC89meK
         FWUjXI3vgEKkj73kSy4Al0L2WNc5W65zvPDiJysMtAtdPm6s5fDBt+asSM6gXcZd873w
         4Mml0EabCi0uCUk8PV1LVmCefoQwnM/BZWKKsAyDjxaLW9SMUWfia2jAxZgaKpH1f5gp
         SVnbODGqmzS/fy7JF9L7cZyTAJ/uSSjj8ihff8ySbpHyAiKoY02rloSGsYZGY3JnfLUV
         q/2gj4V8l3vDvuKbWzxhKWvlRZdQOGwLR2FgpTL0hVWutChsz1qiAso2MHBrvko1cKBl
         C2Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=dJ+izyAvBoNsJoCYKxWa+TqdQdOvtC1yiWpCu+r5xaY=;
        b=OxFjS2aicGXjw2l8aIMffb+H4n13l4Kn2qa8MU0HLeZQLgWzGbtHWGNidnkC2V0ur7
         ctwY9CJppkG5/nnB+xvOdgH3zrCjV/9WIGREqrz/FozvAYF0PqZWrWYCYKIVUH8rmw7Y
         ONNsfjYRT9xpVbzQ7wBiky6XmbNPm6LMqY+A7kF1sEyCG21Vz8P2KqHQcfB/sbcWo/vG
         A9hz2H+vHs2g1Bml+YXx8CeqTG6wuTTpfh1LxWpvjon9JIwV3M0ILMgN78r71B8nmkFb
         rT/6FZ11B3fkJD4fxR1DWWGP0EdNoiwI0kuR8ol7GTangEUQfZpqvKh1XsifFtm2xrzp
         NcLA==
X-Gm-Message-State: APjAAAVrfjZyktvpmw/JkidOGdcOB9dwKBwjDjnyc10eh+PqFxmLWadp
        EfyNNnXDJ+zz+qhemOgZDT5E8T0=
X-Google-Smtp-Source: APXvYqzmowPjzjTHUaEaOyLax2fxGz3INXjP2T1qxWAjQ/KTvJXnPGEsB/iuTunBarqdkS30h8IZWQ==
X-Received: by 2002:a5d:690d:: with SMTP id t13mr16700138wru.135.1552224938580;
        Sun, 10 Mar 2019 06:35:38 -0700 (PDT)
Received: from avx2 ([46.53.246.68])
        by smtp.gmail.com with ESMTPSA id c1sm6561241wrw.7.2019.03.10.06.35.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Mar 2019 06:35:37 -0700 (PDT)
Date:   Sun, 10 Mar 2019 16:35:35 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] Drop -Wdeclaration-after-statement
Message-ID: <20190310133535.GA20473@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Newly added static_assert() is formally a declaration, which will give
a warning if used in the middle of the function.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 Makefile |    3 ---
 1 file changed, 3 deletions(-)

--- a/Makefile
+++ b/Makefile
@@ -792,9 +792,6 @@ endif
 # arch Makefile may override CC so keep this after arch Makefile is included
 NOSTDINC_FLAGS += -nostdinc -isystem $(shell $(CC) -print-file-name=include)
 
-# warn about C99 declaration after statement
-KBUILD_CFLAGS += -Wdeclaration-after-statement
-
 # Variable Length Arrays (VLAs) should not be used anywhere in the kernel
 KBUILD_CFLAGS += $(call cc-option,-Wvla)
 
