Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A3A9C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E713F2087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552414382;
	bh=tZeXPsqJ1QZgIJBr0QZVQCRje8A+GVzBXkSg2v1szzo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VtZeAGPqrjW8GZqj5h0tjuiZlFctUrtxlJQ8NVgjKPomRkjGlQNDAa259p/Ccpsjy
	 QI46l8YFCVTEeoN8HNySjh7cpw9kT7mA0+SNBU7IH+xPOVxQwlkrhQyMzaOyRVJaO/
	 GgxBQjXBVWNYn3RSTnOMCO7tdHEKk5wZJwz5nIME=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbfCLSNA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 14:13:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:45022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726991AbfCLRLd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:11:33 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6829A21741;
        Tue, 12 Mar 2019 17:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410692;
        bh=tZeXPsqJ1QZgIJBr0QZVQCRje8A+GVzBXkSg2v1szzo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YCU0kh/Yn1XmeOYrkUDlC0Z4zUVN9oe/SGiQhpON8M9QlVnAuLgjfBiWXgs14VRSW
         ACw08i6U8JbbiR5PvhHf2jRCo2GnYs5KaOzhsNecJlG1r2xmGznW4iaT/T2o0qMYow
         mGCNYvciWva9z+0WdwzpMw0TYmpjfWIM6hABJvMg=
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
Subject: [PATCH 5.0 09/25] arm64: dts: hikey: Revert "Enable HS200 mode on eMMC"
Date:   Tue, 12 Mar 2019 10:08:47 -0700
Message-Id: <20190312170404.252297707@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170403.643852550@linuxfoundation.org>
References: <20190312170403.643852550@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

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


