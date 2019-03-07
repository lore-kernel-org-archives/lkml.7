Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 166D5C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 10:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D422F20854
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 10:10:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfCGKKf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 05:10:35 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:59161 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbfCGKKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 05:10:33 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MpUQm-1giyJ345W8-00pt6A; Thu, 07 Mar 2019 11:10:26 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: davinci: remove extraneous __init annotation
Date:   Thu,  7 Mar 2019 11:10:11 +0100
Message-Id: <20190307101024.594587-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:5Z+c2+TXyo4rnMtsy185ZWjj08lop8Hyc9X4keISaszoTUMNbwZ
 yMoD8Z0yFnJB/4alQCxmN3ikNJep5jrRnGKkEU6r9+WR1E1X3ppsVtT54n7AyQGtRBnVJbv
 6YjGgoMdIC/wvFzWQyb0zM9ZtnnEoTbbkqJC0H/CLnoe5YcwxKqOTdqeaWh7LN9NDccXqwr
 PAfBqX1xQ6uKX2fv7l4zQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rh1iC44JIzw=:fPhYNNPiCxmD2ARL6TnZsS
 jRPYHBDpd5uDSInQoZn+T0h+BIqltG3SE1BgSHsDyciF2VWOD3xtuVB19Oq2v5XrrG5JWTH+m
 n2cztbyy4sGNDtt+xCqQWoejW9UwdLHY4+5fDHhrI2XKMbgz0IIUcB3xbvYTLUhtDpIof9TkP
 dR0hDCV8UeFkAhLJMA+JTZaTYToV7ue4tfQNJMu/ccxPG922G8lUIPdfE3FKMoMJYg0xHeM3A
 9vf1G0d+F8lLAgoL1h4GL4sjlgXqI7roceBLAit0gWNZZcIsl4fXE46rk2KcsCDIaU5zISPMJ
 4Jc7sLkT8VJvU68ko4I6MAQExDxPAIIUENgUApa0wfCyYSilf9bUtxVO6xC45Dfw+6z5TW7kJ
 Uy5tYrPSmVR/tc1FG5m5lBA6GGKdsBAeMtcGybCtqbB/lCH+/0gxs3jr278qdxtU0/AoY2Tvl
 TJ3XrdvKKaTTGlaBXtzVlA9igNMQm8ZW76rp2v3i3TK9Uo3YruypHOWJUONi7IIb+LMQy0rUQ
 BtXkvqked+qnR1c9TRMzFmrzr6Oj668e+C/xEKBBcH4s+TyNc+jjD2iTfBkUJa/H2R1z1XXzd
 iKckNuI0VH80EgaxOvQZJVILbsF/l3vSCV6/SFuzQDjq3kVVKm2qmNh+W4RkGdKl78rIb6EL1
 7l52d9zAQ59rYWZqiFbKGedTYzqVU1iycr2px0E4QShmf+75o5nLk/ESZ1G5EAK176P5j4gL2
 qzKUyCwWdxlYGqJKoSCyRCwhyRCEpWMLquWsyA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building with clang finds a mistaken __init tag:

WARNING: vmlinux.o(.text+0x5e4250): Section mismatch in reference from the function davinci_mmcsd_probe() to the function .init.text:init_mmcsd_host()
The function davinci_mmcsd_probe() references
the function __init init_mmcsd_host().
This is often because davinci_mmcsd_probe lacks a __init
annotation or the annotation of init_mmcsd_host is wrong.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mmc/host/davinci_mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index 49e0daf2ef5e..f37003df1e01 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -1117,7 +1117,7 @@ static inline void mmc_davinci_cpufreq_deregister(struct mmc_davinci_host *host)
 {
 }
 #endif
-static void __init init_mmcsd_host(struct mmc_davinci_host *host)
+static void init_mmcsd_host(struct mmc_davinci_host *host)
 {
 
 	mmc_davinci_reset_ctrl(host, 1);
-- 
2.20.0

