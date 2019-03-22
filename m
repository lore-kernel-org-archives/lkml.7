Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6466FC10F03
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B5F02075E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553259794;
	bh=MqfhNqtz+rWE1FAbysPkHoay6zZF4Tnp+ixumvANKGE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LasJl2j/MHPgplhgO1cZdeRVzL2BsIRaElxAMDQPbbrLp+vUgGVw1CFEKrS0Uuish
	 Db8nyYFmcgAMy6pl6BCJKqvhOOdmYtuQy9J/6m5nWYp6iSP+6TfGgnil4cksZrWix9
	 CDu4EL4MO7oNbbaqH3Gr6RSDOj/WV01odcDdSPsg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731314AbfCVLkx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:40:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:42848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730221AbfCVLku (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:40:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71FAE2082C;
        Fri, 22 Mar 2019 11:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254850;
        bh=MqfhNqtz+rWE1FAbysPkHoay6zZF4Tnp+ixumvANKGE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JcDqcHGLhlvuyzJCZ7Wy/WEZGk8Qn4JeyxjFyOiJ0vRbfqusIwOw5yzugTs3OO2ap
         rEMgx8WMSpRo8VoZDmg4miax86kGtM8dqbYOeuyGPVW/oyWxDNvqjrgHvmreZ1itl7
         Y792avAzlxZAaD0ODXlBe6Fb8ihvWsvV+hcXe+OE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chase Conklin <Chase.Conklin@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 030/118] arm64: Relax GIC version check during early boot
Date:   Fri, 22 Mar 2019 12:15:02 +0100
Message-Id: <20190322111218.283951585@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111215.873964544@linuxfoundation.org>
References: <20190322111215.873964544@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 74698f6971f25d045301139413578865fc2bd8f9 ]

Updates to the GIC architecture allow ID_AA64PFR0_EL1.GIC to have
values other than 0 or 1. At the moment, Linux is quite strict in the
way it handles this field at early boot stage (cpufeature is fine) and
will refuse to use the system register CPU interface if it doesn't
find the value 1.

Fixes: 021f653791ad17e03f98aaa7fb933816ae16f161 ("irqchip: gic-v3: Initial support for GICv3")
Reported-by: Chase Conklin <Chase.Conklin@arm.com>
Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kernel/head.S | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 3289d1458791..db6ff1944c41 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -534,8 +534,7 @@ set_hcr:
 	/* GICv3 system register access */
 	mrs	x0, id_aa64pfr0_el1
 	ubfx	x0, x0, #24, #4
-	cmp	x0, #1
-	b.ne	3f
+	cbz	x0, 3f
 
 	mrs_s	x0, ICC_SRE_EL2
 	orr	x0, x0, #ICC_SRE_EL2_SRE	// Set ICC_SRE_EL2.SRE==1
-- 
2.19.1



