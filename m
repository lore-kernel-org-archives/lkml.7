Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B48D8C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87FD3208C0
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568932256;
	bh=7MGaVN2wL64VImoAPcctyBsgIy7kwhtcTXeqnOhqXb4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bBvgzkZSL5M1UJ3CmeAlmoDcucMqoCoffIuOWJufFc3wR6QW9KkWhihmUrnllEH/h
	 cYb4GStHTyHUt/jGIVSohkzO1w1U9spFKHNecAmZRQIdmdfS/rv2nyx5y6dVWOqKWJ
	 tgl1hAZL3uIGknbnlk8Wh/ri5v+HljpVyMrAB3Bk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406320AbfISWaz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 18:30:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:55370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406126AbfISWP0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 18:15:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB659218AF;
        Thu, 19 Sep 2019 22:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568931326;
        bh=7MGaVN2wL64VImoAPcctyBsgIy7kwhtcTXeqnOhqXb4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LW9BVM7HUMFd6CwFwiALxgAcztryqeDxYe0mHBiiRJUX8L7dRSGDXCIoGdE0aGT3P
         crhpqjmyz+ZVAC0GC6EHAHcv9s1erohjTl0Fv/thhRsFapmTm2KkutHdEvEv730y3e
         nkKR3IAg061Swoumv9syvNQrPkWOQ4b4L5cu2Dc0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        Niklas Cassel <niklas.cassel@linaro.org>
Subject: [PATCH 4.19 78/79] arm64: kpti: Whitelist Cortex-A CPUs that dont implement the CSV3 field
Date:   Fri, 20 Sep 2019 00:04:03 +0200
Message-Id: <20190919214814.627750263@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190919214807.612593061@linuxfoundation.org>
References: <20190919214807.612593061@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Will Deacon <will.deacon@arm.com>

commit 2a355ec25729053bb9a1a89b6c1d1cdd6c3b3fb1 upstream.

While the CSV3 field of the ID_AA64_PFR0 CPU ID register can be checked
to see if a CPU is susceptible to Meltdown and therefore requires kpti
to be enabled, existing CPUs do not implement this field.

We therefore whitelist all unaffected Cortex-A CPUs that do not implement
the CSV3 field.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Cc: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/kernel/cpufeature.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -895,6 +895,12 @@ static bool unmap_kernel_at_el0(const st
 	static const struct midr_range kpti_safe_list[] = {
 		MIDR_ALL_VERSIONS(MIDR_CAVIUM_THUNDERX2),
 		MIDR_ALL_VERSIONS(MIDR_BRCM_VULCAN),
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_A35),
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_A53),
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_A55),
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_A57),
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_A72),
+		MIDR_ALL_VERSIONS(MIDR_CORTEX_A73),
 		{ /* sentinel */ }
 	};
 	char const *str = "command line option";


