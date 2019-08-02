Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E533C32753
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86C6421871
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564738269;
	bh=TJed8jkosXHtrYtgyAE9DH9vGieBDk4XFI/GZmxO9Pc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Vjhxac634SkiOlLjT1KvpHqKFwxgSlkV7FDQsmYcxD886bRB9SGrwiFdxz8AQEtAE
	 +LLUCdkehRtbXq9il9W/ML5b4r5w5p071NTvbbpE88lnd9R2hMxfJxupPUcOhAvP1q
	 2tGsW4k+z94pP0PuXosmL5Zvk8boVriITvhp28yk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391018AbfHBJbH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 05:31:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:56910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390999AbfHBJbF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 05:31:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF2CF2182B;
        Fri,  2 Aug 2019 09:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564738264;
        bh=TJed8jkosXHtrYtgyAE9DH9vGieBDk4XFI/GZmxO9Pc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kbWT2zAHSj/RHgfAJfty3X7xLMM5ZGOx+PyxVeu+AOOBQ6mfvRpfQMNEqg4K+qLXs
         9BMicsHhP26NL2GWSkIwFOV/OlV7GaTLVqkFgQylJUNtfDjiJ3i3REmrrDhY2l5eZb
         uPB3ukfa9iIX0tfzUujYa6mCr29h+Ba02P5UASf4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 019/158] tua6100: Avoid build warnings.
Date:   Fri,  2 Aug 2019 11:27:20 +0200
Message-Id: <20190802092207.359242196@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190802092203.671944552@linuxfoundation.org>
References: <20190802092203.671944552@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 621ccc6cc5f8d6730b740d31d4818227866c93c9 ]

Rename _P to _P_VAL and _R to _R_VAL to avoid global
namespace conflicts:

drivers/media/dvb-frontends/tua6100.c: In function ‘tua6100_set_params’:
drivers/media/dvb-frontends/tua6100.c:79: warning: "_P" redefined
 #define _P 32

In file included from ./include/acpi/platform/aclinux.h:54,
                 from ./include/acpi/platform/acenv.h:152,
                 from ./include/acpi/acpi.h:22,
                 from ./include/linux/acpi.h:34,
                 from ./include/linux/i2c.h:17,
                 from drivers/media/dvb-frontends/tua6100.h:30,
                 from drivers/media/dvb-frontends/tua6100.c:32:
./include/linux/ctype.h:14: note: this is the location of the previous definition
 #define _P 0x10 /* punct */

Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/dvb-frontends/tua6100.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/media/dvb-frontends/tua6100.c b/drivers/media/dvb-frontends/tua6100.c
index 029384d1fddd..7a3e91cda5df 100644
--- a/drivers/media/dvb-frontends/tua6100.c
+++ b/drivers/media/dvb-frontends/tua6100.c
@@ -80,8 +80,8 @@ static int tua6100_set_params(struct dvb_frontend *fe)
 	struct i2c_msg msg1 = { .addr = priv->i2c_address, .flags = 0, .buf = reg1, .len = 4 };
 	struct i2c_msg msg2 = { .addr = priv->i2c_address, .flags = 0, .buf = reg2, .len = 3 };
 
-#define _R 4
-#define _P 32
+#define _R_VAL 4
+#define _P_VAL 32
 #define _ri 4000000
 
 	// setup register 0
@@ -96,14 +96,14 @@ static int tua6100_set_params(struct dvb_frontend *fe)
 	else
 		reg1[1] = 0x0c;
 
-	if (_P == 64)
+	if (_P_VAL == 64)
 		reg1[1] |= 0x40;
 	if (c->frequency >= 1525000)
 		reg1[1] |= 0x80;
 
 	// register 2
-	reg2[1] = (_R >> 8) & 0x03;
-	reg2[2] = _R;
+	reg2[1] = (_R_VAL >> 8) & 0x03;
+	reg2[2] = _R_VAL;
 	if (c->frequency < 1455000)
 		reg2[1] |= 0x1c;
 	else if (c->frequency < 1630000)
@@ -115,18 +115,18 @@ static int tua6100_set_params(struct dvb_frontend *fe)
 	 * The N divisor ratio (note: c->frequency is in kHz, but we
 	 * need it in Hz)
 	 */
-	prediv = (c->frequency * _R) / (_ri / 1000);
-	div = prediv / _P;
+	prediv = (c->frequency * _R_VAL) / (_ri / 1000);
+	div = prediv / _P_VAL;
 	reg1[1] |= (div >> 9) & 0x03;
 	reg1[2] = div >> 1;
 	reg1[3] = (div << 7);
-	priv->frequency = ((div * _P) * (_ri / 1000)) / _R;
+	priv->frequency = ((div * _P_VAL) * (_ri / 1000)) / _R_VAL;
 
 	// Finally, calculate and store the value for A
-	reg1[3] |= (prediv - (div*_P)) & 0x7f;
+	reg1[3] |= (prediv - (div*_P_VAL)) & 0x7f;
 
-#undef _R
-#undef _P
+#undef _R_VAL
+#undef _P_VAL
 #undef _ri
 
 	if (fe->ops.i2c_gate_ctrl)
-- 
2.20.1



