Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A1FC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BE5B20645
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558356030;
	bh=EQhskojXmAX5CVh8wrKwzyU9tISCLNM0vDhTiTdmXIk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=A0Ipd2rHKVNKcEDuhi6QFUOV5cLWVE0WdOFKJoInikoe+CDcFbsNd4z/+epvTfiu4
	 blZPCMAZLs0c7RI5RQNXFFj9uGd2uqBB3KR3WKWRPSB/c3zX3JCtvgJBjKHV8uTSSm
	 bA/O6kjqYSWlqeDbgQqr9p2zupasDKGcHVkqstMI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391442AbfETMk3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 08:40:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:49764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390617AbfETMcq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 08:32:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CD7F204FD;
        Mon, 20 May 2019 12:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558355565;
        bh=EQhskojXmAX5CVh8wrKwzyU9tISCLNM0vDhTiTdmXIk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r4ivF82L1JeB2myDO2H/o9Yu57FBeQYVDYcrP96fe7jn1EY8AFiED7QsFl7aDtxWt
         lRkwaUa+qk/yYE43iOwftw0OfwiqIKap7m78iPDa02lE8oygVqg2g74J/XV8M1Nb1W
         fYvfcxCuFIG9O5OVDyDvBkQValZxCynHr/9QFxR0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Bauer <mail@david-bauer.net>,
        Christian Lamparter <chunkeey@gmail.com>,
        Andy Gross <agross@kernel.org>
Subject: [PATCH 5.1 007/128] ARM: dts: qcom: ipq4019: enlarge PCIe BAR range
Date:   Mon, 20 May 2019 14:13:14 +0200
Message-Id: <20190520115249.952234512@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520115249.449077487@linuxfoundation.org>
References: <20190520115249.449077487@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Lamparter <chunkeey@gmail.com>

commit f3e35357cd460a8aeb48b8113dc4b761a7d5c828 upstream.

David Bauer reported that the VDSL modem (attached via PCIe)
on his AVM Fritz!Box 7530 was complaining about not having
enough space in the BAR. A closer inspection of the old
qcom-ipq40xx.dtsi pulled from the GL-iNet repository listed:

| qcom,pcie@80000 {
|	compatible = "qcom,msm_pcie";
|	reg = <0x80000 0x2000>,
|	      <0x99000 0x800>,
|	      <0x40000000 0xf1d>,
|	      <0x40000f20 0xa8>,
|	      <0x40100000 0x1000>,
|	      <0x40200000 0x100000>,
|	      <0x40300000 0xd00000>;
|	reg-names = "parf", "phy", "dm_core", "elbi",
|			"conf", "io", "bars";

Matching the reg-names with the listed reg leads to
<0xd00000> as the size for the "bars".

Cc: stable@vger.kernel.org
BugLink: https://www.mail-archive.com/openwrt-devel@lists.openwrt.org/msg45212.html
Reported-by: David Bauer <mail@david-bauer.net>
Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
Signed-off-by: Andy Gross <agross@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/qcom-ipq4019.dtsi |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/arm/boot/dts/qcom-ipq4019.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq4019.dtsi
@@ -400,8 +400,8 @@
 			#address-cells = <3>;
 			#size-cells = <2>;
 
-			ranges = <0x81000000 0 0x40200000 0x40200000 0 0x00100000
-				  0x82000000 0 0x40300000 0x40300000 0 0x400000>;
+			ranges = <0x81000000 0 0x40200000 0x40200000 0 0x00100000>,
+				 <0x82000000 0 0x40300000 0x40300000 0 0x00d00000>;
 
 			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "msi";


