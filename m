Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51DFDC072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22A112606F
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559192370;
	bh=Q5lSDWobAriHZ4bBwYsgrm/31AWgdhRGttYgtiQ26tg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cO+rpSSIWbvOdx3Ad8dvYfCrL1szDvxyV3vUhwpRNlQxm74RK1WrzfMJbYAoLjFCw
	 7ZaGkv4tzLB8yDTP3inG0pRpv6kVOuAt5tJ1y84x7Tjl3W981Gma0SIpEnuXCbXs1L
	 jmU+5e853Wo6W91j0SHJD9FJH1LyzRORw64U3LQc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbfE3DJi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 23:09:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:44120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727591AbfE3DJa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:09:30 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9712C24481;
        Thu, 30 May 2019 03:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559185769;
        bh=Q5lSDWobAriHZ4bBwYsgrm/31AWgdhRGttYgtiQ26tg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BwlmT0FyhpfD+0fA1kPYP6lKUJzfCBfizg9Lg+Eyutew3OS+w92wTiSivVdsdRKbY
         kTTaLuX7DyBK10lK0cvnBUcgy6f9bJLNzQkNfmXZfWwRHlueKkWhZzSebEHDqEdh0U
         ZdFdWmeDccna/YmsGT86DTa4Yr0tIZcC+mAwx58s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Julien Thierry <julien.thierry@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH 5.1 020/405] arm64: Kconfig: Make ARM64_PSEUDO_NMI depend on BROKEN for now
Date:   Wed, 29 May 2019 20:00:18 -0700
Message-Id: <20190530030541.616585036@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.291644921@linuxfoundation.org>
References: <20190530030540.291644921@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Will Deacon <will.deacon@arm.com>

commit 96a13f57b946be7a6c10405e4bd780c0b6b6fe63 upstream.

Although we merged support for pseudo-nmi using interrupt priority
masking in 5.1, we've since uncovered a number of non-trivial issues
with the implementation. Although there are patches pending to address
these problems, we're facing issues that prevent us from merging them at
this current time:

  https://lkml.kernel.org/r/1556553607-46531-1-git-send-email-julien.thierry@arm.com

For now, simply mark this optional feature as BROKEN in the hope that we
can fix things properly in the near future.

Cc: <stable@vger.kernel.org> # 5.1
Cc: Julien Thierry <julien.thierry@arm.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1347,6 +1347,7 @@ config ARM64_MODULE_PLTS
 
 config ARM64_PSEUDO_NMI
 	bool "Support for NMI-like interrupts"
+	depends on BROKEN # 1556553607-46531-1-git-send-email-julien.thierry@arm.com
 	select CONFIG_ARM_GIC_V3
 	help
 	  Adds support for mimicking Non-Maskable Interrupts through the use of


