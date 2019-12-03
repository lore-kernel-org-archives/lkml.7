Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1310DC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 12:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAB5E206DF
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 12:03:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="KnHFG1qs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Rm3MmifX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfLCMDi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 07:03:38 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:38383 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726008AbfLCMDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 07:03:37 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id C3E8C22083;
        Tue,  3 Dec 2019 07:03:35 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 03 Dec 2019 07:03:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=tDbn2lnY4YnA7
        5X5LYWz7jhosHuxo/9hHasNksDYQ9E=; b=KnHFG1qsnC0CBWROzsm9lLVGD4yXX
        yXsn8x7JfmL1iMicxQ9Bv29H1/ImfJvpNNvzhqUVtwD2RU7NyxFfelvNu+fLskbn
        R12c4F9x3IlOJb6aK2ahWGEbb4lGMHuTrirLaboXsWZFQBl7zPcxfqdmHpEWMZVt
        xpLjzL3SQX5VcS43sOAeMFSagogwYb3QpG4R3TlFORjm2TDCa5DA4Ix/+QPwDAZA
        qeLMZLn54OPBQiQy7d/S1QJKBNQ/WkQG2fZta5QFvAmeX5jmcU3jsM6Sufue3B1Q
        qIVoSx0E04zhNhHYiDWgWHM8UQKLiNyN0/ByOcmIGpPgg0OZgG0Zxl+fA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=tDbn2lnY4YnA75X5LYWz7jhosHuxo/9hHasNksDYQ9E=; b=Rm3MmifX
        jeHEre1+PElzDzsddqxc2BTQrHIWquaWQ+1Swf87C07BWCxVYqya0CDpBd4R6Hwz
        G94AKvElbOT6ewWpHGCOYwKrLZxVDvsKMaInhyYJHDO7eHIju+E4po2DmCcdh1MR
        jOh8qu6uzqTmNaHSMOZQxgaRljylYsT/JihlbVBF/7X6lQ1j2fiwnn/2ppEl7twB
        ZddbSeCZWi+cetEpaufHo+IJMs2vE/h6wBDhSRThSoUaEMFz2rFRLY4ccZPFq808
        urA9uTyKEShr2ZU9ODPWGn0Lx2VV0KkYhfzAO3l/I3wDyvaDXwU1rcsfHA4N12st
        qGApoVMc/nxrCg==
X-ME-Sender: <xms:F0_mXUYOT_MKjOxhU5H2gjlKPh-NZCOSBwDnL_WzOpb1jlOqHXwY7w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudejjedgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehnughrvgifucflvghffhgvrhihuceorghnughrvgifsegr
    jhdrihgurdgruheqnecukfhppeduudekrddvuddurdelvddrudefnecurfgrrhgrmhepmh
    grihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgvrhfuihii
    vgepudef
X-ME-Proxy: <xmx:F0_mXZqVPzaBlE9vSyCRRDplhbuuqGw8cMn2T36O9LTbCvZttfhpOw>
    <xmx:F0_mXQvddJzgU4CqVnAzs4k7xGJh3V921k6hJciCtfjQRjYGHvz1ig>
    <xmx:F0_mXTNFpNdOoll9xKxb7AAI3cUWHOuuSPQJIvRXNsZzYL3Z7JVzVw>
    <xmx:F0_mXXJfGDDVZlPr89JXlnzVgi2cAAwhyNrjUe530FXhl5FK2ZrjaQ>
Received: from mistburn.lan (unknown [118.211.92.13])
        by mail.messagingengine.com (Postfix) with ESMTPA id B435530600D2;
        Tue,  3 Dec 2019 07:03:32 -0500 (EST)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-aspeed@lists.ozlabs.org
Cc:     joel@jms.id.au, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 14/14] ARM: dts: ibm-power9-dual: Add a unit address for OCC nodes
Date:   Tue,  3 Dec 2019 22:34:15 +1030
Message-Id: <895711a51b34e0618761cb9e6594e6734769e1cc.1575369656.git-series.andrew@aj.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.08e3a6c95159f017b753d0f240086d1a7923758b.1575369656.git-series.andrew@aj.id.au>
References: <cover.08e3a6c95159f017b753d0f240086d1a7923758b.1575369656.git-series.andrew@aj.id.au>
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
git-series 0.9.1
