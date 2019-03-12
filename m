Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A183C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0465C205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552413505;
	bh=PV18HEirU5NtI+UTocHR1iBT+UGQDa2j60gIi+fZQZ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ev7kzpSBO7cyNh1zqpQ2tYv2IgKfN+qXQQH9xart6+v7qwHDgN5E5lxqGn/svoXgJ
	 M231AznWD8wkRlVEPxPANJb7nb/FIV4xCNS3sNk7Ihee+/a2ZLaLyjvUkCo/bICJRm
	 YvaalencIyuIkkFgcPSUS4pesAAlSqMPSB5QEtvc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728531AbfCLR6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:58:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:51052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727525AbfCLRNl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:13:41 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E115D21872;
        Tue, 12 Mar 2019 17:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410821;
        bh=PV18HEirU5NtI+UTocHR1iBT+UGQDa2j60gIi+fZQZ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QpEfTS/Q7LuhHR/WhqlmLdeymLKaHyIV8I5tyqJyICi1Trxu5FQLIh/DiUAcL3MKV
         QUTg/52OzWxmc9fWLDx8FFt6X4ZdRSrxLTjUPdUtnh2xSs/syU429rpBqMm/4GqOi3
         yqoGR1DDpS4cRUgO9WIpjoC+BgR+qFvHx+Ye9ZIU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jan Kiszka <jan.kiszka@siemens.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH 4.20 154/171] arm64: dts: zcu100-revC: Give wifi some time after power-on
Date:   Tue, 12 Mar 2019 10:08:54 -0700
Message-Id: <20190312170400.768888216@linuxfoundation.org>
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

commit 35a4f89cd4731ac6ec985cd29ddc1630903006b7 upstream.

Somewhere along recent changes to power control of the wl1831, power-on
became very unreliable on the Ultra96, failing like this:

wl1271_sdio: probe of mmc2:0001:1 failed with error -16
wl1271_sdio: probe of mmc2:0001:2 failed with error -16

After playing with some dt parameters and comparing to other users of
this chip, it turned out we need some power-on delay to make things
stable again. In contrast to those other users which define 200 ms,
Ultra96 is already happy with 10 ms.

Fixes: 5869ba0653b9 ("arm64: zynqmp: Add support for Xilinx zcu100-revC")
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
@@ -101,6 +101,7 @@
 	sdio_pwrseq: sdio_pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&gpio 7 GPIO_ACTIVE_LOW>; /* WIFI_EN */
+		post-power-on-delay-ms = <10>;
 	};
 };
 


