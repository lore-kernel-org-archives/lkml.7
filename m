Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E72CBC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 13:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE411206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 13:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=jaseg.net header.i=@jaseg.net header.b="P1bccKss";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vCqjsyaj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfG3Nsb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 09:48:31 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:48245 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725871AbfG3Nsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 09:48:30 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 4332321FF5;
        Tue, 30 Jul 2019 09:48:30 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 30 Jul 2019 09:48:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaseg.net; h=
        from:subject:to:cc:in-reply-to:message-id:date:mime-version
        :content-type:content-transfer-encoding; s=fm3; bh=YBZJLvOv94xbG
        cKq0AjJSs0mHgqSOiwsUSfwbFtC4lE=; b=P1bccKssVFwepyB2iWiQLtwiCTjUI
        hHuFKwYZQOfPPY5vYO70gZNaeHpfNMhJ0AxG3QCObDEP2NR9dIzqO+D1yuY/Xkm/
        TeGxTTcKoY8BOn3bBXM5IyKlqsspLjI9mGgfUjziQ9IlXolTi33EUUFkjKuTQRz/
        jO+Crg1fenKdaURSIJVdUyK9twwHAYNbJpzAAtotp+2W0YO0nhaPx0I5NxVQ6i5y
        muEaCa2hHKps9QXwCEGmUWJ9hJnAfjmqwu8OpRpPuDG02BAiuFJptk/JOgjJ1JB1
        xmf100YAnKrQrteKF7Ylj/8soLt6nxasYN6En32zS38S4Usss2UmX2FVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=YBZJLvOv94xbGcKq0AjJSs0mHgqSOiwsUSfwbFtC4lE=; b=vCqjsyaj
        dzkYcvMzpcNQRJEmYi1aY0vmz7anGhSAww8wzW44bNpOeUht7r5h2Zq7EB3CEH1P
        EapAywOFVygOU4xphNMXoSH8ev79kCcT+mU6UZ1lspWeECTe0I7T/UF7IcyCyAZB
        XLoyC/E6kx9/Fdi1rjALwYm2TIv3Ytxi7w83yFEHcGaUB5bLZ6TC1IwbEjmPfmHa
        RnFXxL9NcFDSDCmCXIahKjeucAj/yCgzIPP9jBchJhbc/if5V63gSniTYahVhZKu
        s4sqKHz03h9j/gqnzrMctmD9HRMU2UxszzPRz2MWLxvzGDZWx4bmLynjtSFTrOu8
        LTEAJlT1hr9R2A==
X-ME-Sender: <xms:rkpAXZ7qCqnOfRAmfgQR7kICuC20_bUtX3brz9dTrWhy33pLpnHL5A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrleefgdeijecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhuffvjgfkffgfgggtgfesthekredttdefjeenucfhrhhomheplfgrnhgpufgv
    sggrshhtihgrnhgpifpnthhtvgcuoehlihhnuhigsehjrghsvghgrdhnvghtqeenucfkph
    epiedtrdejuddrieefrdejheenucfrrghrrghmpehmrghilhhfrhhomheplhhinhhugies
    jhgrshgvghdrnhgvthenucevlhhushhtvghrufhiiigvpeef
X-ME-Proxy: <xmx:rkpAXSHNMqbocVeIo3B1PvqG-BEA7DaX8xxF522-lTTAdv3bKm6uKQ>
    <xmx:rkpAXflXbzTAYyoN9zbUJyrc7cldAuGzlU3f-xn8F8e1mi8tS86K7A>
    <xmx:rkpAXSbplTFFzS40jZ_U2DI4s5mzuXkRlxtAquMgM7VG2HCBU1-reg>
    <xmx:rkpAXf5p3ak2vUnAA06dsKcIObrCPJVu6OUxrOtKZ1d7rxkWq6UhoQ>
Received: from [10.137.0.16] (softbank060071063075.bbtec.net [60.71.63.75])
        by mail.messagingengine.com (Postfix) with ESMTPA id BCCF380059;
        Tue, 30 Jul 2019 09:48:28 -0400 (EDT)
From:   =?UTF-8?Q?Jan_Sebastian_G=c3=b6tte?= <linux@jaseg.net>
Subject: [PATCH 4/6] dt-bindings: add gdepaper documentation
To:     dri-devel@lists.freedesktop.org
Cc:     =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        David Airlie <airlied@linux.ie>
In-Reply-To: <3c8fccc9-63f7-18bb-dcb5-dcd0b9e151d2@jaseg.net>
Message-ID: <5ba77164-cbb5-8c2f-5980-5dce22716329@jaseg.net>
Date:   Tue, 30 Jul 2019 22:48:26 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jan Sebastian Götte <linux@jaseg.net>
---
 .../devicetree/bindings/display/gdepaper.txt  | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/gdepaper.txt

diff --git a/Documentation/devicetree/bindings/display/gdepaper.txt b/Documentation/devicetree/bindings/display/gdepaper.txt
new file mode 100644
index 000000000000..7b86304d982f
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/gdepaper.txt
@@ -0,0 +1,27 @@
+Good Display/Waveshare e-ink displays
+
+Required properties:
+- compatible:		"gooddisplay,wfi0190cz22" for 2.7" b/w/red displays,
+			replace part number for other displays.
+			Use "gooddisplay,generic_epaper" to manually configure
+			the display's resolution etc.
+
+- dc-gpios:		Data Command
+- reset-gpios:		Reset pin
+- busy-gpios:		Busy pin
+- spi-speed-hz		SPI baud rate to use to when talking to the display
+
+The node for this driver must be a child node of a SPI controller, hence
+all mandatory properties described in ../spi/spi-bus.txt must be specified.
+
+Example:
+
+	epaper@0{
+		compatible = "gooddisplay,gdew042z15";
+		reg = <0>;
+		spi-speed-hz = <1000000>;
+		spi-max-frequency = <6000000>;
+		dc-gpios = <&gpio 25 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&gpio 17 GPIO_ACTIVE_HIGH>;
+		busy-gpios = <&gpio 24 GPIO_ACTIVE_LOW>;
+	};
-- 
2.21.0

