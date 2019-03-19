Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F371FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 17:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C08A820872
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 17:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="DXaVduub"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbfCSRV2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 13:21:28 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:41546 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbfCSRV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 13:21:27 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id B35F341C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 17:21:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id rikP_jpNdU-E for <linux-kernel@vger.kernel.org>;
        Tue, 19 Mar 2019 12:21:26 -0500 (CDT)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 855913A
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 12:21:26 -0500 (CDT)
Received: by mail-io1-f72.google.com with SMTP id b16so12714012iot.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 10:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=jcq47gIQYwVBKKJUjwGv/3iAtyAFKlubtbGYph1Yq0U=;
        b=DXaVduubEW6XgsIb6WW7RBdJVnVJ7vDPe42L3s0Mc6gE/eVl/sAXQzyLKtiiUfgCbd
         4MA6n0o6Nglg0Mz8HuDi52nx8/Qi5CpM+OaRcEfAq0MTsQCjvsj3lrYEJtn2c+1cIHvR
         eWNA4pe4k6ccLX3t88NmMUeFpUrU5/Gu2l98elK/enTkyFVWKqufRNuCaNS36tgjfxEX
         t2sSAlgWVbN4oNRsceg8iG32gJEZVuZ9CRxSSeMh3x6kdyMGM5M0MYnPQzFLqMLobIi8
         ej7leHfZjF6UZh0JoYUmOXXtc8PrKH3VCM6qNDWJB5/APiDbCJrrgQU780XFy3/oeIuP
         rAmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jcq47gIQYwVBKKJUjwGv/3iAtyAFKlubtbGYph1Yq0U=;
        b=U2yjpNhWnzZQp1j3GrR32k4IX0FpB8P0d/vVMo5/RhDBwriZnnxkzCTzZ76bQi5GBD
         LGhlFfywxmVGyLnblpyQ5yBg3YkkqS4lPkW/TleyK5tBQtjH3kgeIlIFHgMiRPdiRyi/
         cY5FfEdBzyPYH0/Nk3TeLmBQwYn7D6PVZxMUYHunFytzKScXmDaKvXN0UEA2sM0iJLMD
         shdCWceq+714NFhLey7Jk7S0S1I5GC8CpYfmRiJc3S4Z/z5VnSed2ZIVtcm8Rx6m+v1e
         Tzfcfn+6IPRFcuN78VTeSOd5Le7TzJx08HoyPxuFiyNEN98GkDfkgsetrVW8kZTUMKQP
         6H7w==
X-Gm-Message-State: APjAAAX8e2zcR/kDIJgyApu5tOmA4dVHq9tLIS9b5SAYOM06tbYKdMB6
        vaLPLszg6vNJoL/dad/Vrn1JKBvq0HrZf0IY3CXu8b78NZmMiHxbHgJM9YgwOwGJ9t/rsO0SOX+
        ncRICoDVgs0zVFIddQov1IVZaaoIL
X-Received: by 2002:a24:35c9:: with SMTP id k192mr2792253ita.156.1553016086131;
        Tue, 19 Mar 2019 10:21:26 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxEzBTB0F7ROp3bzLD9vJNGYsyiIVBVYjNuPPWNqTrXBgy1hGnRXRtm6Tc/wV5ojJ43E1tTAA==
X-Received: by 2002:a24:35c9:: with SMTP id k192mr2792244ita.156.1553016085944;
        Tue, 19 Mar 2019 10:21:25 -0700 (PDT)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id g64sm1757437itg.44.2019.03.19.10.21.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 10:21:25 -0700 (PDT)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] thunderbolt: Fix to check return value of ida_simple_get
Date:   Tue, 19 Mar 2019 12:21:22 -0500
Message-Id: <20190319172122.8714-1-pakki001@umn.edu>
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
index e27dd8beb94b..bd3633e31359 100644
--- a/drivers/thunderbolt/xdomain.c
+++ b/drivers/thunderbolt/xdomain.c
@@ -772,7 +772,9 @@ static void enumerate_services(struct tb_xdomain *xd)
 		svc->dev.bus = &tb_bus_type;
 		svc->dev.type = &tb_service_type;
 		svc->dev.parent = &xd->dev;
-		dev_set_name(&svc->dev, "%s.%d", dev_name(&xd->dev), svc->id);
+		if (sv->id >= 0)
+			dev_set_name(&svc->dev, "%s.%d", dev_name(&xd->dev),
+					svc->id);
 
 		if (device_register(&svc->dev)) {
 			put_device(&svc->dev);
-- 
2.17.1

