Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 280EAC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E831820868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:29:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UN9PQL+s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729819AbfDPP3H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 11:29:07 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:36305 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbfDPP3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 11:29:07 -0400
Received: by mail-yw1-f68.google.com with SMTP id u197so7454935ywf.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 08:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CiDNzOF6FPRSsYxd0JWAZRrzI9jxs8nAYPelAU2Dl58=;
        b=UN9PQL+sf/jodUc+5Xa1Usz06GA6zvib2h9+dYGPMZbwd5mm1MS9jFU5rgmrD55FHG
         RXujflovo8ujLIwJO9aKnnkZ3vDipu2ISSXgyBgdltgCO/iMZVAiB5fjHWA+3qf4FZuy
         NTsFZg0106UB0neMFqzqiY4WC8+EDAusbelnvl6XdUOVCqqZYlBhGeTDPvrpuKA9uZox
         Zw8UAnijlbO2+tpmEPLXV16DtTzoRucREz5H7UEAVs2nj1XKIM3XrpApxxWMSHHgP7vH
         bLUv0Sc+IJrTYNFx87T9XuoNUeJqubqJJYKXnFK1RJN76XpVI+FOd3IN4nolJ6fBY/Vs
         QQGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CiDNzOF6FPRSsYxd0JWAZRrzI9jxs8nAYPelAU2Dl58=;
        b=R/1uTUtcgC7t60TbsM8qPQyIwDszzO29F1KV0WpsMWCtvUZAeykkl2IUMrfyJDwnRG
         feXQKN+B1oBCatIv3LNswTqTUvl/EdNgCzQePH/z8XBJxmXaq0voqPSUDFXxeMmBRZcM
         bi3/a9U+9hYyoEP2u+Rm5AIrIwFgiNkmfGgXfDlfA00qhPWd3pQ/p5oEB8gdxg3Am5po
         RNkGpsTC2+WmBBsLrcEntBz6ccfzK3NdRxT8oFssOAFyHaJGh8LDtIx6BR5sVTHyQGIO
         pmblyO4bmdSYp1sYtwS1KsHWuLZDzaElSppd0D8TPLVP2geTHEaXRT1GgqD0PTDnDpl7
         HIeQ==
X-Gm-Message-State: APjAAAVAY8su1QrD/sgQTO9va4Ense91GFw/+Kw15OG+80mIysQr+ZGy
        eBfdMYLBmPX9NNSCLo0GK/U=
X-Google-Smtp-Source: APXvYqyqxM7q/rqg/WGfkhul2fEDL6+6+rkvSyfNz1OIZ58lfT/a8XcrcEitNlxGJYPxRMlOSy8spA==
X-Received: by 2002:a81:3506:: with SMTP id c6mr65178291ywa.207.1555428546429;
        Tue, 16 Apr 2019 08:29:06 -0700 (PDT)
Received: from nishad ([2406:7400:54:eb3:d9be:857a:cd1e:eb7f])
        by smtp.gmail.com with ESMTPSA id s79sm15565301ywg.43.2019.04.16.08.29.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Apr 2019 08:29:05 -0700 (PDT)
Date:   Tue, 16 Apr 2019 20:58:57 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/5] powerpc: Use the correct style for SPDX License
 Identifier
Message-ID: <5c04f72569b508cd5477fa1bf15f0166d376cd3a.1555427420.git.nishadkamdar@gmail.com>
References: <cover.1555427418.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1555427418.git.nishadkamdar@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch corrects the SPDX License Identifier style
in the powerpc Hardware Architecture related files.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 arch/powerpc/include/asm/pnv-ocxl.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/pnv-ocxl.h b/arch/powerpc/include/asm/pnv-ocxl.h
index 208b5503f4ed..7de82647e761 100644
--- a/arch/powerpc/include/asm/pnv-ocxl.h
+++ b/arch/powerpc/include/asm/pnv-ocxl.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0+
+/* SPDX-License-Identifier: GPL-2.0+ */
 // Copyright 2017 IBM Corp.
 #ifndef _ASM_PNV_OCXL_H
 #define _ASM_PNV_OCXL_H
-- 
2.17.1

