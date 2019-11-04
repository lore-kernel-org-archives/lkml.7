Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF033CA9ED3
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 22:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA65121744
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 22:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572904836;
	bh=bhnUTGAyaAASV4EfOnbQFrdIhxipFt4vC9r7havsXp8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=l/VXGR/8eQSZvWseDWllgBD7I9Hc/8Pw/KG03GJOBLR7JAroIgbyKM0xkLqjYvrHR
	 /uyWzxdWI4YJ2AkiQVE24iwLNYuwOqh+4bDd0QZddOvt4L+JLlDOesyDbdKAhqnSt1
	 A///YJ11ejmIgbXGn7fz0dujZAMBdg8poGtLAinw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388111AbfKDWAf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 17:00:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:58184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388870AbfKDWAc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 17:00:32 -0500
Received: from localhost (6.204-14-84.ripe.coltfrance.com [84.14.204.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38223214D8;
        Mon,  4 Nov 2019 22:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572904831;
        bh=bhnUTGAyaAASV4EfOnbQFrdIhxipFt4vC9r7havsXp8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ECzfxEJL+bhSizwVlBxoXdT5KHgnLOAw9VycAfcRp3FE+GmesHt2Ewfluv1HWcJ2J
         o1WV5zifoRImfGyAZXcT94WNRCNErg830UptsOEyBnR5gKIGjrTCM8/utm9RdKumyc
         sHlpT4euEiXe5AUPKdNAP3nVeygAOl+Q6I5nVAWQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hanjun Guo <hanjun.guo@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Zhangshaokun <zhangshaokun@hisilicon.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 044/149] arm64: kpti: Whitelist HiSilicon Taishan v110 CPUs
Date:   Mon,  4 Nov 2019 22:43:57 +0100
Message-Id: <20191104212139.138086779@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104212126.090054740@linuxfoundation.org>
References: <20191104212126.090054740@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hanjun Guo <hanjun.guo@linaro.org>

[ Upstream commit 0ecc471a2cb7d4d386089445a727f47b59dc9b6e ]

HiSilicon Taishan v110 CPUs didn't implement CSV3 field of the
ID_AA64PFR0_EL1 and are not susceptible to Meltdown, so whitelist
the MIDR in kpti_safe_list[] table.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
Reviewed-by: John Garry <john.garry@huawei.com>
Reviewed-by: Zhangshaokun <zhangshaokun@hisilicon.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kernel/cpufeature.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index ff5beb59b3dc3..220ebfa0ece6e 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -906,6 +906,7 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
 		MIDR_ALL_VERSIONS(MIDR_CORTEX_A57),
 		MIDR_ALL_VERSIONS(MIDR_CORTEX_A72),
 		MIDR_ALL_VERSIONS(MIDR_CORTEX_A73),
+		MIDR_ALL_VERSIONS(MIDR_HISI_TSV110),
 		{ /* sentinel */ }
 	};
 	char const *str = "kpti command line option";
-- 
2.20.1



