Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A938C352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 09:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6060D21783
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 09:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570007224;
	bh=T1lzUephD0UG8JaCddGOS63SSQieT0CublnYA/MDb7o=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Q1QfDJQBUMWvXWXXn+SDuWszYJPghViUwVmqXpLfmX8HnKMDtbTXloCX7mCo9DWkM
	 fnuaY770Oy/RkYNUhu2trfmSYP03Bdo/dGQpB5GG81KHiMeVTX9i/EZ2NF6srYz3in
	 Ha+vUAouQcLbK4XNDqJVc+6K34Uk9MAA9mktPvt0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbfJBJG4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 05:06:56 -0400
Received: from inca-roads.misterjones.org ([213.251.177.50]:60109 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725988AbfJBJG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 05:06:56 -0400
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by cheepnis.misterjones.org with esmtpsa (TLSv1.2:DHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iFaas-00057p-BF; Wed, 02 Oct 2019 11:06:46 +0200
From:   Marc Zyngier <maz@kernel.org>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        huawei.libin@huawei.com, uohanjun@huawei.com, liwei391@huawei.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] arm64: Relax ICC_PMR_EL1 synchronisation when possible
Date:   Wed,  2 Oct 2019 10:06:11 +0100
Message-Id: <20191002090613.14236-1-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: will@kernel.org, catalin.marinas@arm.com, suzuki.poulose@arm.com, james.morse@arm.com, julien.thierry.kdev@gmail.com, huawei.libin@huawei.com, uohanjun@huawei.com, liwei391@huawei.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a very late update on [1], fixing the 32bit compilation issue that
was present in v2, and adding an extra message in the kernel log to find out
what is going on.

[1] http://lore.kernel.org/r/20190802125208.73162-1-maz@kernel.org

Marc Zyngier (2):
  arm64: Relax ICC_PMR_EL1 accesses when ICC_CTLR_EL1.PMHE is clear
  arm64: Document ICC_CTLR_EL3.PMHE setting requirements

 Documentation/arm64/booting.rst    |  3 +++
 arch/arm64/include/asm/barrier.h   | 12 ++++++++++++
 arch/arm64/include/asm/daifflags.h |  3 ++-
 arch/arm64/include/asm/irqflags.h  | 19 ++++++++++---------
 arch/arm64/include/asm/kvm_host.h  |  3 +--
 arch/arm64/kernel/entry.S          |  6 ++++--
 arch/arm64/kvm/hyp/switch.c        |  4 ++--
 drivers/irqchip/irq-gic-v3.c       | 20 ++++++++++++++++++++
 include/linux/irqchip/arm-gic-v3.h |  2 ++
 9 files changed, 56 insertions(+), 16 deletions(-)

-- 
2.20.1

