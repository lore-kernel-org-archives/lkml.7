Return-Path: <SRS0=CMjL=VD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,GAPPY_SUBJECT,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D33C48BD5
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 10:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F27D216B7
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 10:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U523Em2K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbfGFKzf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 06:55:35 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44388 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbfGFKz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 06:55:27 -0400
Received: by mail-wr1-f67.google.com with SMTP id p17so1088797wrf.11;
        Sat, 06 Jul 2019 03:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7bgA3KVSNsVJyluNyhiPajryn8BOsiL4nv8POO6e3hg=;
        b=U523Em2KEtwXXxdV/BGn5jTzA7rwZNHEXsm1OcyY68qXcXEIgtM7G0Cet6d7ccvPCH
         xbNCt3TDC5HduqU/DgmJHVWSZe3KHZA5S97dUyH+Nq+WuUGuXAX0ragXjruWpmzsAxwt
         ZI947WMH7fH0XqCrCOg3eUA/2YAFkYNqtSug+CIUNQQHYURAjMXd6h9N5ALvdD0NpxEB
         AK2lAV8bchfSrDSx25gT6m0BWN8JZu//SbcHOnuqBRH2eqm3G2johuskfOsaaGz6nZlh
         deThmGjYCWPUDpw151T+5llw2TOJGBzuERv8CkChSGkkIYR0JLd+dQLERH79C+pRIoUr
         14dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7bgA3KVSNsVJyluNyhiPajryn8BOsiL4nv8POO6e3hg=;
        b=nNRln7yBC7okm2wMCweZiJkf9x/qlQ9VEEaAbR+OBqtjNlMIeYblh4mB8/ALkfe09Z
         vQZQo3YMLBncXjnD/ct8ruVaqUgcLZF5cRRW7lEdcuJzTnxgJ8FZQFl68ovyAUJoQJT2
         ms14w+uR+kMXofW+n3vXYLTZZB96a8yQ2hyw6fHvSYR/kRuOEnda+wMwyhu0KljiMRgW
         L8pkvbg1WhhuuO4h8DFEcfxffUcgmFvoJp3ILjvWHznEay7E+0IE9Aa6byT/rqUmJLEl
         Wb/xJJO1Yz9fMi1rU4DJgmOCHX59bj+rndMq2RImlSnAQjaYVY56nd8L48DwgT4X8FEj
         5ryw==
X-Gm-Message-State: APjAAAWYPntvrsA4cspqBkH6mbnTacqtsj2osb0Qb3JuccEwjl9mbKSJ
        AwILX3ojkreMOQp0Ci45DFDZGgNsNNnxSw==
X-Google-Smtp-Source: APXvYqzPbEUIxunmBrxyk9NAIxCXus8RCS7gBuXZApUJVMJ6c1dTQqt5X0xbeRxaG4n4nmyktigDXg==
X-Received: by 2002:adf:e843:: with SMTP id d3mr9048922wrn.249.1562410525376;
        Sat, 06 Jul 2019 03:55:25 -0700 (PDT)
Received: from localhost (net-93-71-3-102.cust.vodafonedsl.it. [93.71.3.102])
        by smtp.gmail.com with ESMTPSA id h11sm12578794wrx.93.2019.07.06.03.55.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 06 Jul 2019 03:55:25 -0700 (PDT)
From:   Salvatore Mesoraca <s.mesoraca16@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Brad Spengler <spender@grsecurity.net>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Christoph Hellwig <hch@infradead.org>,
        James Morris <james.l.morris@oracle.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        PaX Team <pageexec@freemail.hu>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v5 12/12] MAINTAINERS: take maintainership for S.A.R.A.
Date:   Sat,  6 Jul 2019 12:54:53 +0200
Message-Id: <1562410493-8661-13-git-send-email-s.mesoraca16@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1562410493-8661-1-git-send-email-s.mesoraca16@gmail.com>
References: <1562410493-8661-1-git-send-email-s.mesoraca16@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Salvatore Mesoraca <s.mesoraca16@gmail.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f16e5d0..de6dab1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13925,6 +13925,15 @@ F:	drivers/phy/samsung/phy-s5pv210-usb2.c
 F:	drivers/phy/samsung/phy-samsung-usb2.c
 F:	drivers/phy/samsung/phy-samsung-usb2.h
 
+SARA SECURITY MODULE
+M:	Salvatore Mesoraca <s.mesoraca16@gmail.com>
+T:	git git://github.com/smeso/sara.git lsm/sara/master
+W:	https://sara.smeso.it
+S:	Maintained
+F:	security/sara/
+F:	arch/x86/security/sara/
+F:	Documentation/admin-guide/LSM/SARA.rst
+
 SC1200 WDT DRIVER
 M:	Zwane Mwaikambo <zwanem@gmail.com>
 S:	Maintained
-- 
1.9.1

