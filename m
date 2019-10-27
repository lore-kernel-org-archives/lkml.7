Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB888CA9EBD
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A31662064A
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572210608;
	bh=HblxHirBThSqzUAUJVTeMTe3PxV+0QZyprrOJNCznqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=e7331ujE/3dm3CNV8HIZxJEi/PpIsc/dxWt4/IICvakYfmJJCQF/Am4wHXNQOMukv
	 9c0hQf2gPe0iDy9KoMXnbRgQF2faYF0/2h8N30u5+VUa4ELY3DI7YekrFDYBckHmfK
	 gDfjf8L8b7hRoFql8Qv3U49H1gmdRT8srv8c0biQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729632AbfJ0VKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 17:10:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:56438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728850AbfJ0VKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 17:10:02 -0400
Received: from localhost (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8B4320873;
        Sun, 27 Oct 2019 21:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572210602;
        bh=HblxHirBThSqzUAUJVTeMTe3PxV+0QZyprrOJNCznqI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fpNrRy4JGwGTePoBiomJRe3jB//NN7KucaVHcFM98Ja9AMShtaWiXPWc281dfq2+w
         2pVzs1PNdHeRAvGFa+TXxpqcF8FrV9qiT/AykYPyRo6htXTEKgoDon+ZscVsb52EUI
         F3QI6zhkFpYZIDkNew8ihC62gaoAmYOd3VyUaBB4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mian Yousaf Kaukab <ykaukab@suse.de>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH 4.14 072/119] arm64: Add sysfs vulnerability show for spectre-v1
Date:   Sun, 27 Oct 2019 22:00:49 +0100
Message-Id: <20191027203338.579311139@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191027203259.948006506@linuxfoundation.org>
References: <20191027203259.948006506@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mian Yousaf Kaukab <ykaukab@suse.de>

[ Upstream commit 3891ebccace188af075ce143d8b072b65e90f695 ]

spectre-v1 has been mitigated and the mitigation is always active.
Report this to userspace via sysfs

Signed-off-by: Mian Yousaf Kaukab <ykaukab@suse.de>
Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kernel/cpu_errata.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -638,3 +638,9 @@ const struct arm64_cpu_capabilities arm6
 	{
 	}
 };
+
+ssize_t cpu_show_spectre_v1(struct device *dev, struct device_attribute *attr,
+			    char *buf)
+{
+	return sprintf(buf, "Mitigation: __user pointer sanitization\n");
+}


