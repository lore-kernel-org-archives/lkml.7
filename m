Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 792C8C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 23:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE26B24658
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 23:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="RWGUAIt6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbfLEXRG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 18:17:06 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:37835 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbfLEXRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 18:17:05 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id E255E891AC;
        Fri,  6 Dec 2019 12:17:02 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1575587822;
        bh=7sD4hvugn6rCsxPSuCEvgRnlt+qYR3Ims+ZEAMUX4+k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=RWGUAIt6c18JHB5f1lDrLQBRfBUM49WMD5oC6k5vTtw3sADE/lwVrYhkBTOV3CzAX
         m1MQTw7NZ34GenL00WbkvEW2VmbiMmGrQznrB2VZS2U5++Ykusv7SkbAiI6dU1yvJv
         wO7vdLeGZk4g0SwTq4tRwXGEaFTZCAL2am34W0jufVww59hnRTIe1OXaaavUODDMQf
         kqwb9h35YQu8MbeU1JsXckWC/Ewdm0qUbHX1XNXB325fWjOd5YjreFHlOOlIRTKQ28
         ZjGt2F6EciPXXzL7e26qydRDEE0nBgHJCp/sBv0nZPOTHxgLgVF3BiVGQcDbpJHyn2
         tGuG9neSwZJ7Q==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5de98feb0000>; Fri, 06 Dec 2019 12:17:02 +1300
Received: from luukp-dl.ws.atlnz.lc (luukp-dl.ws.atlnz.lc [10.33.25.31])
        by smtp (Postfix) with ESMTP id 839E213EED2;
        Fri,  6 Dec 2019 12:16:58 +1300 (NZDT)
Received: by luukp-dl.ws.atlnz.lc (Postfix, from userid 1137)
        id A403C261D87; Fri,  6 Dec 2019 12:16:59 +1300 (NZDT)
From:   Luuk Paulussen <luuk.paulussen@alliedtelesis.co.nz>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luuk Paulussen <luuk.paulussen@alliedtelesis.co.nz>
Subject: [PATCH v2] hwmon: (adt7475) Make volt2reg return same reg as reg2volt input
Date:   Fri,  6 Dec 2019 12:16:59 +1300
Message-Id: <20191205231659.1301-1-luuk.paulussen@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191205225755.GC2532@roeck-us.net>
References: <20191205225755.GC2532@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

reg2volt returns the voltage that matches a given register value.
Converting this back the other way with volt2reg didn't return the same
register value because it used truncation instead of rounding.

This meant that values read from sysfs could not be written back to sysfs
to set back the same register value.

With this change, volt2reg will return the same value for every voltage
previously returned by reg2volt (for the set of possible input values)

Signed-off-by: Luuk Paulussen <luuk.paulussen@alliedtelesis.co.nz>
---
 changes in v2:
 - remove unnecessary braces.
 drivers/hwmon/adt7475.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/adt7475.c b/drivers/hwmon/adt7475.c
index 6c64d50c9aae..01c2eeb02aa9 100644
--- a/drivers/hwmon/adt7475.c
+++ b/drivers/hwmon/adt7475.c
@@ -294,9 +294,10 @@ static inline u16 volt2reg(int channel, long volt, u=
8 bypass_attn)
 	long reg;
=20
 	if (bypass_attn & (1 << channel))
-		reg =3D (volt * 1024) / 2250;
+		reg =3D DIV_ROUND_CLOSEST(volt * 1024, 2250);
 	else
-		reg =3D (volt * r[1] * 1024) / ((r[0] + r[1]) * 2250);
+		reg =3D DIV_ROUND_CLOSEST(volt * r[1] * 1024,
+					(r[0] + r[1]) * 2250);
 	return clamp_val(reg, 0, 1023) & (0xff << 2);
 }
=20
--=20
2.24.0

