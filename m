Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85213C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 12:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CB4F2145D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 12:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Dsbr10yf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729160AbfFKM3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 08:29:24 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:33336 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729050AbfFKM3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 08:29:20 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x5BCTE8L082489;
        Tue, 11 Jun 2019 07:29:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1560256154;
        bh=+m5lWAHlVVfRyb53JNXW40WcTZCtmXwYvnNTIZSy6Os=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Dsbr10yfazoV+xdC8T3/Hh5v7PyJPq05OXDqJkdBJdxoIWYYt78gOlGx8eibPRGbw
         viUS+2DAHIoaSuXw7wI/6peKUgkLSkNZkOqrtfa01yQeTXvEygv6u+U/tS75XSy1hm
         8zXY1Kn358AB/6zT+SvgU8CFQyji4V8EAsFrnsHw=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x5BCTEve054631
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Jun 2019 07:29:14 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 11
 Jun 2019 07:29:14 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 11 Jun 2019 07:29:14 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x5BCT9s7010308;
        Tue, 11 Jun 2019 07:29:12 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>
CC:     <alsa-devel@alsa-project.org>, <misael.lopez@ti.com>,
        <jsarha@ti.com>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] bindings: sound: davinci-mcasp: Add support for optional auxclk-fs-ratio
Date:   Tue, 11 Jun 2019 15:29:40 +0300
Message-ID: <20190611122941.10708-2-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190611122941.10708-1-peter.ujfalusi@ti.com>
References: <20190611122941.10708-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When McASP is bus master it's reference clock (AUXCLK) might not be a
static clock, but running at a specific FS ratio.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 .../devicetree/bindings/sound/davinci-mcasp-audio.txt          | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt b/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
index a58f79f5345c..c483dcec01f8 100644
--- a/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
+++ b/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
@@ -44,6 +44,9 @@ Optional properties:
   		 please refer to pinctrl-bindings.txt
 - fck_parent : Should contain a valid clock name which will be used as parent
 	       for the McASP fck
+- auxclk-fs-ratio: When McASP is bus master indicates the ratio between AUCLK
+		   and FS rate if applicable:
+		   AUCLK rate = auxclk-fs-ratio * FS rate
 
 Optional GPIO support:
 If any McASP pin need to be used as GPIO then the McASP node must have:
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

