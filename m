Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB985C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A257220656
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558354735;
	bh=/ZDirSr4DmEBepW/wwMooQlLpLOMWW3JUyAPfpmrj2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XKjtPHRcyM/0kDhbBfK40D/lNBuMEEh787NehN6QnDHrHrBw42ElW8G7p9QXYBbBf
	 +2WQUADfO10hIJE1rffscPZCXI5BAfc0HwyqgxB+JhqE/TLvyXB8XqiFdsM5xeN7Fo
	 dGFxCyYrMjwTqni0fN8udOgkO6hrT8aW5df1FtPQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387763AbfETMSy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 08:18:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:59996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733110AbfETMSr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 08:18:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BCE7820815;
        Mon, 20 May 2019 12:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558354727;
        bh=/ZDirSr4DmEBepW/wwMooQlLpLOMWW3JUyAPfpmrj2g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lE339qk0OZ9R07UI8cj59IkRGS4nqN/+QTRWYMxBLpBUM3OcYWHS0vlRe38QySsHr
         N6yf33CpBa1bEd/42FR9EsLYxN64IqHHjdxb1s+/mqNx3n6LkUdrBLIkbwcEvRpXgM
         yaVoyve1GnZyif06Tr1zITJjbvh6o7J7q8R0IEr0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Stuart Menefy <stuart.menefy@mathembedded.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 4.14 09/63] ARM: dts: exynos: Fix interrupt for shared EINTs on Exynos5260
Date:   Mon, 20 May 2019 14:13:48 +0200
Message-Id: <20190520115232.301143487@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520115231.137981521@linuxfoundation.org>
References: <20190520115231.137981521@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stuart Menefy <stuart.menefy@mathembedded.com>

commit b7ed69d67ff0788d8463e599dd5dd1b45c701a7e upstream.

Fix the interrupt information for the GPIO lines with a shared EINT
interrupt.

Fixes: 16d7ff2642e7 ("ARM: dts: add dts files for exynos5260 SoC")
Cc: stable@vger.kernel.org
Signed-off-by: Stuart Menefy <stuart.menefy@mathembedded.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/exynos5260.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/boot/dts/exynos5260.dtsi
+++ b/arch/arm/boot/dts/exynos5260.dtsi
@@ -226,7 +226,7 @@
 			wakeup-interrupt-controller {
 				compatible = "samsung,exynos4210-wakeup-eint";
 				interrupt-parent = <&gic>;
-				interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
 			};
 		};
 


