Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD8DC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 560AB20656
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jGdcibng"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729510AbfDPPTs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 11:19:48 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:40867 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfDPPTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 11:19:48 -0400
Received: by mail-yw1-f66.google.com with SMTP id p64so7431283ywg.7;
        Tue, 16 Apr 2019 08:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OGZxEZLdV/K30nuH8Uzzyz2QfjUn13BwzqKUuEx08v8=;
        b=jGdcibngQkLqrpkdgccUSMvwK/0UdckbFQlfgM8EDx12LVwCG9IL0sOp3OeGDGUBU/
         Oq5DCq5co7va/iZ8niqdd0iNJ9yMMoV4KZ6AIl63Lyb4KXBJkXiuMeSaxMQ7IVFgesMb
         eg0GWphf2Z5U7JBwRGZbc6hXyiEyIoEYviVgGMFs+z8SFaGMQC4zl7AjBKOvaaghBqcv
         9+0q9EoylYrpkC3UFdLlMMIdvB0CfqVE0LOErrdrwXDi4U7mj1FZ/bQiI/AfMZnlptLe
         /lDg68CnMG3QF6+W1WlF4sJff0wiH7Oe3e5bnKxukTnhACkru6+7l8JAE5xSq1GgZFDQ
         7ODQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OGZxEZLdV/K30nuH8Uzzyz2QfjUn13BwzqKUuEx08v8=;
        b=S0om7PQs9zwaESKK6bsJ9IEugn+YSRF7oi91eIzK0SuAKhJ+1CshLZmun8M/736cnx
         Jrz8zHB3bLo1cff1lXFAn6FGVix1rv4kqKLUgjZNrLR+oawl8r9SBxYWJRP0Wq5bwaW7
         8KQINC0xCNKot4AnPnqBIfOy7tEu3eHFK4Y2BOdkBY0y/bVlrL5Bgns53y1UxUTtfi+w
         pazjN298pBghEPoonVmQ7sEJpzwT+n4R9DBdcSL81hrCX9l/73rKlVNr9hGVsLAa9rfo
         k4kWYeJUnU0sL/j4DQLVmRhHTccZ+/bX5PuIooO0LrAAVYwePDrfEtwdkkqj+rWOKuwm
         jPig==
X-Gm-Message-State: APjAAAUKg8j1NEf6Td8QlCc7xEsRDBcCQzI5UBfjq005Lg90VKBnexMa
        nr+tlBT6K6QgOsWB4WJxtKs=
X-Google-Smtp-Source: APXvYqwlzj98lc+YXQ4mS1P9fmyLboiqYPy1lX5icf+/dyH2DLhHG/euQHfqp9q7yH/feh774Z+Lgg==
X-Received: by 2002:a81:1693:: with SMTP id 141mr63392874yww.448.1555427987586;
        Tue, 16 Apr 2019 08:19:47 -0700 (PDT)
Received: from nishad ([2406:7400:54:eb3:d9be:857a:cd1e:eb7f])
        by smtp.gmail.com with ESMTPSA id e136sm28357702ywa.102.2019.04.16.08.19.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Apr 2019 08:19:46 -0700 (PDT)
Date:   Tue, 16 Apr 2019 20:49:35 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v3 1/5] arm64: Use the correct style for SPDX License
 Identifier
Message-ID: <ecdbe63bea1b1d2d67db6cc577aa32bf872f2310.1555427419.git.nishadkamdar@gmail.com>
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
in the arm64 Hardware Architecture related files.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 arch/arm64/boot/dts/mediatek/mt2712-pinfunc.h | 2 +-
 arch/arm64/include/asm/pointer_auth.h         | 2 +-
 arch/arm64/include/asm/sdei.h                 | 2 +-
 arch/arm64/include/asm/vmap_stack.h           | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt2712-pinfunc.h b/arch/arm64/boot/dts/mediatek/mt2712-pinfunc.h
index 1b4cb0c55744..385c455a7c98 100644
--- a/arch/arm64/boot/dts/mediatek/mt2712-pinfunc.h
+++ b/arch/arm64/boot/dts/mediatek/mt2712-pinfunc.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2018 MediaTek Inc.
  * Author: Zhiyong Tao <zhiyong.tao@mediatek.com>
diff --git a/arch/arm64/include/asm/pointer_auth.h b/arch/arm64/include/asm/pointer_auth.h
index 15d49515efdd..d328540cb85e 100644
--- a/arch/arm64/include/asm/pointer_auth.h
+++ b/arch/arm64/include/asm/pointer_auth.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 #ifndef __ASM_POINTER_AUTH_H
 #define __ASM_POINTER_AUTH_H
 
diff --git a/arch/arm64/include/asm/sdei.h b/arch/arm64/include/asm/sdei.h
index ffe47d766c25..63e0b92a5fbb 100644
--- a/arch/arm64/include/asm/sdei.h
+++ b/arch/arm64/include/asm/sdei.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2017 Arm Ltd.
 #ifndef __ASM_SDEI_H
 #define __ASM_SDEI_H
diff --git a/arch/arm64/include/asm/vmap_stack.h b/arch/arm64/include/asm/vmap_stack.h
index 0b5ec6e08c10..0a12115d9638 100644
--- a/arch/arm64/include/asm/vmap_stack.h
+++ b/arch/arm64/include/asm/vmap_stack.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 // Copyright (C) 2017 Arm Ltd.
 #ifndef __ASM_VMAP_STACK_H
 #define __ASM_VMAP_STACK_H
-- 
2.17.1

