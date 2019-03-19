Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9232AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 17:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60D3120643
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 17:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="X2NJiHAk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbfCSRXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 13:23:04 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:43560 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbfCSRXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 13:23:04 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 58571697
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 17:23:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id IypPD8jMAumi for <linux-kernel@vger.kernel.org>;
        Tue, 19 Mar 2019 12:23:03 -0500 (CDT)
Received: from mail-it1-f198.google.com (mail-it1-f198.google.com [209.85.166.198])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 23FE6B72
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 12:23:03 -0500 (CDT)
Received: by mail-it1-f198.google.com with SMTP id 9so18024231ita.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 10:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=a7XiR+wDXrgognYXwXb8B0nOe7RqZRd0nfnoJsKowhM=;
        b=X2NJiHAkRAd9VBDr/wcDegqmJ89yx+uNFNPmERFicZ0w+vqEnMUGhCX4DcU+y2l7hg
         X9jkyV6eD4WHpBp3pl07PUDCGhkGvoFnBWLdderIakolZwmiqcL9Ms++ksFnbRYza+bt
         Kr3Bx+IF8zBGFrO2yKHQWUbsYxTxyb4IuzAyUjPnQ3uZDl/B48qN8fKuQzArqH60ar2o
         7tj3KZKFTzyb1p7lDjjVdEpFaQ44v119AuzY7v2jF6yJ2PuUcQ8yStbnBFILihareLda
         xRCUb/Dm/tsgTGiAxkpkGNwABUnyaSBz1jahgz63L8GFQ6zYwdFGSyWVnDY2iYJJ51A5
         Y8Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=a7XiR+wDXrgognYXwXb8B0nOe7RqZRd0nfnoJsKowhM=;
        b=OnxrjvxR3LdzUL6owvpEPD6CrRcshLGuZFVsCcsCGKA+JiwtdK2q7xaaRLmVvdmWAE
         gjZfFI+vxLWqkb+9VWqFqtEIHJwV6g0JiXv6/8XxBwxFu5YJzRY2jFOrOVN/d3G5U9PT
         zHaMg+ciaXOezgO8wbuJBNi8PK7rpsI5vgCApwXzPDQc6hXpjVCAtPIpUCAutUetZIY2
         av/n1bCwzknNhcRQJzWxFRanfnm+zTt9ZUQ4zgoMdLEgLQa3u9OKxbjeZjMcZ3Yg2hnO
         CNPLim1nCG1RJSr8hfmHst+eakrW98HD9PawvMOb9ZMbCe70Dwd+9rJ62NKR7H+wc6fi
         /Yvg==
X-Gm-Message-State: APjAAAULh+CEswVGnc35GvkRp5jVfu7keR4LxNWcU6lVGfXsJ8bSg3D2
        bYVouAS95TJ74rl6TnNDgTBcUDB2yfLbcVaqznZpWy56v6+KYOehYXU15v3ZfolI7uYUU0lTY8p
        +3UMAOoAJljjBssGLwM8upaBhSjKe
X-Received: by 2002:a6b:f419:: with SMTP id i25mr2302392iog.216.1553016182545;
        Tue, 19 Mar 2019 10:23:02 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyN2RkgpliXR+2WAICG/ym6JDtbn5ck2t8/j1V1okJIgqaqy6hDGHxiDzB9l6GhPIf8aTICMQ==
X-Received: by 2002:a6b:f419:: with SMTP id i25mr2302376iog.216.1553016182374;
        Tue, 19 Mar 2019 10:23:02 -0700 (PDT)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id z63sm1580893itc.39.2019.03.19.10.23.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 10:23:01 -0700 (PDT)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] thunderbolt: Fix to check return value of ida_simple_get
Date:   Tue, 19 Mar 2019 12:22:59 -0500
Message-Id: <20190319172259.8874-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ida_simple_get on failure can return an error. The patch ensures that
the dev_set_name is set on non failure cases.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/thunderbolt/xdomain.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/thunderbolt/xdomain.c b/drivers/thunderbolt/xdomain.c
index e27dd8beb94b..b1768f595259 100644
--- a/drivers/thunderbolt/xdomain.c
+++ b/drivers/thunderbolt/xdomain.c
@@ -772,7 +772,9 @@ static void enumerate_services(struct tb_xdomain *xd)
 		svc->dev.bus = &tb_bus_type;
 		svc->dev.type = &tb_service_type;
 		svc->dev.parent = &xd->dev;
-		dev_set_name(&svc->dev, "%s.%d", dev_name(&xd->dev), svc->id);
+		if (svc->id >= 0)
+			dev_set_name(&svc->dev, "%s.%d", dev_name(&xd->dev),
+					svc->id);
 
 		if (device_register(&svc->dev)) {
 			put_device(&svc->dev);
-- 
2.17.1

