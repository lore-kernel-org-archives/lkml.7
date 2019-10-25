Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4697ACA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 12:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B85721D71
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 12:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="fN9FLv1T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504565AbfJYMmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 08:42:10 -0400
Received: from mail-lf1-f44.google.com ([209.85.167.44]:38561 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504548AbfJYMld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 08:41:33 -0400
Received: by mail-lf1-f44.google.com with SMTP id q28so1629594lfa.5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 05:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qFJ5knvRmhJ/ykv6ig7dLhGdF7aP5T5p7rUQ0Zs3NtI=;
        b=fN9FLv1TWt9RmdqJPXYJ1BSICN8810u9B90Dtb66/JKKA8kMmjNMG4Z/Vi2NepiVHv
         U71PRBKlbkRbFHhqbC5PMO652qEYoi77kvUe0e46Ve9Kh+Xpu4hungqtf/54qh0BBEAR
         F9UUwkQt99O82HP3vUEdNXGLHMuCUCABaicHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qFJ5knvRmhJ/ykv6ig7dLhGdF7aP5T5p7rUQ0Zs3NtI=;
        b=mPFYgKyaCm/3dpHLSskfNRvU6+23/s5a+JhqaSktd2ZzGVJF2ebluCCNcQzYpwcKU3
         /mD5rcJ2tzMpGLOVIwndY8Huo1B8fQjSWM5jWv2CgZKm3MoGEF8Ztb3uLIbqO2VBDU5a
         iWHL+9A/7g3/iIdHMjrhormsfvpmRuvi2uaKcQybK1NkErVkc8upPRzYHpDYHzS+GFAm
         M5tULFxDkwZuKzlfTK5GSY2oGAOV1i10aL8jQiZ+PdsfnklyNAO/suWWmUvC9zE/h2He
         mqwjztoDgEHTzdgJ19BdDQ9Hf8YxkS6zYz3f2PAsBMFOOuvTr1UeL/H5jW63QXdXagrx
         s4lw==
X-Gm-Message-State: APjAAAUl07Czk3yiXooZRSBefCLvan8WXFNAwNgYJtvebSO507oJ8GiD
        QI507DVsaPYnkaMQQqtrJf2P1A==
X-Google-Smtp-Source: APXvYqwTKAlx+8gqS83r5t1J60mX4EbEf9p/r/d9BH0dUVal/pLCp3KxgEe9mUFMqZVTpXniZZQs0w==
X-Received: by 2002:ac2:55b4:: with SMTP id y20mr2600154lfg.173.1572007291311;
        Fri, 25 Oct 2019 05:41:31 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id 10sm821028lfy.57.2019.10.25.05.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 05:41:30 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>,
        Valentin Longchamp <valentin.longchamp@keymile.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v2 22/23] soc/fsl/qe/qe.h: remove include of asm/cpm.h
Date:   Fri, 25 Oct 2019 14:40:57 +0200
Message-Id: <20191025124058.22580-23-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191025124058.22580-1-linux@rasmusvillemoes.dk>
References: <20191018125234.21825-1-linux@rasmusvillemoes.dk>
 <20191025124058.22580-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

asm/cpm.h only exists on PPC, so this prevents use of this header on
other platforms. Drivers that need asm/cpm.h (and are thus inherently
PPC-specific) must include that explicitly.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/soc/fsl/qe/qe.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/soc/fsl/qe/qe.h b/include/soc/fsl/qe/qe.h
index c1036d16ed03..3768c226490e 100644
--- a/include/soc/fsl/qe/qe.h
+++ b/include/soc/fsl/qe/qe.h
@@ -17,7 +17,6 @@
 #include <linux/spinlock.h>
 #include <linux/errno.h>
 #include <linux/err.h>
-#include <asm/cpm.h>
 #include <soc/fsl/qe/immap_qe.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
-- 
2.23.0

