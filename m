Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A29E3C2D0BF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 19:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A27524672
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 19:05:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbfLRTFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 14:05:02 -0500
Received: from [167.172.186.51] ([167.172.186.51]:49026 "EHLO shell.v3.sk"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726939AbfLRTFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 14:05:02 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 0A0ABDFC5F;
        Wed, 18 Dec 2019 19:05:03 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id xGEUMlC3gG8f; Wed, 18 Dec 2019 19:05:02 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 33510DFC76;
        Wed, 18 Dec 2019 19:05:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id E00NoQuN8_jt; Wed, 18 Dec 2019 19:05:01 +0000 (UTC)
Received: from furthur.lan (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 8FA12DD70C;
        Wed, 18 Dec 2019 19:05:01 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Olof Johansson <olof@lixom.net>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 2/2] clk: mmp2: Fix the order of timer mux parents
Date:   Wed, 18 Dec 2019 20:04:54 +0100
Message-Id: <20191218190454.420358-3-lkundrak@v3.sk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191218190454.420358-1-lkundrak@v3.sk>
References: <20191218190454.420358-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Determined empirically, no documentation is available.

The OLPC XO-1.75 laptop used parent 1, that one being VCTCXO/4 (65MHz), b=
ut
thought it's a VCTCXO/2 (130MHz). The mmp2 timer driver, not knowing
what is going on, ended up just dividing the rate as of
commit f36797ee4380 ("ARM: mmp/mmp2: dt: enable the clock")'

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/clk/mmp/clk-of-mmp2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/mmp/clk-of-mmp2.c b/drivers/clk/mmp/clk-of-mmp2.=
c
index e7e264f26a50d..24af9241bfa06 100644
--- a/drivers/clk/mmp/clk-of-mmp2.c
+++ b/drivers/clk/mmp/clk-of-mmp2.c
@@ -154,7 +154,7 @@ static DEFINE_SPINLOCK(ssp3_lock);
 static const char *ssp_parent_names[] =3D {"vctcxo_4", "vctcxo_2", "vctc=
xo", "pll1_16"};
=20
 static DEFINE_SPINLOCK(timer_lock);
-static const char *timer_parent_names[] =3D {"clk32", "vctcxo_2", "vctcx=
o_4", "vctcxo"};
+static const char *timer_parent_names[] =3D {"clk32", "vctcxo_4", "vctcx=
o_2", "vctcxo"};
=20
 static DEFINE_SPINLOCK(reset_lock);
=20
--=20
2.23.0

