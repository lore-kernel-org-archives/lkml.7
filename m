Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 116D9C17441
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 19:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0CE22245C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 19:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573499082;
	bh=U+Q2q91h71IfZLyPrlsO+f3m6IWcblCUU/aQJzpN5uU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZEGxo6akWcOmBm1gSekNJjmjO3yt9f0DuThuxrrdMT6MS2NNvDwZZcKyb7HT9rxCN
	 WYlQJkd3Vi1AmyHcMD3rzARQJ6XWE5ow0yjtr3yiaat4ce4RBNXjyD1hNrgSlQk8T6
	 Ve6w+OxCh6MXXn1SQxJmV5OwOu8+ezNxN3rlByOU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbfKKSm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 13:42:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:33538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729496AbfKKSmU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:42:20 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E76AF214E0;
        Mon, 11 Nov 2019 18:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573497739;
        bh=U+Q2q91h71IfZLyPrlsO+f3m6IWcblCUU/aQJzpN5uU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=obtWx5AxBh5Jm+HIcGDKSAXCZf1+0zFmOu23ALmO4fKQURRhF49fssOj5DlajgH27
         nr0z21uCHQeQSzWkC0Xzi//rWDHxULwZuCa/3cqwMk6N0Yw4t9kc8P+nebEA/s+j4c
         cXqt9clJVMQbTxNxdIUAjE2F6V5TbQXT2tM+Fez0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ondrej Jirman <megous@megous.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <mripard@kernel.org>
Subject: [PATCH 4.19 036/125] ARM: sunxi: Fix CPU powerdown on A83T
Date:   Mon, 11 Nov 2019 19:27:55 +0100
Message-Id: <20191111181445.383112547@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191111181438.945353076@linuxfoundation.org>
References: <20191111181438.945353076@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Jirman <megous@megous.com>

commit e690053e97e7a9c968df9a97cef9089dfa8e6a44 upstream.

PRCM_PWROFF_GATING_REG has CPU0 at bit 4 on A83T. So without this
patch, instead of gating the CPU0, the whole cluster was power gated,
when shutting down first CPU in the cluster.

Fixes: 6961275e72a8c1 ("ARM: sun8i: smp: Add support for A83T")
Signed-off-by: Ondrej Jirman <megous@megous.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
Cc: stable@vger.kernel.org
Signed-off-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/mach-sunxi/mc_smp.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/arch/arm/mach-sunxi/mc_smp.c
+++ b/arch/arm/mach-sunxi/mc_smp.c
@@ -478,14 +478,18 @@ static void sunxi_mc_smp_cpu_die(unsigne
 static int sunxi_cpu_powerdown(unsigned int cpu, unsigned int cluster)
 {
 	u32 reg;
+	int gating_bit = cpu;
 
 	pr_debug("%s: cluster %u cpu %u\n", __func__, cluster, cpu);
 	if (cpu >= SUNXI_CPUS_PER_CLUSTER || cluster >= SUNXI_NR_CLUSTERS)
 		return -EINVAL;
 
+	if (is_a83t && cpu == 0)
+		gating_bit = 4;
+
 	/* gate processor power */
 	reg = readl(prcm_base + PRCM_PWROFF_GATING_REG(cluster));
-	reg |= PRCM_PWROFF_GATING_REG_CORE(cpu);
+	reg |= PRCM_PWROFF_GATING_REG_CORE(gating_bit);
 	writel(reg, prcm_base + PRCM_PWROFF_GATING_REG(cluster));
 	udelay(20);
 


