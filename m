Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E827CC43219
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 17:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACC6C2067C
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 17:25:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BlYThYJg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbfD1RZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 13:25:07 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43042 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbfD1RZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 13:25:07 -0400
Received: by mail-pl1-f193.google.com with SMTP id n8so3957305plp.10
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2019 10:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=/nxmV2ejCLBlT2N8CFO5Chpe8WRL8/vlUabGbdVX9iI=;
        b=BlYThYJgH+3PFtVlZ3/WM6LWYdsdDy749K6hzzpF1tt+t8StrYUG5URzLGbepM8Ieo
         TV+D9aGm4fHo596hydua7SL49/68gGLviedt9Xc0WbXnqOvYEBKIN2b2ieegGMsJPGvu
         m3q09rTSBmgjYxacxaiSrnz7A7MP8cqPCa9xSw351Cy9AxQXb3XO6siltDpOG0eiP8ZD
         8BTtrSDQ0NLhXak7Cv8SF4NIX2jjmdWDhS3dNjGESnCpfkwOenUI05X0wCftr0SpCxRy
         M+N8+GltLl7SFm/qN35UB3TRjYVYhA+drhOK+Iv34H7eoNq6Zpj0PijMvUP4udfiaHXy
         pMHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=/nxmV2ejCLBlT2N8CFO5Chpe8WRL8/vlUabGbdVX9iI=;
        b=f8OTf09h50xw5ncy4fxq266ObxA9wtSL74Ct6J8A4xLEQ6CyM9eb42xbCSOI/pD2tU
         cMn7O2bgT3Dn4d2hr50J36g5uL38tQAtvbKA0/9fHXBXta2fPOY4XwvqabqxujgJCn1c
         CnqIbCrie6OAonHX+xm23Vs3kZkgZoXKC3qdMwaBEgRgtxKvyp1Epeh2C9Sxk863PFYS
         Uvx7EPUst0PCgHJicAZ0kF9GBvXzhGo6rvrFQU6iM3DZtPU62ZZabctocarOYI6Ym/f9
         b3XrUyXqP6iUAKOEB7pHVCmXVSIwmLIRZk1GYVPP09qcfohpdM7JeMBIWqv5t1PMjvdK
         zFAw==
X-Gm-Message-State: APjAAAUKmgQG2Pt9Xywyv88QdHw/KyN6qAf44u2bkAiOhuPkDiAcfpWd
        0ttA3vGTY9rP7ucBz2Qjqko=
X-Google-Smtp-Source: APXvYqzebahgIFaU/nRnZ5/IHSuoOabIL/Qhxm17X1OZwhEAivLa7nZRJB0b113/BQzBly4R0t0cWw==
X-Received: by 2002:a17:902:442:: with SMTP id 60mr58630388ple.107.1556472306788;
        Sun, 28 Apr 2019 10:25:06 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.73])
        by smtp.gmail.com with ESMTPSA id d10sm6465459pgi.6.2019.04.28.10.25.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Apr 2019 10:25:06 -0700 (PDT)
Date:   Sun, 28 Apr 2019 22:54:59 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: mtd: maps: update physmap-versatile.c file entry
Message-ID: <20190428172459.GA25940@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

from the commit "mtd: maps: Rename physmap_of_{versatile, gemini} into
physmap-{versatile, gemini}"

physmap_of_versatile.c renamed as physmap-versatile.c
updating the same in MAINTAINERS file.

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 43a9ceb..7e42422 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1151,7 +1151,7 @@ F:	arch/arm/boot/dts/versatile*
 F:	drivers/clk/versatile/
 F:	drivers/i2c/busses/i2c-versatile.c
 F:	drivers/irqchip/irq-versatile-fpga.c
-F:	drivers/mtd/maps/physmap_of_versatile.c
+F:	drivers/mtd/maps/physmap-versatile.c
 F:	drivers/power/reset/arm-versatile-reboot.c
 F:	drivers/soc/versatile/
 
-- 
2.7.4

