Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27863CA9EBD
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 13:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8F1D222C4
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 13:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572096074;
	bh=sT9oGxFDElGkZpBJtg+vMBwQFwRn09b3hp6SSHi9yxk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=K8CBEaZs5Os0VykuvUBWtbDL+QBt9T23SOZLecaMHvspqLLA0sl7QaVofYnNcgWRh
	 E1GRWPnaG87+6hc96BYj1KhEcOhJ2EOolJdUaHFQV4a4j7d+xy+loiGh8Xgdk4N9MB
	 szLZCTTII8im4ykkWPvNjocN01ZnN4bQvcJteA6U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728817AbfJZNVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 09:21:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:42672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728757AbfJZNU7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 09:20:59 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38A3821E6F;
        Sat, 26 Oct 2019 13:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572096059;
        bh=sT9oGxFDElGkZpBJtg+vMBwQFwRn09b3hp6SSHi9yxk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KC+N4/aC2kUGG8T18Mvm4CVFxR4hMdeScTQ25YXYSP7giTugnj7PrglAd6ik8gsH/
         SUdYO4RkRM1drFFHb/eGcdHlKB02/dRzSr+8cQbrNBeiIFjfmcU4L+zQYGe3qT19jI
         cqFD2oIhHxxRPZT+ZYNLsYZO8AZPL7uNHR6tx0lw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andrea Parri <parri.andrea@gmail.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wei Liu <wei.liu@kernel.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Sasha Levin <sashal@kernel.org>, linux-hyperv@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 55/59] x86/hyperv: Set pv_info.name to "Hyper-V"
Date:   Sat, 26 Oct 2019 09:19:06 -0400
Message-Id: <20191026131910.3435-55-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191026131910.3435-1-sashal@kernel.org>
References: <20191026131910.3435-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrea Parri <parri.andrea@gmail.com>

[ Upstream commit f7c0f50f1857c1cf013466fcea4dc98d116bf456 ]

Michael reported that the x86/hyperv initialization code prints the
following dmesg when running in a VM on Hyper-V:

  [    0.000738] Booting paravirtualized kernel on bare hardware

Let the x86/hyperv initialization code set pv_info.name to "Hyper-V" so
dmesg reports correctly:

  [    0.000172] Booting paravirtualized kernel on Hyper-V

[ tglx: Folded build fix provided by Yue ]

Reported-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Wei Liu <wei.liu@kernel.org>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Cc: YueHaibing <yuehaibing@huawei.com>
Link: https://lkml.kernel.org/r/20191015103502.13156-1-parri.andrea@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/cpu/mshyperv.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 852e74e48890b..1bec5e4bb1fa9 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -207,6 +207,10 @@ static void __init ms_hyperv_init_platform(void)
 	int hv_host_info_ecx;
 	int hv_host_info_edx;
 
+#ifdef CONFIG_PARAVIRT
+	pv_info.name = "Hyper-V";
+#endif
+
 	/*
 	 * Extract the features and hints
 	 */
-- 
2.20.1

