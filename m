Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D31C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9599F2175B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:06:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfCTMGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 08:06:15 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.67]:6829 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725905AbfCTMGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 08:06:14 -0400
Received: from [46.226.52.194] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-b.eu-west-1.aws.symcld.net id 86/B9-11025-EAC229C5; Wed, 20 Mar 2019 12:06:06 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHIsWRWlGSWpSXmKPExsVy8IPnUd21OpN
  iDH4dMLSYf+Qcq8XDq/4Wq6buZLHY9Pgaq0XXr5XMFpd3zWGzWHr9IpNF694j7BZ/t29isXix
  RdyBy2PNvDWMHjtn3WX32LSqk81j85J6j43vdjB59P818Pi8SS6APYo1My8pvyKBNaN97kuWg
  gecFU823mdpYNzD0cXIxSEksJ5R4tbmayxdjBxAToXE7B9JXYycHGwChhLz3rxnBLFZBFQlrq
  xYwwZiCwt4S3zcvAHMFhHoZZJY8LUcZA6zwHFGib2Lr7CAJHgFHCR2d5xkhLAFJU7OfAIWZxa
  QkDj44gUzxC4tieXHIkHCEgL2EtPfXwULSwjoSzQei4UIG0p8n/WNBcI2lzjUf5ZpAiP/LCRD
  ZyEZuoCRaRWjRVJRZnpGSW5iZo6uoYGBrqGhka6hpaWukZGFXmKVbpJeaqlueWpxia6hXmJ5s
  V5xZW5yTopeXmrJJkZgXKQUHH+yg/F/V/ohRkkOJiVR3ka1STFCfEn5KZUZicUZ8UWlOanFhx
  hlODiUJHj3agPlBItS01Mr0jJzgBEKk5bg4FES4X2lBZTmLS5IzC3OTIdInWLU5XjY+nkusxB
  LXn5eqpQ47w2QIgGQoozSPLgRsGRxiVFWSpiXkYGBQYinILUoN7MEVf4VozgHo5IwLw8w9Qjx
  ZOaVwG16BXQEE9AR6+b1gxxRkoiQkmpg1DTMc8pZ7/n6baSYkJRZe9wGmYw+Uws7mZ6eqd2BR
  VvSBLs1Jta9fXqQ+Wctj9vfStF/kdJq677JnFu+TvTh5G0eG+VblKyCb/a5/fFYxyOWduB1Qf
  wKni/Jd5vcGNfWb700161Ph+WXTHzQvwc1752lmL+WHo/es7Y/tOkmx9M1YRlTLW8psRRnJBp
  qMRcVJwIAtPrUrREDAAA=
X-Env-Sender: stwiss.opensource@diasemi.com
X-Msg-Ref: server-15.tower-282.messagelabs.com!1553083565!3936329!1
X-Originating-IP: [193.240.73.197]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 5737 invoked from network); 20 Mar 2019 12:06:05 -0000
Received: from unknown (HELO sw-ex-cashub01.diasemi.com) (193.240.73.197)
  by server-15.tower-282.messagelabs.com with AES128-SHA256 encrypted SMTP; 20 Mar 2019 12:06:05 -0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 SW-EX-CASHUB01.diasemi.com (10.20.16.140) with Microsoft SMTP Server id
 14.3.408.0; Wed, 20 Mar 2019 12:06:04 +0000
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 22547)      id
 7D99B3FBE9; Wed, 20 Mar 2019 12:06:04 +0000 (GMT)
From:   Steve Twiss <stwiss.opensource@diasemi.com>
Date:   Wed, 20 Mar 2019 11:03:50 +0000
Subject: [PATCH] ARM: dts: imx6qdl-sabresd: change phy-mode to use rgmii-id
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
CC:     DEVICETREE <devicetree@vger.kernel.org>,
        LINUX-ARM-KERNEL <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dialog Opensource Support <support.opensource@diasemi.com>
Message-ID: <20190320120604.7D99B3FBE9@swsrvapps-01.diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-ServerInfo: sw-ex-cashub01.diasemi.com, 9
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 20/03/2019 09:36:00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PHY used on the Freescale i.MX6Q/DL SABRE boards is qualified as
'rgmii' instead of 'rgmii-id'. Meaning the RX and TX delays that were
previously added by the MAC when required, but are now provided
internally by the PHY (and the MAC should no longer add the RX or TX
delays in this case).

This patch fixes the network problems seen on the Freescale i.MX6Q/DL
SABRE boards and makes a difference when correctly loading the NFS
rootfs on startup.

Link: https://lkml.kernel.org/r/1397569821-5530-4-git-send-email-thomas.petazzoni@free-electrons.com
Tested-by: Steve Twiss <stwiss.opensource@diasemi.com>
Tested-by: Adam Thomson <Adam.Thomson@diasemi.com>
Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
---
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index a070506..185fb17 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -202,7 +202,7 @@
 &fec {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet>;
-	phy-mode = "rgmii";
+	phy-mode = "rgmii-id";
 	phy-reset-gpios = <&gpio1 25 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
-- 
1.9.3

