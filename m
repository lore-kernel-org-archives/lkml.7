Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E014BC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B4302075B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355813;
	bh=ZOZRlL/3zrwI58MuYxYhe+4mdWScVzQPvJ577mkH9Lc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0puzBsn0gynOcfSoaf/a5Qau4zYdQXKYYQiFZjm4Pw2zkRryaASfBTUgQEvwwJ8qf
	 VqisPPcm5KkbnxCbVLUVrLmPksOuJUIC5GkfimVlUVbFPQNOAIg+KU/QUNG9CVHzMt
	 mxw+O7Vzq68u93IXvvGOK+9RSlstRJ+tuKC75QrQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731570AbfDOTQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:16:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:50410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728625AbfDOTMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:12:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBDAE2075B;
        Mon, 15 Apr 2019 19:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355573;
        bh=ZOZRlL/3zrwI58MuYxYhe+4mdWScVzQPvJ577mkH9Lc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qydc7+muJ/0TI/ecUyhR7fb4lL2YDjepbDEXvuPv9LJZ+Kw8ISIg3XSFyMd0d2Ca1
         NJs+l64cLqji8C6ihMLqBaXaeh0TAsDnrpCvdIKOOFTPHmSrtrcAYny/y6qYi6L9NB
         rTJxPeamatWiOJel63Op1iXGEtDGC1AT6Es6fbK8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jonas Karlman <jonas@kwiboo.se>,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 5.0 086/117] ARM: dts: rockchip: fix rk3288 cpu opp node reference
Date:   Mon, 15 Apr 2019 21:00:56 +0200
Message-Id: <20190415183749.281424656@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183744.887851196@linuxfoundation.org>
References: <20190415183744.887851196@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonas Karlman <jonas@kwiboo.se>

commit 6b2fde3dbfab6ebc45b0cd605e17ca5057ff9a3b upstream.

The following error can be seen during boot:

  of: /cpus/cpu@501: Couldn't find opp node

Change cpu nodes to use operating-points-v2 in order to fix this.

Fixes: ce76de984649 ("ARM: dts: rockchip: convert rk3288 to operating-points-v2")
Cc: stable@vger.kernel.org
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/rk3288.dtsi |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -70,7 +70,7 @@
 			compatible = "arm,cortex-a12";
 			reg = <0x501>;
 			resets = <&cru SRST_CORE1>;
-			operating-points = <&cpu_opp_table>;
+			operating-points-v2 = <&cpu_opp_table>;
 			#cooling-cells = <2>; /* min followed by max */
 			clock-latency = <40000>;
 			clocks = <&cru ARMCLK>;
@@ -80,7 +80,7 @@
 			compatible = "arm,cortex-a12";
 			reg = <0x502>;
 			resets = <&cru SRST_CORE2>;
-			operating-points = <&cpu_opp_table>;
+			operating-points-v2 = <&cpu_opp_table>;
 			#cooling-cells = <2>; /* min followed by max */
 			clock-latency = <40000>;
 			clocks = <&cru ARMCLK>;
@@ -90,7 +90,7 @@
 			compatible = "arm,cortex-a12";
 			reg = <0x503>;
 			resets = <&cru SRST_CORE3>;
-			operating-points = <&cpu_opp_table>;
+			operating-points-v2 = <&cpu_opp_table>;
 			#cooling-cells = <2>; /* min followed by max */
 			clock-latency = <40000>;
 			clocks = <&cru ARMCLK>;


