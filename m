Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B500C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 13:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05438214AE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 13:32:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YuzG+9hm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfCMNcb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 09:32:31 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39377 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbfCMNca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 09:32:30 -0400
Received: by mail-pg1-f195.google.com with SMTP id h8so1539104pgp.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 06:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=/sGN5rWhNT/1XcsmuvVvFMgLwf5CxtYmDDVPyrioWlg=;
        b=YuzG+9hmJ7QnpE4MTCovUXbsVvby7HHLgSyqpEjBA2Ol7CFqsfXqlA9b76ZglBCYBA
         E2F5nFzweIhUPl1gVf1xTQAQGWAfPber635fzdh6A+ejIljk7peZRMMXksmUoRjveHOH
         Pt3iICi+cjyJOQiI0hYsAa4KiuzFPsUEN+W5l2JJapzE1KaFsKP78l+Ols5DsOzIDnBj
         fHQcTUoYA8HnUYU/k196yj8aLmltb4BJSjZd/SElFEtZ8HV5YKMxpWn/zfqOVaVFbp6c
         uAoaFk/FZMXOubJ8h6RHcn5HCJw5EsnTw0pnjZn3OrG44wsV6gRuBrkFoDOuhytRbGIr
         GJ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/sGN5rWhNT/1XcsmuvVvFMgLwf5CxtYmDDVPyrioWlg=;
        b=Xyb4UO9R9o89ia8RtI3RZFwKTWExAvG1kZC/PWtOhgExx5/K7DtMkEWVJSSTQmD1s+
         c9S0DkZw9gS7NIar0v1be1gJsZbZc6raSUPGjuQ4gOiQlaTHlbLHn+5xFYRRv1+nEk13
         mHDM2luZLbxkAmqOUpSBDFH4jqcGQ7RdH8wc7niD8WWqMXov523tufifxXH6nVAZY17Z
         RZ/f9KrSRs0ugNSyzYvkctxNrzCEVGI8cCVogYMFBmhNgGbZq40kJtb71834b+QqJ6i2
         apVoZ5QFO0D1aMbq+MXaw/FXSWv+E39e932DEeENoO4bAL8S0LbAzFXd3W+r/hyTM4aX
         jnpA==
X-Gm-Message-State: APjAAAU5DwwmvZ/dhCkNvt0fsh3ETv6K1rhIRNDhnLQuyrJwi0h5JOGY
        /Ruh9yCh4JyHYtCnS9VaW6s=
X-Google-Smtp-Source: APXvYqzyvv9NNyMr3zrF4WF3wBlc81/Bue9cAv4Siqmk19qpFo3sh+Fxr4JWRF4adlorGz/+quvT1w==
X-Received: by 2002:aa7:9211:: with SMTP id 17mr43761282pfo.220.1552483949784;
        Wed, 13 Mar 2019 06:32:29 -0700 (PDT)
Received: from test-System-Product-Name.sunix.com.tw (114-36-231-127.dynamic-ip.hinet.net. [114.36.231.127])
        by smtp.gmail.com with ESMTPSA id v12sm17742173pfn.25.2019.03.13.06.32.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 06:32:29 -0700 (PDT)
From:   Morris Ku <saumah@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     morris_ku@sunix.com, linux-kernel@vger.kernel.org, arnd@arndb.de,
        Morris Ku <saumah@gmail.com>
Subject: [PATCH] respond:Add header file,Kconfig and Makefile
Date:   Wed, 13 Mar 2019 21:32:18 +0800
Message-Id: <20190313133218.14568-1-saumah@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,
Thanks for review, my replies are inline:

Signed-off-by: Morris Ku <saumah@gmail.com>
---
+On 3/8/19 4:35 AM, Morris Ku wrote:
+> This patch add header file, Kconfig and Makefile.
+>
+> Signed-off-by: Morris Ku <saumah@gmail.com>
+> ---
+
+> diff --git a/char/snx/Kconfig b/char/snx/Kconfig
+> new file mode 100644
+> index 00000000..86f38352
+> --- /dev/null
+> +++ b/char/snx/Kconfig
+> @@ -0,0 +1,15 @@
+> +# SPDX-License-Identifier: GPL-2.0
+> +#
+> +# Character device configuration
+> +#
+> +
+> +config SNX
+> +     tristate "SUNIX Multi-IO Board Drvier"
+
+                                       Driver
+
+> +     Driver for SUNIX Multi-I/O Board device driver Based on
+> +     drivers/char/serial.c, parport_pc.c, ppdev.c and lp.c by Linus
+> +     Torvalds, Theodore Ts'o.
+
+kconfig does not like those 3 lines above.  That indicates some lack of
+testing.
+
+They could be put under "help", but they really should just be deleted or
+moved to some source file if you think that they are needed.
+
ok , I'll delete Kconfig in next version.
+
+
+> +     help
+> +        Say Y here if you have a SUNIX Multi-IO card.
+
+Indent with tab + 2 spaces, not 3 spaces.
+
+> +
+> +       To compile this driver as a module, choose M here: the
+> +       module will be called snx.
-- 
2.17.1

