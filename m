Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBEB1C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 14:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 861E520674
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 14:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="PtycFUyr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbfLCOWN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 09:22:13 -0500
Received: from mout.gmx.net ([212.227.15.19]:40011 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725957AbfLCOWM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 09:22:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1575382917;
        bh=VPL5dxTYRT1YckwTNyKeV63nmsga6aqCNvYIhHWOx+I=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=PtycFUyrkw8ngoFP4NBX5zi6AZFApbjcOB/Wf+mtZ8M/G3kN+e98sjt7LnwUWSxay
         QEtQKSQqMBS5TM+3LWISFc60TVuzTYP3C+w66bo4c0Ln930S+NXnXOW/OoxmdJw0OU
         d46XcXOKlShmq6ZiF2myP5w4baveg1jWHChUXjJg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from zaphod.peppercon.de ([212.80.250.50]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MbAcs-1i5H9Z1tRg-00bdwu; Tue, 03
 Dec 2019 15:21:57 +0100
From:   Ingo van Lil <inguin@gmx.de>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peter Rosin <peda@axentia.se>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Ingo van Lil <inguin@gmx.de>
Subject: [PATCH] ARM: dts: at91: Reenable UART TX pull-ups
Date:   Tue,  3 Dec 2019 15:21:47 +0100
Message-Id: <20191203142147.875227-1-inguin@gmx.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QFxVTPMDMPVZDLRdDkSXfFJ/Lba6s9TWcXRRXPKkp2exq3hKr3o
 XR6keVtstbA3XPhAqxrFGwUA76Zj05+n1guPDpbO89RS51w6/7k3+HRWTfbrgJnV+OSlG+e
 lRWeVV4ITBPVv69Ef9c9oNm2i9Bt/f/OqBspTRA6JC1eDIhMEYOJ/KqcftLK4cCgUVCuLnY
 R1eINlC1EzdRYhD7qL4ww==
X-UI-Out-Filterresults: notjunk:1;V03:K0:swqUhQVh+9A=:sLaJarqLcvtQsBJ9EdMkJc
 c1s0YJSFI7NAeuhyWINcb/pqor0OBEL0JxZf7pHFVigeeo6WWn+hhLYV+C3epz98Jpx4AQ+rs
 TxwHsuArg3yU6xzwIxPMeUResz9Uq9dcEMLUgbLsELJy+x9dh7Eazrz9FJJN4dc8f/sGt6eVh
 JFIaocQiLayeTcxCRsuJW276ywF5SPX0GD6ezB163iOrLhkO+bUipu6vZolTIWVBMn30P6tFM
 PFkJ8hu5gZ0ViD96aRIZgPsGSFD5tHXtmpaRS672XOH2h8enP1CrbeWoR+gVmUEK54K7a5XqV
 QvYmu1bj4kPKyRqg2b3PDG61kxoCE4QAEEfnZMUzboY6IqFXLPtNqaOqqUZk1wH8WQN5mEaC3
 bxkIOG9t80ICsxXQ7QCrKib/aCjMPftsLS+89ZuK2b10beIfgGjoVrK51daZ0wAofnBlq6eiZ
 SJjoy0Sj8+u9fCTACR0yx9swgkiKN3+H7+LJ+59PGx+3rNos7WN/JNhOEakQlAgWrcMrv9JZg
 uI/0i4pH2b5DZiY6caKVJj2B7NYMbDo+B52JKc6waJU4/IOwdnQnXngOYZ4QphYpwVmzQtGYx
 eZflHgNscZSDGFjWPs0mXlKzHTkaQ41mPOH9iD4sLiVJTJU/WE/t3HO9Gz11lM7S2XVVkGp8M
 eiL2fnlgYTOIiCXCPC0EK2Sb03B/FfwP5IW6y7b7coloTYtCul09elk6JG7yYANZpt7536rRJ
 MPRMIqt4V+ldPISGSbr+dACK1kQEdLa/P6cZModXUQZunQhlgOwllhM7qPIZK5/8Z+zNsVCIn
 q7f4qSL51pEel+1RX0iN3nicnPZGbHowVFNlU76r+/jqgGMPe60vrA6jmSmBBVcGKIufr5XBY
 3Wh41m6rFqvYEJPXSWj5BRretjPpQsEIcIcAP7U/TmcGZ8k+6k/pQ2eLwLm4I1xM/F00GmuHq
 WmeQCPFsK0EJl1G4fMDDtRBjv7wXBYg0EXKmrpOw9zP+iJG86z8g7JYXeayHVg2c9fJAPbhxH
 ChqStxoRX0/tjy1//T12hdCOzA+hYSMX3znCvOkpHYcU1zw06/QYd8MSjVQ0SEoLHH4K5tT4A
 tJYC+VZ8W1dfUPCbpuxRDWGPWhGdDpNx/IjJrVccLqDG/QvmIW9+asBkSQWSp2yRZ7G/Wszcg
 ChZ+5QwLD+KsEhjFDcDzMpgkiRriPiSk+fuj0kSDZeezIOUe7T+OQGPuJxZ0euhXFypLm6Ik6
 NVbvhK4PKG3t8saBfkteaMORXakbUcuHcHqKf9g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pull-ups for SAM9 UART/USART TX lines were disabled in a previous
commit. However, several chips in the SAM9 family require pull-ups to
prevent the TX lines from falling (and causing an endless break
condition) when the transceiver is disabled.

=46rom the SAM9G20 datasheet, 32.5.1: "To prevent the TXD line from
falling when the USART is disabled, the use of an internal pull up
is mandatory.". This commit reenables the pull-ups for all chips having
that sentence in their datasheets.

Fixes: 5e04822f7db5 ("ARM: dts: at91: fixes uart pinctrl, set pullup on rx=
, clear pullup on tx")
Signed-off-by: Ingo van Lil <inguin@gmx.de>
Cc: Peter Rosin <peda@axentia.se>
=2D--
 arch/arm/boot/dts/at91sam9260.dtsi | 12 ++++++------
 arch/arm/boot/dts/at91sam9261.dtsi |  6 +++---
 arch/arm/boot/dts/at91sam9263.dtsi |  6 +++---
 arch/arm/boot/dts/at91sam9g45.dtsi |  8 ++++----
 arch/arm/boot/dts/at91sam9rl.dtsi  |  8 ++++----
 5 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sa=
m9260.dtsi
index dee9c0c8a096..16c6fd3c4246 100644
=2D-- a/arch/arm/boot/dts/at91sam9260.dtsi
+++ b/arch/arm/boot/dts/at91sam9260.dtsi
@@ -187,7 +187,7 @@
 				usart0 {
 					pinctrl_usart0: usart0-0 {
 						atmel,pins =3D
-							<AT91_PIOB 4 AT91_PERIPH_A AT91_PINCTRL_NONE
+							<AT91_PIOB 4 AT91_PERIPH_A AT91_PINCTRL_PULL_UP
 							 AT91_PIOB 5 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;
 					};

@@ -221,7 +221,7 @@
 				usart1 {
 					pinctrl_usart1: usart1-0 {
 						atmel,pins =3D
-							<AT91_PIOB 6 AT91_PERIPH_A AT91_PINCTRL_NONE
+							<AT91_PIOB 6 AT91_PERIPH_A AT91_PINCTRL_PULL_UP
 							 AT91_PIOB 7 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;
 					};

@@ -239,7 +239,7 @@
 				usart2 {
 					pinctrl_usart2: usart2-0 {
 						atmel,pins =3D
-							<AT91_PIOB 8 AT91_PERIPH_A AT91_PINCTRL_NONE
+							<AT91_PIOB 8 AT91_PERIPH_A AT91_PINCTRL_PULL_UP
 							 AT91_PIOB 9 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;
 					};

@@ -257,7 +257,7 @@
 				usart3 {
 					pinctrl_usart3: usart3-0 {
 						atmel,pins =3D
-							<AT91_PIOB 10 AT91_PERIPH_A AT91_PINCTRL_NONE
+							<AT91_PIOB 10 AT91_PERIPH_A AT91_PINCTRL_PULL_UP
 							 AT91_PIOB 11 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;
 					};

@@ -275,7 +275,7 @@
 				uart0 {
 					pinctrl_uart0: uart0-0 {
 						atmel,pins =3D
-							<AT91_PIOA 31 AT91_PERIPH_B AT91_PINCTRL_NONE
+							<AT91_PIOA 31 AT91_PERIPH_B AT91_PINCTRL_PULL_UP
 							 AT91_PIOA 30 AT91_PERIPH_B AT91_PINCTRL_PULL_UP>;
 					};
 				};
@@ -283,7 +283,7 @@
 				uart1 {
 					pinctrl_uart1: uart1-0 {
 						atmel,pins =3D
-							<AT91_PIOB 12 AT91_PERIPH_A AT91_PINCTRL_NONE
+							<AT91_PIOB 12 AT91_PERIPH_A AT91_PINCTRL_PULL_UP
 							 AT91_PIOB 13 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;
 					};
 				};
diff --git a/arch/arm/boot/dts/at91sam9261.dtsi b/arch/arm/boot/dts/at91sa=
m9261.dtsi
index dba025a98527..5ed3d745ac86 100644
=2D-- a/arch/arm/boot/dts/at91sam9261.dtsi
+++ b/arch/arm/boot/dts/at91sam9261.dtsi
@@ -329,7 +329,7 @@
 				usart0 {
 					pinctrl_usart0: usart0-0 {
 						atmel,pins =3D
-							<AT91_PIOC 8 AT91_PERIPH_A AT91_PINCTRL_NONE>,
+							<AT91_PIOC 8 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>,
 							<AT91_PIOC 9 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;
 					};

@@ -347,7 +347,7 @@
 				usart1 {
 					pinctrl_usart1: usart1-0 {
 						atmel,pins =3D
-							<AT91_PIOC 12 AT91_PERIPH_A AT91_PINCTRL_NONE>,
+							<AT91_PIOC 12 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>,
 							<AT91_PIOC 13 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;
 					};

@@ -365,7 +365,7 @@
 				usart2 {
 					pinctrl_usart2: usart2-0 {
 						atmel,pins =3D
-							<AT91_PIOC 14 AT91_PERIPH_A AT91_PINCTRL_NONE>,
+							<AT91_PIOC 14 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>,
 							<AT91_PIOC 15 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;
 					};

diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sa=
m9263.dtsi
index 99678abdda93..5c990cfae254 100644
=2D-- a/arch/arm/boot/dts/at91sam9263.dtsi
+++ b/arch/arm/boot/dts/at91sam9263.dtsi
@@ -183,7 +183,7 @@
 				usart0 {
 					pinctrl_usart0: usart0-0 {
 						atmel,pins =3D
-							<AT91_PIOA 26 AT91_PERIPH_A AT91_PINCTRL_NONE
+							<AT91_PIOA 26 AT91_PERIPH_A AT91_PINCTRL_PULL_UP
 							 AT91_PIOA 27 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;
 					};

@@ -201,7 +201,7 @@
 				usart1 {
 					pinctrl_usart1: usart1-0 {
 						atmel,pins =3D
-							<AT91_PIOD 0 AT91_PERIPH_A AT91_PINCTRL_NONE
+							<AT91_PIOD 0 AT91_PERIPH_A AT91_PINCTRL_PULL_UP
 							 AT91_PIOD 1 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;
 					};

@@ -219,7 +219,7 @@
 				usart2 {
 					pinctrl_usart2: usart2-0 {
 						atmel,pins =3D
-							<AT91_PIOD 2 AT91_PERIPH_A AT91_PINCTRL_NONE
+							<AT91_PIOD 2 AT91_PERIPH_A AT91_PINCTRL_PULL_UP
 							 AT91_PIOD 3 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;
 					};

diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sa=
m9g45.dtsi
index 691c95ea6175..fd179097a4bf 100644
=2D-- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -556,7 +556,7 @@
 				usart0 {
 					pinctrl_usart0: usart0-0 {
 						atmel,pins =3D
-							<AT91_PIOB 19 AT91_PERIPH_A AT91_PINCTRL_NONE
+							<AT91_PIOB 19 AT91_PERIPH_A AT91_PINCTRL_PULL_UP
 							 AT91_PIOB 18 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;
 					};

@@ -574,7 +574,7 @@
 				usart1 {
 					pinctrl_usart1: usart1-0 {
 						atmel,pins =3D
-							<AT91_PIOB 4 AT91_PERIPH_A AT91_PINCTRL_NONE
+							<AT91_PIOB 4 AT91_PERIPH_A AT91_PINCTRL_PULL_UP
 							 AT91_PIOB 5 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;
 					};

@@ -592,7 +592,7 @@
 				usart2 {
 					pinctrl_usart2: usart2-0 {
 						atmel,pins =3D
-							<AT91_PIOB 6 AT91_PERIPH_A AT91_PINCTRL_NONE
+							<AT91_PIOB 6 AT91_PERIPH_A AT91_PINCTRL_PULL_UP
 							 AT91_PIOB 7 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;
 					};

@@ -610,7 +610,7 @@
 				usart3 {
 					pinctrl_usart3: usart3-0 {
 						atmel,pins =3D
-							<AT91_PIOB 8 AT91_PERIPH_A AT91_PINCTRL_NONE
+							<AT91_PIOB 8 AT91_PERIPH_A AT91_PINCTRL_PULL_UP
 							 AT91_PIOB 9 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;
 					};

diff --git a/arch/arm/boot/dts/at91sam9rl.dtsi b/arch/arm/boot/dts/at91sam=
9rl.dtsi
index 8643b7151565..ea024e4b6e09 100644
=2D-- a/arch/arm/boot/dts/at91sam9rl.dtsi
+++ b/arch/arm/boot/dts/at91sam9rl.dtsi
@@ -682,7 +682,7 @@
 				usart0 {
 					pinctrl_usart0: usart0-0 {
 						atmel,pins =3D
-							<AT91_PIOA 6 AT91_PERIPH_A AT91_PINCTRL_NONE>,
+							<AT91_PIOA 6 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>,
 							<AT91_PIOA 7 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;
 					};

@@ -721,7 +721,7 @@
 				usart1 {
 					pinctrl_usart1: usart1-0 {
 						atmel,pins =3D
-							<AT91_PIOA 11 AT91_PERIPH_A AT91_PINCTRL_NONE>,
+							<AT91_PIOA 11 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>,
 							<AT91_PIOA 12 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;
 					};

@@ -744,7 +744,7 @@
 				usart2 {
 					pinctrl_usart2: usart2-0 {
 						atmel,pins =3D
-							<AT91_PIOA 13 AT91_PERIPH_A AT91_PINCTRL_NONE>,
+							<AT91_PIOA 13 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>,
 							<AT91_PIOA 14 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;
 					};

@@ -767,7 +767,7 @@
 				usart3 {
 					pinctrl_usart3: usart3-0 {
 						atmel,pins =3D
-							<AT91_PIOB 0 AT91_PERIPH_A AT91_PINCTRL_NONE>,
+							<AT91_PIOB 0 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>,
 							<AT91_PIOB 1 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;
 					};

=2D-
2.21.0

