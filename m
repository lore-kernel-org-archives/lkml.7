Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3DC4C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 15:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72E8C20811
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 15:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="BXyMgmAE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbfCSPZE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 11:25:04 -0400
Received: from mout.gmx.net ([212.227.17.21]:54305 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726579AbfCSPZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 11:25:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1553009084;
        bh=ipB3CHPowXwUEwhyQjUjLsxdRiVluHFcHPKLTIn+D/M=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=BXyMgmAEXwnXASstwZU5mPG3kd7a+BZpPpWgjdOtJuSkSgzQUSt56Du51B7EcxI4T
         gpe7lhakgmHjyjQHHSyTJMioQIqfI/eaod5YxfEPvAd8b5Lb8W0yAeyUpk7EHB2AKt
         KrWPcKqTpm/jfRC8YrEMdzkEsjAjnDPPp/XEEbOM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([109.90.232.48]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LuJDv-1gz5Vj177X-011h7n; Tue, 19
 Mar 2019 16:24:44 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Thierry Reding <treding@nvidia.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Johan Hovold <johan@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH 3/5] ARM: dts: imx50: Add PHY node for usbotg and adjust clocks
Date:   Tue, 19 Mar 2019 16:24:18 +0100
Message-Id: <20190319152421.16179-4-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190319152421.16179-1-j.neuschaefer@gmx.net>
References: <20190319152421.16179-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RQyRurqixI6BorymjXPsg/bz7SQ80dX0FrwjIhVr3Nu/jA/usv2
 PXBL2wrGE+ZXYEidkgoDmaWL/g/udYoSmXkBPQVgiA9r3HG0m5vg//9n7wd/4CGsJetRVdG
 P5OfFBsdeFMW/Ib8ok+Rf0B8N+rl+u99rFtS6mo94qXzuMPeaE5TRvoXTotTKsMT/qFMyW7
 DuyjSJ69zq/hH3rSHgW/g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:g8SzXboCY28=:U8o0eohhFLl2XENeHIL5Q6
 48gpi74eKpQeiuUfEyHaTjVQHEViFVtg3/y6KyYqzVIidqGhALVwCpw7pKLWjssU+uWvVs5nN
 qBvtXUab4G3MIlNbzC0eVzxaKarJ7gFYBOPTm+ErI/LFzv4sB2Iwo00BP0WTk03wYs4FPmyfX
 Wnqyqx+ZsdLkvKrntsu00ZXpUZvw4h1ryKwY0ZHVvpDTVWhQTUYpLIStJwlZd34SHHiOptNr+
 WHFcsCm41jP07i7GUW+HKRzOBePFa7g568NQzyElq7Xin00x+6B3dGm4IXgH8hfx3LEMAfBGw
 3JZpOhF0E8A42HPU1w/EhsbxgzNSiqCogeNENCrsTxgFoNHDPBfAbBL8zbvd4lqVEhiiq6Rof
 72Q8EJRIX5x/c4njz09HmEMYKFrDq9UHeDhlnXObC78C/A64/PT+1gskvg/NGjZl2cTQCmGCV
 iLNgiYAMD7/UibrVPAmmWMR+LpwGFms47RvN2UdCNbLaa7VqlhsvZUn5uecrPDb5Ipi7N2ug1
 /vKY1W1b6fBq0v9Wdu+qXguGp9MJRbXPKbZHG8gAHOA72x3WRvhgpdi5Sui5TAJU8oAZsJGyL
 MqLCT6Cu2zbPs3q3u7fCv6XshEilBO+el774JIPKmH6vVkWWnElCNGL4TGy00D6WDcfddBWEA
 fK6lIkCUyrZQMZ93iiU1boV2tCHhmHl0UvAqH94zMYWOLqFE7KEEerbKu378ETqUO0kGWE4Vo
 OzI4PRFzn6JcgQoDAha33S0VPaa+b28KXzVF97C2BQb/HNx+iFn0FYo2+4f8NkYkZVN/BaLoM
 56UhstFuQRMDfdAm9gfdguZLLSa3l9sNYIf0tGis1enLJkSVWQ3RsfKFCTxA81EWdPHhXnIfr
 xmADubCMRSq4b2+r9bo1ZUhNWje7GqXJzVNgYYcroaz0tq/1rOjUyLQJy915bbIDsE+9wyKp8
 mtHqtfS4iFQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even though the ChipIdea USB controller binding[1] doesn't specify the
properties that reference a PHY as required, the Linux driver
requires[2] such a reference.

The clock situation is like on i.MX53: The USB controller is clocked
from IMX5_CLK_USBOH3_GATE and the PHY from IMX5_CLK_USB_PHY1_GATE.

[1]: Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
[2]: Search for EINVAL in drivers/usb/chipidea/ci_hdrc_imx.c

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 arch/arm/boot/dts/imx50.dtsi | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx50.dtsi b/arch/arm/boot/dts/imx50.dtsi
index ee1e3e8bf4ec..e5632ce24ba0 100644
=2D-- a/arch/arm/boot/dts/imx50.dtsi
+++ b/arch/arm/boot/dts/imx50.dtsi
@@ -76,6 +76,14 @@
 		};
 	};

+	usbphy0: usbphy-0 {
+		compatible =3D "usb-nop-xceiv";
+		clocks =3D <&clks IMX5_CLK_USB_PHY1_GATE>;
+		clock-names =3D "main_clk";
+		#phy-cells =3D <0>;
+		status =3D "okay";
+	};
+
 	soc {
 		#address-cells =3D <1>;
 		#size-cells =3D <1>;
@@ -187,7 +195,8 @@
 				compatible =3D "fsl,imx50-usb", "fsl,imx27-usb";
 				reg =3D <0x53f80000 0x0200>;
 				interrupts =3D <18>;
-				clocks =3D <&clks IMX5_CLK_USB_PHY1_GATE>;
+				clocks =3D <&clks IMX5_CLK_USBOH3_GATE>;
+				fsl,usbphy =3D <&usbphy0>;
 				status =3D "disabled";
 			};

=2D-
2.20.1

