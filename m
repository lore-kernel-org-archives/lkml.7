Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE96FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 13:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F9D2222CF
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 13:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="btUNt8m0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729795AbfKHNCG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 08:02:06 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45387 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729448AbfKHNCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 08:02:03 -0500
Received: by mail-lj1-f194.google.com with SMTP id n21so6106070ljg.12
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 05:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UljkrHErTTnMZOnzGC3cVx/3LEJEQ4UWt74UluMX0lk=;
        b=btUNt8m0uV4K7rFRwIU8q6zzflOOAMijjQeLyfrjzcaIczK5jbDtdELyjy9dr04RD6
         VsDmKA7rt6Vd7Bj8D6PEuCjxR7+LvQCtJVl/OhH5dz/1en8np2tnjoWXw+wArp7P9bhz
         9UKoh5jfu0tbKnJOUZqtsYgj/Cn0lm7JvLu4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UljkrHErTTnMZOnzGC3cVx/3LEJEQ4UWt74UluMX0lk=;
        b=gFsU2IucWXfjvnNBA24deqUS3ugmaFh/ajE5u+YC2sarhlylTXgSvLN/YXQribpB5P
         TJQp8f5h5o9dSudvLG8+3Q7Rd/huwbJ4Rqqp41rnHgP1Mq8/96N0N1CXmiRWm8s8BfCM
         1T0GbtN6BGt02vIz+8D7NV2ySjk4HsIMSmBf15v/yEULIWP+9r6yaRo6msMPZ+hhY5aP
         LVJSasbRxw+GwVZewh1Vr8zrIhsnVdZCgmw32H+qDpvXgmtWEQ8odtQZW3D/YSEv/o+B
         ynP+lTIlKUx2kuavdSv0n2GFjkUqJ8WEknROT3WsQApKqA7SC3FcBAaCxnfFkm2JRNo4
         jZng==
X-Gm-Message-State: APjAAAVG8aoc/bzP8IjgJTZqH4NAUUj5u1nvWRVCGP5Dj+TszJ55+Uam
        23Ahp7mercC6xsX7IOSwOAzBIg==
X-Google-Smtp-Source: APXvYqxTzVF8/JKsKMHYte+9aWvfI7aAER8ibdsachcG+KIWPQShSZfW9EYappa6aFPy4j79NTv/Bg==
X-Received: by 2002:a05:651c:119b:: with SMTP id w27mr6123930ljo.221.1573218119558;
        Fri, 08 Nov 2019 05:01:59 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id d28sm2454725lfn.33.2019.11.08.05.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 05:01:59 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v4 25/47] soc: fsl: qe: qe_io.c: use of_property_read_u32() in par_io_init()
Date:   Fri,  8 Nov 2019 14:01:01 +0100
Message-Id: <20191108130123.6839-26-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191108130123.6839-1-linux@rasmusvillemoes.dk>
References: <20191108130123.6839-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is necessary for this to work on little-endian hosts.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/soc/fsl/qe/qe_io.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe_io.c b/drivers/soc/fsl/qe/qe_io.c
index 61dd8eb8c0fe..11ea08e97db7 100644
--- a/drivers/soc/fsl/qe/qe_io.c
+++ b/drivers/soc/fsl/qe/qe_io.c
@@ -28,7 +28,7 @@ int par_io_init(struct device_node *np)
 {
 	struct resource res;
 	int ret;
-	const u32 *num_ports;
+	u32 num_ports;
 
 	/* Map Parallel I/O ports registers */
 	ret = of_address_to_resource(np, 0, &res);
@@ -36,9 +36,8 @@ int par_io_init(struct device_node *np)
 		return ret;
 	par_io = ioremap(res.start, resource_size(&res));
 
-	num_ports = of_get_property(np, "num-ports", NULL);
-	if (num_ports)
-		num_par_io_ports = *num_ports;
+	if (!of_property_read_u32(np, "num-ports", &num_ports))
+		num_par_io_ports = num_ports;
 
 	return 0;
 }
-- 
2.23.0

