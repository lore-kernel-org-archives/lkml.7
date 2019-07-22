Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D72DDC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 16:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB08E2190F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 16:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="XVkDOxOh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730549AbfGVQGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 12:06:40 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:24366 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730127AbfGVQGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 12:06:37 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6MG1ITI002144;
        Mon, 22 Jul 2019 18:06:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=d7z0bc5ddIegrEON9PA826gu/aOX90pz7EYmNLgF1Eg=;
 b=XVkDOxOhGfHnkorsYJLRrlA5ooG84J//7fcFWzDNt/fbRXjIAludfLutY7Hse+BIRoYj
 zAFhgeWo9qYpisJwcXsmHNJkMMx5QqsknzTnW6qUNhKGmWlEMdgd1pB8ZSDLv3Hxvymz
 XvdO4Z03mO3OEnuupt2zkBQLQMRdkTO2ZuxyvVyEEGAUgG/NQZfAp7VcqVZrhsHSl55n
 x4mEh3NGr6sUi0rWohXJuDi8bBhycWjWe8MMnDB34yScZUxH9yQFqMAAfptepbDqyn7Y
 2l+Vn6vdh0bhvryI0f/zXTjELNd8JwKPGBHGo/uifBCzvbiNe2+gFKeEU8QRHAFYUQfj zg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2tuw7w391e-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 22 Jul 2019 18:06:05 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id F02D838;
        Mon, 22 Jul 2019 16:06:04 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas23.st.com [10.75.90.46])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C484652BB;
        Mon, 22 Jul 2019 16:06:04 +0000 (GMT)
Received: from SAFEX1HUBCAS21.st.com (10.75.90.45) by SAFEX1HUBCAS23.st.com
 (10.75.90.46) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 22 Jul
 2019 18:06:04 +0200
Received: from localhost (10.201.23.16) by Webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 22 Jul 2019 18:06:04
 +0200
From:   Olivier Moysan <olivier.moysan@st.com>
To:     <a.hajda@samsung.com>, <narmstrong@baylibre.com>,
        <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
        <jernej.skrabec@siol.net>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <benjamin.gaignard@st.com>, <alexandre.torgue@st.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <olivier.moysan@st.com>, <jsarha@ti.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <devicetree@vger.kernel.org>
Subject: [PATCH v2 2/3] dt-bindings: display: sii902x: Change audio mclk binding
Date:   Mon, 22 Jul 2019 18:05:59 +0200
Message-ID: <1563811560-29589-3-git-send-email-olivier.moysan@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1563811560-29589-1-git-send-email-olivier.moysan@st.com>
References: <1563811560-29589-1-git-send-email-olivier.moysan@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.16]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-22_12:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As stated in SiL9022/24 datasheet, master clock is not required for I2S.
Make mclk property optional in DT bindings.

Fixes: 3f18021f43a3 ("dt-bindings: display: sii902x: Add HDMI audio bindings")

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Reviewed-by: Jyri Sarha <jsarha@ti.com>
Acked-by: Andrzej Hajda <a.hajda@samsung.com>
---
 Documentation/devicetree/bindings/display/bridge/sii902x.txt | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/bridge/sii902x.txt b/Documentation/devicetree/bindings/display/bridge/sii902x.txt
index 2df44b7d3821..6e14e087c0d0 100644
--- a/Documentation/devicetree/bindings/display/bridge/sii902x.txt
+++ b/Documentation/devicetree/bindings/display/bridge/sii902x.txt
@@ -26,9 +26,8 @@ Optional properties:
 	- clocks: phandle and clock specifier for each clock listed in
            the clock-names property
 	- clock-names: "mclk"
-	   Describes SII902x MCLK input. MCLK is used to produce
-	   HDMI audio CTS values. This property is required if
-	   "#sound-dai-cells"-property is present. This property follows
+	   Describes SII902x MCLK input. MCLK can be used to produce
+	   HDMI audio CTS values. This property follows
 	   Documentation/devicetree/bindings/clock/clock-bindings.txt
 	   consumer binding.
 
-- 
2.7.4

