Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EECEAC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 05:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8C3522C7C
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 05:40:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="UnoaOFXE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G+GftQAb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbfGZFki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 01:40:38 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:56359 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726327AbfGZFkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 01:40:35 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id C2B8C22314;
        Fri, 26 Jul 2019 01:40:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 26 Jul 2019 01:40:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=VhghfA5tFplYA
        G4+r3v8vhMBGV0zbnubw2hoRcBBm/Y=; b=UnoaOFXEOcH0mIeQ6xiDJRTx4iXQg
        FaZiasNi23dvnEE9840RIcFwehZ7Bwht4bXwspKig4dgjPgYBI5UcS1CLXIt9yko
        b3jebsEzrycjFRbk5j6xmIFl4GOWO+NyydaLcfRpTCyXEUuaSdnH8qSdTMGBAs/L
        YKg4NDRDBVMv4czzdNCrIcoMkvqa1wW3o6TDliQr0SIWggff2I1eUjq4A/ecdzvE
        d/4zEPdbjVw2x34flxlHFZ1uBxE89uhyJ9NiNnZYfMQMtEtWQisb3Ivi8RSPbw0K
        4XkBlmCfnI3SeZf079IYe7xjQcpoSFdtmkDS52oBimUDOy/Wuv8ybSL+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=VhghfA5tFplYAG4+r3v8vhMBGV0zbnubw2hoRcBBm/Y=; b=G+GftQAb
        /rKZ9MAl7JMDFFpOmCOqFFqZD0CGUR7iC1/XnBvWS4YNwg+TLAxRzJ4h5yooJK84
        U+lY/yCl3tVi15rPc0QjxsCY3qxJb6j7YF8jATMD7yiuvMKT0qlM+5//o+/nYQ2o
        lzmQKpik+2CsMOMTyfNXo+32a83yNXu4zjTZeSyPqF03u9VUKJeorL2CWdLdZ8uA
        ky/i1c4zZ7+qncKpgSRhT2rUmUWl49rDBGge4FsbIGYj9GPRXF3cmGtMVpfr1X7D
        ak6099cdK84kaBJepcfhly+L589qq6XSdB0P+4QDDtXrrjoNiDlhOsjIf0wK/XRK
        VMH76LGgM4SduQ==
X-ME-Sender: <xms:UpI6XXVF_1C1lteWYT6S3CTWIeoE9X8i3ziVLaLl5RSh5G9Tt0Z1Yw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrkeefgdeljecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetnhgurhgvficulfgvfhhfvghrhicuoegrnhgurhgvfiesrghj
    rdhiugdrrghuqeenucfkphepvddtvddrkedurddukedrfedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgvrhfuihiivgep
    ke
X-ME-Proxy: <xmx:UpI6Xa_PMnGd9Qab_zrULwXKFIsKv48MpcoUrUo0-8_XsgKdenlNiQ>
    <xmx:UpI6XcytPj3AIuERkV1HTGPs3NcjqAzEbwZtZzIpoaCFRQc6vsu5aQ>
    <xmx:UpI6XaGPUPeOmv2aJYvCY6rnEUfhD14HApn_HcS39f3fC4koiTYy2w>
    <xmx:UpI6XaANAR6MkRct3Wl-0IE2DCIFr5FTTggCZvpMiDDRTJ91KyQN2g>
Received: from mistburn.au.ibm.com (bh02i525f01.au.ibm.com [202.81.18.30])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2FF26380075;
        Fri, 26 Jul 2019 01:40:30 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-aspeed@lists.ozlabs.org
Cc:     Andrew Jeffery <andrew@aj.id.au>, robh+dt@kernel.org,
        mark.rutland@arm.com, joel@jms.id.au, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/17] ARM: dts: ibm-power9-dual: Add a unit address for OCC nodes
Date:   Fri, 26 Jul 2019 15:09:51 +0930
Message-Id: <20190726053959.2003-10-andrew@aj.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190726053959.2003-1-andrew@aj.id.au>
References: <20190726053959.2003-1-andrew@aj.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These temporarily have a unit address until userspace is fixed up as
noted in comments elsewhere in the dtsi.

Fixes the following warning:

    arch/arm/boot/dts/ibm-power9-dual.dtsi:89.18-91.6: Warning (unit_address_vs_reg): /gpio-fsi/cfam@0,0/sbefifo@2400/occ: node has a reg or ranges property, but no unit name
    arch/arm/boot/dts/ibm-power9-dual.dtsi:190.18-192.6: Warning (unit_address_vs_reg): /gpio-fsi/cfam@0,0/hub@3400/cfam@1,0/sbefifo@2400/occ: node has a reg or ranges property, but no unit name

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 arch/arm/boot/dts/ibm-power9-dual.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/ibm-power9-dual.dtsi b/arch/arm/boot/dts/ibm-power9-dual.dtsi
index 2abc42eda7b0..a0fa65b44b0f 100644
--- a/arch/arm/boot/dts/ibm-power9-dual.dtsi
+++ b/arch/arm/boot/dts/ibm-power9-dual.dtsi
@@ -86,7 +86,7 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-			fsi_occ0: occ {
+			fsi_occ0: occ@1 {
 				compatible = "ibm,p9-occ";
 			};
 		};
@@ -187,7 +187,7 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-			fsi_occ1: occ {
+			fsi_occ1: occ@2 {
 				compatible = "ibm,p9-occ";
 			};
 		};
-- 
2.20.1

