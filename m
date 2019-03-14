Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF42BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 08:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6FA521019
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 08:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=openedev.com header.i=@openedev.com header.b="Fd/lEX26"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbfCNIrP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 04:47:15 -0400
Received: from se15t.web-hosting.com ([162.255.118.154]:54375 "EHLO
        se15t.web-hosting.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbfCNIrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 04:47:15 -0400
Received: from [68.65.123.203] (helo=server153.web-hosting.com)
        by se15.registrar-servers.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <akash@openedev.com>)
        id 1h4Kfa-00066Y-Ds; Thu, 14 Mar 2019 00:20:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=openedev.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=L9KydG/K+NUtBi5oOaMFrE5iITC8v0A7DoMtgLN5Cq0=; b=Fd/lEX26dX9cB4cdbeyGuCkL5b
        7r1xpfnGVmy+XhcSjdRiJDrZjJtLCJoNuVLybWPeJq7I0Aek9p3Z1XoKXcGfjGWnZix/HocbbSQvy
        YE7TSUOHnc8oXxqpEMpWJ0m+6xV8RxJT7UzSvKjk+Be+yNprSev4YUwu+ERTJYKFyUH3DR1Eior5Y
        ClC1ry6pSle/rZL9fR2fIQSg4uJ/qLWPZggglkTsONzNGMWH8+3tvVlY7APn+w67GvvNXeImM6Vtq
        OCRwbibnyZOvF6Pk0ZGuEVZ4Q/XOkpljv2nP4wMbSr6BvpW5jONmEP3YDd6lDCDnkT6AtHK6zhy+l
        SyIVsVqw==;
Received: from nat-inn.mentorg.com ([192.94.34.34]:19766 helo=agajjar-vr.inn-wifi.mentorg.com)
        by server153.web-hosting.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <akash@openedev.com>)
        id 1h4KfZ-002iQG-3Z; Thu, 14 Mar 2019 03:20:49 -0400
From:   Akash Gajjar <akash@openedev.com>
To:     heiko@sntech.de
Cc:     Akash Gajjar <akash@openedev.com>,
        =?UTF-8?q?Andrius=20=C5=A0tikonas?= <andrius@stikonas.eu>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Vicente Bergas <vicencb@gmail.com>,
        Pragnesh Patel <Pragnesh_Patel@mentor.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: rockchip: add mali gpu support on rock960
Date:   Thu, 14 Mar 2019 12:48:42 +0530
Message-Id: <20190314071853.32176-3-akash@openedev.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190314071853.32176-1-akash@openedev.com>
References: <20190314071853.32176-1-akash@openedev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OutGoing-Spam-Status: No, score=-0.5
X-Originating-IP: 68.65.123.203
X-SpamExperts-Domain: nctest.net
X-SpamExperts-Username: whmcalls3
Authentication-Results: registrar-servers.com; auth=pass (login) smtp.auth=whmcalls3@nctest.net
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.03)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5lMPI87ZyI+asQ6xS4wMAPZ602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO9Kz5dih1EthU2MWX/atyIZ0kTMsB94LwW8ZN2sS57gfLwzUX7TXOtaq5aORn2baFRjr
 dLldmwqWZjEw2lWOqONg+6d+vVnClNcaHHg4+HBie3u1qNGW8JhNDRlyXw90mNUojfcw2mvVYgaF
 7R4Nq6M2uT75/bHUV0hzFQBt087qxR5lDokjkdmXOD+VbkEJYn4IVrxUJFnyj6nET61XOPekDg/8
 KBBmTt77WjEO9dKSp7ak+Y4NgM/NmE0KCGd3riidpDsdQonTLMh6L/+x+4NpnbTqgaHcIC6UHxUV
 Dh3xzJlM49QIjoztGSyx+/vOFDlnWvpT7I2S76vZY71hhmBhNswRz25079tw4G7Z2x4cGtJiw53d
 qulPCDYQKbu7I7RdtvvPkw5oM1e+KNmpMey1fr3z7O1ewfolpqk29AXTnD32/mt3TbW1oIGms4Ec
 P4C/tOVjI4dWyTvfTQXGjT+aEfC5mTBtCltny75g3MKuTOGkaNRv4coischCI8XZGLL4B+ErFY1U
 RUy06HsjHLlqsTcMcmoZyVJsVk7iVlZvWBsS3EZt9a+xyS/dOq7TUuG+L3bB+j+CVTRhnzm1Nba8
 7gDjZ07+/reN5VC1Nt5sWmuNA8WTybi1JN85FSnfKTyNOwPWvr2eQIsh10IlvMnQ0IIgvIstpD15
 BM6zO/FBOSMe/wvVcKjx/+UKUJ2dATB6AfvblXyj02a3Cw6CrTQhPfNf9nOHpykNhSXpzpjT/mvX
 JYhzeNctU3+zxwd6ti1bnnIt8N6f/CuhLXUVc1pzxfB9KTlrrA+Lc9L7q8GGkhIiorUZ3JATRbIw
 E4M7LfS/U6nQBaqEPay2NtTfamiM3hfzMBl8hnwKNP0YidMw83fxTKrc9DzINJyv7zrrYHcPhRP9
 t1Bhkyq0nBWAZo9XwZ1ws+h8UjXrmz4WLyhA0LDG/G6H7G18yhxuoyf9CjDy69sBxxnhZaNlMhf0
 yEspOMQJvQ/Ck3iiU+4DQAj3eBtzHxmMpdcJLP6h+BqkOPkzKvGCTzOXORlHyGDj+2MLC9DLbVGU
 m3NG3JI5qPYoLHTHlLGaRLF7izLRPLwy3SiZG3Rfh0Hv26E0HHrAMbRGfF8i8PTFZFJqyqrE2dZ/
 2oQwXRNl8amP2PqQ/v0S3E6uhs/Q2KE1Lby4XA9T8BlT0ikNY7j4EN9CrMLZiCokZ6pCNzX0GDqF
 Hnc7CiECq36EId3q8anqWudzZ5J+1ghaAVqVzcOADNlOgmKOxT4mUV8ShebT8U8Xw9HTDfreWRhD
 A2j351jleQ9v0vahVXDX6VptvvxNnuUPvu20HBa4n21Xpgx2swKdR1qkDp+yckKlIgUotFOWz4Xb
 4rXSAHtmbXhBCEgmBHNO2CE+2S+HjgYJdm8xEO/i6lPy/R0iXhq13VtdPYPpQDJAG8jZaE50EhaY
 Q2HQUJjdCwpDm1+TLJXu+jC6iUC5G6ADf/VHYTEvuGslKTrRIXcXpFg5ivY=
X-Report-Abuse-To: spam@se16.registrar-servers.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add gpu node support on board and add the supplying regulator

Signed-off-by: Akash Gajjar <akash@openedev.com>
Signed-off-by: Andrius Štikonas <andrius@stikonas.eu>
---
 arch/arm64/boot/dts/rockchip/rk3399-rock960.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts
index 12285c51cceb..bc8c04190d1a 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts
@@ -62,6 +62,11 @@
 
 };
 
+&gpu {
+	mali-supply = <&vdd_gpu>;
+	status = "okay";
+};
+
 &pcie0 {
 	ep-gpios = <&gpio2 RK_PA2 GPIO_ACTIVE_HIGH>;
 };
-- 
2.17.1

