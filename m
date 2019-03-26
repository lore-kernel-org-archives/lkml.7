Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A5D4C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A50D2146F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="MicVpFtf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732452AbfCZSXe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 14:23:34 -0400
Received: from mout.gmx.net ([212.227.17.22]:41165 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731828AbfCZSXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 14:23:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1553624597;
        bh=CkUkl5LwpfPUkv9EjDifa2662Ftupi9ELad0B9yeyrI=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=MicVpFtf9EBbPCfRZZFoZEZ6dbVqBElW+4MuJ9t29hqfQ1/1byh8frlq79B2vZ0iu
         CN+E7n18pOd+Qr+mQ+KamgopJVv9S6LU89F2Q+uvHf4S6025S23sPrKKG7o7e2pLQs
         /rzEAzvxJ9zGLmkDfyVTJlKa4BLlnEMyyahyAS1g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([109.90.232.48]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MIPhr-1h7ScU2zPT-004Cmb; Tue, 26
 Mar 2019 19:23:17 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-clk@vger.kernel.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Lucas Stach <l.stach@pengutronix.de>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Aisheng Dong <aisheng.dong@nxp.com>
Subject: [PATCH v2 0/2] clk: imx5: Fix i.MX50 clock registers
Date:   Tue, 26 Mar 2019 19:22:56 +0100
Message-Id: <20190326182258.21945-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1O6dobTGETbPCiT543z2JT6KKHRcrb0G5T+WL+RZpcMM/BqDohq
 vd28AJcMhZreS+EKSihdDEERCgtnNsc2U5ZzaSvNwxYi0sZJDyjQpB7rIip96qom0oc25pq
 tUjKWBZ2iiaLUb5V6j2PcoWL3n6H61/+SyBPSDLp2U2YU+Qu6s4AnibxU/SwgtW2+9zeoCd
 T59pn946IsCvngHKgLi5A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:o/X3vEQT5xI=:mTO+tFPDoRuMB8NotUWav4
 yavyy/zOIZitCkCCO6Yv6HeVruMuYEy2QdfNTMVvOqf4Umr9GBAUSeL4O8Toqpn8D2dgX2iZZ
 GwIBdvsOx8UIe1oFXh5Jyne1M5RO9HkUFumYtiLsYm7cMJKUxLkNCppYabth9z0sihkYeI7JI
 IP9jmb4Xjwo8jz0MfX3F9XG7eS0L12cmWKHRZMYt/BSRyd71SBogXmAVYLWjrLQHOgqST0R4i
 vrXpvPLnmeJko+/3NOdoN8Eqc0ZGKQXDtNVUyNFwhjolm1Nk7sffYI/5wVOD3+LEQgnQbnOb/
 19fagu1VPnW2crWOGAjYjeyfMWjnZtFtwdZv+xXWsYGnZmy+AEpH7MVgU3RJm4SOuzW/YB7VY
 BwdXxW/72H1KF9WrvB8EJNhpIIF0pqrTL7vd8gkN/i33aQtR9Fh4PgUUYDDKcuycso7750i+d
 lejHevPaH6i+pa/1TbVmk4Kipg6ZvFyFF9duGk9xp3dmnKsn9SFIlaxpD8d7Jng43gklTxG1R
 gdZcyy2Mf5NhxHSrzFacITUNLPGQ7WKBYemZKrJLwTCV5bncd19xvGYOBlsLnkwkCox0XcFpB
 Q5c+xYNs+tferyBw6i48+m85i07Jib+xTg7P60vlsyMRTbVpBzAhn19kcwEFYhguQHQoPnRCT
 /lP2cVu+jIHY9JOOropEXNNGt63e9dPiuzjQ1i+BZ4U1+B5IlW9Nau40Upt7optg/LiXpoMOo
 d5Co4NhN+XjmRGHkvQa+xdeBO73DNu8axV1orNaG5y+04Bq2Q1yavnEwgJE3o5DLexxQwWBcx
 +RGwYkqGrRcOxrx0dSq2J9uViNfbLNMKm/9RLx5yyoGpSFQhFMUlwbEMUaL6dvfWFLEbQwKlw
 RIdmjAL9MHRPoM593wk1ZwbTWfKVknhuCa/IzauA7Rlle5ZlZrBC0iktboXmk1fN3nl6Hfnpl
 c/xSSTbACJg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a few differences between the i.MX50 clock tree and those of
i.MX51 and i.MX53 that are not yet handled in clk-imx51-imx53.c.  This
series handles two of them.

Jonathan Neusch=C3=A4fer (2):
  clk: imx5: Fix i.MX50 mainbus clock registers
  clk: imx5: Fix i.MX50 ESDHC clock registers

v2:
- Split into two patches, as suggested by Aisheng Dong

v1:
https://lore.kernel.org/lkml/20190318231737.8459-1-j.neuschaefer@gmx.net/

 drivers/clk/imx/clk-imx51-imx53.c | 59 +++++++++++++++++++++++--------
 1 file changed, 45 insertions(+), 14 deletions(-)

=2D-
2.20.1

