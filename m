Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87786C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 520A4205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552413497;
	bh=hfkQ0NIWxZ8hBpm9HoMY0xplsJOcAhFSCx+Yurz0jfQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RpcOxn1Djs4UYhW5xx1boPKu3o0bd/EGveBkeBpJR9tpeU8o28FoqNp3w0s/h+wP8
	 yoXr4Hyse48WMmlLobzm2xYNO38d/4kuay0jKYKcY0DAVJ/s/reLHd/Xt0BhSg6BP+
	 mCNzQn/cvYdk3r1DA+0/RMHZpv4Ww3HTu5AE9F7U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728487AbfCLR6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:58:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:51074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728034AbfCLRNm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:13:42 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95748217F5;
        Tue, 12 Mar 2019 17:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410821;
        bh=hfkQ0NIWxZ8hBpm9HoMY0xplsJOcAhFSCx+Yurz0jfQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T+vVe2fk+l8KXcgDjXbUbfk3WlHFrt8fNhRv1jq91nnVFfPrG5PIgjLWO0JNxnhhQ
         SXm/mAOT24zMlpdNYbypcuiQQVnDel5ahVMwLy3zjdlu2WDVTT4jCNbQ9+4+0BK9BK
         JuW5L1KvBqYZuCv7utWUjMnYs8RHVFe1f0YTWBAI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jan Kiszka <jan.kiszka@siemens.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Wei Xu <xuwei5@hisilicon.com>
Subject: [PATCH 4.20 155/171] arm64: dts: hikey: Give wifi some time after power-on
Date:   Tue, 12 Mar 2019 10:08:55 -0700
Message-Id: <20190312170400.834409736@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170347.868927101@linuxfoundation.org>
References: <20190312170347.868927101@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jan Kiszka <jan.kiszka@siemens.com>

commit 83b944174ad79825ae84a47af1a0354485b24602 upstream.

Somewhere along recent changes to power control of the wl1835, power-on
became very unreliable on the hikey, failing like this:

wl1271_sdio: probe of mmc2:0001:1 failed with error -16
wl1271_sdio: probe of mmc2:0001:2 failed with error -16

After playing with some dt parameters and comparing to other users of
this chip, it turned out we need some power-on delay to make things
stable again. In contrast to those other users which define 200 ms, the
hikey would already be happy with 1 ms. Still, we use the safer 10 ms,
like on the Ultra96.

Fixes: ea452678734e ("arm64: dts: hikey: Fix WiFi support")
Cc: <stable@vger.kernel.org> #4.12+
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Wei Xu <xuwei5@hisilicon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
@@ -118,6 +118,7 @@
 		reset-gpios = <&gpio0 5 GPIO_ACTIVE_LOW>;
 		clocks = <&pmic>;
 		clock-names = "ext_clock";
+		post-power-on-delay-ms = <10>;
 		power-off-delay-us = <10>;
 	};
 


