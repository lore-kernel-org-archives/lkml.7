Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F591C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E806D214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552412292;
	bh=keFLx4MFF91ze69X61P08UPBsR9iiTjotC8EY7ofByI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yVCY9u7lOV0Rc0jRDv10ySDbFjzWh6w5gRL9cp8RTbHMEQhyDzKExDusGldwIXMjm
	 FqfZFPAFRHyvtVDZyhbWqL2GhZn/tdy1zS58r5eAyXj63HdhV3Aq52Tpo6Sn/4OvrX
	 t3M3Ff2fmzRypI1jrAfuCzvh8UzJffvxYkKnzmM4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729183AbfCLRQd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:16:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:56016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728729AbfCLRPa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:15:30 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 477BB2171F;
        Tue, 12 Mar 2019 17:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410929;
        bh=keFLx4MFF91ze69X61P08UPBsR9iiTjotC8EY7ofByI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p1SmX8zQV0CONFxPOVrrXZWHN2ZSetuPXtZy2HGvLF4PnRmV1DF/kLA++zkEpOB0P
         jV43J2kmu5OCgUAcfsjcOjrbycdrPS0V5tM1eG2QtlolOq3adXVtuKPh7/Nil2EVmC
         I8rhBuyoEU40EO6bVwSo4YsJ0X6K41FEMdZfAGHo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ryan Grachek <ryan@edited.us>,
        Wei Xu <xuwei5@hisilicon.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Alistair Strachan <astrachan@google.com>,
        John Stultz <john.stultz@linaro.org>
Subject: [PATCH 4.19 130/149] arm64: dts: hikey: Revert "Enable HS200 mode on eMMC"
Date:   Tue, 12 Mar 2019 10:09:08 -0700
Message-Id: <20190312170400.288034872@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170349.421581206@linuxfoundation.org>
References: <20190312170349.421581206@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alistair Strachan <astrachan@google.com>

commit 8d26c1390aec795d492b8de5e4437751e8805a1d upstream.

This reverts commit abd7d0972a192ee653efc7b151a6af69db58f2bb. This
change was already partially reverted by John Stultz in
commit 9c6d26df1fae ("arm64: dts: hikey: Fix eMMC corruption regression").

This change appears to cause controller resets and block read failures
which prevents successful booting on some hikey boards.

Cc: Ryan Grachek <ryan@edited.us>
Cc: Wei Xu <xuwei5@hisilicon.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org
Cc: stable <stable@vger.kernel.org> #4.17+
Signed-off-by: Alistair Strachan <astrachan@google.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
Signed-off-by: Wei Xu <xuwei5@hisilicon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts |    1 -
 1 file changed, 1 deletion(-)

--- a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
@@ -301,7 +301,6 @@
 
 		dwmmc_0: dwmmc0@f723d000 {
 			cap-mmc-highspeed;
-			mmc-hs200-1_8v;
 			non-removable;
 			bus-width = <0x8>;
 			vmmc-supply = <&ldo19>;


