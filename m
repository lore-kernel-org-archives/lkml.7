Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC27C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 12:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99A2B206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 12:52:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732078AbfDQMwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 08:52:09 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:50565 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbfDQMwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 08:52:08 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1N49d1-1gqEtZ3noP-01012K; Wed, 17 Apr 2019 14:51:56 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     arm@kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Baruch Siach <baruch@tkos.co.il>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] ARM: debug-ll: add default address for digicolor
Date:   Wed, 17 Apr 2019 14:51:32 +0200
Message-Id: <20190417125153.2510262-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:HKd81eS+glV0/lfHYTCTh8TQSO1zMeFcCze6wUhheemUTbQmIgy
 MnkUndh7ToP2k7RSEeuSnv35BbwpQACt49AsHObOG56g8QXwKdFcKUe1Kp3x7LPdRp/ah0N
 pr2td7FPC5bl/HmBcOF3q6rpSCFIi/3D/J/DBz9jC54mDQJqqXnGDev+odS5748iFM8JZ5s
 la2X0whAte/KlOlxg7SVQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oirpGJJjtAQ=:RlB18vNdv+X2xgJpYYQmL3
 AnWAKZN7PQez0Zqu6pPquQtCx2jgJOUcnfLrqmwtzAkq7Oz7F1Tv1p0lW1hYDS1ifxSeGJKYv
 N0iIUn4kCKNnImIbxfBWwHAXINgwH6ZoALucKyX3KNGeSz6COYx4upEiQcKlEmPjbZ59ia4iw
 raATYWrrGaMPIZWjSQ0dXrIs6HnxvMSX/V4BbXofkSO71clvvcwbCAseaM+PIfcZFxsOC6SiF
 US3lYldRYBHM8zLnvyBe3o2JZBP+tBY06rYMp2pE37RkqrT3JuXd9bGfbfjv8iXP30Zo7gNTJ
 LhsL8/SST3dXRIf6fjUDDZjkoOl1p+5K3PL3dkkimwAOdIUCakO2a42P6kWqOJ4qiqbZrPz0Y
 By9LppgMBOx7A7WSYjbZ80/UFq+56j+Qu6+P/aDTkmQzUBVuWElUXvmWZLoroxlIKhn/2hcWj
 ltJtfJQdVOMoxwGmtGdEhvRr5rhuD/mjD0cgGq53cQShDayMH7k+FsJZPK9r+1JsegIeaTN4k
 gfK85BvV2oJVvrORPjGtY3rqsVNLKSk0oXBsxSkpVwX8ZS2aZ66V6yO66vT/O/c8fBG1f8hS8
 rOFFDnZhPtP+2fwfAHgF2nkOTeU0BZ0nP1axEYlqOY+sxsnlPs9JoC+NOJr0HjZ0MzvqOHptH
 ljo5middmXJqOQwNR6kM+WwCuZueAgd4f7uIxGouEIJOCpPsLczJUjqtGAryj0zCTcMZ/riu1
 zbQxE4AJCPLv7STSWnBkUe7MnkRCuaFH12Lt4g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The digicolor platform has three UARTs, but the Kconfig.debug
file explicitly lists port zero as the one to be used for the
console, while not providing any default values.

This can get an automated randconfig build stuck in a loop
waiting for the user to input the number. As we already know
the physical address, this patch provides that number as
default, along with a reasonable default value for the virtual
address.

Cc: Baruch Siach <baruch@tkos.co.il>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: fix physical address

 arch/arm/Kconfig.debug | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 6d6e0330930b..12c0d29b75e3 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -1677,6 +1677,7 @@ config DEBUG_UART_PHYS
 	default 0xe6ee0000 if DEBUG_RCAR_GEN2_SCIF4
 	default 0xe8008000 if DEBUG_R7S72100_SCIF2
 	default 0xf0000be0 if ARCH_EBSA110
+	default 0xf0100000 if DEBUG_DIGICOLOR_UA0
 	default 0xf1012000 if DEBUG_MVEBU_UART0_ALTERNATE
 	default 0xf1012100 if DEBUG_MVEBU_UART1_ALTERNATE
 	default 0xf7fc9000 if DEBUG_BERLIN_UART
@@ -1784,6 +1785,7 @@ config DEBUG_UART_VIRT
 	default 0xfd012000 if DEBUG_MVEBU_UART0_ALTERNATE && ARCH_MV78XX0
 	default 0xfd883000 if DEBUG_ALPINE_UART0
 	default 0xfde12000 if DEBUG_MVEBU_UART0_ALTERNATE && ARCH_DOVE
+	default 0xfe000000 if DEBUG_DIGICOLOR_UA0
 	default 0xfe012000 if DEBUG_MVEBU_UART0_ALTERNATE && ARCH_ORION5X
 	default 0xfe017000 if DEBUG_MMP_UART2
 	default 0xfe018000 if DEBUG_MMP_UART3
-- 
2.20.0

