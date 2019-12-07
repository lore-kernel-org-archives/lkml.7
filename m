Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E82CFC43603
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 18:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA0F9217BA
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 18:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m23WEjs0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbfLGS1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Dec 2019 13:27:17 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:32855 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbfLGS1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Dec 2019 13:27:17 -0500
Received: by mail-wr1-f66.google.com with SMTP id b6so11446769wrq.0;
        Sat, 07 Dec 2019 10:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aa6l8+iIij3OJFvZOZzXN4zGANQjDpNH8fStlTqEIWk=;
        b=m23WEjs0SI70EvQEPOu18sGGkvPE9oMetHFPvr71mG0HhwqWWg1Xm9y1GXtEVzJNJd
         BHf5MPhhohaz4IHbrClTTK8LdIUevdwQbQC2OSweI+AOYmh/myE05PoWRN4RSjhqkBym
         ixH1aJAQIsErfRPSCTvb42XQDtaokqcHJ0lYreCWdpEGZpYjCpvWDf6eMXGxCluS23zX
         DFJnIZpad5T/sgRBlaMtTPT2gzaF2J0ohz6fFpSjhAKh7MDIpX5flD3r0mWvlmCwYPtK
         siblTOSWp/FcbvzSvOGSKdiXV6e+eMDm4dhUqUhod6aNvpR7H894BjB5rNf2qhqKQpk2
         FgHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aa6l8+iIij3OJFvZOZzXN4zGANQjDpNH8fStlTqEIWk=;
        b=TWMpSGIz7Axec7bPolCdBduTHAhsuXbG4XsWPiKpxCaRqqvBrcKn6KV6wPdPs72DGu
         EvLyUHNbRi7agP88ltmitbR0ZR2JW1FA9yy7TMa/afCvZ7KNRhWu9O8ST/b1uwafM0wK
         MtSQbF7p7voLJ8QaE/JGnF5/AzCLNNoLpnTON+MQtyb6pHDOxY5RsDMDqK1KUMyGj2pQ
         IUY0vacJoFC3+wz27l0JjWwqDjtPZsKzl7ov/9EhocrTPfuOLRv8u5YYUvK//wa2NK9F
         MvlJcOTecbqbYjr/gx7WIYvjzI3yjdUzkQjTf5H8Jon5IJGmn1pp7aAsRSpCsyEfvJXa
         CUDQ==
X-Gm-Message-State: APjAAAV7rlW+EqNVRUpdmG9Qd+Ta56dl9QHuWGAmZmFwYh7xA2I707+h
        p/XU8SrDGxh3F9eCXk+PC34=
X-Google-Smtp-Source: APXvYqwICamRNwt4rbMxw0f4GqN/RQjHGDcbcmSc52vaTC1Hr+sao7Nrm8Lq4bV60Q8319T2gQzRLA==
X-Received: by 2002:adf:e6c6:: with SMTP id y6mr22131117wrm.284.1575743234887;
        Sat, 07 Dec 2019 10:27:14 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2d4f:f100:30e3:988a:bff1:5a99])
        by smtp.gmail.com with ESMTPSA id a127sm7916125wmh.43.2019.12.07.10.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Dec 2019 10:27:14 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Przemyslaw Gaj <pgaj@cadence.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Cc:     linux-i3c@lists.infradead.org, kernel-janitors@vger.kernel.org,
        agolec@cadence.com, rafalc@cadence.com, vitor.soares@synopsys.com,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: fix style in CADENCE I3C MASTER IP entry
Date:   Sat,  7 Dec 2019 19:27:03 +0100
Message-Id: <20191207182703.14102-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit ae24f2b6f828 ("MAINTAINERS: add myself as maintainer of Cadence I3C
master controller driver") slips in some formatting with spaces instead of
tabs, which ./scripts/checkpatch.pl -f MAINTAINERS complains about:

  #7838: FILE: MAINTAINERS:7838:
  M:      Przemysław Gaj <pgaj@cadence.com>

  WARNING: MAINTAINERS entries use one tab after TYPE:
  #7839: FILE: MAINTAINERS:7839:
  S:      Maintained

  WARNING: MAINTAINERS entries use one tab after TYPE:
  #7840: FILE: MAINTAINERS:7840:
  F:      Documentation/devicetree/bindings/i3c/cdns,i3c-master.txt

  WARNING: MAINTAINERS entries use one tab after TYPE:
  #7841: FILE: MAINTAINERS:7841:
  F:      drivers/i3c/master/i3c-master-cdns.c

Fixes: ae24f2b6f828 ("MAINTAINERS: add myself as maintainer of Cadence I3C master controller driver")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies cleanly on current master (eea2d5da29e3) and next-20191207

 MAINTAINERS | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0fd82e674cf4..59d4cb7b2981 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7835,10 +7835,10 @@ F:	Documentation/devicetree/bindings/i3c/snps,dw-i3c-master.txt
 F:	drivers/i3c/master/dw*
 
 I3C DRIVER FOR CADENCE I3C MASTER IP
-M:      Przemysław Gaj <pgaj@cadence.com>
-S:      Maintained
-F:      Documentation/devicetree/bindings/i3c/cdns,i3c-master.txt
-F:      drivers/i3c/master/i3c-master-cdns.c
+M:	Przemysław Gaj <pgaj@cadence.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/i3c/cdns,i3c-master.txt
+F:	drivers/i3c/master/i3c-master-cdns.c
 
 IA64 (Itanium) PLATFORM
 M:	Tony Luck <tony.luck@intel.com>
-- 
2.17.1

