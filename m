Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A79C8C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 725DF2087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552412752;
	bh=E3eUkaguNY57ocXetPIkMPBOXhBCr8kREypziZVFiwQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PwEsjOt0VI1F6GQ7MjmAbwoLxlF4Z+B8zpulPZWgWcxb534BymVD7ZTrhRiL6+bxS
	 LTDAEmy7+2OMHQpbQ4xFYiB6TrYcsaw6jCLxvBcp5HZSjXgrlLyJ+G7N9UpkfuYjKF
	 6YP1cCOZUSl5c4Hwr3Ku9URjzQktZizisOrM98jE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729042AbfCLRpv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:45:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:55956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728718AbfCLRP2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:15:28 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6DA52184E;
        Tue, 12 Mar 2019 17:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410927;
        bh=E3eUkaguNY57ocXetPIkMPBOXhBCr8kREypziZVFiwQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VzGXeumWatTKx0EMbQjeTvB9FJJDzwk9yq4SBqbIThztJKWsapyxokrZzEso8SHPO
         7nHeUd3VNxtxVWrh4J0ZBYg0/fukKJmdtqvrr0rF3i5YEWpvoeWXWP55bL4LiGZZhJ
         RjzGV74X7CJB5Fatn7vuL4i7G1rSFJRB8tjj3ERM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jan Kiszka <jan.kiszka@siemens.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH 4.19 128/149] arm64: dts: zcu100-revC: Give wifi some time after power-on
Date:   Tue, 12 Mar 2019 10:09:06 -0700
Message-Id: <20190312170400.118070150@linuxfoundation.org>
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
 


