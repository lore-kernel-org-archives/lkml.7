Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 291E7C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB8272064A
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570697339;
	bh=T4FbpQKPhy3l01rC+LQL19O6vxjqjUvvNx+JZt0oe/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=w0n0WQAqJRKl3TjedFSPhS5ROQqwIjtginrvflYr2XS6QaPOOhAGihd7hlPVHAWSK
	 wn++X41RUZbRoKSqgMkc7QcRMZZ6bE963C7GmCBnanN+fwj/x8XQQeVLrbYwB/xtNE
	 IAiBNnA+1gvvtKoLEuuo3z2sSf4VMYg7TzRWo9DE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388771AbfJJIs6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 04:48:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:55118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388745AbfJJIss (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 04:48:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FF84218AC;
        Thu, 10 Oct 2019 08:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570697326;
        bh=T4FbpQKPhy3l01rC+LQL19O6vxjqjUvvNx+JZt0oe/w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DvVzJZlH6/y+iqSowPXJUyKW6711tKRPd8A/IO2hKjo9IljHTvX6ypUPBYo9+0QAU
         qNpJl0h3ijLl6zJxeIM1sDL0KR2AWYa06ykcGhDPS2rVWkgVzWc1aLLJjScRrXkO3o
         pmZPJzJKw49tyrdXgI/L2eGsE897D52X1KxCeAAE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH 4.19 102/114] arm64: ssbs: Dont treat CPUs with SSBS as unaffected by SSB
Date:   Thu, 10 Oct 2019 10:36:49 +0200
Message-Id: <20191010083613.611304454@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191010083544.711104709@linuxfoundation.org>
References: <20191010083544.711104709@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Will Deacon <will.deacon@arm.com>

[ Upstream commit eb337cdfcd5dd3b10522c2f34140a73a4c285c30 ]

SSBS provides a relatively cheap mitigation for SSB, but it is still a
mitigation and its presence does not indicate that the CPU is unaffected
by the vulnerability.

Tweak the mitigation logic so that we report the correct string in sysfs.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kernel/cpu_errata.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -341,15 +341,17 @@ static bool has_ssbd_mitigation(const st
 
 	WARN_ON(scope != SCOPE_LOCAL_CPU || preemptible());
 
+	/* delay setting __ssb_safe until we get a firmware response */
+	if (is_midr_in_range_list(read_cpuid_id(), entry->midr_range_list))
+		this_cpu_safe = true;
+
 	if (this_cpu_has_cap(ARM64_SSBS)) {
+		if (!this_cpu_safe)
+			__ssb_safe = false;
 		required = false;
 		goto out_printmsg;
 	}
 
-	/* delay setting __ssb_safe until we get a firmware response */
-	if (is_midr_in_range_list(read_cpuid_id(), entry->midr_range_list))
-		this_cpu_safe = true;
-
 	if (psci_ops.smccc_version == SMCCC_VERSION_1_0) {
 		ssbd_state = ARM64_SSBD_UNKNOWN;
 		if (!this_cpu_safe)


