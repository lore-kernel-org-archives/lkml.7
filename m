Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C15C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 12:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6546422DA7
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 12:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="obkg4fpB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729912AbfHTMdh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 08:33:37 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36463 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728366AbfHTMdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 08:33:37 -0400
Received: by mail-pf1-f194.google.com with SMTP id w2so3318293pfi.3;
        Tue, 20 Aug 2019 05:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:date:message-id:in-reply-to:references:subject;
        bh=QXHTiA9+lmYaDV1fP1jTKDbQnYtFZzu5gMQ/7TlFQJU=;
        b=obkg4fpBVG5ro1EO4LITiU/m1X2OSkp1Jqt3lqRGQnF6E+muAWGWwofa8FoKRLii8H
         +lJLJ/3ChfytPIpDTKuRjaICN1tjTdoBIYUvUpImPdOhpxN1yhxinor7EQHNlX1+ajS0
         m4nLvC6a/6q9/aNvFg9YkDuDsnK4EwXTgabq+FKPTMgLg31ACYu3aSwxnDCiUT6aWSLW
         Akp+Vwvv/lAq+GTQEwNR/eGw1WWrVLp3QWIsMYx6pLitgbmT2VUUToMQt/YefwxgqZgJ
         ZlCg7zYEyzcYNafpnyG4clpMQ8m0UnV4cPVBaWM1AW8236IpIaBWeT2NcghplTFMAXxH
         jt+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:date:message-id:in-reply-to
         :references:subject;
        bh=QXHTiA9+lmYaDV1fP1jTKDbQnYtFZzu5gMQ/7TlFQJU=;
        b=hUCrNaThh7tbSjpmSuwLUXwSIFbOgHxlwo/hxdmR/GWuXhPzgL5DmfwkhgaJ3dbS5i
         aLuX3iygAdF4n+yhK45YUzA4prAcOIGKx2wwcW2ZrmpUwOKddcQdtzFkzoaTpE+4PGmV
         i24u9W1RwWHN8c7dXwZFGMJr0+HwkcUJVnRIE38Sw2HonbERMaz4IR0FnqNcK+EHYOBA
         2+NeickR2XOICm1AqcI5EimGMGee/aLgiQZz5/VHxsrMV/uw5GaUNuWYWdL5zAiUYhJD
         HOe7ybc31UcHiXWw/6TKtu7z92cts9dQESMmVBIcJNR4/XLYP6FogsOSH4V+V+VPY2gN
         UL3w==
X-Gm-Message-State: APjAAAXzmjvdbw7xg9U2BWGZfVQKEmDb45ighfniCUfUmcweu+AT+EIZ
        5tA6N3jF3NTivDDJ+2PlPflhkZNO
X-Google-Smtp-Source: APXvYqzQM2xZaPte6AlJ0W8J1aMmeqDzFAH1+gH4ueTSYoeJbwg+2558qF0KANLsGENF5sYynlrygA==
X-Received: by 2002:a17:90a:17ab:: with SMTP id q40mr26456985pja.106.1566304416127;
        Tue, 20 Aug 2019 05:33:36 -0700 (PDT)
Received: from [127.0.0.1] (l193216.ppp.asahi-net.or.jp. [218.219.193.216])
        by smtp.gmail.com with ESMTPSA id o24sm38726945pfp.135.2019.08.20.05.33.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Aug 2019 05:33:35 -0700 (PDT)
From:   Magnus Damm <magnus.damm@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        geert+renesas@glider.be, daniel.lezcano@linaro.org,
        linux-renesas-soc@vger.kernel.org, robh+dt@kernel.org,
        horms+renesas@verge.net.au, Magnus Damm <magnus.damm@gmail.com>,
        tglx@linutronix.de
Date:   Tue, 20 Aug 2019 21:35:14 +0900
Message-Id: <156630451480.17444.3045034693349256156.sendpatchset@octo>
In-Reply-To: <156630449239.17444.11157306180861080402.sendpatchset@octo>
References: <156630449239.17444.11157306180861080402.sendpatchset@octo>
Subject: [PATCH v2 2/7] dt-bindings: timer: renesas, cmt: Update CMT1 on sh73a0 and r8a7740
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

This patch reworks the DT binding documentation for the 6-channel
48-bit CMTs known as CMT1 on r8a7740 and sh73a0.

After the update the same style of DT binding as the rest of the upstream
SoCs will now also be used by r8a7740 and sh73a0. The DT binding "cmt-48"
is removed from the DT binding documentation, however software support for
this deprecated binding will still remain in the CMT driver for some time.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
---

 Documentation/devicetree/bindings/timer/renesas,cmt.txt |   10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

--- 0002/Documentation/devicetree/bindings/timer/renesas,cmt.txt
+++ work/Documentation/devicetree/bindings/timer/renesas,cmt.txt	2019-07-18 18:21:59.453309074 +0900
@@ -12,17 +12,10 @@ datasheets.
 Required Properties:
 
   - compatible: must contain one or more of the following:
-    - "renesas,cmt-48-sh73a0" for the sh73A0 48-bit CMT
-		(CMT1)
-    - "renesas,cmt-48-r8a7740" for the r8a7740 48-bit CMT
-		(CMT1)
-    - "renesas,cmt-48" for all non-second generation 48-bit CMT
-		(CMT1 on sh73a0 and r8a7740)
-		This is a fallback for the above renesas,cmt-48-* entries.
-
     - "renesas,r8a73a4-cmt0" for the 32-bit CMT0 device included in r8a73a4.
     - "renesas,r8a73a4-cmt1" for the 48-bit CMT1 device included in r8a73a4.
     - "renesas,r8a7740-cmt0" for the 32-bit CMT0 device included in r8a7740.
+    - "renesas,r8a7740-cmt1" for the 48-bit CMT1 device included in r8a7740.
     - "renesas,r8a7740-cmt2" for the 32-bit CMT2 device included in r8a7740.
     - "renesas,r8a7740-cmt3" for the 32-bit CMT3 device included in r8a7740.
     - "renesas,r8a7740-cmt4" for the 32-bit CMT4 device included in r8a7740.
@@ -59,6 +52,7 @@ Required Properties:
     - "renesas,r8a77990-cmt0" for the 32-bit CMT0 device included in r8a77990.
     - "renesas,r8a77990-cmt1" for the 48-bit CMT1 device included in r8a77990.
     - "renesas,sh73a0-cmt0" for the 32-bit CMT0 device included in sh73a0.
+    - "renesas,sh73a0-cmt1" for the 48-bit CMT1 device included in sh73a0.
     - "renesas,sh73a0-cmt2" for the 32-bit CMT2 device included in sh73a0.
     - "renesas,sh73a0-cmt3" for the 32-bit CMT3 device included in sh73a0.
     - "renesas,sh73a0-cmt4" for the 32-bit CMT4 device included in sh73a0.
