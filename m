Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69AC9CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 12:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EB582067D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 12:43:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="OHZGBP1T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730932AbfKAMnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 08:43:41 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36006 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730734AbfKAMmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 08:42:49 -0400
Received: by mail-lj1-f195.google.com with SMTP id x9so5303983lji.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 05:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UljkrHErTTnMZOnzGC3cVx/3LEJEQ4UWt74UluMX0lk=;
        b=OHZGBP1TBQfvAP3vjunmLBhfNF02xeHIP7Z4YLcGpteSui6uUZ8cI8v7DR2EY9/BCx
         /3owyBaDZ2Gd2fli4JuN+3IgLGgFzsDaImq3Vsqm51EFCVUaX6ilJa2+PUc2BYjusPhN
         Dol3W59JbHgfpwUAyWr3hYt83wZJbYJzIYXTg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UljkrHErTTnMZOnzGC3cVx/3LEJEQ4UWt74UluMX0lk=;
        b=avPTPhxd0hEKAVpCmaa7xkVjK4VsXBl5aMHyxwvsI9LENL/e4A6KflMEx98HrBTTPi
         xVDrD4nSor69vhVxshM+edYwA6Nc+w6CLQ0H7GnYe/LwO+xaqcKPjuDV7/TYzbGYFi2u
         wLHJwCtG+/oD8ZID36D78bDpyroN0cuKgl60dzAXl9/nNof56QIpSde0+SBaAGdtMZt1
         lm47UBxvarlN9u2yWcTIi4U+UNbuNbuwX7s9+P+nmeqXVc8ktYpf/D8B8Y2UWSimY0KP
         RSsP/p7wqo0r4aHrR5vewwTTNyu0EWYaZGqheBQHb4OUJ1cX8dG6CTGqkym+u+D6634Z
         gpQg==
X-Gm-Message-State: APjAAAWI4nluxSjbQYOq6eIO2aq/Oq0n7XqJuJHR5R2d+y7Fjy5VxKts
        Qems6ITMwbCzh7/abLRfj4iwkg==
X-Google-Smtp-Source: APXvYqy0SISrUEfxbTNa4aExJBg3oQJd6fkt7CSidNJBY4f3WIpx0ZRsrM9/V23RU58OsjkGftFV5w==
X-Received: by 2002:a2e:7204:: with SMTP id n4mr580399ljc.139.1572612166096;
        Fri, 01 Nov 2019 05:42:46 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id o26sm2458540lfi.57.2019.11.01.05.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 05:42:45 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v3 25/36] soc: fsl: qe: qe_io.c: use of_property_read_u32() in par_io_init()
Date:   Fri,  1 Nov 2019 13:41:59 +0100
Message-Id: <20191101124210.14510-26-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191101124210.14510-1-linux@rasmusvillemoes.dk>
References: <20191018125234.21825-1-linux@rasmusvillemoes.dk>
 <20191101124210.14510-1-linux@rasmusvillemoes.dk>
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

