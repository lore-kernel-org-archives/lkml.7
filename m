Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7919C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 09:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A734206C2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 09:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E8x50LQQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405931AbfITJdV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 05:33:21 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51575 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393257AbfITJdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 05:33:21 -0400
Received: by mail-wm1-f65.google.com with SMTP id 7so1677497wme.1;
        Fri, 20 Sep 2019 02:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NrUm6zOy/EJ9ibCviGBB/bXjF+HcDw0sqxAwwkPU5YQ=;
        b=E8x50LQQARW0bDW+w5d63gBizCAHESZUz/7+xvVDGBONbjH2uZkaBWSPPRoSqXsIyY
         SBKd0OnR0uH1PUHLA9rpkBHS9g+/IX0YamCrah/BSfYOXhQREI0LW2T91fPie7uZ7D2u
         Te4Oe7Ankb/cMBcHU1u+iBxIMsC3p6Ubec5hTBn3HlKTFPd8bKWjlCQYCPBx+Hxp458+
         5LBax+bpp+cO1fuocLfVvvSwHfpwRIv955J5Zv3sni/f2kn+eJrFx5uP5F0qQuHBf6kv
         fpSqyNXq9EMKlufxR9Qr4byxA+Sf18NM3z+PD60GQxCvom2nkx7T02qVDfApj+/hlAOE
         zwKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NrUm6zOy/EJ9ibCviGBB/bXjF+HcDw0sqxAwwkPU5YQ=;
        b=sV591coUXDZELvErYj4BM4YuhEyxugw7EBn+t8x8cnWmLEOkGcvLcFg8lSMv3t6oya
         W0Td/TxGHBuEKHnyuDxMVO1tT1vwhC6diIEuw/RFijxQvDeXsKZMpO1QO5TJEixXSx4X
         9GAhhiQVwb5wGDDe9ziKebcuZalUM3Oc7x0U5GQwc+qmKcLolP7wXMsTQ+WY36JgvWfs
         pE511PiHtJP+MhqPxYIE7J8CIESw/Autnu0phnENKrsVOS+dnqtvbXI/JT97Qh+n4O3+
         1heMI7Chy8uXdR7OJUCHwoEI0/VW3ynP7+/U3fNY9/n4gey91XxQGppxPmXumcdAUZds
         RHEw==
X-Gm-Message-State: APjAAAWpNsGkmALumFwTgZvzMmRWQPFhfzIIFOzxapFfu7Ojx5dU3ocX
        EebULCShFm0Cv7q3bsK0i4cIagjcJ9I=
X-Google-Smtp-Source: APXvYqyykmr/1lYPAKZgF+2vPkYifML5oM0ue4sQIEA5SMH7KsYZIDn76PKiZEu0yUnlNOcZf+2JTg==
X-Received: by 2002:a05:600c:114e:: with SMTP id z14mr2470460wmz.134.1568971998305;
        Fri, 20 Sep 2019 02:33:18 -0700 (PDT)
Received: from linux-code.mgc.mentorg.com (nat-sch.mentorg.com. [139.181.36.34])
        by smtp.gmail.com with ESMTPSA id h63sm1760268wmf.15.2019.09.20.02.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2019 02:33:17 -0700 (PDT)
From:   Srikanth Krishnakar <skrishnakar@gmail.com>
X-Google-Original-From: Srikanth Krishnakar <Srikanth_Krishnakar@mentor.com>
To:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        dvhart@infradead.org, andy@infradead.org, jan.kiszka@siemens.com
Cc:     Cedric_Hombourger@mentor.com, volker.edenhofer@siemens.com,
        Srikanth_Krishnakar@mentor.com
Subject: [PATCH v2] platform/x86: pmc_atom: Add Siemens SIMATIC IPC277E to critclk_systems DMI table
Date:   Fri, 20 Sep 2019 15:01:56 +0530
Message-Id: <20190920093156.18885-1-Srikanth_Krishnakar@mentor.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <972f063e-e1da-7248-90ab-e9b12481641d@siemens.com>
References: <972f063e-e1da-7248-90ab-e9b12481641d@siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SIMATIC IPC277E uses the PMC clock for on-board components
and gets stuck during boot if the clock is disabled. Therefore,
add this device to the critical systems list.

Tested on SIMATIC IPC277E.

Fixes: 648e921888ad ("clk: x86: Stop marking clocks as CLK_IS_CRITICAL")
Reviewed-by: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Cedric Hombourger <Cedric_Hombourger@mentor.com>
Signed-off-by: Srikanth Krishnakar <Srikanth_Krishnakar@mentor.com>
---

Suggested for linux-stable v4.14.x and above.
Depends on ad0d315b4d4e ("platform/x86: pmc_atom: Add Siemens SIMATIC IPC227E to critclk_systems DMI table")

 drivers/platform/x86/pmc_atom.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/platform/x86/pmc_atom.c b/drivers/platform/x86/pmc_atom.c
index 9aca5e7ce6d0..07d1b911e72f 100644
--- a/drivers/platform/x86/pmc_atom.c
+++ b/drivers/platform/x86/pmc_atom.c
@@ -422,6 +422,13 @@ static const struct dmi_system_id critclk_systems[] = {
 			DMI_MATCH(DMI_PRODUCT_VERSION, "6ES7647-8B"),
 		},
 	},
+	{
+		.ident = "SIMATIC IPC277E",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "SIEMENS AG"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "6AV7882-0"),
+		},
+	},
 	{ /*sentinel*/ }
 };
 
-- 
2.17.1

